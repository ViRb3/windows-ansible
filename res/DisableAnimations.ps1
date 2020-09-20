Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    [StructLayout(LayoutKind.Sequential)] public struct ANIMATIONINFO {
        public uint cbSize;
        public bool iMinAnimate;
    }
    public class PInvoke { 
        [DllImport("user32.dll")] public static extern bool SystemParametersInfoW(uint uiAction, uint uiParam, ref ANIMATIONINFO pvParam, uint fWinIni);
    }
"@
$animInfo = New-Object ANIMATIONINFO
$animInfo.cbSize = 8
$animInfo.iMinAnimate = $args[0]
[PInvoke]::SystemParametersInfoW(0x49, 0, [ref]$animInfo, 3)