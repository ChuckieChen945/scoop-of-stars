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

## 📃 插件列表

| 插件名称                                                                  | 版本   | 是否持久化 | 标签      | 简介                      |
| ------------------------------------------------------------------------- | ------ | ---------- | --------- | ------------------------- |
| [ImageOcclusion](https://github.com/glutanimate/image-occlusion-enhanced) | latest | ✔️          | anki 插件 | Anki 的图像遮挡增强插件   |
| [AnkiConnect](https://github.com/FooSoft/anki-connect)                    | latest | ➖          | anki 插件 | 提供远程 API 的 Anki 插件 |
| ...                                                                       | ...    | ...        | ...       | ...                       |

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
