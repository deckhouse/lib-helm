{{- /* Usage: {{ include "helm_lib_application_image" (list . "<image-name>") }} */ -}}
{{- /* returns image name in format "registry/package@digest" */ -}}
{{- define "helm_lib_application_image" }}
  {{- $context := index . 0 }}
  {{- $pkg := $context.Package | default $context.Values.Package }}

  {{- $image := index . 1 | trimAll "\"" }}
  {{- $imageDigest := index $pkg.Digests $image }}
  {{- if not $imageDigest }}
  {{- fail (printf "Image %s has no digest" $image) }}
  {{- end }}

  {{- $registryBase := $pkg.Registry.repository }}
  {{- if not $registryBase }}
  {{- fail "Registry base is not set" }}
  {{- end }}

  {{- $packageName := $pkg.Name }}
  {{- if not $packageName }}
  {{- fail "Package name is not set" }}
  {{- end }}

  {{- printf "%s/%s@%s" $registryBase $packageName $imageDigest }}
{{- end }}
