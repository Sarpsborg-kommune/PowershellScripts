$Computers = "E:\_Script\ConfigMgr\DeleteCMDevices\DeleteCMDevices.txt"
ForEach ($Computer in (Get-Content $Computers))
{   Try {
        Remove-CMDevice $Computer -Force 
        Add-Content "E:\_Script\ConfigMgr\DeleteCMDevices\Log_RemoveCMDevices.log" -Value "$Computer removed" -Force
    }
    Catch {
        Add-Content "E:\_Script\ConfigMgr\DeleteCMDevices\Log_RemoveCMDevices.log" -Value "$Computer not found because $($Error[0])"
    }
}