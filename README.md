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

```
# clone this repo
git clone https://github.com/noebs/website.git


## IMPORTANT: this only works for node v12! 
# go to the repo directory
cd website

# install all dependencies
npm install

# start the website on http://localhost:3000 with hot module reloading
npm start
```

### Production

```
# install all dependencies using the versions in package-lock.json
npm ci

# generate the build artifacts in the dist directory
npm run build
```

### Deployment

We are currently using cloudflare pages to deploy our platform.


## License

This project is released under the [MIT License](LICENSE).
