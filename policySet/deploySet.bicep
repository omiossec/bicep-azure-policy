targetScope = 'managementGroup' 

@maxLength(64)
@description('PolicySet name')
param initiativeName string 

@maxLength(128)
@description('PolicySet display Name')
param initiativeDisplayName string

@description('PolicySet description')
param initiativeDescription string

@minLength(1)
@description('array of policy ID')
param initiativePoliciesID array

param category string = 'compliance' 
param verion string = '1.0.0'


resource policySetDef 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {

  name: initiativeName

    properties: {
      description: initiativeDescription
      displayName: initiativeDisplayName 
      metadata: {
        category: category
        version: verion
      }

      parameters: {}

      policyDefinitions: [for ID in initiativePoliciesID: {
          parameters: {}
          policyDefinitionId: ID
          policyDefinitionReferenceId: ''
        } ]
      policyType: 'Custom'

    }
}

