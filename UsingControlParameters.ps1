<#
.SYNOPSIS
    Test using one parameter to control use of other parameters

.DESCRIPTION
    This script provides examples for using the presence of one parameter to control which other parameters are used.
    If the parameter "SwitchTest" is used when calling the script, the Parameter Set named "SwitchPresent" is used.
    If the parameter "SwitchTest" is NOT used when calling the script, the Parameter Set named "SwitchNotPresent" is used.
    In this instance, the parameter "TestStringSetTwo" is required.
    The Parameter "TestStringAll" is usable by both Parameter Sets.

.PARAMETER SwitchTest
    Specify the action to take. Valid values are Export, Remove, AssignLicense, and Validate

.PARAMETER TestStringSetOne
    A string parameter used only in the SwitchPresent Parameter Set

.PARAMETER TestStringSetTwo
    A string parameter used only in the SwitchNotPresent Parameter Set

.PARAMETER TestStringAll
    A string parameter shared among all Parameter Sets

.NOTES
    Version:        1.0
    Author:         John O'Neill Sr.
    Creation Date:  20/06/2019
    Change Date:    
    Purpose/Change:

.EXAMPLE
    .\Test-Code.ps1 -SwitchTest -TestStringSetOne "SomeString..."

    This command line runs the script WITH the switch, also specifying the -TestStringSetOne parameter specified in the SwitchPresent Parameter Set.

.EXAMPLE
    .\Test-Code.ps1 -TestStringSetTwo "SomeOtherString..."
    
    This command line runs the script WITHOUT the switch, specifying only the parameter required by the SwitchNotPresent Parameter Set.

.EXAMPLE
    .\Test-Code.ps1 -TestStringSetTwo "SomeOtherString..." -TestStringAll "YetAnotherString..."

    This command line runs the script WITHOUT the switch, specifying the parameter TestStringSetTwo required by the SwitchNotPresent Parameter Set.
    The shared parameter TestStringAll is also specified.

#>

[cmdletbinding()]

Param (
    # Control parameter for Parameter Set named "SwitchPresent"
    [Parameter(mandatory=$True,ParameterSetName = "SwitchPresent")]
    [Switch]$SwitchTest,

    # Parameter belonging only to Parameter Set named "SwitchPresent"
    [Parameter(mandatory=$False,ParameterSetName = "SwitchPresent")]
    [String]$TestStringSetOne,

    # Control parameter for Parameter Set named "SwitchNotPresent"
    [Parameter(mandatory=$True,ParameterSetName = "SwitchNotPresent")]
    [String]$TestStringSetTwo,

    # Parameter belonging to all parameter sets
    [Parameter(Mandatory = $False)]
    [String]$TestStringAll
)

Function Test-Something{
        Write-Host "Control switch IS specified in command line"
        Write-Host $TestStringSetOne
        Write-Host "Shared string is $TestStringAll"
}

If ($SwitchTest -eq $True) {
    Test-Something
} ElseIf  ($TestStringSetTwo -ne "") {
    Write-Host "Control switch IS NOT specified in command line"
    Write-Host "Shared string is $TestStringAll"
}