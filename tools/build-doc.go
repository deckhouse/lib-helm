/*
Copyright 2023 Flant JSC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package main

import (
	"bytes"
	"flag"
	"fmt"
	"os"
	"path"
	"path/filepath"
	"regexp"
	"strings"
	"text/template"
)

func reverse(ss []string) {
	last := len(ss) - 1
	for i := 0; i < len(ss)/2; i++ {
		ss[i], ss[last-i] = ss[last-i], ss[i]
	}
}

var (
	rDefine  = regexp.MustCompile(`\{\{- define "([a-z_]+)"\s*-?\}\}`)
	rComment = regexp.MustCompile(`\{\{-?\s*/\*(.+)\*/\s*-?\}\}`)
	rNewLine = regexp.MustCompile(`\n`)
	rUsage   = regexp.MustCompile(`Usage: (.+)`)
)

func parseFile(filename string) (string, []string) {
	c, _ := os.ReadFile(filename)

	strs := rNewLine.Split(string(c), -1)

	definitionTemplate := `
## {{ .name }}
{{- range $i, $d := .description }}
{{ $d }}
{{- end }}

### Usage
` + "`" + "{{ .usage }}" + "`" + `

{{- if .args }}
### Arguments
{{- if .argsDesc }}
{{ .argsDesc }}
{{- end }}
{{- range $i, $a := .args }}
- {{ $a }}
{{- end }}
{{- end }}
`

	tmp := template.New("definition")
	tmp, err := tmp.Parse(definitionTemplate)
	if err != nil {
		panic(err)
	}

	all := make([]string, 0)

	definitions := make([]string, 0)

	for indx, str := range strs {
		defineNameMatch := rDefine.FindStringSubmatch(str)
		if defineNameMatch != nil {
			name := defineNameMatch[1]
			usage := ""
			description := make([]string, 0)
			args := make([]string, 0)

			commentIndx := indx - 1
			for ; commentIndx >= 0; commentIndx-- {
				comment := rComment.FindStringSubmatch(strs[commentIndx])
				if comment == nil {
					break
				}

				usageMatch := rUsage.FindStringSubmatch(comment[1])
				if usageMatch != nil {
					usage = usageMatch[1]
					continue
				}

				description = append(description, comment[1])
			}

			argsIndx := indx + 1
			for ; argsIndx < len(strs); argsIndx++ {
				arg := rComment.FindStringSubmatch(strs[argsIndx])
				if arg == nil {
					break
				}

				args = append(args, arg[1])
			}

			// skip internal definitions
			if len(description) == 0 {
				continue
			}

			reverse(description)

			argsDesc := ""
			if len(args) > 1 {
				argsDesc = "list:"
			}

			var tpl bytes.Buffer
			err = tmp.Execute(&tpl, map[string]interface{}{
				"name":        name,
				"usage":       usage,
				"args":        args,
				"argsDesc":    argsDesc,
				"description": description,
			})
			if err != nil {
				panic(err)
			}

			all = append(all, tpl.String())
			definitions = append(definitions, name)
		}
	}

	return strings.Join(all, "\n"), definitions
}

type Definitions struct {
	Title       string
	Definitions []string
}

func generateDocs(dirPattern string) string {
	paths, err := filepath.Glob(dirPattern)
	if err != nil {
		panic(err)
	}

	all := make([]string, 0)

	allDefinitions := make([]map[string]interface{}, 0)
	all = append(all, "Helm utils template definitions for Deckhouse modules", "\n")
	for _, p := range paths {
		res, definitions := parseFile(p)
		if res == "" {
			continue
		}

		base := path.Base(p)
		base = strings.Replace(base, "_", " ", -1)
		base = strings.TrimSpace(base)
		base = strings.Split(base, ".")[0]
		base = strings.Title(base)

		all = append(all, "# "+base, res)
		allDefinitions = append(allDefinitions, map[string]interface{}{
			"title":       base,
			"definitions": definitions,
		})
	}

	definitionTemplate := `
# Content
{{- range $i, $d := .descriptions }}
|**{{ $d.title }}**|
{{- range $j, $n := $d.definitions }}
|[{{ $n }}](#{{$n}})|
{{- end }}
{{- end }}
`
	defTmp := template.New("definition")
	defTmp, err = defTmp.Parse(definitionTemplate)
	if err != nil {
		panic(err)
	}

	var tpl bytes.Buffer
	err = defTmp.Execute(&tpl, map[string]interface{}{
		"descriptions": allDefinitions,
	})
	if err != nil {
		panic(err)
	}

	return tpl.String() + strings.Join(all, "\n")
}

func equalsDocs(newContent string, curFilePath string) bool {
	var curContent string
	curContentBytes, err := os.ReadFile(curFilePath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error while read file %s: %s", curFilePath, err.Error())
	} else {
		curContent = string(curContentBytes)
	}

	return newContent == curContent
}

const outputFile = "charts/helm_lib/README.md"

func main() {
	var onlyDiff bool
	flag.BoolVar(&onlyDiff, "diff", false, "Returns non-zero code if current readme file not equal with generated")
	flag.Parse()

	docString := generateDocs("charts/helm_lib/templates/*.tpl")

	if onlyDiff {
		exitCode := 0

		if !equalsDocs(docString, outputFile) {
			exitCode = 1
			fmt.Fprintf(os.Stderr, "You have uncommited changes\n")
		}

		os.Exit(exitCode)
		return
	}

	err := os.WriteFile(outputFile, []byte(docString), 0o644)
	if err != nil {
		panic(err)
	}
}
