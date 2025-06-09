#Requires -Version 5.1

# Common functions for Anki addon manifests
# Anki 的应用内「Get Add‑ons」功能接口: https://ankiweb.net/shared/download/{id}

$PersistDirAnki = persistdir anki $global
$addonBasePath = Get-AnkiAddonBasePath -PersistDirAnki $PersistDirAnki
$addonID = Get-AddonID -manifest $manifest -arch $arch

function Get-AddonID {
    param (
        [Parameter(Mandatory)]
        [hashtable]$manifest,

        [string]$arch = '64bit'  # 可选参数，用于获取架构相关的 URL
    )

    $addonId = $manifest.addon_id
    if ($addonId) {
        return $addonId
    }

    # 其次尝试从 homepage 中提取 ID（匹配 AnkiWeb 分享链接）
    $homepageUrl = $manifest.homepage
    if ($homepageUrl -match 'https://ankiweb\.net/shared/info/(\d+)') {
        return $matches[1]
    }

    # 如果还未获得 addonId，尝试获取 URL 字段
    $downloadUrl = $manifest.url
    if (-not $downloadUrl -and $manifest.architecture -and $manifest.architecture[$arch]) {
        $downloadUrl = $manifest.architecture[$arch].url
    }

    # 可选：从 downloadUrl 中提取 ID（如 URL 中也包含类似 ID 的模式）
    if ($downloadUrl -match '/(\d+)(?:/|$)') {
        return $matches[1]
    }

    # 最后 fallback
    return $app
}



function Get-AnkiAddonBasePath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PersistDirAnki # Should be $(persistdir anki $global) from manifest
    )
    return (Join-Path $PersistDirAnki "data\addons21")
}

function Install-AnkiAddonJunction {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$AddonID, # $app from manifest
        [Parameter(Mandatory = $true)]
        [string]$SourceDir, # $dir from manifest
        [Parameter(Mandatory = $true)]
        [string]$PersistDirAnki # $(persistdir anki $global) from manifest
    )

    $targetPath = Join-Path $addonBasePath $AddonID

    if (Test-Path $targetPath) {
        Write-Warning "Target path already exists: $targetPath. Skipping junction creation."
        return
    }

    Write-Verbose "Creating directory junction for $AddonID from $SourceDir to $targetPath"
    New-DirectoryJunction $targetPath $SourceDir | Out-Null
}

function Uninstall-AnkiAddonJunction {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$AddonID,
        [Parameter(Mandatory = $true)]
        [string]$PersistDirAnki
    )

    $targetPath = Join-Path $addonBasePath $AddonID

    if (Test-Path $targetPath) {
        try {
            Write-Verbose "Removing directory junction for $AddonID at $targetPath"
            Remove-Item -Path $targetPath -Recurse -Force
        } catch {
            Write-Error "Failed to remove junction at $($targetPath): $_"
        }
    } else {
        Write-Verbose "Target path $targetPath does not exist. Nothing to remove."
    }
}

function Install-AnkiAddonCopy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$AddonID,
        [Parameter(Mandatory = $true)]
        [string]$SourceDir,
        [Parameter(Mandatory = $true)]
        [string]$PersistDirAnki,

        [bool]$removeSource = $false
    )

    $targetPath = Join-Path $addonBasePath $AddonID

    if (Test-Path $targetPath) {
        Write-Warning "Target path already exists: $targetPath. Skipping copy."
        return
    }

    Write-Verbose "Copying addon $AddonID from $SourceDir to $targetPath"
    try {
        Copy-Item -Path $SourceDir -Destination $targetPath -Recurse
        if ($removeSource) {
            Remove-Item -Path $SourceDir -Recurse -Force
        }
    } catch {
        Write-Error "Failed to copy addon to $($targetPath): $_"
    }
}

function Uninstall-AnkiAddonCopy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$AddonID,
        [Parameter(Mandatory = $true)]
        [string]$PersistDirAnki
    )

    $targetPath = Join-Path $addonBasePath $AddonID

    if (Test-Path $targetPath) {
        try {
            Write-Verbose "Removing copied addon $AddonID from $targetPath"
            Remove-Item -Path $targetPath -Recurse -Force
        } catch {
            Write-Error "Failed to remove copied addon at $($targetPath): $_"
        }
    } else {
        Write-Verbose "Target path $targetPath does not exist. Nothing to remove."
    }
}


function Install-AnkiAddonDependencyJunction {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ParentAddonName, # $app of the addon that needs the dependency
        [Parameter(Mandatory = $true)]
        [string]$DependencyName, # Name of the dependency addon (e.g., 'ajt_common')
        [Parameter(Mandatory = $true)]
        [string]$DependencySourceDir, # $(appdir <dependency_app_name> $global)\current
        [Parameter(Mandatory = $true)]
        [string]$PersistDirAnki # $(persistdir anki $global) from manifest
    )
    $parentAddonBasePath = Join-Path (Get-AnkiAddonBasePath -PersistDirAnki $PersistDirAnki) $ParentAddonName
    $targetDependencyPath = Join-Path $parentAddonBasePath $DependencyName

    Write-Verbose "Removing existing dependency junction for $DependencyName in $ParentAddonName (if any)"
    Remove-Item -Path $targetDependencyPath -ErrorAction SilentlyContinue -Recurse -Force

    Write-Verbose "Creating directory junction for dependency $DependencyName in $ParentAddonName from $DependencySourceDir to $targetDependencyPath"
    New-DirectoryJunction $targetDependencyPath $DependencySourceDir | Out-Null
}


function AutoInstall {

    Install-AnkiAddonCopy -AddonID $addonID -SourceDir $dir -PersistDirAnki $PersistDirAnki -removeSource $true

}

function AutoUninstall {
    Uninstall-AnkiAddonCopy -AddonID $addonID -PersistDirAnki $PersistDirAnki
}

Export-ModuleMember -Function
