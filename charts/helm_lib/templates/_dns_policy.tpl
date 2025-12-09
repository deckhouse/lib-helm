{{- /* Usage: {{ include "helm_lib_dns_policy_bootstraping_state" . }} */ -}}
{{- /* returns the proper dnsPolicy value depending on the cluster bootstrap phase */ -}}
{{- define "helm_lib_dns_policy_bootstraping_state" }}
{{- if .Values.global.clusterIsBootstrapped }}
{{- printf "ClusterFirstWithHostNet" }}
{{- else }}
{{- printf "Default" }}
{{- end }}
{{- end }}
