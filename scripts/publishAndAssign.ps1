param(
    [Parameter(Mandatory=$true)]$blueprintName,
    [Parameter(Mandatory=$true)]$subscriptionId,
    [Parameter(Mandatory=$true)]$blueprintVersion
)

# this is a command in powershell
Import-AzBlueprintWithArtifact -Name $blueprintName -SubscriptionId $subscriptionId -InputPath  "../blueprint/" -Force

# Get the blueprint we just created
$bp = Get-AzBlueprint -Name $blueprintName -SubscriptionId $subscriptionId
# Publish version 1.0
Publish-AzBlueprint -Blueprint $bp -Version $blueprintVersion

# Get the version of the blueprint you want to assign, which we will pas to New-AzBlueprintAssignment
$publishedBp = Get-AzBlueprint -SubscriptionId $subscriptionId -Name $blueprintName -LatestPublished

#define the parameters that will be used to assign the blueprint
$params = @{ vmSizeGen = "Standard_A2" }

# Assign the new blueprint to the specified subscription (Assignment updates should use Set-AzBlueprintAssignment
$joinedName = -join($blueprintName, $blueprintVersion)

New-AzBlueprintAssignment -Blueprint $publishedBp -Location eastus -SubscriptionId $subscriptionId -Name $joinedName.Replace(".","") -Parameter $params