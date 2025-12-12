{{- /* Usage: {{ include "helm_lib_application_image" (list . "<container-name>" "<application-name>(optional)") }} */ -}}
{{- /* returns image name */ -}}
{{- define "helm_lib_application_image" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $rawapplicationName := $context.Chart.Name }}
  {{- if ge (len .) 3 }}
    {{- $rawapplicationName = (index . 2) }} {{- /* Optional application name */ -}}
  {{- end }}
  {{- $applicationName := (include "helm_lib_module_camelcase_name" $rawapplicationName) }}
  {{- $imageDigest := index $context.Values.global.Runtime.Instance.Digests $applicationName $containerName }}
  {{- if not $imageDigest }}
    {{- $error := (printf "Image %s.%s has no digest" $applicationName $containerName ) }}
    {{- fail $error }}
  {{- end }}
  {{- $registryBase := $context.Values.global.Runtime.Instance.Registry.base }}
  {{- /*  handle external applications registry */}}
  {{- if index $context.Values $applicationName }}
    {{- if index $context.Values $applicationName "registry" }}
      {{- if index $context.Values $applicationName "registry" "base" }}
        {{- $host := trimAll "/" (index $context.Values $applicationName "registry" "base") }}
        {{- $path := trimAll "/" (include "helm_lib_module_kebabcase_name" $rawapplicationName) }}
        {{- $registryBase = join "/" (list $host $path) }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- /* end of external application handling block */}}
  {{- printf "%s@%s" $registryBase $imageDigest }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_application_image_no_fail" (list . "<container-name>") }} */ -}}
{{- /* returns image name if found */ -}}
{{- define "helm_lib_application_image_no_fail" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $applicationName := (include "helm_lib_module_camelcase_name" $context) }}
  {{- if ge (len .) 3 }}
  {{- $applicationName = (include "helm_lib_module_camelcase_name" (index . 2)) }} {{- /* Optional application name */ -}}
  {{- end }}
  {{- $imageDigest := index $context.Values.global.Runtime.Instance.Digests $applicationName $containerName }}
  {{- if $imageDigest }}
    {{- $registryBase := $context.Values.global.Runtime.Instance.Registry.base }}
    {{- if index $context.Values $applicationName }}
      {{- if index $context.Values $applicationName "registry" }}
        {{- if index $context.Values $applicationName "registry" "base" }}
          {{- $host := trimAll "/" (index $context.Values $applicationName "registry" "base") }}
          {{- $path := trimAll "/" $context.Chart.Name }}
          {{- $registryBase = join "/" (list $host $path) }}
        {{- end }}
      {{- end }}
    {{- end }}
    {{- printf "%s@%s" $registryBase $imageDigest }}
  {{- end }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_application_common_image" (list . "<container-name>") }} */ -}}
{{- /* returns image name from common application */ -}}
{{- define "helm_lib_application_common_image" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $imageDigest := index $context.Values.global.Runtime.Instance.Digests "common" $containerName }}
  {{- if not $imageDigest }}
  {{- $error := (printf "Image %s.%s has no digest" "common" $containerName ) }}
  {{- fail $error }}
  {{- end }}
  {{- printf "%s@%s" $context.Values.global.Runtime.Instance.Registry.base $imageDigest }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_application_common_image_no_fail" (list . "<container-name>") }} */ -}}
{{- /* returns image name from common application if found */ -}}
{{- define "helm_lib_application_common_image_no_fail" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $imageDigest := index $context.Values.global.Runtime.Instance.Digests "common" $containerName }}
  {{- if $imageDigest }}
  {{- printf "%s@%s" $context.Values.global.Runtime.Instance.Registry.base $imageDigest }}
  {{- end }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_application_image_digest" (list . "<container-name>" "<application-name>(optional)") }} */ -}}
{{- /* returns image digest */ -}}
{{- define "helm_lib_application_image_digest" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $rawapplicationName := $context.Chart.Name }}
  {{- if ge (len .) 3 }}
  {{- $rawapplicationName = (index . 2) }} {{- /* Optional application name */ -}}
  {{- end }}
  {{- $applicationName := (include "helm_lib_module_camelcase_name" $rawapplicationName) }}
  {{- $applicationMap := index $context.Values.global.Runtime.Instance.Digests $applicationName | default dict }}
  {{- $imageDigest := index $applicationMap $containerName | default "" }}
  {{- if not $imageDigest }}
  {{- $error := (printf "Image %s.%s has no digest" $applicationName $containerName ) }}
  {{- fail $error }}
  {{- end }}
  {{- printf "%s" $imageDigest }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_application_image_digest_no_fail" (list . "<container-name>" "<application-name>(optional)") }} */ -}}
{{- /* returns image digest if found */ -}}
{{- define "helm_lib_application_image_digest_no_fail" }}
  {{- $context := index . 0 }} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $containerName := index . 1 | trimAll "\"" }} {{- /* Container name */ -}}
  {{- $applicationName := (include "helm_lib_module_camelcase_name" $context) }}
  {{- if ge (len .) 3 }}
  {{- $applicationName = (include "helm_lib_module_camelcase_name" (index . 2)) }} {{- /* Optional application name */ -}}
  {{- end }}
  {{- $applicationMap := index $context.Values.global.Runtime.Instance.Digests $applicationName | default dict }}
  {{- $imageDigest := index $applicationMap $containerName | default "" }}
  {{- printf "%s" $imageDigest }}
{{- end }}
