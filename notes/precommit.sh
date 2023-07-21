#!/bin/sh

README_FILE=README.md

for dir in `find . -type d`; do
    pushd "$dir"

    : > "$README_FILE"
    i=0

    for f in *.md; do
        if [[ ! "$f" = "$README_FILE" ]]; then
            echo "- [$f]($f)" >> "$README_FILE"
            ((i++))
        fi
    done

    if [[ "$i" -lt 1 ]]; then
        rm "$README_FILE"
    fi

    popd
done

markdown-optimize-images.py
find . -type f -iname "*.md" -exec git add {} \;
find . -type f -iname "*.webp" -exec git lfs track {} \;
find . -type f -iname "*.webp" -exec git add {} \;