@maxLength(24)
@description('Assignment name')
param assignmentName string 

@maxLength(128)
@description('Assignement display Name')
param assignmentDisplayName string

@description('Assignement description')
param assignmentDescription string


@description('Assignement enforcement mode')
param assignmentEnforcementMode string

@description('remediation message JSON string')
param assignmentMessage string

@description('parameter json string')
param assignmentParameters string

@description('policy definition or policy set ID')
param assignmentPolicyID string



resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: assignmentName
  properties: {
    description: assignmentDescription
    displayName: assignmentDisplayName
    enforcementMode: assignmentEnforcementMode
    nonComplianceMessages: json(assignmentMessage)
    parameters: json(assignmentParameters)
    policyDefinitionId: assignmentPolicyID
  }
}
