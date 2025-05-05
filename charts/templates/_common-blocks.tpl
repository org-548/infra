{{/* Common used metadata of ServiceAccount */}}
{{- define "sa-metadata" }}
name: {{ .sa_name }}
namespace: {{ .namespace }}
{{- end }}

{{/* key/values of the Deployments label */}}
{{- define "deploy-labels" }}
{{ .label_key }}: {{ .label_value }}-deploy
{{- end }}
