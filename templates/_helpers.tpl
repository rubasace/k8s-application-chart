{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kubernetes-application.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubernetes-application.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubernetes-application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubernetes-application.labels" -}}
helm.sh/chart: {{ include "kubernetes-application.chart" . }}
{{ include "kubernetes-application.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubernetes-application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubernetes-application.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubernetes-application.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kubernetes-application.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create a default TLS secret name.
*/}}
{{- define "kubernetes-application.tlsSecretName" -}}
{{- if .Values.ingress.tlsSecretName }}
{{- .Values.tlsSecretName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "ingress-tls" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create oauth2 annotations.
*/}}
{{- define "kubernetes-application.oauth2Annotations" -}}
{{- $authUrl := .Values.ingress.oauth2AuthUrl | default "http://oauth2-proxy.ingress.svc.cluster.local/oauth2/auth" -}}
{{- $signinUrl := .Values.ingress.oauth2SigninUrl | default (printf "https://auth.%s/oauth2/start" .Values.ingress.domain) -}}
nginx.ingress.kubernetes.io/auth-url: {{ $authUrl }}
nginx.ingress.kubernetes.io/auth-signin: {{ $signinUrl }}
{{- end }}