#Requires -Version 5.1

<#
一些能在清单中使用的 Anki 插件专用函数：

    1. 常用工具函数：

        - Get-AddonID: 从 manifest 中提取 Anki 插件 ID（优先使用 addon_id 字段、homepage URL 或下载链接中提取）
        - Get-AnkiAddonBasePath: 获取 Anki 插件数据目录（即 $PersistDirAnki\data\addons21）

    2. 安装函数（用于 pre_install 或 post_install）：

        - Install-AnkiAddonJunction: 使用 NTFS Junction 将插件源目录链接到 Anki 插件目录（已弃用。已知如果使用chezmoi管理插件的配置数据，设置Junctionlink的话会存在问题）
        - Install-AnkiAddonCopy: 将插件源目录复制到 Anki 插件目录（推荐使用，支持拷贝后删除源目录）

    3. 卸载函数（用于 pre_uninstall 或 post_uninstall）：

        - Uninstall-AnkiAddonJunction: 删除指定插件在 Anki 插件目录下的 Junction 链接
        - Uninstall-AnkiAddonCopy: 删除复制安装的插件目录

    4. 自动化包装器：

        - AutoInstall: 自动调用 Install-AnkiAddonCopy 并在复制完成后删除源目录
        - AutoUninstall: 自动调用 Uninstall-AnkiAddonCopy 进行插件卸载

    5. 变量：

        - $PersistDirAnki: 表示 Anki 的 persist 数据目录，用于插件存储路径（如 persist\anki\data\addons21）
        - $addonID: 通过 Get-AddonID 获取到的插件 ID，可作为路径名使用
        - $AnkiAddonBasePath: Anki的插件源目录
        - $AddonPath: Anki 插件的完整路径（$AnkiAddonBasePath\$addonID）

    注：
        - 使用方法参考 本仓库 bucket目录下 manifests 中的 pre_install/post_install/pre_uninstall/post_uninstall 等字段
        - Anki 的应用内「Get Add‑ons」功能接口: https://ankiweb.net/shared/download/{id}
#>


# === 工具函数 ===

function Get-AddonID {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [PSCustomObject]$manifest,

        [string]$arch = '64bit'
    )

    if ($manifest.addon_id) {
        return $manifest.addon_id
    }

    if ($manifest.homepage -match 'https://ankiweb\.net/shared/info/(\d+)') {
        return $matches[1]
    }

    $downloadUrl = $manifest.url
    if (-not $downloadUrl -and $manifest.architecture -and $manifest.architecture[$arch]) {
        $downloadUrl = $manifest.architecture[$arch].url
    }

    if ($downloadUrl -match '/(\d+)(?:/|$)') {
        return $matches[1]
    }

    return $app  # fallback
}

function Get-AnkiAddonBasePath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$PersistDirAnki
    )
    return (Join-Path $PersistDirAnki "data\addons21")
}

# === 安装 / 卸载函数 ===

function Install-AnkiAddonJunction {
    [CmdletBinding()]
    param (
        [string]$AddonID,
        [string]$SourceDir,
        [string]$PersistDirAnki
    )

    $targetPath = Join-Path (Get-AnkiAddonBasePath $PersistDirAnki) $AddonID

    if (Test-Path $targetPath) {
        Write-Warning "Path already exists: $targetPath. Skipping junction."
        return
    }

    Write-Host "Creating junction from $SourceDir to $targetPath"
    New-DirectoryJunction $targetPath $SourceDir | Out-Null
}

function Uninstall-AnkiAddonJunction {
    [CmdletBinding()]
    param (
        [string]$AddonID,
        [string]$PersistDirAnki
    )

    $targetPath = Join-Path (Get-AnkiAddonBasePath $PersistDirAnki) $AddonID

    if (Test-Path $targetPath) {
        try {
            Write-Host "Removing junction at $targetPath"
            Remove-Item -Path $targetPath -Recurse -Force
        }
        catch {
            Write-Error "Failed to remove: $_"
        }
    }
}

function Install-AnkiAddonCopy {
    [CmdletBinding()]
    param (
        [string]$AddonID,
        [string]$SourceDir,
        [string]$PersistDirAnki,
        [bool]$removeSource = $false
    )

    $targetPath = Join-Path (Get-AnkiAddonBasePath $PersistDirAnki) $AddonID

    if (Test-Path $targetPath) {
        Write-Warning "Target exists: $targetPath. Skipping copy."
        return
    }

    try {
        Copy-Item -Path $SourceDir -Destination $targetPath -Recurse
        Write-Host "Copied $SourceDir to $targetPath"
        if ($removeSource) {
            Get-ChildItem -Path $SourceDir -Force | Remove-Item -Recurse -Force
            Write-Host "Removed source directory: $SourceDir"
        }
    }
    catch {
        Write-Error "Failed to copy: $_"
    }
}

function Uninstall-AnkiAddonCopy {
    [CmdletBinding()]
    param (
        [string]$AddonID,
        [string]$PersistDirAnki
    )
    $targetPath = Join-Path (Get-AnkiAddonBasePath $PersistDirAnki) $AddonID

    if (Test-Path $targetPath) {
        try {
            Get-ChildItem -Path $targetPath -Force | Remove-Item -Recurse -Force
            Write-Host "Removed addon directory: $targetPath"
        }
        catch {
            Write-Error "Failed to remove: $_"
        }
    }
}

# function Install-AnkiAddonDependencyJunction {
#     [CmdletBinding()]
#     param (
#         [string]$ParentAddonName,
#         [string]$DependencyName,
#         [string]$DependencySourceDir,
#         [string]$PersistDirAnki
#     )

#     $parentPath = Join-Path (Get-AnkiAddonBasePath $PersistDirAnki) $ParentAddonName
#     $targetDepPath = Join-Path $parentPath $DependencyName

#     Remove-Item -Path $targetDepPath -Recurse -Force -ErrorAction SilentlyContinue
#     New-DirectoryJunction $targetDepPath $DependencySourceDir | Out-Null
# }

# === 自动化包装器 ===

function AutoInstall {

    Install-AnkiAddonCopy -AddonID $AddonID -SourceDir $dir -PersistDirAnki $PersistDirAnki -removeSource:$true
}

function AutoUninstall {

    Uninstall-AnkiAddonCopy -AddonID $AddonID -PersistDirAnki $PersistDirAnki
}

# === 基本参数 ===

$PersistDirAnki = persistdir anki $global
$AnkiAddonBasePath = Get-AnkiAddonBasePath -PersistDirAnki $PersistDirAnki
$AddonID = Get-AddonID -manifest $manifest -arch $arch
$AddonPath = Join-Path $AnkiAddonBasePath $AddonID
