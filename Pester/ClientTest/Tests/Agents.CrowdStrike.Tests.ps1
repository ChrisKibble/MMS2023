
Describe "Verify CrowdStrike Agent Installation" {
    
    It 'CrowdStrike Windows Sensor >= 6.4 must be installed' -Tag "Baseline","Agents","CrowdStrike" {
        $csPath = Join-Path $env:ProgramFiles -ChildPath "CrowdStrike\CSFalconService.exe"
        [Version](Get-Item $csPath).VersionInfo.FileVersion | Should -BeGreaterOrEqual ([Version]'6.4')
    }

    It 'CrowdStrike Falcon Service Must be Running' -Tag "Baseline","Agents","CrowdStrike" {
        (Get-Service -Name CSFalconService).Status | Should -Be "Running"
    }

    It 'CrowdStrike Falcon Service Must Autostart' -Tag "Baseline","Agents","CrowdStrike" {
        (Get-Service -Name CSFalconService).StartType | Should -Be "Automatic"
    }

}