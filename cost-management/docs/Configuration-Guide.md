# Configuration Guide

This guide covers all configuration options for the Azure Cost Management Dashboard.

## 🔧 **Configuration Files**

### **Main Configuration (config.json)**
Primary configuration file containing Azure connection settings, dashboard preferences, and automation parameters.

```json
{
  "azure": {
    "subscriptionId": "12345678-1234-1234-1234-123456789012",
    "tenantId": "87654321-4321-4321-4321-210987654321",
    "resourceGroups": ["Production-RG", "Development-RG", "Testing-RG"],
    "excludedServices": ["Microsoft.Insights", "Microsoft.Advisor"],
    "defaultRegion": "East US",
    "costManagementScope": "subscription"
  },
  "dashboard": {
    "refreshSchedule": "Daily",
    "dataRetentionDays": 90,
    "currencyCode": "USD",
    "timeZone": "Eastern Standard Time",
    "theme": "Azure",
    "defaultDateRange": 30
  },
  "notifications": {
    "enabled": true,
    "emailRecipients": ["finance@company.com", "it-manager@company.com"],
    "budgetThresholds": [50, 80, 95],
    "anomalyDetection": true,
    "weeklyReports": true,
    "monthlyReports": true
  },
  "exports": {
    "autoExport": true,
    "formats": ["Excel", "CSV", "PDF"],
    "exportPath": "data\\exports",
    "retentionDays": 365,
    "compression": true
  },
  "security": {
    "encryptExports": false,
    "auditLogging": true,
    "accessControl": true,
    "dataClassification": "Internal"
  },
  "performance": {
    "maxRecordsPerQuery": 100000,
    "queryTimeout": 300,
    "cacheEnabled": true,
    "cacheDuration": 3600
  }
}
```

### **Authentication Configuration (auth.json)**
Secure authentication settings for Azure API access.

```json
{
  "tenantId": "your-tenant-id",
  "clientId": "your-service-principal-client-id", 
  "clientSecret": "your-service-principal-secret",
  "subscriptionId": "your-default-subscription-id",
  "authMethod": "ServicePrincipal",
  "scope": ["https://management.azure.com/.default"],
  "tokenCacheEnabled": true
}
```

## ⚙️ **Configuration Sections**

### **Azure Settings**

#### **subscriptionId**
- **Type**: String (GUID)
- **Required**: Yes
- **Description**: Primary Azure subscription for cost analysis
- **Example**: `"12345678-1234-1234-1234-123456789012"`

#### **tenantId**
- **Type**: String (GUID) 
- **Required**: Yes (for service principal auth)
- **Description**: Azure Active Directory tenant identifier
- **Example**: `"87654321-4321-4321-4321-210987654321"`

#### **resourceGroups**
- **Type**: Array of strings
- **Required**: No
- **Description**: Specific resource groups to monitor (empty = all)
- **Example**: `["Production-RG", "Development-RG"]`

#### **excludedServices**
- **Type**: Array of strings
- **Required**: No
- **Description**: Azure services to exclude from cost analysis
- **Common Values**: 
  - `"Microsoft.Insights"` (Application Insights)
  - `"Microsoft.Advisor"` (Azure Advisor)
  - `"Microsoft.Support"` (Support plans)

#### **costManagementScope**
- **Type**: String
- **Required**: No
- **Default**: `"subscription"`
- **Options**: `"subscription"`, `"resourceGroup"`, `"managementGroup"`
- **Description**: Default scope for cost queries

### **Dashboard Settings**

#### **refreshSchedule**
- **Type**: String
- **Required**: No
- **Default**: `"Daily"`
- **Options**: `"Hourly"`, `"Daily"`, `"Weekly"`, `"Manual"`
- **Description**: How frequently to refresh dashboard data

#### **dataRetentionDays**
- **Type**: Integer
- **Required**: No
- **Default**: `90`
- **Range**: 30-730
- **Description**: How long to retain historical cost data

#### **currencyCode**
- **Type**: String
- **Required**: No
- **Default**: `"USD"`
- **Options**: `"USD"`, `"EUR"`, `"GBP"`, `"CAD"`, etc.
- **Description**: Display currency for cost amounts

#### **timeZone**
- **Type**: String
- **Required**: No
- **Default**: `"UTC"`
- **Description**: Time zone for date/time displays
- **Example**: `"Eastern Standard Time"`, `"Pacific Standard Time"`

