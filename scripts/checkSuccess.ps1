param(
    [Parameter(Mandatory=$true)]$blueprintName,
    [Parameter(Mandatory=$true)]$subscriptionId,
    [Parameter(Mandatory=$true)]$blueprintVersion
)

. "./scripts/common.ps1"

# following the convetion that the assign script creates
$joinedName = generateName -blueprintName $blueprintName -blueprintVersion $blueprintVersion

$foundBlueprint = Get-AzBlueprintAssignment -SubscriptionId $subscriptionId -Name $joinedName.Replace(".","")

# wait until the deployment is valid and then exit the script
While ($true) {
    if ($foundBlueprint.ProvisioningState -eq "Succeeded") {
        Write-Output "Deployment $joinedName was successfull!"
        Break
    } elseif ($foundBlueprint.ProvisioningState -eq "Failed" ) {
        Write-Output "Deployment $joinedName failed. Check Azure logs!"
        exit 1
    } else {
        Start-Sleep -Seconds 30
    }
    $foundBlueprint = Get-AzBlueprintAssignment -SubscriptionId $subscriptionId -Name $joinedName
}
