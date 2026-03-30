{{- define "cloud_data_discoverer_resources" -}}
cpu: 25m
memory: 50Mi
{{- end -}}

{{- define "cloud_data_discoverer_max_allowed_resources" -}}
cpu: 50m
memory: 50Mi
{{- end -}}

{{- /* Usage: {{ include "helm_lib_cloud_data_discoverer_manifests" (list . $config) }} */ -}}
{{- define "helm_lib_cloud_data_discoverer_manifests" -}}
  {{- $context := index . 0 -}}
  {{- $config := index . 1 -}}

  {{- $fullname := dig "fullname" "cloud-data-discoverer" $config -}}
  {{- $image := required "helm_lib_cloud_data_discoverer_manifests: image is required" $config.image -}}
  {{- $resources := dig "resources" (include "cloud_data_discoverer_resources" $context | fromYaml) $config -}}
  {{- $replicas := dig "replicas" 1 $config -}}
  {{- $revisionHistoryLimit := dig "revisionHistoryLimit" 2 $config -}}
  {{- $serviceAccountName := dig "serviceAccountName" "cloud-data-discoverer" $config -}}
  {{- $automountServiceAccountToken := dig "automountServiceAccountToken" true $config -}}
  {{- $priorityClassName := dig "priorityClassName" "cluster-low" $config -}}
  {{- $nodeSelectorStrategy := dig "nodeSelectorStrategy" "master" $config -}}
  {{- $tolerationsStrategies := dig "tolerationsStrategies" (list "any-node" "with-uninitialized") $config -}}
  {{- $additionalArgs := dig "additionalArgs" (list) $config -}}
  {{- $additionalEnv := dig "additionalEnv" (list) $config -}}
  {{- $additionalPodLabels := dig "additionalPodLabels" (dict) $config }}
  {{- $additionalPodAnnotations := dig "additionalPodAnnotations" (dict) $config }}
  {{- $additionalInitContainers := dig "additionalInitContainers" (list) $config -}}
  {{- $additionalVolumes := dig "additionalVolumes" (list) $config -}}
  {{- $additionalVolumeMounts := dig "additionalVolumeMounts" (list) $config -}}

  {{- $pdbEnabled := dig "pdbEnabled" true $config -}}
  {{- $pdbMaxUnavailable := dig "pdbMaxUnavailable" 1 $config -}}

  {{- $vpaEnabled := dig "vpaEnabled" true $config -}}
  {{- $vpaUpdateMode := dig "vpaUpdateMode" "Initial" $config -}}
  {{- $vpaMaxAllowed := dig "vpaMaxAllowed" (include "cloud_data_discoverer_max_allowed_resources" $context | fromYaml) $config -}}

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
        {{- toYaml $resources | nindent 8 }}
      maxAllowed:
        {{- toYaml $vpaMaxAllowed | nindent 8 }}
    {{- include "helm_lib_vpa_kube_rbac_proxy_resources" $context | nindent 4 }}
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
  replicas: {{ $replicas }}
  revisionHistoryLimit: {{ $revisionHistoryLimit }}
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: {{ $fullname }}
  template:
    metadata:
      labels:
        app: {{ $fullname }}
      {{- with $additionalPodLabels }}
        {{- toYaml . | nindent 8 }}
      {{- end }}
      annotations:
        kubectl.kubernetes.io/default-exec-container: {{ $fullname }}
        kubectl.kubernetes.io/default-logs-container: {{ $fullname }}
      {{- with $additionalPodAnnotations }}
        {{- toYaml . | nindent 8 }}
      {{- end }}
    spec:
      imagePullSecrets:
        - name: deckhouse-registry
      {{- include "helm_lib_priority_class" (tuple $context $priorityClassName) | nindent 6 }}
      {{- include "helm_lib_node_selector" (tuple $context $nodeSelectorStrategy) | nindent 6 }}
      {{- include "helm_lib_tolerations" (concat (list $context) $tolerationsStrategies) | nindent 6 }}
      {{- include "helm_lib_module_pod_security_context_run_as_user_deckhouse" $context | nindent 6 }}
      dnsPolicy: {{ include "helm_lib_dns_policy_bootstraping_state" (list $context "Default" "ClusterFirstWithHostNet") }}
      automountServiceAccountToken: {{ $automountServiceAccountToken }}
      serviceAccountName: {{ $serviceAccountName }}
      {{- with $additionalInitContainers }}
      initContainers:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      containers:
      - name: {{ $fullname }}
        {{- include "helm_lib_module_container_security_context_pss_restricted_flexible" dict | nindent 8 }}
        image: {{ $image }}
        args:
        - --discovery-period=1h
        - --listen-address=127.0.0.1:8081
        {{- with $additionalArgs }}
          {{- toYaml . | nindent 8 }}
        {{- end }}
        {{- with $additionalEnv }}
        env:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
            scheme: HTTPS
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8080
            scheme: HTTPS
        {{- with $additionalVolumeMounts }}
        volumeMounts:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        resources:
          requests:
            {{- include "helm_lib_module_ephemeral_storage_only_logs" $context | nindent 12 }}
          {{- if not (and $vpaEnabled ($context.Values.global.enabledModules | has "vertical-pod-autoscaler-crd")) }}
            {{- toYaml $resources | nindent 12 }}
          {{- end }}
      - name: kube-rbac-proxy
        {{- include "helm_lib_module_container_security_context_pss_restricted_flexible" dict | nindent 8 }}
        image: {{ include "helm_lib_module_common_image" (list $context "kubeRbacProxy") }}
        args:
          - "--secure-listen-address=$(KUBE_RBAC_PROXY_LISTEN_ADDRESS):8080"
          - "--v=2"
          - "--logtostderr=true"
          - "--stale-cache-interval=1h30m"
          - "--livez-path=/livez"
        ports:
          - containerPort: 8080
            name: https-metrics
        env:
          - name: KUBE_RBAC_PROXY_LISTEN_ADDRESS
            valueFrom:
              fieldRef:
                fieldPath: status.podIP
          - name: KUBE_RBAC_PROXY_CONFIG
            value: |
              excludePaths:
              - /healthz
              upstreams:
              - upstream: http://127.0.0.1:8081/
                path: /
                authorization:
                  resourceAttributes:
                    namespace: d8-{{ $context.Chart.Name }}
                    apiGroup: apps
                    apiVersion: v1
                    resource: deployments
                    subresource: prometheus-metrics
                    name: {{ $fullname }}
        livenessProbe:
          httpGet:
            path: /livez
            port: 8080
            scheme: HTTPS
        readinessProbe:
          httpGet:
            path: /livez
            port: 8080
            scheme: HTTPS
        resources:
          requests:
            {{- include "helm_lib_module_ephemeral_storage_only_logs" $context | nindent 12 }}
          {{- if not (and $vpaEnabled ($context.Values.global.enabledModules | has "vertical-pod-autoscaler-crd")) }}
            {{- include "helm_lib_container_kube_rbac_proxy_resources" $context | nindent 12 }}
          {{- end }}
      {{- with $additionalVolumes }}
      volumes:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end }}