#### **theme**
- **Type**: String
- **Required**: No
- **Default**: `"Azure"`
- **Options**: `"Azure"`, `"Dark"`, `"Light"`, `"Custom"`
- **Description**: Visual theme for dashboards

### **Notification Settings**

#### **emailRecipients**
- **Type**: Array of strings
- **Required**: Yes (if notifications enabled)
- **Description**: Email addresses for cost alerts and reports
- **Example**: `["finance@company.com", "manager@company.com"]`

#### **budgetThresholds**
- **Type**: Array of integers
- **Required**: No
- **Default**: `[80, 95]`
- **Range**: 1-100
- **Description**: Budget percentage thresholds for alerts

#### **anomalyDetection**
- **Type**: Boolean
- **Required**: No
- **Default**: `true`
- **Description**: Enable automated anomaly detection and alerts

### **Export Settings**

#### **autoExport**
- **Type**: Boolean
- **Required**: No
- **Default**: `false`
- **Description**: Automatically export reports on schedule

#### **formats**
- **Type**: Array of strings
- **Required**: No
- **Default**: `["Excel"]`
- **Options**: `"Excel"`, `"CSV"`, `"PDF"`, `"HTML"`, `"JSON"`
- **Description**: Export formats to generate

#### **exportPath**
- **Type**: String
- **Required**: No
- **Default**: `"data\\exports"`
- **Description**: Directory for exported reports

## 🔒 **Security Configuration**

### **Service Principal Setup**
```powershell
# Create service principal for dashboard authentication
$sp = New-AzADServicePrincipal -DisplayName "Azure-Cost-Dashboard"

# Assign minimum required permissions
New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName "Cost Management Reader" -Scope "/subscriptions/your-subscription-id"
New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName "Reader" -Scope "/subscriptions/your-subscription-id"

# Save credentials securely
$authConfig = @{
    tenantId = "your-tenant-id"
    clientId = $sp.ApplicationId
    clientSecret = "your-client-secret"
    subscriptionId = "your-subscription-id"
}
$authConfig | ConvertTo-Json | Out-File "config\auth.json"
```

### **Encryption Settings**
```json
{
  "security": {
    "encryptExports": true,
    "encryptionKey": "your-encryption-key",
    "auditLogging": true,
    "logLevel": "Information",
    "accessControl": true,
    "allowedUsers": ["user1@company.com", "user2@company.com"],
    "dataClassification": "Confidential"
  }
}
```

## 📧 **Email Configuration**

### **SMTP Settings**
```json
{
  "email": {
    "smtpServer": "smtp.office365.com",
    "smtpPort": 587,
    "useSSL": true,
    "authMethod": "Basic",
    "fromAddress": "costmanagement@company.com",
    "fromDisplayName": "Azure Cost Management",
    "templatePath": "templates\\email"
  }
}
```

### **Office 365 Configuration**
```json
{
  "email": {
    "smtpServer": "smtp.office365.com",
    "smtpPort": 587,
    "useSSL": true,
    "authMethod": "OAuth2",
    "tenantId": "your-tenant-id",
    "clientId": "your-email-app-id",
    "clientSecret": "your-email-app-secret"
  }
}
```

### **Gmail Configuration**
```json
{
  "email": {
    "smtpServer": "smtp.gmail.com",
    "smtpPort": 587,
    "useSSL": true,
    "authMethod": "AppPassword",
    "username": "your-gmail@gmail.com",
    "appPassword": "your-app-password"
  }
}
```

## 🎯 **Environment-Specific Configurations**

### **Development Environment**
```json
{
  "azure": {
    "subscriptionId": "dev-subscription-id",
    "resourceGroups": ["Dev-RG", "Test-RG"]
  },
  "dashboard": {
    "refreshSchedule": "Manual",
    "dataRetentionDays": 30
  },
  "notifications": {
    "enabled": false
  },
  "exports": {
    "autoExport": false
  }
}
```

### **Production Environment**
```json
{
  "azure": {
    "subscriptionId": "prod-subscription-id",
    "resourceGroups": []
  },
  "dashboard": {
    "refreshSchedule": "Daily",
    "dataRetentionDays": 365
  },
  "notifications": {
    "enabled": true,
    "budgetThresholds": [75, 90, 95, 100]
  },
  "exports": {
    "autoExport": true,
    "retentionDays": 1095
  },
  "security": {
    "encryptExports": true,
    "auditLogging": true
  }
}
```

