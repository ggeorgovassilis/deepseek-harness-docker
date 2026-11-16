#!/usr/bin/env bash
set -Eeuo pipefail

# Convenience wrapper for the DeepSeek Harness container. It uses the
# toolchain image (the base image plus GitHub CLI) so the coding agent can
# drive GitHub from inside the container.

# Resolve symlinks so the repo root is found even when invoked via run.sh.
script_path="${BASH_SOURCE[0]}"
while [ -L "${script_path}" ]; do
  link_dir="$(cd -P "$(dirname "${script_path}")" && pwd)"
  script_path="$(readlink "${script_path}")"
  case "${script_path}" in
    /*) ;;
    *) script_path="${link_dir}/${script_path}" ;;
  esac
done

repo_dir="$(cd -P "$(dirname "${script_path}")/.." && pwd)"
cd "${repo_dir}"

image="deepseek-harness-toolchain:0.2.2-rc.1-r1"
compose=(docker compose -f compose.yaml -f compose.toolchain.yaml)

usage() {
  cat <<'EOF'
Usage: run.sh [COMMAND]

Commands:
  build              Build the toolchain image (adds gh on top of the base image)
  up                 Start the container, building the image first if needed (default)
  down               Stop and remove the container (volumes are kept)
  logs               Follow container logs (shows the dsh web access URL/token)
  ps                 Show container status
  exec CMD...        Run a command inside the running container
  help               Show this message
EOF
}

cmd="${1:-up}"
if [[ "$#" -gt 0 ]]; then shift; fi

case "${cmd}" in
  build)
    docker build -f Dockerfile.toolchain -t "${image}" .
    ;;
  up)
    if ! docker image inspect "${image}" >/dev/null 2>&1; then
      docker build -f Dockerfile.toolchain -t "${image}" .
    fi
    "${compose[@]}" up -d
    echo "Started. Get the access URL (token) with: run.sh logs"
    ;;
  down)
    "${compose[@]}" down
    ;;
  logs)
    "${compose[@]}" logs -f deepseek-harness
    ;;
  ps|status)
    "${compose[@]}" ps
    ;;
  exec)
    if [[ "$#" -eq 0 ]]; then
      echo "run.sh exec: missing command" >&2
      exit 1
    fi
    "${compose[@]}" exec deepseek-harness "$@"
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    echo "run.sh: unknown command: ${cmd}" >&2
    usage >&2
    exit 1
    ;;
esac
