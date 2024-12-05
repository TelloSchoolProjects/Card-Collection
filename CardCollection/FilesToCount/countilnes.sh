#!/bin/bash

# Create or clear output file
echo "File Line Counts (excluding blank lines, comments, and whitespace):" > line_counts.txt
echo "=====================================\n" >> line_counts.txt

# Find QML and Python files, count only actual code lines
find . -type f \( -name "*.qml" -o -name "*.py" \) -print0 | while IFS= read -r -d '' file; do
    # Exclude:
    # - Empty lines
    # - Lines with only whitespace
    # - Comment lines starting with //
    # - Comment lines starting with /*
    # - Comment lines ending with */
    # - Lines with only import statements
    count=$(grep -v '^[[:space:]]*$' "$file" | \
           grep -v '^[[:space:]]*\/\/' | \
           grep -v '^[[:space:]]*\/\*' | \
           grep -v '\*\/' | \
           grep -v '^[[:space:]]*import' | \
           wc -l)
    printf "%4d lines: %s\n" "$count" "$file" >> line_counts.txt
done

# Sort by line count descending
sort -rn line_counts.txt -o line_counts.txt

# Add total at bottom
echo "\nTotal Lines:" >> line_counts.txt
grep -h "^[[:space:]]*[0-9]" line_counts.txt | awk '{sum += $1} END {print sum}' >> line_counts.txt