#!/bin/sh

README_FILE="README.md"

# Function to extract the first markdown title from a file
get_first_title() {
    local file="$1"
    grep -m1 '^# ' "$file" | sed 's/^# //'
}

# Function to get a formatted filename (without extension) as fallback
get_formatted_filename() {
    local file="$1"
    basename "$file" .md | sed 's/[_-]/ /g'
}

for dir in $(find . -type d); do
    pushd "$dir" > /dev/null

    : > "$README_FILE"
    i=0

    for f in *.md; do
        if [[ ! "$f" = "$README_FILE" ]]; then
            title=$(get_first_title "$f")
            if [[ -n "$title" ]]; then
                echo "- [$title]($f)" >> "$README_FILE"
                ((i++))
            else
                fallback_name=$(get_formatted_filename "$f")
                echo "- [$fallback_name]($f)" >> "$README_FILE"
                ((i++))
            fi
        fi
    done

    if [[ "$i" -lt 1 ]]; then
        rm "$README_FILE"
    fi

    popd > /dev/null
done

markdown-optimize-images.py
find . -type d -empty -delete
find . -type f -iname "*.md" -exec git add {} \;
find . -type f -iname "*.webp" -exec git add {} \;
