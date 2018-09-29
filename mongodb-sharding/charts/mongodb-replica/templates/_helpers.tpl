{{/* vim: set filetype=mustache: */}}
{{/*
Name of the app.
*/}}
{{- define "mongo.name" -}}
{{- if eq .Values.replicas.svr  "configsvr" -}}
{{- printf "%s" .Values.global.config.name -}}
{{- else -}}
{{- printf "%s%s" .Values.global.mongod.name .Values.replicas.idx -}}
{{- end -}}
{{- end -}}
{{/*
Name of the service.
*/}}
{{- define "service.name" -}}
{{- if eq .Values.replicas.svr  "configsvr" -}}
{{- printf "%s" .Values.global.config.repName -}}
{{- else -}}
{{- printf "%s%s" .Values.global.mongod.repName .Values.replicas.idx -}}
{{- end -}}
{{- end -}}
{/*
number per replicas.
*/}}
{{- define "replicas.num" -}}
{{- if eq .Values.replicas.svr  "configsvr" -}}
{{- printf "%s" .Values.global.config.repNum -}}
{{- else -}}
{{- printf "%s" .Values.global.mongod.repNum -}}
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
