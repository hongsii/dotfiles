#! /bin/bash
# Print ktlint reports in IDEA 

find . -type f -path "*/build/reports/ktlint/*" | while read -r file; do
  if [ ! -s "$file" ]; then
    continue
  fi

  extension="${file##*.}"
  if [ "$extension" == "json" ]; then
    if command -v jq &> /dev/null; then
      json=$(jq . "$file")
      if [ "$json" == "[]" ]; then
        continue
      fi
      echo "$json"
    else
      cat "$file"
    fi
  else
    cat "$file"
  fi
done
