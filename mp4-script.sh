#!/bin/bash

# Check if a YouTube URL is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <youtube-url>"
    exit 1
fi

URL="$1"

# Initialize the output filename
# Change BASE_NAME to your liking, it should be a sting
BASE_NAME="####"
EXT="mp4"
COUNTER=1

# Find the next available filename
while [[ -e "${BASE_NAME}_${COUNTER}.${EXT}" ]]; do
    COUNTER=$((COUNTER + 1))
done

OUTPUT_FILE="${BASE_NAME}_${COUNTER}"

# Download video and audio together
echo "Downloading video and audio..."
yt-dlp --merge-output-format mp4 -f "bestvideo+bestaudio[ext=m4a]/best" -o "$OUTPUT_FILE" "$URL"
if [ $? -ne 0 ]; then
    echo "Failed to download video and audio."
    exit 1
fi

echo "Download completed. Output file: $OUTPUT_FILE"
