<!-- markdownlint-disable MD033 MD041 -->
<p align="center">
    <h1 align="center">⭐ scoop of stars ⭐</h1>
</p>

<p align="center">
    <a href="https://github.com/ChuckieChen945/scoop-of-stars">GitHub</a> |
    <a href="https://gitee.com/Chuckie_Chen/scoop-of-stars">Gitee</a> |
    <a href="readme-cn.md">简体中文</a> |
    <a href="readme.md">English</a> |
</p>

<p align="center">
    <a href="https://github.com/ChuckieChen945/scoop-of-stars/actions/workflows/ci.yml">
        <img src="https://github.com/ChuckieChen945/scoop-of-stars/actions/workflows/ci.yml/badge.svg" alt="CI Status" />
    </a>
    <a href="https://github.com/ChuckieChen945/scoop-of-stars/actions/workflows/excavator.yml">
        <img src="https://github.com/ChuckieChen945/scoop-of-stars/actions/workflows/excavator.yml/badge.svg" alt="Excavator Status" />
    </a>
    <a href="https://github.com/ChuckieChen945/scoop-of-stars/blob/main/license">
        <img src="https://img.shields.io/github/license/ChuckieChen945/scoop-of-stars" alt="license" />
    </a>
    <a href="https://img.shields.io/github/languages/code-size/ChuckieChen945/scoop-of-stars.svg">
        <img src="https://img.shields.io/github/languages/code-size/ChuckieChen945/scoop-of-stars.svg" alt="code size" />
    </a>
</p>

