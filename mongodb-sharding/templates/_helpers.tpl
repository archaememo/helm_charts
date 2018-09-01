{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{/*
Create the name of config service
*/}}
{{- define "mongodb-conf.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-conf" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create config service list
*/}}
{{- define "cfgsvr.list" -}}
{{- $repName := .Values.config.replicas.name -}}
{{- $repNum := (int (.Values.config.replicas.num)) -}}
{{- $mdName := .Values.config.mongod.name -}}
{{- $mdPort := .Values.config.mongod.port -}}
{{- $rlName := .Release.Name -}}
{{- printf "%s/" .Values.config.replicas.name -}}
{{- $num := .Values.config.replicas.num -}}
{{- range $val := .Values.loop8 -}}
{{- if lt (int ($val)) $repNum -}}
{{- printf "%s-%s-%s.%s-%s.default.svc.cluster.local:%s," $mdName $rlName $val $repName $rlName $mdPort -}}
{{- else if eq (int ($val)) $repNum -}}
{{- printf "%s-%s-%s.%s-%s.default.svc.cluster.local:%s"  $mdName $rlName $val $repName $rlName $mdPort -}}
{{- else -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mongodb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of shard
*/}}
{{- define "mongodb-shard.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-shard" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of mongos service
*/}}
{{- define "mongodb-mongos.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-mongos" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongodb.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongodb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
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
