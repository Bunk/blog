#!/bin/sh
set -e

# Generate the Caddyfile based on the following heredoc template
cat >${CADDY_FILE} <<EOF
${CADDY_PROXY_DOMAINS:-"*.courtoy.io"}
proxy / ${CADDY_PROXY_TO:-"blog:2368"} {
  transparent
}
expvar /stats
tls ${CADDY_TLS:-off}
EOF

exec /usr/bin/caddy -conf ${CADDY_FILE} -log stdout -agree $@
# exec /bin/sh
