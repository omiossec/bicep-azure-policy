[CmdletBinding()]
param (
    [string]
    $location = "westeurope"
)
$jsonData = Get-Content -Path "./assignments.json"| ConvertFrom-Json  

foreach ($assignment in $jsonData) {
    $assignmentDisplayName = $assignment.assignmentDisplayName
    $assignmentName = $assignment.assignmentName
    $assignmentDescription = $assignment.assignmentDescription
    $assignmentEnforcementMode = $assignment.assignmentEnforcementMode
    $assignmentPolicyID = $assignment.assignmentPolicyID
    $scope = $assignment.scope
    $assignmentParameters = $assignment.assignmentParameters | convertTo-Json 
    if ($assignment.assignmentMessage.count -EQ 0) {
        $assignmentMessage = "[]"
    }
    elseif ($assignment.assignmentMessage.count-EQ 1) {
        $assignmentTmp = $assignment.assignmentMessage | convertTo-Json  
        $assignmentMessage = "[$($assignmentTmp)]"

    }
    else {
        $assignmentMessage = $assignment.assignmentMessage | convertTo-Json 
    }
    $randomNumber = Get-Random
    $deployName = "$($assignmentName)-$($randomNumber)"
    New-AzManagementGroupDeployment -Name $deployName  -ManagementGroupId $scope -Location $location -TemplateFile ./deployAssignement.bicep -assignmentName $assignmentName -assignmentDisplayName $assignmentDisplayName -assignmentDescription $assignmentDescription -assignmentEnforcementMode $assignmentEnforcementMode -assignmentMessage $assignmentMessage -assignmentParameters $assignmentParameters -assignmentPolicyID $assignmentPolicyID

}