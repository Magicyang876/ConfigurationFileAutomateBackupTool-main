$lists = Import-Csv .\BackupList.csv -Encoding UTF8
$date = Get-Date -format "yyyyMMdd-HHmmss"
function BackupFilesInFolder {
    param (
        [string]$FolderPath,
        [string]$FileName
    )

    $fileNameArr = $FileName.Split("|")
    foreach ($file in $fileNameArr) {
        $config_files = Get-ChildItem -Path $folderPath -Filter $file -Recurse -ErrorAction SilentlyContinue -Force
        foreach($f in $config_files){
            Copy-Item $f.FullName -Destination ($f.Directory.FullName + '\' + $date + '-' + $f.Name)
            Write-Host "Backup" $f.Director $f.FullName " Successfully." -ForegroundColor Green
        }
    }
}
function BackupFilesInRemoteFolder {
    param (
        [string]$HostName,
        [string]$UserName,
        [string]$FolderPath,
        [string]$FileName
    )
    if([string]::IsNullOrEmpty($UserName)){
        $credential = Get-Credential -Message "Connecting to $($HostName)"
    }else{
        $credential = Get-Credential -UserName $UserName -Message "Connecting to $($HostName)"
    }

    if(!$credential){
        Write-Host "Credential for $($HostName) Cancelled!" -ForegroundColor Yellow
        return
    }else{
        Invoke-Command -ComputerName $HostName -ScriptBlock {
            $fileNameArr = ($using:FileName).Split("|")
            foreach ($file in $fileNameArr) {
                $config_files = Get-ChildItem -Path $using:folderPath -Filter $file -Recurse -ErrorAction SilentlyContinue -Force
                foreach($f in $config_files){
                    Copy-Item $f.FullName -Destination ($f.Directory.FullName + '\' + $using:date + '-' + $f.Name)
                    Write-Host "Backup $($f.Director) $($f.FullName) Successfully." -ForegroundColor Green
                }
            }
        } -Credential $credential
    }

}

foreach ($listItem in $lists) {
    if($listItem.Enabled -eq "N"){
        continue;
    }
    if($listItem.Enabled -eq "Y" -or [string]::IsNullOrEmpty($listItem.Enabled)){
        if([string]::IsNullOrEmpty($listItem.Folder) -or [string]::IsNullOrEmpty($listItem.FileName)){
            Write-Host "Folder and FileName can't be empty!Skipped!" -ForegroundColor Red;
            continue;
        }
        if([string]::IsNullOrEmpty($listItem.Host)){
            BackupFilesInFolder -FolderPath $listItem.Folder -FileName $listItem.FileName
        }else {
            BackupFilesInRemoteFolder -HostName $listItem.Host -UserName $listItem.UserName -FolderPath $listItem.Folder -FileName $listItem.FileName
        }
    }

}
