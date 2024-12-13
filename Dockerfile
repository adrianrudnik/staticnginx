FROM georgjung/nginx-brotli:1.27.3-bookworm AS base

USER root

EXPOSE 8080

VOLUME [ "/usr/share/nginx/html" ]

COPY setup/nginx.conf /etc/nginx/nginx.conf
COPY setup/vhost.conf /etc/nginx/conf.d/default.conf
