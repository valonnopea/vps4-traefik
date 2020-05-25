#!/bin/bash
set -e

CONTROL_PORT="${TRAEFIK_PORT:-"7080"}"
NAME="${TRAEFIK_NAME:-"traefik"}"
IMAGE="${TRAEFIK_IMAGE:-"traefik:latest"}"
CONFIG="${TRAEFIK_CONFIG:-"${PWD}/traefik.yml"}"
CONFIG_DIR="${TRAEFIK_CONFIG_DIR:-"${PWD}/configs"}"
LETSENCRYPT="${TRAEFIK_LETSENCRYPT:-"/etc/letsencrypt"}"

docker 'run' \
	--detach \
	--publish '80:80' \
	--publish '443:443' \
	--publish "${CONTROL_PORT}:8080" \
	--restart 'always' \
	--volume "${CONFIG}:/etc/traefik/traefik.yml" \
	--volume "${LETSENCRYPT}:/letsencrypt" \
	--volume "${CONFIG_DIR}:/etc/traefik/configs" \
	--volume '/var/run/docker.sock:/var/run/docker.sock' \
	--name "${NAME}" \
	"${IMAGE}"
