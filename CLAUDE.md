# CLAUDE.md

Guida per Claude Code in questo repository.

## Cos'è

Sito Hugo `ogginews.com` (tema PaperMod in `themes/`): notizie italiane e dal mondo spiegate. Pubblicato su Cloudflare Pages (progetto `ogginews`, upload diretto). Repo `SalvatoreIp/ogginews`. La config attiva è `hugo.toml`; `config.toml` e `content.bak-*` sono residui.

## Comandi

```bash
cd /home/salvatore/notizie-italiane && rm -rf public/ && hugo --minify \
  && npx wrangler pages deploy public --project-name ogginews --commit-dirty=true \
  && git add . && git commit -m "TITOLO" && git push
```

- wrangler usa `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID`: esporta `/home/salvatore/risparmio-energetico/.env` (stesso account; il `.env` di questo repo non ha `CLOUDFLARE_ACCOUNT_ID`).
- `scripts/salva_immagine.py URL SLUG` — salva un'immagine ElevenLabs come `static/immagini/SLUG.jpg` a 1280 px.
- Pubblicazione automatica: cron della VPS alle 07:35 → `scripts/daily_publish_vps.sh` (prompt in `scripts/daily_publish_prompt.txt`), log in `logs/daily_publish.log`.

## Struttura contenuti

- Sezioni in uso: `attualita`, `economia`, `guerre`, `scienza`, `curiosita`. Non usare né creare `ultimora`, `esteri`, `mondo`, `guida` o altre cartelle.
- File: `content/<sezione>/YYYY-MM-DD-slug.md`. In `guerre` il permalink è `/guerre/:slug/` e, senza campo `slug`, Hugo lo ricava dal TITOLO; nelle altre sezioni l'URL contiene il nome file completo (es. `/economia/2026-05-04-unicredit-commerzbank-aumento-capitale/`). Il permalink esatto si legge con `hugo list all` (colonna permalink).
- Immagini in `static/immagini/`, referenziate come `/immagini/<slug>.jpg`.

Frontmatter (virgolette doppie):

```yaml
---
title: "max 60 caratteri"
date: YYYY-MM-DDTHH:MM:SS+02:00
draft: false
description: "120-155 caratteri"
categories: ["<sezione>"]
tags: ["tag1", "tag2", "tag3"]
cover:
  image: "/immagini/slug.jpg"
  alt: "Immagine illustrativa: ..."
---
```

## Regole editoriali (sito di notizie: l'accuratezza viene prima di tutto)

- Una notizia delle ultime 24 ore, verificata su ALMENO due testate affidabili diverse (ANSA, Il Post, Sole 24 Ore, Corriere, Repubblica, RaiNews, Reuters, AP, BBC…).
- Angolo "notizia spiegata": cosa è successo, perché conta, cosa succede adesso. 700-1000 parole, testo originale, tono neutro.
- VIETATO inventare: nomi, cifre, citazioni tra virgolette, date. Le citazioni dirette si usano solo se riportate identiche da una fonte; nel dubbio si parafrasa ("secondo ANSA…"). Se un dato non è confermato si scrive che non è confermato.
- Struttura: attacco con chi/cosa/quando/dove → `## I fatti` → `## Il contesto` → `## Cosa succede adesso` → `## In sintesi` → `*Fonti: [Testata](URL), [Testata](URL)*` con link reali.
- Niente link affiliati o box CTA negli articoli di notizie.
- Immagine: illustrazione simbolica generica, mai una finta foto dell'evento reale né volti di persone reali; alt che inizia con "Immagine illustrativa:".
- Slug: minuscolo e trattini, niente accenti né apostrofi. Una sola categoria. Mai post di prova.
