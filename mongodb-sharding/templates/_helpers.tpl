{{/* vim: set filetype=mustache: */}}

{{/*
Create config service list
*/}}
{{- define "cfgsvr.list" -}}
    {{- $repName := .Values.global.config.repName -}}
    {{- $repNum := (int (.Values.global.config.repNum)) -}}
    {{- $mdName := .Values.global.config.name -}}
    {{- $mdPort := .Values.global.port -}}
    {{- $rlName := .Release.Name -}}
    {{- printf "%s/" $repName -}}
    {{- range $val := .Values.loop8 -}}
        {{- $val_r := add (int ($val)) 1 -}}
        {{- if lt $val_r (int ($repNum)) -}}
            {{- printf "%s-%s-%s.%s-%s.default.svc.cluster.local:%s," $mdName $rlName $val $repName $rlName $mdPort -}}
        {{- else if eq $val_r (int ($repNum)) -}}
            {{- printf "%s-%s-%s.%s-%s.default.svc.cluster.local:%s" $mdName $rlName $val $repName $rlName $mdPort -}}
        {{- else -}}
        {{- end -}}
    {{- end -}}
{{- end -}}

{{/*
Create config service list
*/}}
{{- define "sharding.list" -}}
    {{- $repName := .Values.global.mongod.repName -}}
    {{- $repNum := (int (.Values.global.mongod.repNum)) -}}
    {{- $mdName := .Values.global.mongod.name -}}
    {{- $mdPort := .Values.global.port -}}
    {{- $rlName := .Release.Name -}}
    {{- $shNum := .Values.mongos.shardNum -}}
    {{- range $val := .Values.loop8 -}}
        {{- $val_r := add (int ($val)) 1 -}}
        {{- if le $val_r (int ($shNum)) -}}
            {{- printf "\"%s%s\": \"%s%s/" $repName $val $repName $val -}}
            {{- range $idx := $.Values.loop8 -}}
                {{- $idx_r := add (int ($idx)) 1 -}}
                {{- if lt $idx_r (int ($repNum)) -}}
                    {{- printf "%s%s-%s-%s.%s%s-%s.default.svc.cluster.local:%s," $mdName $val $rlName $idx $repName $val $rlName $mdPort -}}
                {{- else if eq $idx_r (int ($repNum)) -}}
                    {{- printf "%s%s-%s-%s.%s%s-%s.default.svc.cluster.local:%s\"" $mdName $val $rlName $idx $repName $val $rlName $mdPort -}}
                {{- else -}}
                {{- end -}}
            {{- end -}}
            {{- if lt $val_r (int ($shNum)) -}}
                {{- printf "\n" -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
{{- end -}}


{{/*
Create the name for the admin secret.
*/}}
{{- define "mongodb-replicaset.adminSecret" -}}
    {{- if .Values.auth.existingAdminSecret -}}
        {{- .Values.auth.existingAdminSecret -}}
    {{- else -}}
        {{- template "mongodb.fullname" . -}}-admin
    {{- end -}}
{{- end -}}

{{- define "mongodb-replicaset.metricsSecret" -}}
    {{- if .Values.auth.existingMetricsSecret -}}
        {{- .Values.auth.existingMetricsSecret -}}
    {{- else -}}
        {{- template "mongodb.fullname" . -}}-metrics
    {{- end -}}
{{- end -}}


{{/*
Create the name for the key secret.
*/}}
{{- define "mongodb-replicaset.keySecret" -}}
    {{- if .Values.auth.existingKeySecret -}}
        {{- .Values.auth.existingKeySecret -}}
    {{- else -}}
        {{- template "mongodb.fullname" . -}}-keyfile
    {{- end -}}
{{- end -}}
