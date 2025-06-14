{{- /* Usage: {{ include "helm_lib_module_pod_security_context_run_as_user_custom" (list . 1000 1000) }} */ -}}
{{- /* returns PodSecurityContext parameters for Pod with custom user and group */ -}}
{{- define "helm_lib_module_pod_security_context_run_as_user_custom" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
{{- /* User id */ -}}
{{- /* Group id */ -}}
securityContext:
  runAsNonRoot: true
  runAsUser: {{ index . 1 }}
  runAsGroup: {{ index . 2 }}
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_pod_security_context_run_as_user_nobody" . }} */ -}}
{{- /* returns PodSecurityContext parameters for Pod with user and group "nobody" */ -}}
{{- define "helm_lib_module_pod_security_context_run_as_user_nobody" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  runAsNonRoot: true
  runAsUser: 65534
  runAsGroup: 65534
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_pod_security_context_run_as_user_nobody_with_writable_fs" . }} */ -}}
{{- /* returns PodSecurityContext parameters for Pod with user and group "nobody" with write access to mounted volumes */ -}}
{{- define "helm_lib_module_pod_security_context_run_as_user_nobody_with_writable_fs" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  runAsNonRoot: true
  runAsUser: 65534
  runAsGroup: 65534
  fsGroup: 65534
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_pod_security_context_run_as_user_deckhouse" . }} */ -}}
{{- /* returns PodSecurityContext parameters for Pod with user and group "deckhouse" */ -}}
{{- define "helm_lib_module_pod_security_context_run_as_user_deckhouse" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  runAsNonRoot: true
  runAsUser: 64535
  runAsGroup: 64535
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_pod_security_context_run_as_user_deckhouse_with_writable_fs" . }} */ -}}
{{- /* returns PodSecurityContext parameters for Pod with user and group "deckhouse" with write access to mounted volumes */ -}}
{{- define "helm_lib_module_pod_security_context_run_as_user_deckhouse_with_writable_fs" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  runAsNonRoot: true
  runAsUser: 64535
  runAsGroup: 64535
  fsGroup: 64535
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_run_as_user_deckhouse_pss_restricted" . }} */ -}}
{{- /* returns SecurityContext parameters for Container with user and group "deckhouse" plus minimal required settings to comply with the Restricted mode of the Pod Security Standards */ -}}
{{- define "helm_lib_module_container_security_context_run_as_user_deckhouse_pss_restricted" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - all
  runAsGroup: 64535
  runAsNonRoot: true
  runAsUser: 64535
  seccompProfile:
    type: RuntimeDefault
{{- end }}


{{- /* SecurityContext for Deckhouse UID/GID 64535, PSS Restricted */ -}}
{{- /* Optional keys: */ -}}
{{- /* .ro   – bool, read-only root FS (default true) */ -}}
{{- /* .caps – []string, capabilities.add (default empty) */ -}}
{{- /* .uid  – int, runAsUser/runAsGroup (default 64535) */ -}}
{{- /* Usage: include "helm_lib_module_container_security_context_pss_restricted_flexible" (dict "ro" false "caps" (list "NET_ADMIN" "SYS_TIME") "uid" 1001) */ -}}
{{- define "helm_lib_module_container_security_context_pss_restricted_flexible" -}}
{{- $ro := true -}}
{{- if hasKey . "ro" -}}
  {{- $ro = .ro -}}
{{- end -}}
{{- $caps := default (list) .caps -}}
{{- $uid  := default 64535 .uid  -}}

securityContext:
  readOnlyRootFilesystem: {{ $ro }}
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
{{- if $caps }}
    add: {{ $caps | toJson }}
{{- end }}
  runAsUser:   {{ $uid }}
  runAsGroup:  {{ $uid }}
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
{{- end }}


{{- /* Usage: {{ include "helm_lib_module_pod_security_context_run_as_user_root" . }} */ -}}
{{- /* returns PodSecurityContext parameters for Pod with user and group 0 */ -}}
{{- define "helm_lib_module_pod_security_context_run_as_user_root" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  runAsNonRoot: false
  runAsUser: 0
  runAsGroup: 0
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_pod_security_context_runtime_default" . }} */ -}}
{{- /* returns PodSecurityContext parameters for Pod with seccomp profile RuntimeDefault */ -}}
{{- define "helm_lib_module_pod_security_context_runtime_default" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_not_allow_privilege_escalation" . }} */ -}}
{{- /* returns SecurityContext parameters for Container with allowPrivilegeEscalation false */ -}}
{{- define "helm_lib_module_container_security_context_not_allow_privilege_escalation" -}}
securityContext:
  allowPrivilegeEscalation: false
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_read_only_root_filesystem_with_selinux" . }} */ -}}
{{- /* returns SecurityContext parameters for Container with read only root filesystem and options for SELinux compatibility*/ -}}
{{- define "helm_lib_module_container_security_context_read_only_root_filesystem_with_selinux" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  seLinuxOptions:
    level: 's0'
    type: 'spc_t'
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_read_only_root_filesystem" . }} */ -}}
{{- /* returns SecurityContext parameters for Container with read only root filesystem */ -}}
{{- define "helm_lib_module_container_security_context_read_only_root_filesystem" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_privileged" . }} */ -}}
{{- /* returns SecurityContext parameters for Container running privileged */ -}}
{{- define "helm_lib_module_container_security_context_privileged" -}}
securityContext:
  privileged: true
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_escalated_sys_admin_privileged" . }} */ -}}
{{- /* returns SecurityContext parameters for Container running privileged with escalation and sys_admin */ -}}
{{- define "helm_lib_module_container_security_context_escalated_sys_admin_privileged" -}}
securityContext:
  allowPrivilegeEscalation: true
  readOnlyRootFilesystem: true
  capabilities:
    add:
    - SYS_ADMIN
  privileged: true
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_privileged_read_only_root_filesystem" . }} */ -}}
{{- /* returns SecurityContext parameters for Container running privileged with read only root filesystem */ -}}
{{- define "helm_lib_module_container_security_context_privileged_read_only_root_filesystem" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  privileged: true
  readOnlyRootFilesystem: true
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_read_only_root_filesystem_capabilities_drop_all" . }} */ -}}
{{- /* returns SecurityContext for Container with read only root filesystem and all capabilities dropped  */ -}}
{{- define "helm_lib_module_container_security_context_read_only_root_filesystem_capabilities_drop_all" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_read_only_root_filesystem_capabilities_drop_all_and_add"  (list . (list "KILL" "SYS_PTRACE")) }} */ -}}
{{- /* returns SecurityContext parameters for Container with read only root filesystem, all dropped and some added capabilities */ -}}
{{- define "helm_lib_module_container_security_context_read_only_root_filesystem_capabilities_drop_all_and_add" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
{{- /* List of capabilities */ -}}
securityContext:
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
    add: {{ index . 1 | toJson }}
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_capabilities_drop_all_and_add"  (list . (list "KILL" "SYS_PTRACE")) }} */ -}}
{{- /* returns SecurityContext parameters for Container with all dropped and some added capabilities */ -}}
{{- define "helm_lib_module_container_security_context_capabilities_drop_all_and_add" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
{{- /* List of capabilities */ -}}
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
    add: {{ index . 1 | toJson }}
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_capabilities_drop_all_and_run_as_user_custom" (list . 1000 1000) }} */ -}}
{{- /* returns SecurityContext parameters for Container with read only root filesystem, all dropped, and custom user ID */ -}}
{{- define "helm_lib_module_container_security_context_capabilities_drop_all_and_run_as_user_custom" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
{{- /* User id */ -}}
{{- /* Group id */ -}}
securityContext:
  runAsUser: {{ index . 1 }}
  runAsGroup: {{ index . 2 }}
  runAsNonRoot: true
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
  seccompProfile:
    type: RuntimeDefault
{{- end }}

{{- /* Usage: {{ include "helm_lib_module_container_security_context_read_only_root_filesystem_capabilities_drop_all_pss_restricted" . }} */ -}}
{{- /* returns SecurityContext parameters for Container with minimal required settings to comply with the Restricted mode of the Pod Security Standards */ -}}
{{- define "helm_lib_module_container_security_context_read_only_root_filesystem_capabilities_drop_all_pss_restricted" -}}
{{- /* Template context with .Values, .Chart, etc */ -}}
securityContext:
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
  seccompProfile:
    type: RuntimeDefault
{{- end }}
