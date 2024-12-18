# Function to enable dark mode

function Set-DarkMode {

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0

    Write-Host -ForegroundColor Yellow "Dark mode enabled."

}
 
# Function to restart explorer to apply changes

function Restart-Explorer {

    Stop-Process -Name explorer -Force

    Start-Sleep -Seconds 2

    Start-Process explorer

}
 
# Enable dark mode and restart explorer

Set-DarkMode

Restart-Explorer
 