
{{- /*  A table showing which `ConstraintTemplate` object is responsible for parameter validation. This is needed to generate the correct annotation.  */ -}}
{{- /*  Auxiliary internal function */ -}}
{{- define "helm_lib_module_pss_rules_table" }}
securityContext:
  readOnlyRootFilesystem: d8readonlyrootfilesystem
  allowPrivilegeEscalation: d8allowprivilegeescalation
  capabilities: d8allowedcapabilities
  runAsUser: d8allowedusers
  runAsNonRoot: d8allowedusers
  seccompProfile: d8allowedseccompprofiles
  appArmorProfile: d8apparmor
  seLinuxOptions: d8selinux
  privileged: d8privilegedcontainer
  procMount: d8allowedprocmount
  sysctls: d8allowedsysctls
network:
  hostNetwork: d8hostnetwork
  hostPID: d8hostprocesses
  hostIPC: d8hostprocesses
  hostPorts: d8hostnetwork
volumes:
  hostPath: d8allowedhostpaths
  type: d8allowedvolumetypes
{{- end }}



{{- /* Usage: {{ include "helm_lib_module_pss_settings" ( dict "securityContext" $settings ) }} */ -}}
{{- /* settings example */ -}}
{{- /* 
settings:
    securityContext:                             
        readOnlyRootFilesystem: true             
        allowPrivilegeEscalation: false          
        capabilities:                            
            drop:                                
                - ALL                            
            add:
                - NET_BIND_SERVICE   
        runAsUser: 1000                          
        runAsGroup: 3000                         
        runAsNonRoot: true                       
        appArmorProfile:
            type: localhost/*
        localhostProfile: k8s-apparmor-example-deny-write       
        seccompProfile:                          
            type: RuntimeDefault                 
        privileged: false                        
        procMount: Default                       
        sysctls:                                 
          - name: net.ipv4.ip_local_port_range 
            value: "1024 65535"                
        seLinuxOptions:                          
            user: system_u                       
            role: system_r                       
            type: container_init_t                   
            level: s0 
    network:
        hostNetwork: true
        hostPID: false
        hostIPC: false
        hostPorts:
        - containerPort: 8081
          hostPort: 12345
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for metrics of example-service
        - containerPort: 8080
          hostPort: 12346
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for connetions to example-service
    volumes: 
        hostPath:
            - path: /var/logs
              type: Directory
              metadata:
                desc: For parsing logs                         
*/ -}}
{{- /* return securityContext */ -}}

{{- define "helm_lib_module_pss_settings" }}
{{- with .securityContext }}
securityContext:
  readOnlyRootFilesystem:{{ if hasKey . "readOnlyRootFilesystem" }} {{ .readOnlyRootFilesystem }}{{ else }} true{{ end }}
  allowPrivilegeEscalation:{{ if hasKey . "allowPrivilegeEscalation" }} {{ .allowPrivilegeEscalation }}{{ else }} false{{ end }}
  capabilities:
    drop:
      - all
    {{- if .capabilities.add }}
    add: 
      {{- .capabilities.add | toYaml | nindent 6 }}
    {{- end }}
  runAsUser: {{ .runAsUser | default 64535 }}
  runAsGroup: {{ .runAsGroup | default 64535 }}
  {{- if .fsGroup }}
  fsGroup: {{ .fsGroup }}
  {{- end }}
  runAsNonRoot:{{ if hasKey . "runAsNonRoot" }} {{ .runAsNonRoot }}{{ else }} true{{ end }}
  seccompProfile:
    type: {{ .seccompProfile.type | default "RuntimeDefault" }}
  {{- if .windowsOptions }}
    {{- if hasKey .windowsOptions "hostProcess" }}
  windowsOptions:
    hostProcess: {{ .windowsOptions.hostProcess }}
    {{- end }}
  {{- end }}
  {{- if hasKey . "privileged" }}
  privileged: {{ .privileged | default false }}
  {{- end }}
  procMount: {{ .procMount | default "Default" }}
  {{- if hasKey . "appArmorProfile" }}
    {{- if hasKey .appArmorProfile "type" }}
  appArmorProfile: 
    {{- .appArmorProfile | toYaml | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if hasKey . "seLinuxOptions" }}
  seLinuxOptions:
    {{-  .seLinuxOptions | toYaml | nindent 4 }}
  {{- end }}
  {{- if .sysctls }}
  sysctls:
  {{- range .sysctls }}
    - name: {{ .name }}
      value: {{ .value }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end }}


