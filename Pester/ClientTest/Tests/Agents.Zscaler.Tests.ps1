BeforeDiscovery {
    $script:zsaServices = @("ZSAService","ZSATrayManager","ZSATunnel")
}

BeforeAll {

    If(Get-ChildItem $env:ProgramFiles\Zscaler\ZSAService -ErrorAction SilentlyContinue) {
        $zsaPath = "$env:ProgramFiles\Zscaler\ZSAService"
        $script:regRoot = "HKLM:\Software"
    } Else {
        $zsaPath = "$env:ProgramFiles (x86)\Zscaler\ZSAService"
        $script:regRoot = "HKLM:\Software\Wow6432Node"
    }

    $script:zsaExe = Join-Path $zsaPath -ChildPath "ZSAService.exe"
    $script:regRoot = Join-Path $script:regRoot -ChildPath "Zscaler Inc."

}

Describe "Verify Zscaler Agent Installation" {

    It 'Zscaler Agent Must be >= 3.5' -Tag "Baseline","Agents","Zscaler" {
        [Version](Get-Item $zsaExe -ErrorAction SilentlyContinue).VersionInfo.FileVersion | Should -BeGreaterOrEqual ([Version]'3.5')
    }

    It 'Service <_> Must be Running' -ForEach $zsaServices -Tag "Baseline","Agents","Zscaler" {
        (Get-Service -Name $_).Status | Should -Be "Running"
    }

    It 'Service <_> Must Autostart' -ForEach $zsaService -Tag "Baseline","Agents","Zscaler" {
        (Get-Service -Name $_).StartType | Should -Be "Automatic"
    }

    It 'Zscaler Cloud Name Must be Zscloud' -Tag "Baseline","Agents","Zscaler" {
        $(Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Zscaler Inc.\Zscaler" -Name CloudName).CloudName | Should -Be "zscloud"
    }

}

