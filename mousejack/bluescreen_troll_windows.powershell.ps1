# From https://github.com/EmpireProject/Empire/blob/master/lib/modules/powershell/trollsploit/thunderstruck.py
Function Invoke-FakeBSOD {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $URL = "http://fakebsod.com/windows-8-and-10"
    )

    $edgeversion = Get-AppxPackage -Name Microsoft.MicrosoftEdge | ForEach-Object Status
    if ($edgeversion -like "Ok") {
        Start-Process microsoft-edge:$URL
        $EdgeComObject = New-Object -ComObject wscript.shell
        $EdgeComObject.AppActivate('Google - Microsoft Edge')
        Start-Sleep 2
        $EdgeComObject.SendKeys('{F11}')
    }
    else {
        #Create hidden IE Com Object
        $IEComObject = New-Object -com "InternetExplorer.Application"
        $IEComObject.visible = $True
        $IEComObject.navigate($URL)
        $IEComObject.FullScreen = $True
    }
} Invoke-FakeBSOD
