$allLibs = "Az", "Az.Blueprint"

Foreach ($lib in $allLibs) {
    Install-Module -Name $lib -AllowClobber -Force
}