{{- /*  Auxiliary internal function */ -}}
{{- define "helm_lib_module_pss_generate_annotation" }}
  {{- $type := .type -}}
  {{- $param := .param -}}
  {{- $annotation_info := .annotation_info -}}
  {{- $helm_lib_module_pss_rules_table := fromYaml (include "helm_lib_module_pss_rules_table" .) -}}
  
  {{- if hasKey $helm_lib_module_pss_rules_table $type }}
    {{- $rulesForType := index $helm_lib_module_pss_rules_table $type -}}
    {{- if hasKey $rulesForType $param }}
      {{- $constraint := index $rulesForType $param -}}
      {{- if eq $param "hostPorts" -}}
        {{- $description := .metadata.desc }}
        {{- dict ( printf "security.deckhouse.io/skip-pss-check/%s/hostPort/%.0f" $constraint .portNumber ) $description  | toYaml }}
      {{- else if eq $param "hostPath" -}}
        {{- $description := .metadata.desc }}
        {{- dict ( printf "security.deckhouse.io/skip-pss-check/%s/hostPath/_%s_" $constraint .path ) $description  | toYaml }}
      {{- else }}
        {{- $description := index $annotation_info $type $param }}
        {{- dict ( printf "security.deckhouse.io/skip-pss-check/%s" $constraint ) $description  | toYaml }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{- /*  Auxiliary internal function */ -}}
{{- define "helm_lib_module_pss_merge_annotations" }}
  {{- $output := dict }}
  {{- $annotation := fromYaml .annotation -}}
  {{- $annotations := fromYaml .annotations -}}
    {{- range $key, $value := $annotation -}}
      {{- if hasKey $annotations $key -}}
        {{- $output = set $annotations $key (printf "%s\n%s" (index $annotations $key) $value) -}}
      {{- else -}}
        {{- $output = set $annotations $key $value -}}
      {{- end -}}
    {{- end -}}
  {{- $output | toYaml -}}
{{- end }}


{{- /* Usage: {{- include "helm_lib_module_pss_annotations" ( dict "settings" $settings "annotation_info" $annotation_info ) | nindent 2 }} */ -}}
{{- /* settings example */ -}}
{{- /* 
settings:
    securityContext:                             
        readOnlyRootFilesystem: true             
        allowPrivilegeEscalation: false          
        capabilities:                            
            drop:                                
                - ALL                            
            add:
                - NET_BIND_SERVICE   
        runAsUser: 1000                          
        runAsGroup: 3000                         
        runAsNonRoot: true                       
        appArmorProfile:
            type: localhost/*
        localhostProfile: k8s-apparmor-example-deny-write       
        seccompProfile:                          
            type: RuntimeDefault                 
        privileged: false                        
        procMount: Default                       
        sysctls:                                 
          - name: net.ipv4.ip_local_port_range 
            value: "1024 65535"                
        seLinuxOptions:                          
            user: system_u                       
            role: system_r                       
            type: container_init_t                   
            level: s0 
    network:
        hostNetwork: true
        hostPID: false
        hostIPC: false
        hostPorts:
        - containerPort: 8081
          hostPort: 12345
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for metrics of example-service
        - containerPort: 8080
          hostPort: 12346
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for connetions to example-service
    volumes: 
        hostPath:
            - path: /var/logs
              type: Directory
              metadata:
                desc: For parsing logs                      
*/ -}}
{{- /* annotation_info example */ -}}
{{- /* 
annotation_info:
    securityContext:
        capabilities: |
            On some systems, the `timex` collector requires an additional capability `SYS_TIME`
            See https://github.com/prometheus/node_exporter/blob/v1.9.1/README.md?plain=1#L71
        runAsUser: |
            runAsUser.
            I added this field only for demonstration purposes.
        runAsNonRoot: |
            runAsNonRoot.
            I added this field only for demonstration purposes.
        allowPrivilegeEscalation: |
            allowPrivilegeEscalation.
            I added this field only for demonstration purposes.
        seccompProfile: |
            seccompProfile.
            I added this field only for demonstration purposes.
        windowsOptions: |
            windowsOptions.
            I added this field only for demonstration purposes.
        privileged: |
            privileged.
            I added this field only for demonstration purposes.
        procMount: |
            procMount.
            I added this field only for demonstration purposes.
        seLinuxOptions: |
            seLinuxOptions.
            I added this field only for demonstration purposes.
        sysctls: |
            sysctls.
            I added this field only for demonstration purposes.
        appArmorProfile: |
            appArmorProfile.
            I added this field only for demonstration purposes.
    network:
        hostNetwork: |
            hostNetwork.
            I added this field only for demonstration purposes.
        hostPID: |
            hostPID.
            I added this field only for demonstration purposes.
        hostIPC: |
            hostIPC.
            I added this field only for demonstration purposes.
                    
*/ -}}
{{- /* return annotations */ -}}

