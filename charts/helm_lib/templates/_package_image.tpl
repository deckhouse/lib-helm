{{- /* Usage: {{ include "helm_lib_package_image" (list . "<container-name>" "<package-name>(optional)") }} */ -}}
{{- /* returns image name */ -}}
{{- define "helm_lib_package_image" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $rawPackageName := $context.Chart.Name }}
  {{- if ge (len .) 3 }}
    {{- $rawPackageName = (index . 2) }} {{- /* Optional package name */ -}}
  {{- end }}
  {{- $packageName := (include "helm_lib_module_camelcase_name" $rawPackageName) }}
  {{- $imageDigest := index $context.Values.global.packagesImages.digests $packageName $containerName }}
  {{- if not $imageDigest }}
    {{- $error := (printf "Image %s.%s has no digest" $packageName $containerName ) }}
    {{- fail $error }}
  {{- end }}
  {{- $registryBase := $context.Values.global.packagesImages.registry.base }}
  {{- /*  handle external packages registry */}}
  {{- if index $context.Values $packageName }}
    {{- if index $context.Values $packageName "registry" }}
      {{- if index $context.Values $packageName "registry" "base" }}
        {{- $host := trimAll "/" (index $context.Values $packageName "registry" "base") }}
        {{- $path := trimAll "/" (include "helm_lib_module_kebabcase_name" $rawPackageName) }}
        {{- $registryBase = join "/" (list $host $path) }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- /* end of external package handling block */}}
  {{- printf "%s@%s" $registryBase $imageDigest }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_package_image_no_fail" (list . "<container-name>") }} */ -}}
{{- /* returns image name if found */ -}}
{{- define "helm_lib_package_image_no_fail" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $packageName := (include "helm_lib_module_camelcase_name" $context) }}
  {{- if ge (len .) 3 }}
  {{- $packageName = (include "helm_lib_module_camelcase_name" (index . 2)) }} {{- /* Optional package name */ -}}
  {{- end }}
  {{- $imageDigest := index $context.Values.global.packagesImages.digests $packageName $containerName }}
  {{- if $imageDigest }}
    {{- $registryBase := $context.Values.global.packagesImages.registry.base }}
    {{- if index $context.Values $packageName }}
      {{- if index $context.Values $packageName "registry" }}
        {{- if index $context.Values $packageName "registry" "base" }}
          {{- $host := trimAll "/" (index $context.Values $packageName "registry" "base") }}
          {{- $path := trimAll "/" $context.Chart.Name }}
          {{- $registryBase = join "/" (list $host $path) }}
        {{- end }}
      {{- end }}
    {{- end }}
    {{- printf "%s@%s" $registryBase $imageDigest }}
  {{- end }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_package_common_image" (list . "<container-name>") }} */ -}}
{{- /* returns image name from common package */ -}}
{{- define "helm_lib_package_common_image" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $imageDigest := index $context.Values.global.packagesImages.digests "common" $containerName }}
  {{- if not $imageDigest }}
  {{- $error := (printf "Image %s.%s has no digest" "common" $containerName ) }}
  {{- fail $error }}
  {{- end }}
  {{- printf "%s@%s" $context.Values.global.packagesImages.registry.base $imageDigest }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_package_common_image_no_fail" (list . "<container-name>") }} */ -}}
{{- /* returns image name from common package if found */ -}}
{{- define "helm_lib_package_common_image_no_fail" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $imageDigest := index $context.Values.global.packagesImages.digests "common" $containerName }}
  {{- if $imageDigest }}
  {{- printf "%s@%s" $context.Values.global.packagesImages.registry.base $imageDigest }}
  {{- end }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_package_image_digest" (list . "<container-name>" "<package-name>(optional)") }} */ -}}
{{- /* returns image digest */ -}}
{{- define "helm_lib_package_image_digest" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $rawPackageName := $context.Chart.Name }}
  {{- if ge (len .) 3 }}
  {{- $rawPackageName = (index . 2) }} {{- /* Optional package name */ -}}
  {{- end }}
  {{- $packageName := (include "helm_lib_module_camelcase_name" $rawPackageName) }}
  {{- $packageMap := index $context.Values.global.packagesImages.digests $packageName | default dict }}
  {{- $imageDigest := index $packageMap $containerName | default "" }}
  {{- if not $imageDigest }}
  {{- $error := (printf "Image %s.%s has no digest" $packageName $containerName ) }}
  {{- fail $error }}
  {{- end }}
  {{- printf "%s" $imageDigest }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_package_image_digest_no_fail" (list . "<container-name>" "<package-name>(optional)") }} */ -}}
{{- /* returns image digest if found */ -}}
{{- define "helm_lib_package_image_digest_no_fail" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $packageName := (include "helm_lib_module_camelcase_name" $context) }}
  {{- if ge (len .) 3 }}
  {{- $packageName = (include "helm_lib_module_camelcase_name" (index . 2)) }} {{- /* Optional package name */ -}}
  {{- end }}
  {{- $packageMap := index $context.Values.global.packagesImages.digests $packageName | default dict }}
  {{- $imageDigest := index $packageMap $containerName | default "" }}
  {{- printf "%s" $imageDigest }}
{{- end }}
