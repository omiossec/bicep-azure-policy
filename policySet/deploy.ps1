[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $managementGroupID,

    [string]
    $location = "westeurope"
)

if (!(Test-Path -Path "./policysetdef.json")) {
    throw "Definition policy configuration json file is not present"
    exit 1
}

if ($null -eq ( Get-AzContext -ErrorAction SilentlyContinue)){
    throw "You need to have an open session in Azure, please use connect-azaccount"
    exit 1 
}

try {
    $jsonDefinition = Get-Content -Path "./policysetdef.json" | ConvertFrom-Json
}
catch {
    write-error "unable to get configuration data"
    exit 1
}

$randomNumber = Get-Random
$deployName = "$($jsonDefinition.initiativeName)-$($randomNumber)"

New-AzManagementGroupDeployment -Name $deployName  -ManagementGroupId $managementGroupID -Location $location -TemplateFile ./deploySet.bicep -initiativeName $jsonDefinition.initiativeName  -initiativeDisplayName $jsonDefinition.displayName -initiativeDescription $jsonDefinition.description -initiativePoliciesID $jsonDefinition.policyToInclude