FROM abiosoft/caddy

ENV ACME_AGREE true

COPY ./caddy.config/Caddyfile /etc/Caddyfile

