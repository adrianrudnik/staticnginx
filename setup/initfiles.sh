#!/bin/sh

set -eu

ME=$(basename "$0")
TARGET_OWNER=$(stat -c "%u:%g" /usr/share/nginx/html/)

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

if [ -n "$(ls -A '/docker-entrypoint-files-replace.d')" ]; then
    entrypoint_log "$ME: info: Processing installable files to be replaced from /docker-entrypoint-files-replace.d"
    rsync -ahq --chown=$TARGET_OWNER --delete /docker-entrypoint-files-replace.d/ /usr/share/nginx/html/
fi

if [ -n "$(ls -A '/docker-entrypoint-files-add.d')" ]; then
    entrypoint_log "$ME: info: Processing installable files to be added from /docker-entrypoint-files-add.d"
    rsync -ahq --chown=$TARGET_OWNER /docker-entrypoint-files-add.d/ /usr/share/nginx/html/
fi
