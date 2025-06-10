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

## 📃 App List

| App                                                                       | Version | Persist | Tag         | Description                       |
| ------------------------------------------------------------------------- | ------- | ------- | ----------- | --------------------------------- |
| [ImageOcclusion](https://github.com/glutanimate/image-occlusion-enhanced) | latest  | ✔️       | anki add-on | Image Occlusion Enhanced for Anki |
| [AnkiConnect](https://github.com/FooSoft/anki-connect)                    | latest  | ➖       | anki add-on | Remote API interface for Anki     |
| ...                                                                       | ...     | ...     | ...         | ...                               |

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
