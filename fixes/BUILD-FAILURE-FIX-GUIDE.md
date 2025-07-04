# Build Failure Fix Guide

This document outlines the two build failures in your Azure Enterprise Toolkit project and their solutions.

## Issue 1: PowerShell CI Failure ❌

**Problem:** PSScriptAnalyzer found parse errors in `Azure-Resource-Tagger-Pro.ps1`

**Root Cause:** Using the `++` operator on variables accessed through `$using:` scope in parallel execution blocks is invalid PowerShell syntax.

**Location:** Lines 93 and 96 in the parallel execution block:
```powershell
$using:successCount++    # ❌ Invalid syntax
$using:errorCount++      # ❌ Invalid syntax
```

**Solution:** ✅ **FIXED**
The script has been updated to collect results from parallel execution and count them afterward:
```powershell
# Before (invalid)
$using:successCount++

# After (fixed)
$results = $operations | ForEach-Object -Parallel {
    # Return success/failure objects
    return @{ Success = $true; ResourceName = $_.Resource.Name }
} -ThrottleLimit 10

# Count results
$successCount = ($results | Where-Object { $_.Success }).Count
$errorCount = ($results | Where-Object { -not $_.Success }).Count
```

## Issue 2: Jekyll Build Failure (Git Submodule) ❌

**Problem:** Jekyll build fails with "No url found for submodule path 'bookmarks' in .gitmodules"

**Root Cause:** The `bookmarks` directory was previously configured as a git submodule, but the `.gitmodules` file is missing or the submodule wasn't properly configured.

**Solution:** 🔧 **READY TO FIX**
Run the provided script to convert the submodule to a regular directory:

```powershell
# Execute the fix script
.\fixes\fix-bookmarks-submodule.ps1
```

**Manual Steps (if script fails):**
```bash
# 1. Remove submodule reference from git index
git rm --cached bookmarks

# 2. Add bookmarks as regular directory
git add bookmarks/

# 3. Commit the changes
git commit -m "Convert bookmarks from submodule to regular directory"

# 4. Push changes
git push origin main
```

## Additional PowerShell Issues Found

The PSScriptAnalyzer also found numerous other warnings that should be addressed for code quality:

### Critical Issues:
- **PSUseShouldProcessForStateChangingFunctions:** Many functions that change system state don't support `-WhatIf`
- **PSUseSingularNouns:** Several cmdlets use plural nouns instead of singular
- **PSUseDeclaredVarsMoreThanAssignments:** Variables assigned but never used
- **PSAvoidUsingPositionalParameters:** Using positional parameters instead of named parameters

### Recommendations:
1. **Add ShouldProcess support** to functions that change system state
2. **Rename cmdlets** to use singular nouns (e.g., `New-ModernDataPipeline` instead of `New-ModernDataPipelines`)
3. **Remove unused variables** or use them appropriately
4. **Use named parameters** instead of positional parameters for better readability

## Next Steps

1. ✅ **PowerShell syntax error** - Fixed automatically
2. 🔧 **Run the bookmarks fix script** - Execute `.\fixes\fix-bookmarks-submodule.ps1`
3. 🔄 **Test the builds** - Push changes and verify both CI pipelines pass
4. 📋 **Address remaining warnings** - Consider fixing the PSScriptAnalyzer warnings for better code quality

## Files Modified

- `automation-scripts/General-Utilities/Azure-Resource-Tagger-Pro.ps1` - Fixed parallel execution syntax
- `fixes/fix-bookmarks-submodule.ps1` - Script to fix git submodule issue

After applying these fixes, both build pipelines should pass successfully!
