# Integrate Pi-hole with DNS-over-HTTPS (DoH)

Recommended method: **cloudflared** as a local DNS proxy.

## Option 1: Docker Compose (recommended)

Create or edit your `docker-compose.yml`:

```yaml
version: "3"

services:
  cloudflared:
    image: cloudflare/cloudflared:latest
    container_name: cloudflared
    restart: unless-stopped
    command: proxy-dns
    environment:
      - TUNNEL_DNS_UPSTREAM=https://1.1.1.1/dns-query,https://1.0.0.1/dns-query
    # Alternative upstreams (uncomment if desired):
    # - TUNNEL_DNS_UPSTREAM=https://dns.quad9.net/dns-query,https://dns.google/dns-query
    networks:
      - pihole_net

  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    restart: unless-stopped
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80/tcp"
      - "443:443/tcp"
    environment:
      TZ: 'Europe/Madrid'
      WEBPASSWORD: 'change_me'
    volumes:
      - './etc-pihole:/etc/pihole'
      - './etc-dnsmasq.d:/etc/dnsmasq.d'
    depends_on:
      - cloudflared
    networks:
      - pihole_net

networks:
  pihole_net:
    driver: bridge
```

### Configure Pi-hole

1. Open Pi-hole admin interface → **Settings** → **DNS**
2. Uncheck all upstream DNS servers
3. In **Custom 1 (IPv4)** enter:
   ```
   cloudflared#5053
   ```
   (or `172.x.x.x#5053` if you prefer the IP)

4. Save

## Option 2: Bare metal / VM

### Install cloudflared

```bash
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
```

### Configure

```bash
sudo mkdir -p /etc/cloudflared
sudo nano /etc/cloudflared/config.yml
```

Content:

```yaml
proxy-dns: true
proxy-dns-port: 5053
proxy-dns-upstream:
  - https://1.1.1.1/dns-query
  - https://1.0.0.1/dns-query
```

### Create systemd service

```bash
sudo cloudflared service install
sudo systemctl enable --now cloudflared
```

### Point Pi-hole to it

In Pi-hole → Settings → DNS → Custom 1:

```
127.0.0.1#5053
```

## Option 3: dnscrypt-proxy (alternative)

```bash
sudo apt update
sudo apt install dnscrypt-proxy
```

Edit `/etc/dnscrypt-proxy/dnscrypt-proxy.toml` and set Pi-hole upstream to `127.0.0.1:53` (adjust ports if needed).

## Verify

```bash
# Test from host
dig @127.0.0.1 -p 5053 example.com

# Or inside Pi-hole
pihole -t
```

## Popular DoH upstreams

| Provider   | URL                              |
|------------|----------------------------------|
| Cloudflare | `https://1.1.1.1/dns-query`      |
| Quad9      | `https://dns.quad9.net/dns-query`|
| Google     | `https://dns.google/dns-query`   |
| AdGuard    | `https://dns.adguard-dns.com/dns-query` |

## Notes

- DoH encrypts DNS queries between your Pi-hole and the upstream resolver.
- Pi-hole still sees all local queries (this is desired for blocking).
- cloudflared is lightweight and well maintained.
