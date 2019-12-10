param(
    [Parameter(Mandatory=$true)]$servicePrincipalPassword,
    [Parameter(Mandatory=$true)]$servicePrincipalId,
    [Parameter(Mandatory=$true)]$tenantId
)

# Authorizing powershell against Azure using a Service Principal
$passwd = ConvertTo-SecureString $servicePrincipalPassword -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential($servicePrincipalId, $passwd)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $tenantId