# Legal Disclaimer
This script is an example script and is not supported under any Zerto support program or service. The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.

In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.

# What This Script Does

In the article "vSphere: Privileges Required by Zerto Virtual Replication" (see References), Zerto documents the list of the minimum privileges needed for a ZVM to work with a vCenter. A common mistake is for users to assign a full administrator role to this service account which is not a best practice. Zerto recommends you create a separate role with least privleges for that account to use. The guide lists the privileges and explains why each is needed in greater detail. For information, please read the guide.

The goal of the script is to automate the creation of that role via script to minimize time and possibility for error. Note that this is an example script and that an effort will be made to update it as Zerto releases new versions. It is the responsbility of the user to understand how this script works and to validate it is applicable to the vSphere and Zerto versions being used at script runtime.

# References
- https://help.zerto.com/bundle/Prereq.VC.HTML/page/Content/Ent_Guide_VC/Prerequisites_Requirements_vSphere_Environments.htm
- https://help.zerto.com/bundle/Install.VC.HTML/page/Content/Install_ZVM-Hyper-V/vSphere_Privileges_Required_by_Zerto_Virtual_Replication.htm

# Requirements
- Supported versions of VMware vSphere (vCenter, ESXi)
- Supported version of Zerto
- PowerShell
- Supported version of VMware's PowerCLI Powershell Module
- Appropriate privileges to create a role in vCenter

# How to use this script

Make sure you are already connected to a vCenter (i.e., Connect-VIServer) and with a user with appropriate privileges to create/edit a VIRole in that vCenter. Then run this script, which will read in the appropriate vCenter privileges from the text file and create a new role using New-VIRole. You can then assign the ZVM service account this role at the top level of vCenter with "propogation to children" enabled.

# Noteworthy

This script was developed and tested using PowerShell 7.2.4, PowerCLI 11.2, vSphere 7.0, and Zerto 9.5. No warranties or guarantees are made for these or any other versions.