FROM bunk/alpine-ghost:0.11.10
MAINTAINER JD Courtoy <jd.courtoy@gmail.com>

COPY ./src $GHOST_SOURCE
COPY ./entrypoint.sh /entry.sh

ENTRYPOINT [ "/sbin/tini", "--", "/entry.sh" ]
CMD [ "npm", "start" ]
