#Requires -Module Pester


BeforeAll {

    # === 模拟注入 ===
    function persistdir {
        param ($name, $scope)
        return 'C:\User\name\scoop\'
    }

    $app = 'fallback-addon-id'
    $global = $true
    $manifest = @{ addon_id = '123456'; homepage = 'irrelevant' }

    . "$PSScriptRoot\utils.ps1"
}


Describe "Get-AddonID" {
    It "returns addon_id from manifest directly" {
        $manifest = @{ addon_id = '1234567890'; homepage = 'irrelevant' }
        Get-AddonID -manifest $manifest | Should -Be '1234567890'
    }

    It "extracts ID from homepage URL if addon_id not present" {
        $manifest = @{ homepage = 'https://ankiweb.net/shared/info/7890128888' }
        Get-AddonID -manifest $manifest | Should -Be '7890128888'
    }

    It "extracts ID from manifest.url if homepage and addon_id not present" {
        $manifest = @{ url = 'https://ankiweb.net/shared/download/987654' }
        Get-AddonID -manifest $manifest | Should -Be '987654'
    }

    It "extracts ID from manifest.architecture if url is missing" {
        $manifest = @{ architecture = @{ '64bit' = @{ url = 'https://ankiweb.net/shared/download/1112228888' } } }
        Get-AddonID -manifest $manifest | Should -Be '1112228888'
    }

    It "returns fallback when ID not found" {
        $manifest = @{ homepage = 'https://example.com' }
        Get-AddonID -manifest $manifest | Should -Be 'fallback-addon-id'
    }
}

Describe "Get-AnkiAddonBasePath" {
    It "returns the expected addon path" {
        Get-AnkiAddonBasePath -PersistDirAnki "C:\Data\Anki" | Should -Be "C:\Data\Anki\data\addons21"
    }
}

Describe "Install-AnkiAddonJunction and Uninstall-AnkiAddonJunction" {

    BeforeEach {

        function New-DirectoryJunction {
            return 'done'

        }

        Mock -CommandName New-DirectoryJunction {}
    }

    It "creates junction when target does not exist" {
        Mock -CommandName Test-Path -MockWith { $false }
        Install-AnkiAddonJunction -AddonID "1234567890" -SourceDir "C:\Addon" -PersistDirAnki "C:\Anki"
        Assert-MockCalled -CommandName New-DirectoryJunction -Exactly 1
    }

    It "skips creating junction if target exists" {
        Mock -CommandName Test-Path -MockWith { $true }
        Install-AnkiAddonJunction -AddonID "1234567890" -SourceDir "C:\Addon" -PersistDirAnki "C:\Anki"
        Assert-MockCalled -CommandName New-DirectoryJunction -Exactly 0
    }
}

Describe "Install-AnkiAddonCopy and Uninstall-AnkiAddonCopy" {

    BeforeEach {

        Mock -CommandName Copy-Item {}
        Mock -CommandName Remove-Item {}
    }

    It "copies addon if target does not exist" {
        Mock -CommandName Test-Path -MockWith { $false }
        Install-AnkiAddonCopy -AddonID "addon" -SourceDir "C:\Users\Public" -PersistDirAnki "C:\Users"
        Assert-MockCalled -CommandName Copy-Item -Exactly 1
    }

    It "removes copied addon during uninstall" {
        Mock -CommandName Test-Path -MockWith { $true }
        Uninstall-AnkiAddonCopy -AddonID "addon" -PersistDirAnki "C:\Anki"
        Assert-MockCalled -CommandName Remove-Item -Exactly 1
    }
}

Describe "AutoInstall / AutoUninstall" {
    BeforeEach {
        . "$PSScriptRoot\utils.ps1"
        Mock Install-AnkiAddonCopy {}
        Mock Uninstall-AnkiAddonCopy {}
    }

    It "calls Install-AnkiAddonCopy with removeSource = true" {
        AutoInstall -AddonID "id" -SourceDir "src" -PersistDirAnki "anki"
        Assert-MockCalled Install-AnkiAddonCopy -ParameterFilter {
            $removeSource -eq $true
        }
    }

    It "calls Uninstall-AnkiAddonCopy" {
        AutoUninstall -AddonID "id" -PersistDirAnki "anki"
        Assert-MockCalled Uninstall-AnkiAddonCopy -Exactly 1
    }
}
