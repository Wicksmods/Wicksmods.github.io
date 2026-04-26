# Wick's Mods — Landing Page

Static landing page for the Wick addon suite, served at **[wicksmods.io](https://wicksmods.io)**.

Source for the design and copy lives next door in [WickSuite](https://github.com/Wicksmods/WickSuite); this repo is just the static deployable.

## Structure

```
Wicksmods.github.io/
├── index.html         single-page landing
├── CNAME              custom domain for GitHub Pages (wicksmods.io)
├── images/
│   ├── wick-thumb-{bis,cd,trade,macro,combat}.png   addon thumbnails
│   ├── wick-banner-suite{,-2x}.png                  Open Graph share image
│   ├── wick-logo-base-256.png                       reference logo
│   └── favicon.png                                  256×256 PNG favicon
└── deploy.sh          one-shot Cloudflare Pages deploy
```

## Hosting

The site is dual-deployable:

- **GitHub Pages (automatic)** — when this repo is named `<user>.github.io`, Pages serves `index.html` from `main` automatically. URL: `https://wicksmods.github.io` (and `https://wicksmods.io` once the CNAME + DNS are in place).
- **Cloudflare Pages (preferred for production)** — better CDN, instant cache invalidation, no rate limits. See `deploy.sh`.

## Cloudflare Pages — first-time setup

One-time, before the first deploy:

1. Buy `wicksmods.io` through Cloudflare Registrar (≈$50/yr at-cost).
2. Sign in to the Cloudflare dashboard, create a Pages project named `wicksmods`. Either:
   - Connect the project to this GitHub repo (auto-deploys on push), or
   - Use direct upload (manual deploys via `deploy.sh`).
3. Generate an API token with `Pages:Edit`, `DNS:Edit`, and `Workers Routes:Edit` scoped to the `wicksmods.io` zone.
4. Set the token in your shell: `export CLOUDFLARE_API_TOKEN=...`
   Or run `wrangler login` once for OAuth.
5. Attach the custom domain: `wrangler pages domain add wicksmods.io --project-name=wicksmods`
6. (Optional) Set up a `wicksmods.com → wicksmods.io` Bulk Redirect via the dashboard or API.

## Routine deploy

After any change to `index.html` or `images/`:

```bash
./deploy.sh
```

That's it. Site updates within seconds.

## Local preview

Just open `index.html` in a browser. No build step, no bundler.

For more realistic local serving (proper relative paths, CORS, etc.):

```bash
python -m http.server 8000
# then visit http://localhost:8000
```

## Adding a new addon to the suite grid

1. Open `index.html`.
2. Find the `<section class="container" id="suite">` block (the 5-card grid).
3. Copy any existing `<div class="card">…</div>` block, paste it as the new last card.
4. Update the thumbnail src (`images/wick-thumb-<key>.png`), name, tagline, slash command, CurseForge URL, GitHub URL.
5. Drop the new thumbnail PNG in `images/` (use `wick render` from WickSuite to regenerate).
6. Commit + `./deploy.sh`.

## License

MIT for code, trademark-protected for the Wick brand assets. See [WickSuite/TRADEMARK.md](https://github.com/Wicksmods/WickSuite/blob/main/TRADEMARK.md).
