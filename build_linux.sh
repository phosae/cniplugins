#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

if [ "$(uname)" == "Darwin" ]; then
	export GOOS="${GOOS:-linux}"
fi

export GOFLAGS="${GOFLAGS} -mod=mod"

mkdir -p "${PWD}/bin"

echo "Building plugins ${GOOS}"
PLUGINS="plugins/meta/*"
for d in $PLUGINS; do
	if [ -d "$d" ]; then
		plugin="$(basename "$d")"
		if [ "${plugin}" != "windows" ]; then
			echo "  $plugin"
			${GO:-go} build -o "${PWD}/bin/$plugin" "$@" ./"$d"
		fi
	fi
done
