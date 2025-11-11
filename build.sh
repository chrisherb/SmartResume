#!/bin/bash

# Default paths
INPUT_PATH="./markdown/resume.md"
OUTPUT_PATH="./output/resume.pdf"
TEMPLATE="default_template.tex"
PDF_ENGINE="xelatex"

# Parse options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--input) INPUT_PATH="$2"; shift ;;
        -o|--output) OUTPUT_PATH="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Check if input file exists
if [ ! -f "$INPUT_PATH" ]; then
    echo "Input file $INPUT_PATH does not exist."
    exit 1
fi

# Ensure output directory exists
OUTPUT_DIR=$(dirname "$OUTPUT_PATH")
mkdir -p "$OUTPUT_DIR"

# Run pandoc (assumes pandoc is installed and available in PATH)
pandoc "$INPUT_PATH" \
    --template="$TEMPLATE" \
    --pdf-engine="$PDF_ENGINE" \
    -o "$OUTPUT_PATH"

if [ $? -eq 0 ]; then
    echo "Successfully converted $INPUT_PATH to $OUTPUT_PATH"
else
    echo "Pandoc failed to convert the file."
    exit 2
fi
