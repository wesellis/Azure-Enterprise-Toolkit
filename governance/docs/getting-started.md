# Getting Started with Azure Governance Toolkit

This guide will help you get started with the Azure Governance Toolkit, a comprehensive collection of PowerShell scripts and ARM templates for Azure governance, compliance, and security management.

## Prerequisites

Before you begin, ensure you have the following:

### Software Requirements
- **PowerShell 5.1** or **PowerShell Core 6.0+**
- **Azure PowerShell module** (Az module)
- **Git** for cloning the repository
- **Visual Studio Code** (recommended) with PowerShell extension

### Azure Requirements
- **Azure subscription** with appropriate permissions
- **Contributor** or **Owner** role at the subscription level
- **Policy Contributor** role for policy-related scripts
- **Security Admin** role for security-related scripts

### Permissions Overview
Different scripts require different levels of access:

| Script Category | Required Permissions |
|-----------------|---------------------|
| Policy Management | Policy Contributor, Contributor |
| Resource Management | Contributor, Owner |
| Security Scripts | Security Admin, Contributor |
| Cost Management | Cost Management Contributor |
| RBAC Management | User Access Administrator |

## Installation

### Step 1: Clone the Repository

```powershell
# Clone the repository
git clone https://github.com/wesellis/Azure-Governance-Toolkit.git
cd Azure-Governance-Toolkit
```

### Step 2: Install Required PowerShell Modules

```powershell
# Install Azure PowerShell modules
Install-Module -Name Az -Force -AllowClobber -Scope CurrentUser

# Install additional modules for specific functionality
Install-Module -Name Az.PolicyInsights -Force -Scope CurrentUser
Install-Module -Name Az.Security -Force -Scope CurrentUser
Install-Module -Name Az.CostManagement -Force -Scope CurrentUser

# For development and testing
Install-Module -Name Pester -Force -Scope CurrentUser
Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser
```

### Step 3: Connect to Azure

```powershell
# Connect to Azure (interactive login)
Connect-AzAccount

# Set the subscription context
$subscriptionId = "your-subscription-id"
Set-AzContext -SubscriptionId $subscriptionId

# Verify your connection
Get-AzContext
```

### Step 4: Verify Installation

```powershell
# Check Azure PowerShell version
Get-Module Az -ListAvailable | Select-Object Name, Version

# Verify your permissions
Get-AzRoleAssignment -SignInName (Get-AzContext).Account.Id

# Test a simple script
.\scripts\audit-resources.ps1 -SubscriptionId $subscriptionId -WhatIf
```

## First Steps

### 1. Understand Your Environment

Before running governance scripts, understand your current Azure environment:

```powershell
# Get subscription information
Get-AzSubscription

# List resource groups
Get-AzResourceGroup | Select-Object ResourceGroupName, Location, Tags

# Check current policies
Get-AzPolicyAssignment | Select-Object Name, PolicyDefinitionId, Scope
```

### 2. Start with Read-Only Operations

Begin with scripts that only read information:

```powershell
# Audit your resources
.\scripts\audit-resources.ps1 -SubscriptionId $subscriptionId

# Check compliance status
.\scripts\audit-resource-compliance.ps1 -SubscriptionId $subscriptionId

# Generate a report
.\scripts\generate-report.ps1 -SubscriptionId $subscriptionId -OutputPath "./reports"
```

### 3. Use -WhatIf for Testing

Most scripts support the `-WhatIf` parameter for safe testing:

```powershell
# Test policy deployment without making changes
.\scripts\deploy-governance-policies.ps1 -SubscriptionId $subscriptionId -WhatIf

# Test resource tagging
.\scripts\tag-resources.ps1 -SubscriptionId $subscriptionId -TagName "Environment" -TagValue "Test" -WhatIf
```

## Common Workflows

### Basic Governance Setup

1. **Audit current state**
   ```powershell
   .\scripts\audit-resources.ps1 -SubscriptionId $subscriptionId
   ```

2. **Deploy core policies**
   ```powershell
   .\scripts\deploy-governance-policies.ps1 -SubscriptionId $subscriptionId
   ```

3. **Configure resource tagging**
   ```powershell
   .\scripts\tag-resources.ps1 -SubscriptionId $subscriptionId -TagName "CostCenter" -TagValue "IT"
   ```

4. **Set up monitoring**
   ```powershell
   .\scripts\create-budget-alerts.ps1 -SubscriptionId $subscriptionId -BudgetAmount 1000 -AlertEmail "admin@company.com"
   ```

### Security Baseline Setup

1. **Enable Security Center**
   ```powershell
   .\scripts\enable-security-center.ps1 -SubscriptionId $subscriptionId -Tier "Standard"
   ```

2. **Configure diagnostic settings**
   ```powershell
   .\scripts\configure-diagnostic-settings.ps1 -SubscriptionId $subscriptionId
   ```

3. **Set up resource locks**
   ```powershell
   .\scripts\configure-resource-locks.ps1 -SubscriptionId $subscriptionId -LockType "ReadOnly"
   ```

## Best Practices

### Before Running Scripts

1. **Test in development** - Always test scripts in a non-production environment first
2. **Use -WhatIf** - Understand what changes will be made
3. **Check permissions** - Ensure you have the required access
4. **Backup important data** - Some scripts may modify existing configurations

### Script Execution

1. **Run incrementally** - Don't run all scripts at once
2. **Monitor progress** - Use `-Verbose` parameter for detailed output
3. **Save logs** - Redirect output to files for audit trails
4. **Validate results** - Check that changes were applied correctly

### Security Considerations

1. **Use service principals** for automation scenarios
2. **Apply least privilege** - Only grant necessary permissions
3. **Secure credentials** - Never hardcode passwords or keys
4. **Audit changes** - Keep track of what was modified

## Troubleshooting

### Common Issues

**Authentication Errors**
```powershell
# Refresh your authentication
Connect-AzAccount -Force
```

**Permission Errors**
```powershell
# Check your current permissions
Get-AzRoleAssignment -SignInName (Get-AzContext).Account.Id
```

**Module Not Found**
```powershell
# Install missing modules
Install-Module -Name Az.PolicyInsights -Force
```

### Getting Help

- **Script Help**: Use `Get-Help .\scripts\script-name.ps1 -Full`
- **Azure Documentation**: [Azure PowerShell documentation](https://docs.microsoft.com/powershell/azure/)
- **Community**: [GitHub Issues](https://github.com/wesellis/Azure-Governance-Toolkit/issues)

## Next Steps

1. **Explore the scripts** - Review the available scripts in the `/scripts` directory
2. **Read documentation** - Check other guides in the `/docs` directory
3. **Join the community** - Contribute to the project or ask questions
4. **Customize for your needs** - Adapt scripts to your organization's requirements

## Resources

- [Azure Governance Documentation](https://docs.microsoft.com/azure/governance/)
- [Azure Policy Documentation](https://docs.microsoft.com/azure/governance/policy/)
- [PowerShell Best Practices](https://docs.microsoft.com/powershell/scripting/dev-cross-plat/performance/script-authoring-considerations)
- [Azure Security Best Practices](https://docs.microsoft.com/azure/security/fundamentals/)
