<#
Legal Disclaimer
This script is an example script and is not supported under any Zerto support program or service. The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.

In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.
#>

[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $roleName = "Zerto - Least Privilege Service Account Role"  # default rolename to use, use the argument to pass the name you'd like or modify this default
)

# No modifications needed below this line, just make sure you read an understand what the script does

# Privileges are specified in a text file, one per line, in the format understood by PowerCLI and vSphere
# Will read them into a variable, so make sure this file is present in the same folder as this script

$Privileges = Get-Content .\zerto-role-least-privileges-vCenter7.txt

# One requirement is that you already have PowerCLI connected to a vCenter (i.e., using Connect-VIServer) which will mean the PowerCLI module is loaded
# Verify PowerCLI Connectivity, otherwise throw an error and exit

if ($global:DefaultVIServers.Count -eq 0)
{
    Write-Error "NOT CONNECTED: Please connect to a vCenter via PowerCLI first"
    exit 1
}

# Turn the list of privileges into the appropriate object, then create role

$VMwarePrivileges = Get-VIPrivilege -Id $Privileges
    
if (New-VIRole -name $RoleName -Privilege $VMwarePrivileges)
{
    Write-Host "SUCCESS: Role created -"  $roleName
    Write-Host
    Write-Host "NOTE: After this, you can go into vCenter GUI and assign the service account the ZVM will use to this role and place it at the top level of vCenter."  
    Write-Host "      Or if you wish to do via PowerCLI, here's an example command to use:"
    Write-Host
    Write-Host "      e.g., New-VIPermission -Role `"Zerto - Least Privilege Service Account Role`" -Principal `"vsphere.local\svc-zerto`" -Entity (Get-Folder Datacenters) -Propagate 1"
    Write-Host
    Write-Host "      In this example, an existing account (svc-zerto@vsphere.local) is assigned the newly created role at the vCenter top-level, with propogation to all children."
    Write-Host "      Please consider the appropriate action for your environment based on your own internal security and management guidelines."
}
else {
    Write-Host "ERROR: Could not create role -" $roleName
    Write-Host "       Check your permissions to create a role and if the name already exists."
}
