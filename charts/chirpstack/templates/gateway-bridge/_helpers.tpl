{{- define "chirpstack.gatewaybridge.labels" -}}
app.kubernetes.io/name: {{ template "chirpstack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.gatewaybridge.image.tag }}
app.kubernetes.io/component: "{{ .Values.gatewaybridge.name }}"
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}


{{- define "chirpstack.gatewaybridge.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.gatewaybridge.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.gatewaybridge.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}