{{- define "helm_lib_module_pss_annotations" }}
{{- $annotation_info := .annotation_info -}}
{{- $annotations := "" -}}
{{- with .settings.securityContext }}
  {{- /* allowPrivilegeEscalation. Acceptable values: false, nd */ -}}
  {{- $allowPrivilegeEscalation := default false .allowPrivilegeEscalation -}}
  {{- if (ne $allowPrivilegeEscalation false) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "allowPrivilegeEscalation") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{ end }}

  {{- /* Acceptable values for capabilities: */ -}}
  {{- $validCapabilities := list "NET_BIND_SERVICE" -}}
  {{- /* Проверка capabilities */ -}}
  {{- if (and .capabilities .capabilities.add) }}
    {{- range .capabilities.add }}
      {{- if not (has . $validCapabilities) }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "capabilities") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}      
      {{- end }}
    {{- end }}
  {{- end }}

  {{- /* runAsUser: only non-zero values ​​are allowed */ -}}
  {{- $runAsUser := default "" (quote .runAsUser) -}}
  {{- if eq $runAsUser (quote 0) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "runAsUser") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}      
  {{- end }}

  {{- /* runAsNonRoot. Acceptable values: true */ -}}
  {{- $runAsNonRoot := true -}}
  {{- if hasKey . "runAsNonRoot" }}
    {{- $runAsNonRoot = .runAsNonRoot }}
  {{- end }}
  {{- if (ne $runAsNonRoot true) }}

    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "runAsNonRoot") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
  {{- end }}

  {{- /* seccompProfile. Acceptable values: "RuntimeDefault" */ -}}
  {{- if (and .seccompProfile (ne (default "RuntimeDefault" .seccompProfile.type) "RuntimeDefault")) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "seccompProfile") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
  {{- end }}

  {{- /* privileged. Acceptable values: false, nd */ -}}
  {{- $privileged := false -}}
  {{- if hasKey . "privileged" }}
    {{- $privileged = .privileged }}
  {{- end }}
  {{- if (ne $privileged false) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "privileged") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
  {{- end }}

  {{- /* procMount. Acceptable values: "Default", nd */ -}}
  {{- if (ne (default "Default" .procMount) "Default") }}
    {{- include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "procMount") }}
  {{- end }}

  {{- /* seLinuxOptions */ -}}
  {{- if .seLinuxOptions }}
    {{- $selinuxType := default "" .seLinuxOptions.type -}}
    {{- $validSELinuxTypes := list "container_t" "container_init_t" "container_kvm_t" "container_engine_t" "" -}}
    {{- if (not (has $selinuxType $validSELinuxTypes)) }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "seLinuxOptions") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
    {{- end }}
  {{- end }}

  {{- /* appArmorProfile */ -}}
  {{- if .appArmorProfile }}
    {{- $appArmorProfileType := default "" .appArmorProfile.type -}}
    {{- $validappArmorProfileTypes := list "runtime/default" "localhost/*" "" -}}
    {{- if (not (has $appArmorProfileType $validappArmorProfileTypes)) }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "appArmorProfile") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
    {{- end }}
  {{- end }}

  {{- /* sysctls */ -}}
  {{- if .sysctls }}
    {{- $isAnnotationNeeded := false -}}
    {{- $allowedSysctls := list "kernel.shm_rmid_forced" "net.ipv4.ip_local_port_range" "net.ipv4.ip_unprivileged_port_start" "net.ipv4.tcp_syncookies" "net.ipv4.ping_group_range" "net.ipv4.ip_local_reserved_ports" "net.ipv4.tcp_keepalive_time" "net.ipv4.tcp_fin_timeout" "net.ipv4.tcp_keepalive_intvl" "net.ipv4.tcp_keepalive_probes" -}}
    {{- range .sysctls }}
      {{- if (and .name (not (has .name $allowedSysctls))) }}
        {{- $isAnnotationNeeded = true }}
      {{- end }}
    {{- end }}
    {{- if $isAnnotationNeeded }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "sysctls") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
    {{- end }}
  {{- end }}
{{- end }}
{{- with .settings.network }}
  {{- if .hostNetwork }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostNetwork") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{- end }}
  {{- if .hostPID }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostPID") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{- end }}
  {{- if .hostIPC }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostIPC") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{- end }}
  {{- if .hostPorts }}
      {{- range .hostPorts }}
        {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostPorts" "portNumber" .hostPort "metadata" .metadata) }}
        {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
      {{- end }}
  {{- end }}
{{- end }}
{{- with .settings.volumes }}
  {{- if .hostPath }}
      {{- range .hostPath }}
        {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "volumes" "param" "hostPath" "path" .path "metadata" .metadata) }}
        {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
      {{- end }}
  {{- end }}
{{- end }}

{{ $annotations  }}   
{{- end }}

