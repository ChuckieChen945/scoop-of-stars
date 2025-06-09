<!-- markdownlint-disable MD033 MD041 -->
<p align="center">
    <h1 align="center">⭐ scoop of starts ⭐</h1>
</p>

<p align="center">
    <a href="https://github.com/ChuckieChen945/scoop-of-starts">GitHub</a> |
    <a href="https://gitee.com/Chuckie_Chen/scoop-of-stars">Gitee</a> |
    <a href="readme-cn.md">简体中文</a> |
    <a href="readme.md">English</a> |
</p>

<p align="center">
    <a href="https://github.com/ChuckieChen945/scoop-of-starts/actions/workflows/ci.yml">
        <img src="https://github.com/ChuckieChen945/scoop-of-starts/actions/workflows/ci.yml/badge.svg" alt="CI Status" />
    </a>
    <a href="https://github.com/ChuckieChen945/scoop-of-starts/actions/workflows/excavator.yml">
        <img src="https://github.com/ChuckieChen945/scoop-of-starts/actions/workflows/excavator.yml/badge.svg" alt="Excavator Status" />
    </a>
</p>

> [!Note]
>
> 这是一个**非官方 Scoop bucket**，收录了一些精选的 **Anki 插件（[add-ons](https://ankiweb.net/shared/addons)）**及相关工具，方便用户通过命令行使用 Scoop 管理 Anki 插件。

---

## 🌟 什么是 “scoop of starts”？

> 这个名字是以下两个元素的结合：
>
> * **Scoop**：Windows 下的命令行安装器；
> * **Anki**：其图标是一个 ✨星星✨。
>
> 因此，“scoop of starts” 就是“一勺星星” —— 一个小而亮眼的 Anki 插件集合！

---

## 📦 如何安装本 bucket 中的应用？

首先，确保你已安装 [Scoop](https://scoop.sh)，并使用 scoop 安装 Anki：

```powershell
scoop bucket add extras
scoop install extras/anki
```

然后，添加本 bucket，并通过以下命令安装插件：

```powershell
scoop bucket add starts https://github.com/ChuckieChen945/scoop-of-starts.git
scoop install starts/<插件名>
```

---

## 🧠 实现原理

本仓库中的插件 manifest 会配置 scoop 直接从插件开发者的主页下载插件，然后自动定位 scoop 安装的 anki 路径，将插件复制到 `dir/to/scoop/persist/anki/data/addons21` 目录中。Anki 启动时会自动加载该目录下的插件。

本仓库尽量支持 scoop 的自动更新机制，但由于许多 Anki 插件发布方式较为随意，目前仅部分插件支持自动更新。

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

我们欢迎社区贡献！

请参考以下文档：

* [Scoop 应用清单编写指南](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests)
* [Scoop 贡献指南](https://github.com/ScoopInstaller/.github/blob/main/.github/CONTRIBUTING.md)

你可以 fork 本仓库，新建分支，添加或修改 manifest 后提交 Pull Request。

---

## 📜 许可证

本项目采用 [MIT License](LICENSE) 开源许可协议。
