# Deploying TechMinds to techminds.com.au

This site is pure static HTML/CSS/JS — no build step, no server required. That
makes deployment simple: push it to a free static host and point your domain
at it.

## 0. Prerequisite: fix git on this machine

```bash
sudo xcodebuild -license
```
Accept the license (space to page through, type `agree` at the end). Then
confirm it worked:
```bash
git --version
```

## 1. Register techminds.com.au

**.com.au domains require an Australian ABN or ACN.** Since TechMinds is a
Pty Ltd company, once it's registered with ASIC you'll have an ACN, which
satisfies eligibility. If the company isn't registered yet, that's step zero
(business.gov.au → register a company, or register as a sole trader with an
ABN if you don't need a Pty Ltd structure).

Once you're eligible, register through an AU-accredited registrar:
- **VentraIP** (ventraip.com.au) — popular, good support, reasonable pricing
- **Crazy Domains** (crazydomains.com.au)
- **GoDaddy Australia** (godaddy.com/en-au)

Search for `techminds.com.au`, confirm it's available, and register it
(usually ~$15–25/year). You'll need your ABN/ACN during checkout.

## 2. Push this site to GitHub

```bash
cd ~/REPOS/techminds
git init
git add .
git commit -m "Initial TechMinds site"
```

Then create a new **empty** repository on github.com (no README/license —
you already have files), and push:

```bash
git remote add origin https://github.com/<your-username>/techminds-website.git
git branch -M main
git push -u origin main
```

## 3. Deploy to Netlify (free)

1. Go to **netlify.com** → sign up (free, GitHub login is easiest)
2. **Add new site → Import an existing project → GitHub** → select your
   `techminds-website` repo
3. Build settings: leave **Build command** blank and set **Publish
   directory** to `.` (the repo root) — there's nothing to build, it's static
4. Click **Deploy** — Netlify gives you a live URL like
   `https://techminds-xyz123.netlify.app` within ~30 seconds

From now on, every `git push` to `main` auto-redeploys the live site — that's
how you "work from anywhere": edit locally or from any machine with the repo,
push, and it's live in under a minute.

## 4. Connect techminds.com.au

In the Netlify site dashboard: **Domain settings → Add a domain** →
`techminds.com.au`.

Netlify will offer two ways to connect it — use **Netlify DNS** (simplest,
recommended):

1. Netlify shows you 4 nameservers (e.g. `dns1.p0X.nsone.net`, etc.)
2. Log into your domain registrar (VentraIP / Crazy Domains / GoDaddy) →
   find **Nameservers** / **DNS settings** for techminds.com.au
3. Replace the default nameservers with the 4 Netlify gave you
4. Wait 10 minutes–24 hours for DNS to propagate (usually much faster)

Netlify then manages all DNS automatically, including `www.techminds.com.au`
redirecting to the apex domain.

*(Alternative if you'd rather keep DNS at your registrar: Netlify will show
specific A and CNAME records to add manually instead of changing
nameservers — a bit more manual maintenance, functionally the same result.)*

## 5. HTTPS

Automatic. Once DNS resolves, Netlify provisions a free SSL certificate
(Let's Encrypt) within a few minutes — no action needed. `https://techminds.com.au`
will just work.

## Updating the live site later

```bash
cd ~/REPOS/techminds
# ... edit files ...
git add .
git commit -m "describe the change"
git push
```

Netlify redeploys automatically on every push — typically live within 30–60
seconds.

## Alternatives to Netlify

Functionally equivalent free options if you'd rather use one of these:
- **Cloudflare Pages** (pages.cloudflare.com) — same free static hosting;
  nice if you also want Cloudflare's DNS/CDN in front of everything
- **Vercel** (vercel.com) — same idea, same free tier
- **GitHub Pages** — free and simple, but custom-domain HTTPS setup is
  slightly more manual than Netlify/Cloudflare

Any of these follow the same shape: connect the GitHub repo → point DNS at
the host → done.
