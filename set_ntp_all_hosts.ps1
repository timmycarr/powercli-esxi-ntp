## PowerCLI script to configure NTP services on all ESXi hosts attched to vCenter
## Requires a connection to a vCenter with Connect-VIServer prior to execution
## Adds NTPserver1-4 to configuration
## Adds a Host firewall exception
## Sets the service to start automatically
## Restarts NTP



$Hosts = Get-VMHost
$NTPserver1 = "0.vmware.pool.ntp.org"
$NTPserver2 = "1.vmware.pool.ntp.org"
$NTPserver3 = "2.vmware.pool.ntp.org"
$NTPserver4 = "3.vmware.pool.ntp.org"
ForEach ($HostA in $Hosts)
{
Add-VmHostNtpServer -NtpServer $NTPserver1, $NTPserver2, $NTPserver3, $NTPserver4 -VMHost $HostA | Out-Null
Get-VMHostFirewallException -VMHost $HostA | where {$_.Name -eq "NTP client"} |Set-VMHostFirewallException -Enabled:$true | Out-Null
Get-VmHostService -VMHost $HostA | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic" | Out-Null
Get-VmHostService -VMHost $HostA | Where-Object {$_.key -eq "ntpd"} | Restart-VMHostService -Confirm:$false | Out-Null
write-output "NTP Services configured on $HostA"
}