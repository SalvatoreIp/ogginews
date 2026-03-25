# Istruzioni Operative Blog Notizie

## SEZIONI DISPONIBILI
- `guerre`    → conflitti, geopolitica
- `attualita` → cronaca, politica, società
- `scienza`   → tecnologia, spazio, innovazione
- `curiosita` → storie insolite, fatti virali
- `economia`  → mercati, finanza, aziende

Cartelle reali:
- /home/salvatore/notizie-italiane/content/guerre/
- /home/salvatore/notizie-italiane/content/attualita/
- /home/salvatore/notizie-italiane/content/scienza/
- /home/salvatore/notizie-italiane/content/curiosita/
- /home/salvatore/notizie-italiane/content/economia/

Immagini: static/immagini/

## OBIETTIVO
Ogni esecuzione:
1. Naviga le fonti sotto
2. Scegli UNA notizia fresca (max 6 ore)
3. Identifica la sezione corretta
4. Scarica immagine rilevante e salvala in static/immagini/slug.jpg
5. Scrivi articolo originale italiano 600-900 parole
6. Esegui: bash /home/salvatore/notizie-italiane/scripts/publish_news_post.sh "TITOLO" "CORPO" "SEZIONE" "URL_IMMAGINE" "DESCRIZIONE"

## FONTI
1. https://www.ansa.it/sito/notizie/topnews/topnews.shtml
2. https://news.google.com/?hl=it&gl=IT&ceid=IT:it
3. https://www.ansa.it/sito/notizie/mondo/mondo.shtml
4. https://www.ansa.it/sito/notizie/economia/economia.shtml
5. https://www.ansa.it/sito/notizie/scienza/scienza.shtml
6. https://www.wired.it/

## FRONTMATTER OBBLIGATORIO
---
title: "Titolo SEO max 60 caratteri"
date: YYYY-MM-DDTHH:MM:SSZ
draft: false
description: "Riassunto 120-155 caratteri"
categories: ["<sezione>"]
tags: ["tag1", "tag2", "tag3"]
cover:
  image: "/immagini/slug.jpg"
  alt: "Descrizione immagine"
---

## STRUTTURA ARTICOLO

## Introduzione
[Chi? Cosa? Quando? Dove? Perché? - 2-4 frasi]

## I fatti principali
[Fatti, numeri, dichiarazioni ufficiali - 200+ parole]

## Contesto e retroscena
[Perché è importante, background - 150+ parole]

## Impatti e sviluppi futuri
[Conseguenze, scenari possibili - 100+ parole]

## Conclusione
[Sintesi finale neutrale - 2-3 frasi]

*Fonte: [Nome testata](URL originale)*

## NAVIGAZIONE STEALTH
Se un sito blocca → usa: ~/.openclaw/skills/stealth-browser/generate.sh URL
MAI Browser Relay (siamo su VPS)

## REGOLE ASSOLUTE
- MAI copiare testo originale
- MAI pubblicare notizie > 6 ore
- Tono giornalistico neutro
- Slug: solo minuscolo, trattini, niente apostrofi
- UNA sola categoria
- MAI creare la cartella ultimora/ o qualsiasi altra cartella non elencata sopra
- Nel frontmatter usare SEMPRE virgolette doppie, MAI apostrofi singoli
- Dopo aver creato il file eseguire SEMPRE: cd /home/salvatore/notizie-italiane && hugo --minify && git add . && git commit -m "TITOLO" && git push
- MAI creare post di test, prova, yaml o simili. Lo script è già testato e funzionante.

## IMMAGINI
MAI scaricare immagini da siti di notizie: bloccano il download e restituiscono HTML.
Usa SEMPRE Pixabay con questo comando (KEYWORD in inglese, NOME-FILE = slug articolo):

PIXABAY_KEY=$(grep PIXABAY_API_KEY /home/salvatore/notizie-italiane/.env | cut -d= -f2)
URL=$(wget -qO- "https://pixabay.com/api/?key=$PIXABAY_KEY&q=KEYWORD&image_type=photo&orientation=horizontal&per_page=3" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['hits'][0]['largeImageURL'])")
wget -O /home/salvatore/notizie-italiane/static/immagini/NOME-FILE.jpg "$URL"
