# caddy

Custom Caddy image with two plugins compiled in:

- **[caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare)** — DNS-01 ACME challenge provider for Cloudflare
- **[pberkel/caddy-storage-redis](https://github.com/pberkel/caddy-storage-redis)** — Redis-backed certificate storage for multi-replica deployments

Published to `ghcr.io/unkempthenry/caddy`.

## Runtime configuration

### Cloudflare DNS

The Cloudflare plugin reads your API token from the environment:

```
CLOUDFLARE_API_TOKEN=<your-token>
```

Required token scopes (scoped to the target zone(s)):
- Zone → Zone → **Read**
- Zone → DNS → **Edit**

Example Caddyfile snippet:

```
tls {
  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
}
```

### Redis storage

Configure via environment variables — see the [pberkel/caddy-storage-redis docs](https://github.com/pberkel/caddy-storage-redis) for the full list. Common vars:

```
REDIS_ADDRESS=redis:6379
REDIS_PASSWORD=
REDIS_DB=0
```

Example Caddyfile snippet:

```
{
  storage redis {
    address {env.REDIS_ADDRESS}
  }
}
```

## Image verification

Images are signed with [Cosign](https://github.com/sigstore/cosign) keyless signing via GitHub Actions OIDC. Verify with:

```sh
cosign verify \
  --certificate-identity "https://github.com/unkempthenry/caddy-cloudflare-dns-redis-store/.github/workflows/build.yml@refs/heads/main" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
  ghcr.io/unkempthenry/caddy:latest
```

## Adding caddy-security

Uncomment the `--with github.com/greenpau/caddy-security` line in the Dockerfile and push to trigger a rebuild.
