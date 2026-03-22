# GitHub Pages Setup

Use this after you create your first GitHub repository.

## 1) Create the repository on GitHub

Suggested names:

- `bcbc-log-capture-tools`
- `bcbc-tech-toolkit`
- `bcbc-diagnostics-suite`

## 2) Upload or push these files

From the project folder:

```bash
git init
git add .
git commit -m "Initial commit: BCBC log capture starter"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
git push -u origin main
```

## 3) Turn on GitHub Pages

In the repository on GitHub:

- Open **Settings**
- Open **Pages**
- Under **Build and deployment**, choose:
  - **Source:** Deploy from a branch
  - **Branch:** `main`
  - **Folder:** `/ (root)`
- Save

## 4) Wait for the site link to appear

GitHub will publish the site from `index.html`.

Your site URL will usually look like:

```text
https://YOUR-USERNAME.github.io/YOUR-REPO-NAME/
```

## 5) What to edit first

- `index.html` = your public project landing page
- `style.css` = the design and layout
- `usb-menu-preview.html` = future USB SSD launcher style preview
- `README.md` = repo overview for GitHub visitors

## Good next upgrades

- Add screenshots
- Add a storage checker script
- Add a network diagnostics script
- Add buttons that open tool docs or demos
- Connect the same layout style to the USB SSD menu system later
