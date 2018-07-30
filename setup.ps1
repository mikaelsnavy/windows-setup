function Ask-Command {
    <#
    .SYNOPSIS
    Yes or no prompt to run a command
    .DESCRIPTION
    Provides the user with a yes or no prompt to do something, if yes run a command
    .EXAMPLE
    Give an example of how to use it
    .PARAMETER prompt
    What are we asking the user to do?
    .PARAMETER command
    Command to execute if yes 
    #>
    [CmdletBinding()]
    param
    (
      [Parameter(Mandatory=$True)]
      [string]$prompt,
      [Parameter(Mandatory=$True)]
      [string]$command
    )

    process {
        $answer = Read-Host $prompt + " (Yes or No)"
        while("yes","no" -notcontains $answer)
        {
            $answer = Read-Host "Yes or No"
        }
        if ($answer -eq "yes") {
            & $command
        }
    }
  }

## INSTALL PACKAGE MANAGERS
Write-Host "Installing Scoop and Choco..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## INSTALL APPS THROUGH SCOOP
Write-Host "Installing basic apps through scoop (cmder, curl, docker)..."
scoop install cmder
scoop install curl
scoop install dotnet-sdk

# Optional installs
Ask-Command "Do you want to install docker?" "scoop install docker"
Ask-Command "Do you want to install python?" "scoop install python"
Ask-Command "Do you want to install r?" "scoop install r"
Ask-Command "Do you want to install rust?" "scoop install rust"

## INSTALL APPS THROUGH CHOCO
Write-Host "Installing apps through choco (Greenshot, git, ditto, vscode, microsoft teams, postman, 7-Zip, ZoomIt)..."
choco install greenshot -y
choco install git.install -y
choco install ditto -y
choco install vscode -y
choco install 7zip -y
choco install zoomit -y
choco install autohotkey -y

Ask-Command "Do you want to install MS teams?" "choco install microsoft-teams -y"
Ask-Command "Do you want to install postman?" "choco install postman -y"

# Startup script setup
mkdir ~/bin/
Copy-Item ".\startup.cmd" -Destination "~/bin/"
# AutoHotKey setup :) 
mkdir ~/bin/AutoHotKey/
Copy-Item "\AutoHotKey" -Destination "~/bin/AutoHotKey/" -Recurse

# Make the startup script...well..startup automatically
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($env:USERPROFILE + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startup.cmd.lnk")
$Shortcut.TargetPath = $env:USERPROFILE + "\bin\startup.cmd"
$Shortcut.Save()

# Install visual studio
Invoke-WebRequest -Uri "https://aka.ms/vs/15/release/vs_enterprise.exe"
.\vs_enterprise.exe
Write-Host 'Popping up VS Installer';
Write-Host -NoNewLine 'Press any key to continue once done...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# MANUAL STEP
Write-Host "MANUAL STEP: Install setting sync for VSCode. Use gist ID 2fae7ab3b58333e6c065f070ece52867"
Write-Host -NoNewLine 'Press any key to continue once done...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Write-Host "MANUAL STEP: Powershell tricks at https://gist.github.com/rkeithhill/60eaccf1676cf08dfb6f"
Write-Host -NoNewLine 'Press any key to continue once done...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Write-Host "MANUAL STEP: Install Notion"
Write-Host -NoNewLine 'Press any key to continue once done...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Write-Host "Installing WSL..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

Write-Host "Now reboot and install Ubuntu through the store..."
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');