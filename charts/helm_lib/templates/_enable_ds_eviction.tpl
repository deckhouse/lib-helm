{{- /* Usage: {{ include "helm_lib_enable_ds_eviction" . }} */ -}}
{{- /*cluster-autoscaler.kubernetes.io/enable-ds-eviction annotation */- }}
{{- define "helm_lib_ds_eviction_annotation" -}}
{{- $context := index . 0 }}
{{- $enableEviction := index . 1 }}
  cluster-autoscaler.kubernetes.io/enable-ds-eviction: "{{ $enableEviction }}"
{{- end }}
