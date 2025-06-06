# Excel Dashboard Templates

Professional Excel templates for Azure cost analysis and reporting when Power BI is not available.

## Available Templates

### 📈 **Cost-Analysis-Template.xlsx**
- **Purpose**: Comprehensive cost analysis and visualization
- **Features**: 
  - Automated data import from CSV exports
  - Interactive pivot tables and charts
  - Month-over-month comparison
  - Service category breakdown
  - Resource group analysis
- **Macros**: VBA automation for data refresh
- **Target Users**: Finance analysts, Cost center managers

### 💰 **Budget-Tracking-Template.xlsx**
- **Purpose**: Budget monitoring and variance analysis
- **Features**:
  - Budget vs actual comparison
  - Variance analysis with conditional formatting
  - Department-level budget allocation
  - Quarterly and annual projections
  - Alert systems for budget overruns
- **Data Sources**: Manual input or CSV import
- **Target Users**: Finance teams, Department managers

### 📊 **Executive-Summary-Template.xlsx**
- **Purpose**: High-level executive reporting
- **Features**:
  - KPI dashboard with charts
  - One-page executive summary
  - Trend analysis and forecasting
  - Cost optimization recommendations
  - Print-friendly formatting
- **Update Frequency**: Monthly
- **Target Users**: Executives, Finance leadership

## 🚀 **Quick Start Guide**

### 1. Download and Setup
```
1. Download the Excel template you need
2. Enable macros when prompted (required for auto-refresh)
3. Save to your desired location
4. Review the Instructions worksheet
```

### 2. Data Import
```
Option A: CSV Import (Recommended)
- Export cost data using Get-AzureCostData.ps1
- Use Data → Get Data → From Text/CSV
- Select your exported cost data file
- Follow the import wizard

Option B: Manual Entry
- Use the Data Entry worksheet
- Follow the column format exactly
- Validate data using built-in checks
```

### 3. Refresh and Analyze
```
1. Click "Refresh All Data" button
2. Review the Dashboard worksheet
3. Use filters to drill down into specific areas
4. Export or print reports as needed
```

## 📋 **Template Details**

### Cost Analysis Template Structure
```
📁 Cost-Analysis-Template.xlsx
├── 📄 Dashboard (Main view with charts and KPIs)
├── 📄 Raw Data (Imported cost data)
├── 📄 Pivot Analysis (Interactive pivot tables)
├── 📄 Trends (Historical trend analysis)
├── 📄 Service Breakdown (By Azure service)
├── 📄 Resource Groups (By resource group)
├── 📄 Instructions (How to use guide)
└── 📄 Settings (Configuration and parameters)
```

### Budget Tracking Template Structure
```
📁 Budget-Tracking-Template.xlsx
├── 📄 Budget Dashboard (Main budget overview)
├── 📄 Department Budgets (By department/cost center)
├── 📄 Monthly Tracking (Month-by-month analysis)
├── 📄 Variance Analysis (Budget vs actual)
├── 📄 Forecasting (Projection calculations)
├── 📄 Data Entry (Manual budget input)
└── 📄 Instructions (Setup and usage guide)
```

## 🔧 **Features & Formulas**

### Key Excel Formulas Used

#### **Cost Calculations**
```excel
// Total Monthly Cost
=SUMIFS(RawData[Cost], RawData[Date], ">="&DATE(YEAR(TODAY()),MONTH(TODAY()),1))

// Month-over-Month Growth
=((CurrentMonth-PreviousMonth)/PreviousMonth)*100

// Service Cost Percentage
=RawData[Cost]/SUM(RawData[Cost])

// Budget Variance
=Actual-Budget

// Variance Percentage
=(Actual-Budget)/Budget*100
```

#### **Conditional Formatting Rules**
```excel
// Budget Status (Green/Yellow/Red)
Green: <=80% of budget
Yellow: 80-95% of budget  
Red: >95% of budget

// Cost Trend (Up/Down arrows)
Up Arrow: >5% increase
Down Arrow: >5% decrease
Flat: -5% to +5% change
```

#### **Data Validation**
```excel
// Date Range Validation
>=TODAY()-365 AND <=TODAY()

// Cost Amount Validation
>=0 AND <=1000000

// Service Name Validation
List: "Virtual Machines","Storage","Networking","Databases"
```

### VBA Macros (Optional)

#### **Auto-Refresh Macro**
```vb
Sub RefreshCostData()
    ' Refresh all external data connections
    ActiveWorkbook.RefreshAll
    
    ' Update last refresh timestamp
    Range("LastRefresh").Value = Now()
    
    ' Recalculate all formulas
    Application.CalculateFullRebuild
    
    MsgBox "Cost data refreshed successfully!"
End Sub
```

#### **Export Report Macro**
```vb
Sub ExportToPDF()
    Dim ws As Worksheet
    Set ws = Worksheets("Dashboard")
    
    ' Export dashboard to PDF
    ws.ExportAsFixedFormat _
        Type:=xlTypePDF, _
        Filename:="Azure-Cost-Report-" & Format(Date, "yyyy-mm-dd") & ".pdf"
    
    MsgBox "Report exported to PDF successfully!"
End Sub
```

