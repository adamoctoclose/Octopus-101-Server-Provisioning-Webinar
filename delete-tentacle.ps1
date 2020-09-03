[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$OctopusURL = $OctopusParameters["Global.Octopus.ServerUrl"]
$APIKey = $OctopusParameters["Global.Octopus.api.Key"]
$SpaceId = $OctopusParameters["Global.Octopus.Space.Id"]
$template = $OctopusParameters["Project.AWS.EC2.Web.Stack.Name"]

$header = @{ "X-Octopus-ApiKey" = $APIKey }

Write-Host "Get a list of all machine"

write-highlight "$OctopusUrl/api/$SpaceId/machines?skip=0&take=1000&partialName=$template"
$targetList = (Invoke-RestMethod "$OctopusUrl/api/$SpaceId/machines?skip=0&take=1000&partialName=$template" -Headers $header)

foreach($target in $targetList.Items)
{
	$targetId = $target.Id
    Write-Highlight "Deleting the target $targetId because the name matches the template"
    $deleteResponse = (Invoke-RestMethod "$OctopusUrl/api/$SpaceId/machines/$targetId" -Headers $header -Method Delete)

    Write-Host "Delete Response $deleteResponse"    
}