## 🔧 **Advanced Configuration**

### **Custom Cost Allocation**
```json
{
  "costAllocation": {
    "enabled": true,
    "rules": [
      {
        "name": "Department Allocation",
        "tagKey": "Department",
        "method": "TagBased",
        "fallbackMethod": "ResourceGroup"
      },
      {
        "name": "Project Allocation", 
        "tagKey": "Project",
        "method": "TagBased",
        "includeSharedCosts": true
      }
    ],
    "sharedCostDistribution": {
      "method": "Proportional",
      "sharedServices": ["Networking", "Security", "Management"]
    }
  }
}
```

### **Custom Dashboards**
```json
{
  "customDashboards": [
    {
      "name": "Executive Summary",
      "type": "PowerBI",
      "file": "dashboards\\PowerBI\\Executive-Summary.pbix",
      "refreshSchedule": "Weekly",
      "recipients": ["executives@company.com"]
    },
    {
      "name": "Department Breakdown",
      "type": "Excel", 
      "template": "dashboards\\Excel\\Department-Template.xlsx",
      "refreshSchedule": "Daily",
      "recipients": ["managers@company.com"]
    }
  ]
}
```

### **API Rate Limiting**
```json
{
  "apiLimits": {
    "costManagementApi": {
      "requestsPerMinute": 30,
      "requestsPerHour": 1000,
      "retryAttempts": 3,
      "retryDelay": 5000
    },
    "resourceGraphApi": {
      "requestsPerMinute": 60,
      "requestsPerHour": 2000,
      "retryAttempts": 5,
      "retryDelay": 2000
    }
  }
}
```

## 🛠️ **Configuration Management**

### **Environment Variables**
Set sensitive values using environment variables:

```powershell
# Set Azure authentication
$env:AZURE_TENANT_ID = "your-tenant-id"
$env:AZURE_CLIENT_ID = "your-client-id"
$env:AZURE_CLIENT_SECRET = "your-client-secret"

# Set email credentials
$env:SMTP_USERNAME = "your-email@company.com"
$env:SMTP_PASSWORD = "your-password"
```

### **Configuration Validation**
```powershell
# Validate configuration file
.\scripts\utilities\Test-Configuration.ps1 -ConfigPath "config\config.json"

# Validate Azure connectivity
.\scripts\utilities\Test-AzureConnection.ps1

# Validate email settings
.\scripts\utilities\Test-EmailConfiguration.ps1
```

### **Configuration Templates**
Create configuration templates for different scenarios:

```powershell
# Generate configuration for new environment
.\scripts\setup\New-Configuration.ps1 -Environment "Production" -SubscriptionId "your-sub-id"

# Update existing configuration
.\scripts\setup\Update-Configuration.ps1 -ConfigPath "config\config.json" -Setting "dashboard.refreshSchedule" -Value "Hourly"
```

## 🔍 **Troubleshooting Configuration**

### **Common Configuration Issues**

#### **Azure Authentication Failures**
- Check service principal permissions
- Verify tenant ID and client ID
- Ensure client secret hasn't expired
- Check subscription access

#### **Email Delivery Issues**
- Verify SMTP server settings
- Check firewall and network connectivity
- Validate email credentials
- Test with simple SMTP client

#### **Data Access Problems**
- Confirm Cost Management Reader role assignment
- Check subscription scope and permissions
- Verify resource group access
- Test with Azure CLI/PowerShell

### **Configuration Validation Script**
```powershell
# Run comprehensive configuration test
.\scripts\setup\Validate-Configuration.ps1 -Verbose

# Test specific configuration section
.\scripts\setup\Test-ConfigSection.ps1 -Section "azure" -ConfigPath "config\config.json"
```

## 📞 **Configuration Support**

For configuration assistance:
- **Documentation**: See `/docs` folder for detailed guides
- **Examples**: Check `/config/examples` for sample configurations
- **Issues**: Report configuration problems on GitHub
- **Email**: wes@wesellis.com for configuration consultation

---

**Next Steps**: After configuring, run the installation validation script and generate your first cost report to verify everything is working correctly.