> [!Note]
>
> This is an **unofficial Scoop bucket** that contains selected **[Anki add-ons](https://ankiweb.net/shared/addons)** and related tools. It helps users manage Anki add-ons conveniently via the command line using Scoop.

---

## 🌟 What is “scoop of stars”?

> The name is inspired by:
>
> * **Scoop**: a command-line installer for Windows.
> * **Anki**: whose icon is a ✨star✨.
>
> So this bucket is literally a “scoop of stars” — a small collection of shining Anki add-ons!

---

## 📦 How to install apps from this bucket?

First, make sure [Scoop](https://scoop.sh) is installed. Then install Anki via Scoop:

```powershell
scoop bucket add extras
scoop install extras/anki
```

Next, add this bucket and install any Anki add-on like this:

```powershell
scoop bucket add ChuckieChen945_scoop-of-stars https://github.com/ChuckieChen945/scoop-of-stars.git
scoop install ChuckieChen945_scoop-of-stars/<addon-name>
```

---

## 🧠 How it works

Each plugin manifest in this repository is configured to download the add-on directly from the developer’s site. Scoop then locates the installed Anki path and copies the plugin into the `scoop/persist/anki/data/addons21` directory. Anki automatically loads all add-ons from this directory on startup.

Plugins installed through this repository are functionally identical to those installed manually or via Anki itself. Anki cannot distinguish between installation methods, and all future behaviors—such as settings persistence, updates, or removals—will remain consistent.

This bucket attempts to support Scoop’s auto-update mechanism. However, due to the often unstructured release patterns of Anki add-ons, only a limited number of plugins can be updated automatically.

---

## 🙋 For Developers

Utility functions are provided in `bin/utils.ps1` to help standardize Anki add-on installation and reduce redundant code. If other buckets plan to merge or reuse these tools, please review compatibility carefully.

---

## 🤝 How to contribute?

We welcome contributions!

Please refer to the following guides:

* [Scoop App Manifest Guide](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests)
* [Scoop Contribution Guide](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md)

This repository has a few additional rules:

* All Anki add-ons should use **kebab-case-naming** and start with the `anki-` prefix. This helps differentiate them from standard software and improves searchability within Scoop.
* Each manifest should include the AnkiWeb plugin homepage (e.g., <https://ankiweb.net/shared/info/xxxxxxxx>) in the `homepage` field. During installation, the script in `bin/utils.ps1` will extract the plugin ID from this URL and use it as the directory name under `scoop/persist/anki/data/addons21`. This matches the structure Anki uses for its own installations, ensuring seamless integration.
* For details on variables and functions available after importing `bin/utils.ps1`, refer to the comments inside the `bin/utils.ps1` script.

You can fork this repository, create a new branch, add your manifest(s), and open a pull request.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 📃 Add-ons List

<!-- prettier-ignore-start -->
|Anki addons (7)|version|description|github url|
|:-:|:-:|:-:|-|
|[anki-advanced-browser](https://ankiweb.net/shared/info/874215009 "Click to view the homepage or repository of anki-advanced-browser")|<a href="./bucket/anki-advanced-browser.json" title="Click to view the manifest json file of anki-advanced-browser"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-advanced-browser.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Anki add-on with card browser enhancements.|<https://github.com/AnKing-VIP/advanced-browser/releases/download/v4.4/Advanced_Browser__branch_idx_5__AnkiVers_231000-231000__2023-10-15.ankiaddon#/dl.zip>|
|[anki-ajt-common](https://github.com/Ajatt-Tools/ajt_common/ "Click to view the homepage or repository of anki-ajt-common")|<a href="./bucket/anki-ajt-common.json" title="Click to view the manifest json file of anki-ajt-common"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-ajt-common.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|🍘 Common information for anki AJT add-ons.|<https://github.com/Ajatt-Tools/ajt_common/archive/refs/heads/main.zip>|
|[anki-anki-javascript-api](https://ankiweb.net/shared/info/1490471827 "Click to view the homepage or repository of anki-anki-javascript-api")|<a href="./bucket/anki-anki-javascript-api.json" title="Click to view the manifest json file of anki-anki-javascript-api"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-anki-javascript-api.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Anki JavaScript API to get cards informations in reviewer window|<https://github.com/krmanik/AnkiJS-API/archive/refs/heads/main.zip>|
|[anki-crowd-anki](https://ankiweb.net/shared/info/1788670778 "Click to view the homepage or repository of anki-crowd-anki")|<a href="./bucket/anki-crowd-anki.json" title="Click to view the manifest json file of anki-crowd-anki"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-crowd-anki.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Plugin for Anki SRS designed to facilitate cooperation on creation of notes and decks.|<https://github.com/Stvad/CrowdAnki/releases/download/v0.9.5/crowd_anki_20231030.zip>|
|[anki-customize-keyboard-shortcuts](https://ankiweb.net/shared/info/24411424 "Click to view the homepage or repository of anki-customize-keyboard-shortcuts")|<a href="./bucket/anki-customize-keyboard-shortcuts.json" title="Click to view the manifest json file of anki-customize-keyboard-shortcuts"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-customize-keyboard-shortcuts.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Custom Keyboard Shortcuts for Anki 2.1|<https://github.com/Liresol/anki-custom-shortcuts/archive/refs/heads/merge-main-into-dev.zip>|
|[anki-fsrs-helper](https://ankiweb.net/shared/info/759844606 "Click to view the homepage or repository of anki-fsrs-helper")|<a href="./bucket/anki-fsrs-helper.json" title="Click to view the manifest json file of anki-fsrs-helper"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-fsrs-helper.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|An Anki add-on that supports Postpone & Advance & Load Balance & Easy Days & Disperse Siblings & Flatten|<https://github.com/open-spaced-repetition/fsrs4anki-helper/archive/refs/heads/main.zip>|
|[anki-learn-now-button](https://ankiweb.net/shared/info/1021636467 "Click to view the homepage or repository of anki-learn-now-button")|<a href="./bucket/anki-learn-now-button.json" title="Click to view the manifest json file of anki-learn-now-button"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-learn-now-button.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|🍝 Put cards in the learning queue and answer cards from the Card Browser.|<https://github.com/Ajatt-Tools/learn-now-button/archive/refs/heads/main.zip>|
<!-- prettier-ignore-end -->
