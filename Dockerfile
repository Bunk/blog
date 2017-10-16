FROM ghost:1.13.0-alpine
LABEL maintainer="JD Courtoy <docker@courtoy.io>"

COPY ./src/content /var/lib/ghost/content
