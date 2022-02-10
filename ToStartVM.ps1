using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$requestBody = $Request.Body
Write-Host $requestBody
$requestBody = $requestBody.Replace('&',"`n")
$requestBody = ConvertFrom-StringData -StringData $requestBody
$inputParam = $requestBody.text.Split('+')

$ResourceGroupName = $inputParam[0]
$VMName = $inputParam[1]

$Command = 'Start-AzVM -ResourceGroupName ' + '"'+ $ResourceGroupName + '"' + ' -Name ' + '"'+ $VMName + '"' + ' -NoWait'

Write-Host $Command
Invoke-Expression  $Command

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $Request.Query.Task + $Request.Query.ResourceGroupName + $Request.Query.VMName
})