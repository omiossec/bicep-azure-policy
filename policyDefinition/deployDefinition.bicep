targetScope = 'managementGroup' 

@maxLength(64)
@description('PolicySet name')
param defintionName string 

@maxLength(128)
@description('PolicySet display Name')
param definitionDisplayName string

@description('PolicySet description')
param definitionDescription string

@allowed([
  'All'
  'Indexed'
])
@description('Policy Definition Mode')
param policyMode string

@description('JSON string')
param policyParameters string

@description('JSON string')
param policyMetadata string

@description('JSON string')
param policyRule string

resource policyInitiative 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: defintionName
  properties: {
    displayName: definitionDisplayName
    description: definitionDescription
    policyType: 'Custom'
    mode: policyMode
    metadata: json(policyMetadata)
  
    parameters: json(policyParameters) 

    policyRule: json(policyRule)
  }
}
