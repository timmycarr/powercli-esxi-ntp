# powercli-esxi-ntp
PowerCLI PoSH script to ensure that vmware ntp pool servers are set and service is enabled on ESXi hosts attached to your vCenter.

This requires vSphere PowerCLI available here: https://www.vmware.com/support/developer/PowerCLI/  

This script will iterate through each of your ESXi hosts and do the following:
- Set four default NTP servers 0-3.vmware.pool.ntp.org
- Configure ESXi firewall ports to support NTP
- Configure The ESXi service policy for NTP to automatically start on system boot
- Restart the NTP service to ensure that the new configuration is up and running


