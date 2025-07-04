# Azure Resource Size Analyzer
# Analyze and recommend right-sizing for Azure resources
# Author: Wesley Ellis | wes@wesellis.com
# Version: 1.0

param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName,
    
    [Parameter(Mandatory=$false)]
    [int]$AnalysisDays = 30,
    
    [Parameter(Mandatory=$false)]
    [switch]$IncludeRecommendations
)

Import-Module (Join-Path $PSScriptRoot "..\modules\AzureAutomationCommon\AzureAutomationCommon.psm1") -Force
Show-Banner -ScriptName "Azure Resource Size Analyzer" -Version "1.0" -Description "Analyze resource utilization and sizing"

try {
    if (-not (Test-AzureConnection)) { throw "Azure connection validation failed" }

    $vms = if ($ResourceGroupName) {
        Get-AzVM -ResourceGroupName $ResourceGroupName
    } else {
        Get-AzVM
    }

    $sizeAnalysis = @()
    
    foreach ($vm in $vms) {
        $vmSize = Get-AzVMSize -Location $vm.Location | Where-Object { $_.Name -eq $vm.HardwareProfile.VmSize }
        
        # Get basic metrics (simplified for demo)
        $analysis = [PSCustomObject]@{
            VMName = $vm.Name
            ResourceGroup = $vm.ResourceGroupName
            CurrentSize = $vm.HardwareProfile.VmSize
            Cores = $vmSize.NumberOfCores
            MemoryMB = $vmSize.MemoryInMB
            MaxDataDisks = $vmSize.MaxDataDiskCount
            PowerState = (Get-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Status).Statuses[1].DisplayStatus
            Recommendation = "Monitor" # Placeholder - would need actual metrics
        }
        
        $sizeAnalysis += $analysis
    }

    Write-Host "VM Size Analysis:" -ForegroundColor Cyan
    $sizeAnalysis | Format-Table VMName, CurrentSize, Cores, MemoryMB, PowerState, Recommendation

    $totalVMs = $sizeAnalysis.Count
    $runningVMs = ($sizeAnalysis | Where-Object { $_.PowerState -eq "VM running" }).Count
    
    Write-Host "Summary:" -ForegroundColor Green
    Write-Host "  Total VMs: $totalVMs" -ForegroundColor White
    Write-Host "  Running VMs: $runningVMs" -ForegroundColor White
    Write-Host "  Stopped VMs: $($totalVMs - $runningVMs)" -ForegroundColor Yellow

} catch {
    Write-Log "❌ Resource size analysis failed: $($_.Exception.Message)" -Level ERROR
    exit 1
}
