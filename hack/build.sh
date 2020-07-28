#! /usr/bin/env bash
# Helper script to build the workshop spawner

LOCATION=${1:local}
QUAY_PROJECT=${2:-redhatgov}

cd $(dirname $(realpath $0))/../dashboard
if [ -f .quay_creds -a -z "$1" ]; then
  LOCATION=quay
  . .quay_creds
fi

case $LOCATION in
  local)
    podman build -t quay.io/$QUAY_PROJECT/workshop-dashboard:latest .
  ;;
  quay)
    # designed to be used by travis-ci, where the docker_* variables are defined
    if [ -z "$DOCKER_PASSWORD" -o -z "$DOCKER_USERNAME" ]; then
        echo "Requires DOCKER_USERNAME and DOCKER_PASSWORD variables to be exported." >&2
        exit 1
    fi
    echo "$DOCKER_PASSWORD" | podman login -u "$DOCKER_USERNAME" --password-stdin quay.io

    podman build -t quay.io/$QUAY_PROJECT/workshop-dashboard:latest .
    podman push quay.io/$QUAY_PROJECT/workshop-dashboard:latest
  ;;
  *)
    echo "usage: ./hack/build.sh [local|quay] [QUAY_PROJECT]"
  ;;
esac
