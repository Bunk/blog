FROM klakegg/hugo:ext-alpine-onbuild AS hugo

FROM nginx
COPY --from=hugo /onbuild /usr/share/nginx/html
