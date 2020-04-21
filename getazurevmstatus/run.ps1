using namespace System.Net
param($Request)
Function Get-VMStatus {
    get-Azvm -Status 
}
Function Get-HTMLReport {
    $Header = @"
<style>
BODY {font-family:Arial;}
TABLE{border: 1px solid black; border-collapse: collapse; font-size:13pt;}
TH{border: 1px solid black; background: #dddddd; padding: 5px; color: #000000;}
TD{border: 1px solid black; padding: 5px; }
</style>
"@
  
    $VMsStatus = Get-VMStatus
    $VmsHTMLReport = $VMsStatus | ConvertTo-Html -property "ResourceGroupName", "Name", "PowerState","Location"
 
    $Header + "VM's Status <p>" + $VmsHTMLReport
}
$HTML = Get-HTMLReport  
Push-OutputBinding -Name Response -Value (@{
        StatusCode  = "ok"
        ContentType = "text/html"
        Body        = $HTML
    })