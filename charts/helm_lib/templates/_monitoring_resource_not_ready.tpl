{{- /* Usage: {{ include "helm_lib_prometheus_rules_resource_not_ready" (list . (dict "kinds" (list (dict "kind" "HPEStorageConnection" "role" "connection") (dict "kind" "HPEStorageClass" "role" "class")))) }} */ -}}
{{- /* returns the rule group of the D8<Module><Kind>NotReady alerts on <metricPrefix>_resource_ready, for a monitoring/prometheus-rules/*.tpl file */ -}}
{{- /* config keys: module (default: Chart.Name in PascalCase), metricPrefix (default: Chart.Name with "_"), for (default "15m"), severity (default "5"), excludeReasons (default Deleting, InUse), faqAnchor, hasBackendProbe (default false), hasConnection (default false), kinds */ -}}
{{- /* kinds[] keys: kind (required), role ("connection", "class" or empty), alert (default: StorageConnection, StorageClass or kind), resource (default: kind in lower case), for, severity, faqAnchor, hasBackendProbe, hasConnection, reasons (list of dicts with reason and text) */ -}}
{{- /* hasBackendProbe: a connection probes its storage system (BackendReady), so the runbook lists Unreachable, AuthenticationFailed, CertificateInvalid and InvalidCredentials */ -}}
{{- /* hasConnection: a class refers to a connection, so the runbook lists WaitingForDependency */ -}}
{{- define "helm_lib_prometheus_rules_resource_not_ready" -}}
  {{- $context := index . 0 -}} {{- /* Template context with .Values, .Chart, etc */ -}}
  {{- $config := index . 1 -}}  {{- /* Config dict */ -}}

  {{- $module := $config.module | default ($context.Chart.Name | replace "-" "_" | camelcase) -}}
  {{- $prefix := $config.metricPrefix | default ($context.Chart.Name | replace "-" "_") -}}
  {{- $excludeReasons := list "Deleting" "InUse" -}}
  {{- if hasKey $config "excludeReasons" -}}
    {{- $excludeReasons = $config.excludeReasons -}}
  {{- end -}}
  {{- $groupKey := printf "d8_%s_resources_health" $prefix -}}
  {{- $groupValue := printf "D8%sResourcesHealth,tier=~tier,prometheus=deckhouse,kubernetes=~kubernetes" $module -}}

  {{- $name := "{{ $labels.name }}" -}}
  {{- $condition := "{{ $labels.condition }}" -}}
  {{- $reason := "{{ $labels.reason }}" -}}
  {{- $nsFlag := "{{ if $labels.namespace }} -n {{ $labels.namespace }}{{ end }}" -}}
  {{- $nsSuffix := "{{ if $labels.namespace }} in the namespace `{{ $labels.namespace }}`{{ end }}" -}}

  {{- if not $config.kinds -}}
    {{- fail "helm_lib_prometheus_rules_resource_not_ready: kinds is empty" -}}
  {{- end -}}

  {{- $rules := list -}}
  {{- range $k := $config.kinds -}}
    {{- if not $k.kind -}}
      {{- fail "helm_lib_prometheus_rules_resource_not_ready: a kind without kind" -}}
    {{- end -}}
    {{- $role := $k.role | default "" -}}
    {{- if not (has $role (list "" "connection" "class")) -}}
      {{- fail (printf "helm_lib_prometheus_rules_resource_not_ready: role %q of %s is not connection or class" $role $k.kind) -}}
    {{- end -}}
    {{- $alertKind := $k.kind -}}
    {{- if eq $role "connection" -}}
      {{- $alertKind = "StorageConnection" -}}
    {{- else if eq $role "class" -}}
      {{- $alertKind = "StorageClass" -}}
    {{- end -}}
    {{- $alertKind = $k.alert | default $alertKind -}}
    {{- $resource := $k.resource | default (lower $k.kind) -}}
    {{- $for := $k.for | default ($config.for | default "15m") -}}
    {{- $severity := $k.severity | default ($config.severity | default "5") | toString -}}
    {{- $anchor := $k.faqAnchor | default ($config.faqAnchor | default "") -}}
    {{- $probe := false -}}
    {{- if hasKey $k "hasBackendProbe" -}}
      {{- $probe = $k.hasBackendProbe -}}
    {{- else if hasKey $config "hasBackendProbe" -}}
      {{- $probe = $config.hasBackendProbe -}}
    {{- end -}}
    {{- $withConnection := false -}}
    {{- if hasKey $k "hasConnection" -}}
      {{- $withConnection = $k.hasConnection -}}
    {{- else if hasKey $config "hasConnection" -}}
      {{- $withConnection = $config.hasConnection -}}
    {{- end -}}
    {{- $own := list -}}
    {{- range $r := ($k.reasons | default list) -}}
      {{- if not (and $r.reason $r.text) -}}
        {{- fail (printf "helm_lib_prometheus_rules_resource_not_ready: a reason of %s needs reason and text" $k.kind) -}}
      {{- end -}}
      {{- $own = append $own (printf "- `%s`: %s" $r.reason $r.text) -}}
    {{- end -}}
    {{- $faq := include "helm_lib_module_documentation_uri" (list $context (printf "/modules/%s/faq.html%s" $context.Chart.Name (ternary (printf "#%s" $anchor) "" (ne $anchor "")))) | trim -}}

    {{- $selector := printf "kind=%q" $k.kind -}}
    {{- if $excludeReasons -}}
      {{- $selector = printf "%s,reason!~%q" $selector (join "|" $excludeReasons) -}}
    {{- end -}}
    {{- $expr := printf "max by (kind, namespace, name, condition, reason) (%s_resource_ready{%s}) == 0" $prefix $selector -}}

    {{- $get := printf "d8 k get %s%s %s" $resource $nsFlag $name -}}
    {{- $lines := list
      (printf "The `Ready` condition of the %s `%s`%s has not been `True` for %s. The condition that keeps it there is `%s` with the reason `%s`." $k.kind $name $nsSuffix $for $condition $reason)
      ""
      (printf "Read the condition first, its message names the cause: `%s -o jsonpath='{.status.conditions[?(@.type==\"%s\")]}'`. The controller logs the same: `d8 k -n d8-%s logs deploy/controller -c controller --tail=500 | grep %s`." $get $condition $context.Chart.Name $name)
      ""
    -}}
    {{- if eq $role "connection" -}}
      {{- $lines = concat $lines (list "What to check, by reason:" "") -}}
      {{- if $probe -}}
        {{- $lines = concat $lines (list
          "- `Unreachable`: the storage system did not answer at the address of the connection. Check the address, the network path from the controller's nodes to the storage system and that its management API is up."
          "- `AuthenticationFailed`: the storage system answered and refused the credentials. Check the user and the password in the connection, and that the user is not locked or expired."
          "- `CertificateInvalid`: the certificate of the storage system does not verify against the CA of the connection or of the module settings, or does not match the address. Supply the right CA."
          "- `InvalidCredentials`: the credentials in the connection are empty or not in the encoding the field requires, so the storage system was not asked. Fix the field."
          "- `ReconcileFailed`: the controller could not write the driver configuration, or the probe failed in a way it does not classify. The message and the controller log have the error."
        ) -}}
      {{- else -}}
        {{- $lines = append $lines "- `ReconcileFailed`: the controller could not write the driver configuration. The message and the controller log have the error." -}}
      {{- end -}}
      {{- $lines = concat $lines $own (list
        "- `Pending`: no verdict yet. A new connection normally passes it within minutes; check that the controller is running."
        "- Any other reason: the message of the condition describes it. While the connection is not `Ready`, the storage classes that use it are not `Ready` either; volumes already created keep working unless the storage system itself is down."
        ""
      ) -}}
    {{- else if eq $role "class" -}}
      {{- $lines = concat $lines (list "What to check, by reason:" "") -}}
      {{- if $withConnection -}}
        {{- $lines = append $lines "- `WaitingForDependency`: the connection the class refers to does not exist or is not `Ready`. Fix the connection first; its own alert names the cause." -}}
      {{- end -}}
      {{- $lines = concat $lines (list "- `ReconcileFailed`: the controller could not create or update the StorageClass. A StorageClass of the same name that the module does not manage is the usual cause; the message says which.") $own (list
        "- `Pending`: no verdict yet. A new class normally passes it within minutes; check that the controller is running."
        "- Any other reason: the message of the condition describes it. While the class is not `Ready`, new volumes of its StorageClass may not be provisioned; existing volumes keep working."
        ""
      ) -}}
    {{- else if $own -}}
      {{- $lines = concat $lines (list "What to check, by reason:" "") $own (list "") -}}
    {{- end -}}
    {{- $lines = append $lines (printf "The meaning of each reason is described in the [FAQ of the %s module](%s)." $context.Chart.Name $faq) -}}

    {{- $annotations := dict
      "plk_markup_format" "markdown"
      "plk_protocol_version" "1"
      (printf "plk_create_group_if_not_exists__%s" $groupKey) $groupValue
      (printf "plk_grouped_by__%s" $groupKey) $groupValue
      "summary" (printf "%s %s is not Ready (%s %s)" $k.kind $name $condition $reason)
      "description" (join "\n" $lines)
    -}}
    {{- $rule := dict
      "alert" (printf "D8%s%sNotReady" $module $alertKind)
      "expr" $expr
      "for" $for
      "labels" (dict "severity_level" $severity "tier" "cluster")
      "annotations" $annotations
    -}}
    {{- $rules = append $rules $rule -}}
  {{- end -}}

  {{- list (dict "name" (printf "kubernetes.%s.resource_ready" $prefix) "rules" $rules) | toYaml -}}
{{- end -}}
