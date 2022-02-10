using namespace System.Net

param($Request, $TriggerMetadata)

$output = get-Azvm -Status | select "ResourceGroupName", "Name", "PowerState"

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $output
})