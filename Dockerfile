ARG CADDY_VERSION=2.11.4

FROM caddy:${CADDY_VERSION}-builder AS builder

ARG CADDY_VERSION

RUN xcaddy build v${CADDY_VERSION} \
    --with github.com/caddy-dns/cloudflare@a8737d095ad5a48ca031cea6ab704057dbc2d250 \
    --with github.com/pberkel/caddy-storage-redis@a9100c777a8a0be9e6e6203328b15fd9c2ed4e06
    # --with github.com/greenpau/caddy-security

# caddy-dns/cloudflare v0.2.4
# pberkel/caddy-storage-redis v1.8.0

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
