version: 0.36.3

.options: &options
  namespace: somens
  wait: true
  timeout: 100s
  create_namespace: true

releases:
  {{- with readFile "releases.yaml" | fromYaml | get "releases" }}
  {{ range $value := . }}
  - name: {{ $value | get "name" }}
    chart:
      name: .
    tags: [{{ $value | get "name" }}]
    values:
      - values/{{ $value | get "name" }}-values.yaml
    {{ $rel_name := $value | get "name" }}
    {{- if eq $rel_name "frontend" }}
    depends_on:
      - backend
    {{- end }}
    <<: *options
  {{ end }}
  {{- end }}

