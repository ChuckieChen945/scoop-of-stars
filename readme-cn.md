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
</p>

> [!Note]
>
> 这是一个**非官方 Scoop bucket**，收录了一些精选的 **Anki 插件（[add-ons](https://ankiweb.net/shared/addons)）**及相关工具，方便用户通过命令行使用 Scoop 管理 Anki 插件。

---

## 🌟 什么是 “scoop of stars”？

> 这个名字是以下两个元素的结合：
>
> * **Scoop**：Windows 下的命令行安装器；
> * **Anki**：其图标是一个 ✨星星✨。
>
> 因此，“scoop of stars” 就是“一勺星星” —— 一个小而亮眼的 Anki 插件集合！

---

## 📦 如何安装本 bucket 中的应用？

首先，确保你已安装 [Scoop](https://scoop.sh)，并使用 scoop 安装 Anki：

```powershell
scoop bucket add extras
scoop install extras/anki
```

然后，添加本 bucket，并通过以下命令安装插件：

```powershell
scoop bucket add ChuckieChen945_scoop-of-stars https://github.com/ChuckieChen945/scoop-of-stars
scoop install ChuckieChen945_scoop-of-stars/<插件名>
```

---

## 🧠 实现原理

本仓库中的每个插件 manifest 文件都配置为直接从开发者网站下载安装插件。Scoop 会自动定位 Anki 的安装路径，并将插件复制到 `scoop/persist/anki/data/addons21` 目录中。Anki 启动时会自动从该目录加载所有插件。

通过本仓库安装的插件与通过 Anki 内置功能或手动安装的插件在功能上完全一致。Anki 无法分辨插件是以何种方式安装的，后续所有使用、配置、更新和卸载行为也都保持一致。

本 bucket 会尽量支持 Scoop 的自动更新机制，但由于大多数 Anki 插件的发布结构不规范，只有少数插件可以实现自动更新。

---

## 🙋 给开发者的话

本仓库的 `bin/utils.ps1` 中包含了一些用于插件安装的实用函数，可用于简化 manifest 编写并统一插件安装行为。其他 buckets 如需合并使用，请谨慎评估其兼容性。

---

## 🤝 如何参与贡献？

我们欢迎所有形式的贡献！

请参考以下指南：

* [Scoop 应用清单编写指南](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests)
* [Scoop 贡献指南](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md)

本仓库还规定了一些额外的约定：

* 所有 Anki 插件的名称应统一使用 **kebab-case** 命名法，并添加 `anki-` 前缀。这有助于区分普通软件与插件，也便于在 Scoop 中搜索。
* 每个 manifest 的 `homepage` 字段应填写插件的 AnkiWeb 页面链接（如 [https://ankiweb.net/shared/info/xxxxxxxx](https://ankiweb.net/shared/info/xxxxxxxx)）。安装时，`bin/utils.ps1` 中的脚本会自动提取该链接中的插件 ID，并将其作为复制到 `scoop/persist/anki/data/addons21` 中的目录名称。此行为与通过 Anki 安装插件时保持一致，可实现无缝集成。
* 有关导入 `bin/utils.ps1` 后可用的变量和函数，请查看该脚本中的注释部分。

你可以 fork 本仓库，新建分支，添加或修改 manifest 后提交 Pull Request。

---

## 📜 许可证

本项目采用 [MIT License](LICENSE) 开源许可协议。

---

## 📃 插件列表

<!-- prettier-ignore-start -->
|Anki addons (7)|version|description|github url|
|:-:|:-:|:-:|-|
|[anki-advanced-browser](https://ankiweb.net/shared/info/874215009 "点击查看 anki-advanced-browser 的主页或仓库")|<a href="./bucket/anki-advanced-browser.json" title="点击查看 anki-advanced-browser 的 manifest json 文件"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-advanced-browser.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Anki add-on with card browser enhancements.|<https://github.com/AnKing-VIP/advanced-browser/releases/download/v4.4/Advanced_Browser__branch_idx_5__AnkiVers_231000-231000__2023-10-15.ankiaddon#/dl.zip>|
|[anki-ajt-common](https://github.com/Ajatt-Tools/ajt_common/ "点击查看 anki-ajt-common 的主页或仓库")|<a href="./bucket/anki-ajt-common.json" title="点击查看 anki-ajt-common 的 manifest json 文件"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-ajt-common.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|🍘 Common information for anki AJT add-ons.|<https://github.com/Ajatt-Tools/ajt_common/archive/refs/heads/main.zip>|
|[anki-anki-javascript-api](https://ankiweb.net/shared/info/1490471827 "点击查看 anki-anki-javascript-api 的主页或仓库")|<a href="./bucket/anki-anki-javascript-api.json" title="点击查看 anki-anki-javascript-api 的 manifest json 文件"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-anki-javascript-api.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Anki JavaScript API to get cards informations in reviewer window|<https://github.com/krmanik/AnkiJS-API/archive/refs/heads/main.zip>|
|[anki-crowd-anki](https://ankiweb.net/shared/info/1788670778 "点击查看 anki-crowd-anki 的主页或仓库")|<a href="./bucket/anki-crowd-anki.json" title="点击查看 anki-crowd-anki 的 manifest json 文件"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-crowd-anki.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Plugin for Anki SRS designed to facilitate cooperation on creation of notes and decks.|<https://github.com/Stvad/CrowdAnki/releases/download/v0.9.5/crowd_anki_20231030.zip>|
|[anki-customize-keyboard-shortcuts](https://ankiweb.net/shared/info/24411424 "点击查看 anki-customize-keyboard-shortcuts 的主页或仓库")|<a href="./bucket/anki-customize-keyboard-shortcuts.json" title="点击查看 anki-customize-keyboard-shortcuts 的 manifest json 文件"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-customize-keyboard-shortcuts.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|Custom Keyboard Shortcuts for Anki 2.1|<https://github.com/Liresol/anki-custom-shortcuts/archive/refs/heads/merge-main-into-dev.zip>|
|[anki-fsrs-helper](https://ankiweb.net/shared/info/759844606 "点击查看 anki-fsrs-helper 的主页或仓库")|<a href="./bucket/anki-fsrs-helper.json" title="点击查看 anki-fsrs-helper 的 manifest json 文件"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-fsrs-helper.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|An Anki add-on that supports Postpone & Advance & Load Balance & Easy Days & Disperse Siblings & Flatten|<https://github.com/open-spaced-repetition/fsrs4anki-helper/archive/refs/heads/main.zip>|
|[anki-learn-now-button](https://ankiweb.net/shared/info/1021636467 "点击查看 anki-learn-now-button 的主页或仓库")|<a href="./bucket/anki-learn-now-button.json" title="点击查看 anki-learn-now-button 的 manifest json 文件"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2Fanki-learn-now-button.json&query=%24.version&prefix=v&label=%20" alt="version" /></a>|🍝 Put cards in the learning queue and answer cards from the Card Browser.|<https://github.com/Ajatt-Tools/learn-now-button/archive/refs/heads/main.zip>|
<!-- prettier-ignore-end -->
