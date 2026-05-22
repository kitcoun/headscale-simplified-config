server:
  host: "0.0.0.0"
  port: 3000

  # 不要带 /admin
  base_url: "https://${DHE_TAILSCALE_HOST}"

  cookie_secret: "534445516d31627e0bf96284d367ebd2"
  cookie_secure: true
  cookie_max_age: 86400

  data_path: "/var/lib/headplane"

headscale:
  url: "http://headscale:8080"
  public_url: "https://${DHE_TAILSCALE_HOST}"
  config_path: "/etc/headscale/config.yaml"
  config_strict: true
  dns_records_path: "/etc/headscale/dns_records.json"

integration:
  agent:
    enabled: false
    pre_authkey: ""

  docker:
    enabled: true
    container_label: "me.tale.headplane.target=headscale"
    socket: "unix:///var/run/docker.sock"

  kubernetes:
    enabled: false
    validate_manifest: true
    pod_name: "headscale"

  proc:
    enabled: false

# 不配置 OIDC 时，Headplane 登录依赖 Headscale API Key
# oidc:
#   enabled: true
