#!/bin/bash

# Input directory containing font files
input_dir="./"

# Output directory to store converted TTF files
output_dir="./converted"

if ! command -v fontforge &> /dev/null; then
  echo "FontForge is not installed. Installing..."

  # Determine the package manager based on the operating system
  if [[ -x "$(command -v apt-get)" ]]; then
    # Debian-based systems (e.g., Ubuntu)
    sudo apt-get update
    sudo apt-get install -y fontforge
  elif [[ -x "$(command -v yum)" ]]; then
    # Red Hat-based systems (e.g., CentOS)
    sudo yum install -y fontforge
  elif [[ -x "$(command -v dnf)" ]]; then
    # Fedora
    sudo dnf install -y fontforge
  elif [[ -x "$(command -v brew)" ]]; then
    # macOS
    brew install fontforge
  elif [[ -x "$(command -v choco)" ]]; then
    # Windows with Chocolatey package manager
    choco install fontforge
  else
    echo "Unable to determine the package manager. Please install FontForge manually."
    exit 1
  fi

  echo "FontForge has been installed."
else
  echo "FontForge is already installed."
fi

if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
  echo "Directory created: $output_dir"
fi

# Loop through all font files in the input directory
for font_file in $input_dir/*.woff2; do
    # Convert the font file to TTF format
    fontforge -lang=ff -c "Open(\"$font_file\"); Generate(\"$output_dir/$(basename ${font_file%.*}).ttf\");"
done
