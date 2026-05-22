# 参考文档
https://www.sunnypai.top/posts/tailscale%E7%BB%AD%E9%9B%86-%E8%87%AA%E5%BB%BAheadscalederp/
https://www.zkcoi.com/365up/program/4438.html

### 使用的域名
derp:`derp.ex.com`
tailscale:`tailscale.ex.com`

# 首先执行
```sh
docker network create derper_network || true
docker network create caddy_network || true
```

# 执行`headscale/docker-compose.yml`前需
1.要替换`headscale/headplane-config/config.yaml`的`cookie_secret`
```sh
openssl rand -hex 16
```
2.先初始化`dns_records.json`在项目中的`head`文件夹中执行
```sh
mkdir -p headscale-config headscale-data headplane-config headplane-data
echo "[]" > headscale-config/dns_records.json
```
3. 生成最终配置文件
```sh
cd head
./generate-headscale-configs.sh
```

请确保 `headscale/.env` 存在，并包含 `DHE_TAILSCALE_HOST`、`DHE_DERP_HOST` 和 `DHE_DERP_CERTS_DIR`。

# 安装

### 1. 安装证书,进入`acme`
```sh
docker compose up -d
```
1.
```sh
docker exec acme --set-default-ca --server letsencrypt

docker exec acme --issue \
  --dns \
  -d derp.ex.com \
  --server letsencrypt
```
2.手动DNS
```sh
docker exec acme --issue -d derp.ex.com --dns \
 --server letsencrypt \
 --yes-I-know-dns-manual-mode-enough-go-ahead-please

docker exec acme --renew -d derp.ex.com \
  --yes-I-know-dns-manual-mode-enough-go-ahead-please
```
⚠️ 注意：泛域名证书 必须使用 DNS 验证（HTTP 验证不支持）

3.复制修改证书后缀
```sh
sudo cp ../acme/certs/derp.ex.com_ecc/derp.ex.com.cer ../acme/certs/derp.ex.com_ecc/derp.ex.com.crt
```
### 2. 安装`derp`,进入`derp`
```sh
docker compose up -d
```

### 3. 安装`headscale`和`headplane`面板,进入`head`
```sh
docker compose up -d
```

