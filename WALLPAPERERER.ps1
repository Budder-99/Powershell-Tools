# Path to the wallpaper image
$wallpaperPath = "C:\wallpaper custom.png"

# Function to set the wallpaper
function Set-Wallpaper {
    param (
        [string]$imagePath
    )
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    [Wallpaper]::SystemParametersInfo(0x0014, 0, $imagePath, 0x0001 -bor 0x0002)
}

# Disable the group policy that sets the wallpaper
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
if (Test-Path $regPath) {
    Remove-ItemProperty -Path $regPath -Name "Wallpaper" -Force
    Remove-ItemProperty -Path $regPath -Name "WallpaperStyle" -Force
}

# Set the new wallpaper
Set-Wallpaper -imagePath $wallpaperPath

# Confirm the wallpaper has been set
Write-Output "Wallpaper has been set to $wallpaperPath"