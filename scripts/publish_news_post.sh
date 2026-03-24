#!/bin/bash
TITLE="$1"
BODY="$2"
SECTION="${3:-attualita}"
IMAGE_PATH="${4:-}"

cd /home/salvatore/notizie-italiane || exit 1

case "$SECTION" in
  "ultimora"|"guerre"|"attualita"|"scienza"|"curiosita"|"economia") ;;
  *) SECTION="attualita" ;;
esac

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g;s/--*/-/g')
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
DATEONLY=$(date -u +"%Y-%m-%d")
HOUR=$(date -u +"%H")
FILE="content/$SECTION/$DATEONLY-$HOUR-$SLUG.md"

mkdir -p static/immagini

if [ -n "$IMAGE_PATH" ] && [ -f "$IMAGE_PATH" ]; then
  cp "$IMAGE_PATH" "static/immagini/$SLUG.jpg"
fi

cat > "$FILE" << MD
---
title: "$TITLE"
date: $DATE
draft: false
description: ""
categories: ["$SECTION"]
tags: []
cover:
  image: /immagini/$SLUG.jpg
  alt: "Immagine per $TITLE"
---

$BODY
MD

chmod 644 "$FILE"
chown salvatore:salvatore "$FILE"

CHARS=$(wc -m < "$FILE")
echo "✅ $FILE creato! ($CHARS caratteri)"
echo "🔥 Prossimo: git add . && git commit -m '$TITLE' && git push"
