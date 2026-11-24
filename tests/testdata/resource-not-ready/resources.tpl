{{- include "helm_lib_prometheus_rules_resource_not_ready" (list . (dict "kinds" (list (dict "kind" "HPEStorageConnection" "role" "connection") (dict "kind" "HPEStorageClass" "role" "class")))) }}
