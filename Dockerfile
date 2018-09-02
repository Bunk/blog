FROM klakegg/hugo:ext-alpine-onbuild AS hugo

FROM nginx:alpine
COPY --from=hugo /onbuild /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx
