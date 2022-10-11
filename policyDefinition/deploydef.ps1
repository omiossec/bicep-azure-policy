[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $managementGroupID,

    [string]
    $location = "westeurope"
)

$jsonFilesList = Get-ChildItem -Path ./definition/* -include *.json 

foreach ($jsonFile in $jsonFilesList) {
    $jsonData = Get-Content -Path $jsonFile.FullName | ConvertFrom-Json  
    $displayName = $jsonData.properties.DisplayName 
    $name = $jsonFile.name.replace(".json","")
    $parameters = $jsonData.properties.parameters | convertTo-Json  -Depth 5
    $policyRules = $jsonData.properties.policyRule | convertTo-Json  -Depth 5
    $policyMetadata = $jsonData.properties.metadata | convertTo-Json  -Depth 5
    $mode = $jsonData.properties.mode 
    $description = $jsonData.properties.description 

    $randomNumber = Get-Random
    $deployName = "$($name)-$($randomNumber)"
    New-AzManagementGroupDeployment -Name $deployName  -ManagementGroupId $managementGroupID -Location $location -TemplateFile ./deployDefinition.bicep -defintionName $name -definitionDisplayName $displayName -definitionDescription $description -policyMode $mode -policyParameters $parameters -policyMetadata $policyMetadata -policyRule $policyRules
}