{{- /* Usage: {{ include "helm_lib_cloud_data_discoverer_pod_monitor" (list . $config) }} */ -}}
{{- define "helm_lib_cloud_data_discoverer_pod_monitor" -}}
  {{- $context := index . 0 -}}
  {{- $config := index . 1 -}}

  {{- $fullname := dig "fullname" "cloud-data-discoverer" $config -}}
  {{- $targetNamespace := required "helm_lib_cloud_data_discoverer_pod_monitor: targetNamespace is required" $config.targetNamespace -}}
  {{- $additionalRelabelings := dig "additionalRelabelings" (list) $config -}}

{{- if ($context.Values.global.enabledModules | has "operator-prometheus-crd") -}}
---
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: {{ $fullname }}-metrics
  namespace: d8-monitoring
  {{- include "helm_lib_module_labels" (list $context (dict "prometheus" "main" "app" $fullname)) | nindent 2 }}
spec:
  jobLabel: app
  podMetricsEndpoints:
    - port: https-metrics
      path: /metrics
      scheme: https
      bearerTokenSecret:
        name: prometheus-token
        key: token
      tlsConfig:
        insecureSkipVerify: true
      honorLabels: true
      scrapeTimeout: {{ include "helm_lib_prometheus_target_scrape_timeout_seconds" (list $context 25) }}
      relabelings:
      - regex: "endpoint|pod|container"
        action: labeldrop
      - targetLabel: job
        replacement: {{ $fullname }}
      - sourceLabels: [__meta_kubernetes_pod_node_name]
        targetLabel: node
      - targetLabel: tier
        replacement: cluster
      - sourceLabels: [__meta_kubernetes_pod_ready]
        regex: "true"
        action: keep
    {{- with $additionalRelabelings }}
      {{- toYaml . | nindent 6 }}
    {{- end }}
  selector:
    matchLabels:
      app: {{ $fullname }}
  namespaceSelector:
    matchNames:
      - {{ $targetNamespace }}

  {{- end -}}
{{- end -}}