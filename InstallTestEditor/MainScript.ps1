#Paths
$WorkingDirectory = split-path -parent $MyInvocation.MyCommand.Definition
$ModulesLocationPath = "$WorkingDirectory\InstallTextEditor"
#$InstallationfileLocation = "C:\Users\Abby\Downloads\npp.7.7.1.Installer.x64.exe"
$InstallationfileLocation="C:\Users\Abby\Downloads\Programs\k\npp.7.8.4.Installer.exe"

$logfile = "C:\Users\Abby\Desktop\new\chilog_$(get-date -format `"yyyyMMdd_hhmmsstt`").txt"
#


param 
( 
    [parameter()][string] $FolderPath=$InstallationfileLocation,
    [parameter()][string] $FileExtension =".exe"
) 
 
$Result = (TestPath($FolderPath)); 
 
If ($Result) 
{ 
    $Dir = get-childitem $FolderPath -recurse 
    $List = $Dir | where {$_.extension -eq $FileExtension} 
    $List | format-table Name 
} 
else 
{ 
    "Folder path is incorrect." 
} 
 
function TestPath()  
{ 
    $FileExists = Test-Path $FolderPath 
    If ($FileExists -eq $True)  
    { 
        Return $true 
    } 
    Else  
    { 
        Return $false 
    } }



function RegisterModules {
    <#
    .Description

    Registers all modules created and placed in scripts within the modules folder
    #>
    if (Test-Path $ModulesLocationPath) {
        foreach ($item in (Get-ChildItem -Path $ModulesLocationPath)) {
            Import-Module "$ModulesLocationPath\$item"
        }
    }
    else {
        Write-Information "Path $ModulesLocationPath does not exist"
        log "Path $ModulesLocationPath does not exist"
    }
}


 
#this is our logging function, it must appear above the code where you are trying to use it.
#note there is a technique to get around needing this at the top
function log($string, $color)
{
   if ($Color -eq $null) {$color = "white"}
   write-host $string -foregroundcolor $color
   $string | out-file -Filepath $logfile -append
}





function Main {
    <#
    .Description
    This is the point of entry for program execution.
    It is from this point that installation of the text editorwill be intiated

    #>
    RegisterModules
    if (TestPath = $true){
    Write-Host "File exists"
    
    
    
    Install-TextEditor $InstallationfileLocation
    $cmds = get-command
    log "there are $($cmds.count)" 
    }
    else{
    Write-Host "File Does Not Exist"
     log "Error: File Does Not Exist" 
    }
    
}
Main
