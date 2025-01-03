{{/*
Expand the name of the chart.
*/}}
{{- define "e-commerce-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "e-commerce-app.fullname" -}}
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
{{- define "e-commerce-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "e-commerce-app.labels" -}}
helm.sh/chart: {{ include "e-commerce-app.chart" . }}
{{ include "e-commerce-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "e-commerce-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "e-commerce-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "e-commerce-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "e-commerce-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "dbHost" -}}
{{ .Release.Name }}-db.{{ .Release.Namespace }}.svc.cluster.local
{{- end -}}

{{- define "e-commerce.uniqueKey" -}}
{{- printf "%s-%s" .Release.Name .Release.Namespace | trunc 6 -}}
{{- end -}}

# Test query to display initial data in the database
{{- define "testQuery" -}}
SELECT * FROM products;
{{- end -}}