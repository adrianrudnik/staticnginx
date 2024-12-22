FROM georgjung/nginx-brotli:1.27.3-bookworm AS base

# Shared folder is located at
# /usr/share/nginx/html

# Mount installables to, they will execute in given order:
# /docker-entrypoint-files-replace.d for rpelacements, everything else gets removed
# /docker-entrypoint-files-add.d for additions, will existing will be overwritten

# Additional location configuration can be mounted to
# /etc/nginx/vhost.conf.d/

USER root

EXPOSE 8080

RUN set -ex \
    && apt update && apt install -y --no-install-recommends rsync \
	&& rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && mkdir /docker-entrypoint-files-replace.d /docker-entrypoint-files-add.d /etc/nginx/vhost.conf.d

COPY setup/initfiles.sh /docker-entrypoint.d/99-initfiles.sh
COPY setup/nginx.conf /etc/nginx/nginx.conf
COPY setup/vhost.conf /etc/nginx/conf.d/default.conf
