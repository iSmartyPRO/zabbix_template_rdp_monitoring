# Improved by Ilias Aidar - 24/09/2019
# Originally created by Diego Cavalcante - 10/02/2017
# Monitoring Windows RDP - Terminal Server

Param(
  [string]$select
)

# Active Users: Domain Name, Username, Computer Name, IP Address
if ( $select -eq 'ACTIVE' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {$_.DomainName, $_.UserName, $_.ClientName, (($_.IPAddress).IPAddressToString), ""}
}

# Total Active Users
if ( $select -eq 'ACTIVENUM' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {$_.UserName} | Measure-Object -Line | select-object Lines | select-object -ExpandProperty Lines
}

# Inactive Users: Domain Name, Username
if ( $select -eq 'INACTIVE' )
{
Import-Module PSTerminalServices
Get-TSSession -State Disconnected -ComputerName localhost | where { $_.SessionID -ne 0 } | foreach {$_.DomainName, $_.UserName, ""}
}

# Toal Inactive Users
if ( $select -eq 'INACTIVENUM' )
{
Import-Module PSTerminalServices
Get-TSSession -State Disconnected -ComputerName localhost | where { $_.SessionID -ne 0 } | foreach {$_.UserName} | Measure-Object -Line | select-object Lines | select-object -ExpandProperty Lines
}

# List of Remote Computer Names
if ( $select -eq 'DEVICE' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {$_.ClientName}
}

# List of Remoter IP Addresses
if ( $select -eq 'IP' )
{
Import-Module PSTerminalServices
Get-TSSession -State Active -ComputerName localhost | foreach {(($_.IPAddress).IPAddressToString)}
}
