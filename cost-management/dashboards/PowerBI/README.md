# Power BI Dashboard Templates

This folder contains Power BI dashboard templates for Azure cost management and analysis.

## Available Dashboards

### 📊 **Azure-Cost-Dashboard.pbix** (Main Dashboard)
- **Overview**: Comprehensive cost analysis across all Azure services
- **Features**: 
  - Real-time cost monitoring
  - Service breakdown charts
  - Monthly trend analysis
  - Resource group cost allocation
  - Budget vs actual spending
- **Data Sources**: Azure Cost Management API, Azure Resource Graph
- **Refresh Schedule**: Daily automated refresh
- **Target Audience**: IT managers, Finance teams, Operations

### 👥 **Executive-Summary.pbix** (Executive Level)
- **Overview**: High-level KPIs and executive metrics
- **Features**:
  - Total spend overview
  - Month-over-month variance
  - Budget utilization percentage
  - Cost optimization opportunities
  - ROI and efficiency metrics
- **Data Sources**: Aggregated cost data, Budget APIs
- **Refresh Schedule**: Weekly refresh
- **Target Audience**: Executives, Finance leadership

### 🏢 **Department-Breakdown.pbix** (Departmental View)
- **Overview**: Cost allocation by department and project
- **Features**:
  - Tag-based cost categorization
  - Departmental budget tracking
  - Chargeback/showback reporting
  - Project-level cost analysis
  - Resource ownership tracking
- **Data Sources**: Tagged resources, Cost allocation data
- **Refresh Schedule**: Daily refresh
- **Target Audience**: Department managers, Project managers

## 🚀 **Quick Start**

### Prerequisites
- Power BI Desktop (latest version)
- Power BI Pro license (for sharing)
- Azure Cost Management Reader permissions
- Service principal for automated refresh (optional)

### Setup Instructions

1. **Download Power BI Desktop**
   ```
   https://powerbi.microsoft.com/desktop/
   ```

2. **Open Dashboard Template**
   - Double-click any .pbix file
   - Power BI Desktop will open the template

3. **Configure Data Source**
   - Go to Home → Transform Data → Data Source Settings
   - Update Azure subscription and tenant information
   - Configure authentication (Service Principal recommended)

4. **Refresh Data**
   - Click Home → Refresh to load your cost data
   - Verify data appears correctly in all visuals

5. **Publish to Power BI Service** (Optional)
   - Click Home → Publish
   - Select workspace destination
   - Configure scheduled refresh in Power BI Service

## 📋 **Dashboard Components**

### Common Visuals Across All Dashboards
- **Cost Trend Line Chart**: Monthly spending patterns
- **Service Pie Chart**: Cost distribution by Azure service
- **Resource Group Bar Chart**: Top spending resource groups
- **Geographic Map**: Cost distribution by Azure region
- **KPI Cards**: Total cost, budget utilization, variance
- **Data Table**: Detailed cost breakdown with drill-down

### Advanced Features
- **Drill-through Pages**: Click any visual to see detailed breakdown
- **Interactive Filters**: Date range, subscription, resource group
- **Conditional Formatting**: Red/yellow/green cost indicators
- **Bookmarks**: Saved views for different scenarios
- **Mobile Layout**: Optimized for mobile viewing

## 🔧 **Customization Guide**

### Adding New Visuals
1. **Data Tab**: Ensure required fields are available
2. **Visualizations**: Drag and drop fields to create new charts
3. **Format**: Apply consistent color scheme and fonts
4. **Interactions**: Configure how visuals filter each other

### Custom Calculations
```dax
// Total Cost This Month
Total Cost = SUM(CostData[PreTaxCost])

// Month Over Month Growth
MoM Growth = 
VAR CurrentMonth = [Total Cost]
VAR PreviousMonth = CALCULATE([Total Cost], PREVIOUSMONTH(CostData[Date]))
RETURN DIVIDE(CurrentMonth - PreviousMonth, PreviousMonth)

// Budget Utilization
Budget Utilization = DIVIDE([Total Cost], [Budget Amount])
```

### Color Scheme (Corporate Standards)
- **Primary Blue**: #0078D4 (Azure Blue)
- **Secondary Blue**: #106EBE
- **Success Green**: #107C10
- **Warning Orange**: #FF8C00
- **Danger Red**: #D13438
- **Neutral Gray**: #605E5C

## 🔄 **Data Refresh Setup**

### Service Principal Configuration
```powershell
# Create service principal for Power BI refresh
$sp = New-AzADServicePrincipal -DisplayName "PowerBI-CostDashboard"

# Assign required permissions
New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName "Cost Management Reader" -Scope "/subscriptions/your-subscription-id"
```

### Power BI Service Refresh
1. **Publish Dashboard** to Power BI Service
2. **Navigate to Dataset** settings
3. **Configure Data Source Credentials** with service principal
4. **Setup Scheduled Refresh** (daily at 6 AM recommended)
5. **Enable Refresh Failure Notifications**

## 📊 **Sample Data**

If you don't have Azure cost data yet, use these sample datasets for testing:

### Sample Cost Data Structure
```csv
Date,ResourceGroup,ServiceName,Location,Cost,Currency
2025-05-01,Production-RG,Virtual Machines,East US,1200.50,USD
2025-05-01,Development-RG,Storage Accounts,West US,450.25,USD
2025-05-01,Testing-RG,App Services,Central US,320.75,USD
```

### Sample Budget Data
```csv
Department,Budget,Actual,Variance
IT Operations,10000,8500,-1500
Development,5000,5200,200
Marketing,3000,2800,-200
```

## 🎯 **Use Cases**

### **Monthly Business Reviews**
- Load Executive Summary dashboard
- Review total spend vs budget
- Identify top cost drivers
- Discuss optimization opportunities

### **Department Charge-backs**
- Use Department Breakdown dashboard
- Filter by specific department tags
- Export detailed cost allocation reports
- Share with department managers

### **Cost Optimization**
- Analyze service-level spending trends
- Identify unused or underutilized resources
- Compare costs across environments
- Track optimization initiative results

## 🔍 **Troubleshooting**

### Common Issues

#### **Data Not Loading**
- Check Azure permissions (Cost Management Reader required)
- Verify subscription ID in data source settings
- Ensure service principal has correct permissions
- Check date range filters (some data may have delays)

#### **Refresh Failures**
- Review Power BI Service refresh history
- Check service principal credentials haven't expired
- Verify Azure subscription is active
- Look for API rate limiting issues

#### **Performance Issues**
- Limit date range to reduce data volume
- Use aggregated tables instead of detailed records
- Enable query folding where possible
- Consider incremental refresh for large datasets

### Getting Help
- **Power BI Community**: https://community.powerbi.com/
- **Azure Cost Management Docs**: https://docs.microsoft.com/azure/cost-management/
- **Project Issues**: https://github.com/wesellis/Azure-Cost-Management-Dashboard/issues

## 📞 **Support**

For dashboard-specific issues or customization requests:
- **Email**: wes@wesellis.com
- **GitHub**: Create an issue with the "powerbi" label
- **Documentation**: See full project documentation in `/docs` folder

---

**Note**: Actual .pbix files will be added in future releases. These templates provide the foundation for comprehensive Azure cost management dashboards.
