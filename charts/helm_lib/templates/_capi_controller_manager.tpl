{{- define "capi_controller_manager_resources" -}}
cpu: 25m
memory: 50Mi
{{- end -}}

{{- define "capi_controller_manager_max_allowed_resources" -}}
cpu: 50m
memory: 50Mi
{{- end -}}

{{- /* Usage: {{ include "helm_lib_capi_controller_manager_manifests" (list . $config) }} */ -}}
{{- define "helm_lib_capi_controller_manager_manifests" -}}
  {{- $context := index . 0 -}}
  {{- $config := index . 1 -}}

  {{- $fullname := required "helm_lib_capi_controller_manager_manifests: fullname is required" $config.fullname -}}
  {{- $image := required "helm_lib_capi_controller_manager_manifests: image is required" $config.image -}}
  {{- $capiProviderName := required "helm_lib_capi_controller_manager_manifests: $capiProviderName is required" $config.capiProviderName -}}
  {{- $resources := dig "resources" (include "capi_controller_manager_resources" $context | fromYaml) $config -}}
  {{- $priorityClassName := dig "priorityClassName" "system-cluster-critical" $config -}}
  {{- $serviceAccountName := dig "serviceAccountName" $fullname $config -}}
  {{- $automountServiceAccountToken := dig "automountServiceAccountToken" true $config -}}
  {{- $revisionHistoryLimit := dig "revisionHistoryLimit" 2 $config -}}
  {{- $terminationGracePeriodSeconds := dig "terminationGracePeriodSeconds" 10 $config -}}
  {{- $hostNetwork := dig "hostNetwork" false $config -}}
  {{- $dnsPolicy := dig "dnsPolicy" nil $config -}}
  {{- $nodeSelectorStrategy := dig "nodeSelectorStrategy" "master" $config -}}
  {{- $tolerationsStrategies := dig "tolerationsStrategies" (list "any-node" "uninitialized") $config -}}
  {{- $livenessProbePort := dig "livenessProbePort" 8081 $config }}
  {{- $readinessProbePort := dig "readinessProbePort" 8081 $config }}

  {{- $additionalArgs := dig "additionalArgs" (list) $config -}}
  {{- $additionalEnv := dig "additionalEnv" (list) $config -}}
  {{- $additionalPorts := dig "additionalPorts" (list) $config -}}
  {{- $additionalInitContainers := dig "additionalInitContainers" (list) $config -}}
  {{- $additionalVolumeMounts := dig "additionalVolumeMounts" (list) $config -}}
  {{- $additionalVolumes := dig "additionalVolumes" (list) $config -}}
  {{- $additionalPodLabels := dig "additionalPodLabels" (dict) $config -}}
  {{- $additionalPodAnnotations := dig "additionalPodAnnotations" (dict) $config -}}

  {{- $pdbEnabled := dig "pdbEnabled" true $config -}}
  {{- $pdbMaxUnavailable := dig "pdbMaxUnavailable" 1 $config -}}

  {{- $vpaEnabled := dig "vpaEnabled" false $config -}}
  {{- $vpaUpdateMode := dig "vpaUpdateMode" "InPlaceOrRecreate" $config -}}
  {{- $vpaMaxAllowed := dig "vpaMaxAllowed" (include "capi_controller_manager_max_allowed_resources" $context | fromYaml) $config -}}

{{- if and $vpaEnabled ($context.Values.global.enabledModules | has "vertical-pod-autoscaler-crd") }}
---
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: {{ $fullname }}
  namespace: d8-{{ $context.Chart.Name }}
  {{- include "helm_lib_module_labels" (list $context (dict "app" $fullname)) | nindent 2 }}
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ $fullname }}
  updatePolicy:
    updateMode: {{ $vpaUpdateMode | quote }}
  resourcePolicy:
    containerPolicies:
      - containerName: {{ $fullname | quote }}
        minAllowed:
          {{- toYaml $resources | nindent 10 }}
        maxAllowed:
          {{- toYaml $vpaMaxAllowed | nindent 10 }}
{{- end }}

{{- if $pdbEnabled }}
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ $fullname }}
  namespace: d8-{{ $context.Chart.Name }}
  {{- include "helm_lib_module_labels" (list $context (dict "app" $fullname)) | nindent 2 }}
spec:
  maxUnavailable: {{ $pdbMaxUnavailable }}
  selector:
    matchLabels:
      app: {{ $fullname }}
{{- end }}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ $fullname }}
  namespace: d8-{{ $context.Chart.Name }}
  {{- include "helm_lib_module_labels" (list $context (dict "app" $fullname)) | nindent 2 }}
spec:
  {{- include "helm_lib_deployment_on_master_strategy_and_replicas_for_ha" $context | nindent 2 }}
  revisionHistoryLimit: {{ $revisionHistoryLimit }}
  selector:
    matchLabels:
      app: {{ $fullname }}
      cluster.x-k8s.io/provider: {{ $capiProviderName }}
      control-plane: controller-manager
  template:
    metadata:
      labels:
        app: {{ $fullname }}
        cluster.x-k8s.io/provider: {{ $capiProviderName }}
        control-plane: controller-manager
      {{- with $additionalPodLabels }}
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $additionalPodAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    spec:
      imagePullSecrets:
        - name: deckhouse-registry
      {{- include "helm_lib_pod_anti_affinity_for_ha" (list $context (dict "app" $fullname)) | nindent 6 }}
      {{- include "helm_lib_priority_class" (tuple $context $priorityClassName) | nindent 6 }}
      {{- include "helm_lib_node_selector" (tuple $context $nodeSelectorStrategy) | nindent 6 }}
      {{- include "helm_lib_tolerations" (concat (list $context) $tolerationsStrategies) | nindent 6 }}
      {{- include "helm_lib_module_pod_security_context_run_as_user_deckhouse" $context | nindent 6 }}
      automountServiceAccountToken: {{ $automountServiceAccountToken }}
      serviceAccountName: {{ $serviceAccountName }}
      terminationGracePeriodSeconds: {{ $terminationGracePeriodSeconds }}
      hostNetwork: {{ $hostNetwork }}
      {{- with $dnsPolicy }}
      dnsPolicy: {{ . }}
      {{- end }}
      {{- with $additionalInitContainers }}
      initContainers:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      containers:
      - name: {{ $fullname }}
        {{- include "helm_lib_module_container_security_context_pss_restricted_flexible" dict | nindent 8 }}
        image: {{ $image }}
        imagePullPolicy: IfNotPresent
        args:
          - --leader-elect
        {{- with $additionalArgs }}
          {{- toYaml . | nindent 10 }}
        {{- end }}
        {{- with $additionalEnv }}
        env:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        {{- with $additionalPorts }}
        ports:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        livenessProbe:
          httpGet:
            path: /healthz
            port: {{ $livenessProbePort }}
          initialDelaySeconds: 15
          periodSeconds: 20
        readinessProbe:
          httpGet:
            path: /readyz
            port: {{ $readinessProbePort }}
          initialDelaySeconds: 5
          periodSeconds: 10
        {{- with $additionalVolumeMounts }}
        volumeMounts:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        resources:
          requests:
            {{- include "helm_lib_module_ephemeral_storage_logs_with_extra" 10 | nindent 12 }}
          {{- if not (and $vpaEnabled ($context.Values.global.enabledModules | has "vertical-pod-autoscaler-crd")) }}
            {{- toYaml $resources | nindent 12 }}
          {{- end }}
      {{- with $additionalVolumes }}
      volumes:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end -}}