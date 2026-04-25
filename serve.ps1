$localRubyRoot = Join-Path $PSScriptRoot ".local-tools\ruby-devkit-3.3.11"
$fallbackRubyRoot = Join-Path $PSScriptRoot ".local-tools\rubyinstaller-3.3.11-1-x64"
$ridk = $null

if (Test-Path (Join-Path $localRubyRoot "bin\ruby.exe")) {
    $env:Path = "$(Join-Path $localRubyRoot "bin");$env:Path"
    $ridk = Join-Path $localRubyRoot "bin\ridk.cmd"
} elseif (Test-Path (Join-Path $fallbackRubyRoot "bin\ruby.exe")) {
    $env:Path = "$(Join-Path $fallbackRubyRoot "bin");$env:Path"
}

if (-not (Get-Command bundle -ErrorAction SilentlyContinue)) {
    Write-Error "Bundler is not available. Install Ruby, then run: gem install bundler"
    exit 1
}

$env:BUNDLE_PATH = Join-Path $PSScriptRoot ".bundle"
$env:BUNDLE_USER_HOME = Join-Path $PSScriptRoot ".bundle"
$env:RUBYOPT = "-W0"

foreach ($target in @("_site", ".sass-cache")) {
    $path = Join-Path $PSScriptRoot $target
    if (Test-Path $path) {
        $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        & icacls $path /grant "${user}:(OI)(CI)F" /T /C | Out-Null
        Remove-Item -LiteralPath $path -Recurse -Force
    }
}

if ($ridk -and (Test-Path $ridk)) {
    & $ridk exec bundle install
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    & $ridk exec bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload
    exit $LASTEXITCODE
}

bundle install
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload
