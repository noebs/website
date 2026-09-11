# Noebs website

This repository generates [noebs.sd](https://noebs.sd), including the public Android wallet download links. Signed APKs and checksums are published separately in [tutipay/android-releases](https://github.com/tutipay/android-releases/releases/tag/v26.09.11-alpha.2).

The repository was transferred from `adonese/userbase-homepage` to `noebs/website` with its history preserved. It was adapted from the Userbase homepage; the original MIT license remains in [LICENSE](LICENSE).

### Structure

* [/src/template.html](src/template.html) contains the common HTML wrapper around every page.
* [/src/pages](src/pages) contains the HTML body for each page of the site.
* [/src/partials](src/partials) contains common HTML fragments shared by multiple pages.
* [/src/style.css](src/style.css) holds all the CSS for the site, using [Tailwind CSS](https://tailwindcss.com).
* [/src/index.js](src/index.js) holds all the JS for the site, which can be written in ES6.

### Development

Use Node 24 with npm 11 for the commands below. The locked website generator
requires Node 12.22.12 and npm 6.14.16; the commands invoke those versions in
isolation. Cloudflare serves the resulting static files, with no Node server.

```sh
git clone https://github.com/noebs/website.git
cd website

# Install exactly the locked dependencies and generate dist/.
npm run build:static

# Start the development server at http://localhost:3000.
npm exec --yes --package=node@12.22.12 --package=npm@6.14.16 -- npm start
```

### Production

```sh
npm run build:static
```

This runs a clean locked install before building `dist/`. Installing the locked
`sharp@0.22.1` dependency directly with Node 24 fails; keep the build wrapper until
the generator dependencies are upgraded together.

### Cloudflare Pages deployment

Deploy the generated `dist/` directory with Wrangler 4.131.0 running under Node 24.
The existing Pages project is `userbase-homepage`, its production branch is
`master`, and its domains are `userbase-homepage.pages.dev` and `noebs.sd`.
The Pages project retains its historical name after the GitHub repository move.
Its deployment configuration is checked in as [wrangler.toml](wrangler.toml).

Deployments currently use Wrangler uploads from this repository. Cloudflare's
existing Git integration does not follow a repository transfer; its old native
Git triggers are disabled. See [Cloudflare's transfer guidance](https://developers.cloudflare.com/pages/configuration/git-integration/troubleshooting/).
Git pushes alone do not deploy the site. External CI can use the same upload
command below with a Pages deployment credential.

The saved Cloudflare build settings are `npm run build:static`, output directory
`dist`, and build image v3. Both preview and production use
`NODE_VERSION=24.18.0` and `SKIP_DEPENDENCY_INSTALL=true`, so the wrapper controls
the locked install. `vercel.json` disables the previous Vercel Git deployments.

```sh
# Authorize the Cloudflare account that manages noebs.sd.
npm exec --yes --package=wrangler@4.131.0 -- wrangler login --device
npm exec --yes --package=wrangler@4.131.0 -- wrangler whoami

# Select the account that owns noebs.sd, especially with multiple memberships.
export CLOUDFLARE_ACCOUNT_ID='<account-id>'
npm exec --yes --package=wrangler@4.131.0 -- wrangler pages project list

# Commit the intended source before deploying it.
test -z "$(git status --porcelain)"
npm run build:static
npm exec --yes --package=wrangler@4.131.0 -- wrangler pages deploy dist \
  --project-name userbase-homepage \
  --branch master --commit-hash "$(git rev-parse HEAD)"
```

For a preview before production, run the deploy command with
`--branch cloudflare-preview` and verify the returned preview URL first.

Verify `https://noebs.sd/#android-wallet`, `/docs/`, the APK release link, and a
missing URL returning HTTP 404 after deployment. The build emits a top-level
`dist/404.html` so Pages handles this as a multi-page site. The APKs remain GitHub
release assets; only website files go to Pages.
Wrangler credentials belong in the local credential store, outside Git and
`dist/`. Cloudflare can also accept manual Wrangler deployments for an existing
Git-integrated Pages project.

The [2026-09-11 deployment record](docs/deployment-20260911.json) records the
production deployment, source revision, artifact hashes, browser checks and
independent live review. It also records the previous production deployment for
rollback through the Pages dashboard.

## License

This project is released under the [MIT License](LICENSE).
