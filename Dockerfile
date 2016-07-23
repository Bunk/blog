FROM bunk/alpine-ghost
MAINTAINER JD Courtoy <jd.courtoy@gmail.com>

# copy any additional themes
COPY ./content $GHOST_CONTENT
