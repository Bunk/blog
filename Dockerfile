FROM bunk/alpine-ghost
MAINTAINER JD Courtoy <jd.courtoy@gmail.com>

# The base image
COPY ./src $GHOST_SOURCE
