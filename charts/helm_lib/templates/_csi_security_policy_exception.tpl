{{- /* Usage: {{ $relaxations := include "helm_lib_csi_spe_container_relaxations" (list $containers $hostNetwork) | fromYaml }} */ -}}
{{- /* returns the Pod Security Standards relaxations the given containers need, with the names of the containers needing each one */ -}}
{{- define "helm_lib_csi_spe_container_relaxations" }}
  {{- $containers := index . 0 | default list }}
  {{- $hostNetwork := index . 1 }}
  {{- $privileged := list }}
  {{- $escalation := list }}
  {{- $root := list }}
  {{- $capabilities := list }}
  {{- $capabilityValues := list }}
  {{- $seLinux := list }}
  {{- $seLinuxValues := list }}
  {{- $hostPorts := list }}
  {{- range $container := $containers }}
    {{- $securityContext := $container.securityContext | default dict }}
    {{- if $securityContext.privileged }}
      {{- $privileged = append $privileged $container.name }}
    {{- end }}
    {{- if or (not (hasKey $securityContext "allowPrivilegeEscalation")) $securityContext.allowPrivilegeEscalation }}
      {{- $escalation = append $escalation $container.name }}
    {{- end }}
    {{- if or (and (hasKey $securityContext "runAsUser") (eq (int $securityContext.runAsUser) 0)) (and (hasKey $securityContext "runAsNonRoot") (not $securityContext.runAsNonRoot)) }}
      {{- $root = append $root $container.name }}
    {{- end }}
    {{- $add := dig "capabilities" "add" list $securityContext }}
    {{- if $add }}
      {{- $capabilities = append $capabilities $container.name }}
      {{- $capabilityValues = concat $capabilityValues $add }}
    {{- end }}
    {{- if $securityContext.seLinuxOptions }}
      {{- $seLinux = append $seLinux $container.name }}
      {{- $seLinuxValues = append $seLinuxValues $securityContext.seLinuxOptions }}
    {{- end }}
    {{- if $hostNetwork }}
      {{- range $port := $container.ports | default list }}
        {{- $hostPorts = append $hostPorts (dict "port" ($port.hostPort | default $port.containerPort) "protocol" ($port.protocol | default "TCP") "name" ($port.name | default "") "container" $container.name) }}
      {{- end }}
    {{- end }}
  {{- end }}
privileged: {{ $privileged | uniq | toJson }}
escalation: {{ $escalation | uniq | toJson }}
root: {{ $root | uniq | toJson }}
capabilities: {{ $capabilities | uniq | toJson }}
capabilityValues: {{ $capabilityValues | uniq | toJson }}
seLinux: {{ $seLinux | uniq | toJson }}
seLinuxValues: {{ $seLinuxValues | uniq | toJson }}
hostPorts: {{ $hostPorts | toJson }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_csi_spe_host_ports" (list $hostPorts $component) | trim | nindent 4 }} */ -}}
{{- /* returns spec.network.hostPorts of a CSI SecurityPolicyException with a description for each port */ -}}
{{- define "helm_lib_csi_spe_host_ports" }}
  {{- $hostPorts := index . 0 }}
  {{- $component := index . 1 }}
hostPorts:
  {{- range $hostPort := $hostPorts }}
  - port: {{ $hostPort.port }}
    protocol: {{ $hostPort.protocol }}
    metadata:
      description: {{ printf "Port %v%s of the %s container, bound on the node because the %s Pod runs in the host network." $hostPort.port (ternary (printf " (%s)" $hostPort.name) "" (ne $hostPort.name "")) $hostPort.container $component | quote }}
  {{- end }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_csi_spe_selinux_options" (list $relaxations $component) | trim | nindent 4 }} */ -}}
{{- /* returns spec.securityContext.seLinuxOptions of a CSI SecurityPolicyException */ -}}
{{- define "helm_lib_csi_spe_selinux_options" }}
  {{- $relaxations := index . 0 }}
  {{- $component := index . 1 }}
seLinuxOptions:
  allowedValues:
    {{- $relaxations.seLinuxValues | toYaml | nindent 4 }}
  metadata:
    description: |
      Allow the SELinux options set by the {{ $relaxations.seLinux | join ", " }} container(s) of the {{ $component }}.
      These containers act on the host outside the container sandbox, which the confined SELinux types of a container forbid.
{{- end }}
