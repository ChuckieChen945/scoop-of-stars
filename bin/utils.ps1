#Requires -Version 5.1

# Common functions for Anki addon manifests
# Anki 的应用内「Get Add‑ons」功能接口: https://ankiweb.net/shared/download/{id}


# === 工具函数 ===

function Get-AddonID {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [hashtable]$manifest,

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

    Write-Verbose "Creating junction from $SourceDir to $targetPath"
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
            Write-Verbose "Removing junction at $targetPath"
            Remove-Item -Path $targetPath -Recurse -Force
        } catch {
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
    Copy-Item

    # $targetPath = Join-Path (Get-AnkiAddonBasePath $PersistDirAnki) $AddonID

    # if (Test-Path $targetPath) {
    #     Write-Warning "Target exists: $targetPath. Skipping copy."
    #     return
    # }

    # try {
    #     Copy-Item -Path $SourceDir -Destination $targetPath -Recurse
    #     if ($removeSource) {
    #         Remove-Item -Path $SourceDir -Recurse -Force
    #     }
    # } catch {
    #     Write-Error "Failed to copy: $_"
    # }
}

function Uninstall-AnkiAddonCopy {
    [CmdletBinding()]
    param (
        [string]$AddonID,
        [string]$PersistDirAnki
    )
    Remove-Item
    # $targetPath = Join-Path (Get-AnkiAddonBasePath $PersistDirAnki) $AddonID

    # if (Test-Path $targetPath) {
    #     try {
    #         Remove-Item -Path $targetPath -Recurse -Force
    #     } catch {
    #         Write-Error "Failed to remove: $_"
    #     }
    # }
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
    [CmdletBinding()]
    param (
        [string]$AddonID,
        [string]$SourceDir,
        [string]$PersistDirAnki
    )
    Install-AnkiAddonCopy -AddonID $AddonID -SourceDir $SourceDir -PersistDirAnki $PersistDirAnki -removeSource:$true
}

function AutoUninstall {
    [CmdletBinding()]
    param (
        [string]$AddonID,
        [string]$PersistDirAnki
    )
    Uninstall-AnkiAddonCopy -AddonID $AddonID -PersistDirAnki $PersistDirAnki
}

# === 基本参数 ===

$PersistDirAnki = persistdir anki $global
$addonID = Get-AddonID -manifest $manifest -arch $arch
