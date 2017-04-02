#!/bin/sh
set -e

# Generate the Caddyfile based on the following heredoc template
cat >${CADDY_FILE} <<EOF
${CADDY_PROXY_DOMAINS:-"localhost"}
proxy / ${CADDY_PROXY_TO:-"blog:2368"} {
  transparent
}
${CADDY_STATS:+"expvar /stats"}
tls ${CADDY_TLS:-off}
EOF

exec $@
