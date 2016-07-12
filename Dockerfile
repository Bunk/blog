FROM bunk/alpine-ghost:latest
MAINTAINER JD Courtoy <jd.courtoy@gmail.com>

# copy any additional themes
COPY ./content $GHOST_CONTENT
