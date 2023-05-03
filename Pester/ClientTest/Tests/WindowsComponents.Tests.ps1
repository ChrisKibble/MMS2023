BeforeDiscovery {
    $script:FeatureStatus = @(
        @{FeatureName = 'MicrosoftWindowsPowerShellV2'; State = 'Disabled'; MissingOK = $True }
        @{FeatureName = 'MicrosoftWindowsPowerShellV2Root'; State = 'Disabled'; MissingOK = $True }        
        @{FeatureName = 'SMB1Protocol'; State = 'Disabled'; MissingOK = $True }        
        @{FeatureName = 'SMB1Protocol-Client'; State = 'Disabled'; MissingOK = $True }        
        @{FeatureName = 'SMB1Protocol-Server'; State = 'Disabled'; MissingOK = $True }        
    )
}

BeforeAll {
    $script:WindowsFeatures = Get-WindowsOptionalFeature -Online
}

Describe "Verify Windows Components Status" {

    It "Windows Feature '<FeatureName>' Should be '<State>'" -ForEach $FeatureStatus {
        $thisFeature = $_.FeatureName
        $requiredState = $_.State
        $feature = $WindowsFeatures | Where-Object { $_.FeatureName -eq $thisFeature }
        If($feature -or -not $_.MissingOK) {
            # Feature exists and is in this state, or feature doesn't exist and it's not OK to be missing.
            $feature.State | Should -Be $requiredState
        } Else {
            # Feature doesn't exist but it's OK.
            Return $true
        }
    }

}