## 📊 **Sample Data & Templates**

### Sample Cost Data Format
```csv
Date,SubscriptionName,ResourceGroup,ServiceName,ResourceName,Location,Cost,Currency,Tags
2025-05-01,Production,Production-RG,Virtual Machines,WebServer-01,East US,245.50,USD,Environment:Prod|Department:IT
2025-05-01,Production,Production-RG,Storage Accounts,proddata001,East US,89.25,USD,Environment:Prod|Department:IT
2025-05-01,Development,Dev-RG,Virtual Machines,DevServer-01,West US,125.75,USD,Environment:Dev|Department:IT
```

### Sample Budget Data Format
```csv
Department,Service,MonthlyBudget,Q1Budget,AnnualBudget,CostCenter
IT Operations,Virtual Machines,5000,15000,60000,CC001
IT Operations,Storage,2000,6000,24000,CC001
Development,Virtual Machines,3000,9000,36000,CC002
Development,Storage,1000,3000,12000,CC002
```

## 🎯 **Use Case Scenarios**

### **Monthly Finance Close**
1. **Export** cost data for the month using PowerShell script
2. **Import** data into Cost Analysis template  
3. **Review** dashboard for anomalies or unexpected costs
4. **Generate** executive summary report
5. **Distribute** to finance team and stakeholders

### **Department Chargeback**
1. **Filter** cost data by department tags
2. **Export** department-specific cost breakdown
3. **Create** chargeback reports using Budget template
4. **Send** to department managers for review
5. **Track** budget utilization throughout the month

### **Cost Optimization Review**
1. **Analyze** service-level spending trends
2. **Identify** top cost drivers and inefficiencies  
3. **Compare** costs across environments (Prod vs Dev)
4. **Document** optimization opportunities
5. **Track** savings from implemented changes

## 🔄 **Data Refresh Options**

### **Option 1: PowerShell Integration**
```powershell
# Export cost data and open Excel automatically
.\Get-AzureCostData.ps1 -Days 30 -ExportPath "cost-data.csv" -OutputFormat "Excel"
Start-Process "Cost-Analysis-Template.xlsx"
```

### **Option 2: Power Query Refresh**
1. **Data** tab → **Refresh All**
2. **Queries** will automatically pull from configured CSV files
3. **Charts and tables** update automatically
4. **Save** the workbook with refreshed data

### **Option 3: Manual Data Entry**
1. **Navigate** to Data Entry worksheet
2. **Follow** the column format guidelines
3. **Use** data validation to ensure accuracy
4. **Click** Refresh button to update dashboards

## 🎨 **Customization Guide**

### **Adding New Charts**
1. **Select** data range for new chart
2. **Insert** → **Chart** → Choose appropriate type
3. **Format** chart to match template style
4. **Add** to dashboard worksheet as needed

### **Custom Calculations**
```excel
// Custom KPI Formula Example
=IF(CurrentMonthCost>BudgetAmount, "Over Budget", 
   IF(CurrentMonthCost>BudgetAmount*0.8, "Warning", "On Track"))

// Department Ranking
=RANK(DepartmentCost, DepartmentCostRange, 0)

// Cost per Resource
=TotalCost/ResourceCount
```

### **Branding and Colors**
- **Primary Color**: RGB(0, 120, 212) - Azure Blue
- **Secondary Color**: RGB(16, 110, 190) - Dark Blue  
- **Success Color**: RGB(16, 124, 16) - Green
- **Warning Color**: RGB(255, 140, 0) - Orange
- **Error Color**: RGB(209, 52, 56) - Red

## 🔍 **Troubleshooting**

### **Common Issues**

#### **Macros Not Working**
- **Enable macros** in Excel security settings
- **Check** if VBA references are broken
- **Verify** file is saved as .xlsm (macro-enabled)

#### **Data Import Errors**
- **Check CSV format** matches expected structure
- **Verify date formats** are consistent
- **Ensure no special characters** in cost amounts
- **Check file permissions** and location

#### **Formula Errors**
- **Verify data ranges** in named ranges
- **Check for missing data** in key columns
- **Ensure proper data types** (dates, numbers, text)
- **Update references** if worksheet names changed

#### **Performance Issues**
- **Limit data range** to current year only
- **Remove unnecessary formatting** from large ranges
- **Use manual calculation** mode for large datasets
- **Close other applications** to free up memory

## 📞 **Support & Resources**

### **Getting Help**
- **Documentation**: See `/docs` folder for detailed guides
- **Issues**: Report problems on GitHub with "excel" label
- **Email**: wes@wesellis.com for template customization
- **Community**: Excel community forums for general Excel help

### **Additional Resources**
- **Microsoft Excel Help**: https://support.microsoft.com/excel
- **Power Query Documentation**: https://docs.microsoft.com/power-query/
- **VBA Reference**: https://docs.microsoft.com/office/vba/excel

---

**Note**: Excel templates provide full functionality for cost analysis when Power BI is not available. Templates include comprehensive documentation and examples for easy adoption.
