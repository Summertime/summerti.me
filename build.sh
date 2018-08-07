#!/bin/bash
set -euo pipefail
shopt -s globstar
shopt -s extglob

rm -r build 2> /dev/null || true
for src in ./site/**; do
    dest=${src/site/build}
    echo -n "$src ==> $dest"

    if [[ -d $src ]]; then
        echo -n ' AS DIR'
        mkdir "$dest"

    elif [[ -f $src && $src == *.@(html|css) ]]; then
        echo -n ' AS TEXT'
        sed -E 's/^!!!EXEC (.*)$/\1/e' "$src" > "$dest"

    elif [[ -f $src ]]; then
        echo -n ' AS BINARY'
        cp "$src" "$dest"
    else
        echo -n ' AS NOCOPY!'
    fi
    echo
done
