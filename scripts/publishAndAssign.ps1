param(
    [Parameter(Mandatory=$true)]$blueprintName,
    [Parameter(Mandatory=$true)]$blueprintPath,
    [Parameter(Mandatory=$true)]$subscriptionId,
    [Parameter(Mandatory=$true)]$blueprintVersion
)

. "./scripts/common.ps1"

# this is a command in powershell
Import-AzBlueprintWithArtifact -Name $blueprintName -SubscriptionId $subscriptionId -InputPath $blueprintPath -Force

# Get the blueprint we just created
$bp = Get-AzBlueprint -Name $blueprintName -SubscriptionId $subscriptionId
# Publish version 1.0
Publish-AzBlueprint -Blueprint $bp -Version $blueprintVersion

# Get the version of the blueprint you want to assign, which we will pas to New-AzBlueprintAssignment
$publishedBp = Get-AzBlueprint -SubscriptionId $subscriptionId -Name $blueprintName -LatestPublished


# Assign the new blueprint to the specified subscription (Assignment updates should use Set-AzBlueprintAssignment
$joinedName = generateName -blueprintName $blueprintName -blueprintVersion $blueprintVersion

# Submit a new assignment with the deserved values
New-AzBlueprintAssignment -Blueprint $publishedBp -Location eastus -SubscriptionId $subscriptionId -Name $joinedName