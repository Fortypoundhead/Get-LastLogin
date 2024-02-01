param
{
    [Parameter(Mandatory=$True,Position=1)][string]$UserName
}

Import-Module ActiveDirectory

<#
    It's necessary to contact all domain controllers to get the true 
    last logon time of the specified user. First though, we must have
    a list of the domain controllers.
#>

$dcs = Get-ADDomainController -Filter {Name -like "*"}

#   set the time var for a number

$time = 0

foreach($dc in $dcs)
{

<#
    iterate through the list of domain controllers, looking for the
    specified username. One we have the data, it is compared to the
    previous value for $time, and only the newer value is kept.
#>

    $hostname = $dc.HostName
    $user = Get-ADUser $userName | Get-ADObject -Properties lastLogon
    if($user.LastLogon -gt $time)
    {
        $time = $user.LastLogon
    }
}

#   convert the value to a human readable format, and display it on screen.

$dt = [DateTime]::FromFileTime($time)
Write-Host $username "last logged on at:" $dt 
