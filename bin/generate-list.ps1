param($path)

$manifests = Get-ChildItem "$PSScriptRoot\..\bucket"

$content = @("|Anki addons ($($manifests.Length))|version|description|github url|", "|:-:|:-:|:-:|-|")


$isCN = $path -like "*cn*.md"

foreach ($_ in $manifests) {
    $json = Get-Content $_.FullName -Raw -Encoding UTF8 | ConvertFrom-Json -AsHashtable
    $info = @()

    $app = $_.BaseName

    # homepage
    if ($isCN) {
        $info += "[$app]($($json.homepage) `"点击查看 $($app) 的主页或仓库`")"
    }
    else {
        $info += "[$app]($($json.homepage) `"Click to view the homepage or repository of $($app)`")"
    }


    # Tag
    $tag = @()

    ## version
    # $info += "[v$($json.version)](./bucket/$($_.Name))"
    $title = if ($isCN) { "点击查看 $app 的 manifest json 文件" } else { "Click to view the manifest json file of $app" }
    $tag += '<a href="./bucket/' + $_.Name + '" title="' + $title + '"><img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FChuckieChen945%2Fscoop-of-stars%2Frefs%2Fheads%2Fmain%2Fbucket%2F' + $_.Name + '&query=%24.version&prefix=v&label=%20" alt="version" /></a>'

    $info += $tag -join '<br />'

    ## description
    $description = $json.description
    $info += $description

    # url
    $info += if ($json.url) { "<$($json.url)>" } else { " " }

    $content += "|" + ($info -join "|") + "|"
}

function get_static_content($path) {
    $content = Get-Content -Path $path -Encoding UTF8

    $match = $content | Select-String -Pattern "<!-- prettier-ignore-start -->"

    if ($match) {
        $matchLineNumber = ([array]$match.LineNumber)[0]
        $result = $content | Select-Object -First $matchLineNumber
        $result
    }
}

(get_static_content $path) + $content + "<!-- prettier-ignore-end -->" | Out-File $path -Encoding UTF8 -Force
