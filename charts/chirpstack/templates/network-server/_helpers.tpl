{{- define "chirpstack.networkserver.labels" -}}
app.kubernetes.io/name: {{ template "chirpstack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.networkserver.image.tag }}
app.kubernetes.io/component: "{{ .Values.networkserver.name }}"
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}


{{- define "chirpstack.networkserver.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.networkserver.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.networkserver.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "chirpstack.networkserver.selector" -}}
app.kubernetes.io/name: {{ template "chirpstack.networkserver.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "chirpstack.networkserver.postgres.dsn" -}}
{{- printf "user=$(POSTGRESQL__USER) password=$(POSTGRESQL__PASSWORD) host=%s dbname=%s sslmode=%s" .Values.networkserver.postgres.host .Values.networkserver.postgres.dbname .Values.networkserver.postgres.sslmode -}}
{{- end -}}


{{- define "chirpstack.networkserver.backend" -}}
{{- if eq .Values.networkserver.gateway.backend.type "mqtt" -}}
{{- $mqttSecret := .Values.networkserver.gateway.backend.mqtt.existingSecret | default "secret.not.set" | quote -}}
- name: NETWORK_SERVER__GATEWAY__BACKEND__MQTT__SERVER
  value: {{ .Values.networkserver.gateway.backend.mqtt.server }}
- name: NETWORK_SERVER__GATEWAY__BACKEND__MQTT__USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $mqttSecret }}
      key: username
      optional: true
- name: NETWORK_SERVER__GATEWAY__BACKEND__MQTT__PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $mqttSecret  }}
      key: password
      optional: true
- name: NETWORK_SERVER__GATEWAY__BACKEND__MQTT__CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ $mqttSecret }}
      key: clientId
      optional: true
{{- else -}}
{{- fail "networkserver: backend type not supported" -}}
{{- end -}}
{{- end -}}


{{- define "chirpstack.join.default.server" -}}
{{- if and (.Values.appserver.enabled) (not .Values.networkserver.join.default.server) -}}
{{ template "chirpstack.appserver.fullname" . }}-join:8003
{{- else if not .Values.networkserver.join.default.server -}}
{{- fail "networkserver: You must set a join_server default address if app-server(disabled)" -}}
{{- else -}}
{{- printf "%s" .Values.networkserver.join.default.server -}}  
{{- end -}}
{{- end -}}