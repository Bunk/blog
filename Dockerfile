FROM bunk/alpine-ghost:1.5.1
MAINTAINER JD Courtoy <jd.courtoy@gmail.com>

COPY ./src $GHOST_SOURCE
COPY ./entrypoint.sh /entry.sh

ENTRYPOINT [ "/sbin/tini", "--", "/entry.sh" ]
CMD [ "npm", "start" ]
