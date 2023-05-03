
BeforeDiscovery {
    $script:Services = @(
        @{ServiceName = 'w32Time'; Status = 'Running'; StartType = 'Automatic'; OrNotInstalled = $False }
        @{ServiceName = 'FTPSVC'; Status = 'Stopped'; StartType = 'Disabled'; OrNotInstalled = $True }
    )
}

Describe "Verify Windows Service Status" {

    It "Service '<ServiceName>' Should be '<Status>' and StartType '<StartType>'" -ForEach $services {
        $thisService = Get-Service -Name $_.ServiceName -ErrorAction SilentlyContinue
        If(-Not($thisService)) {
            If($OrNotInstalled) {
                Return $True
            }
        }
        $thisService.Status | Should -Be $_.Status
        $thisService.StartType | Should -Be $_.StartType
    }

}


