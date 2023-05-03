#Requires -RunAsAdministrator
#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.4.1" }

$PesterConfig = [PesterConfiguration]::Default

$PesterConfig.Run.Path = (Join-Path $PSScriptRoot -ChildPath Tests)
$PesterConfig.Run.PassThru = $True
$PesterConfig.Output.Verbosity = "Detailed"

$PesterResults = Invoke-Pester -Configuration $PesterConfig

$PesterResults.Tests | Select-Object ExpandedPath,Executed,Passed | Sort-Object ExpandedPath | Export-Csv .\ScanResults.csv -Force
