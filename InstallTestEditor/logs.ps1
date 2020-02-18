#Handling log errors we use the try catch then store the logs in the new.txt

$SearchLog  = “C:\Users\Omboye\Desktop\logs\new.txt”
Try{
  Get-ChildItem -Path "~\Documents\*.g" -Recurse -ErrorAction Stop -ErrorVariable SearchError
}
Catch{
  Add-Content -Path $SearchLog -Value "$(Get-Date -Format dd-MM-yy-hh_mm_ss) Files not found returned error: $SearchError"
Write-Host "$SearchLog"
}
Write-Host "$SearchLog"

