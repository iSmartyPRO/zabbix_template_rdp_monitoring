# RDP ServerMonitoring

> Improved by Ilias Aidar 24/09/2019

> Originally created by Diego Cavalcante - 10/02/2017




If you have a Windows RDP “Terminal Server” server, monitoring consists of collecting connection statistics from users.

**ITEMS**
* Total Active Users
* Total inactive users
* Name of active users
* Name of inactive users
* Remote IP Address of Active Users
* Remote device hostname of active users
* Terminal Service
* Terminal Service License
* RDP port status


**TRIGGERS**
* Number of Connected Users
* Number of Logged Out Users
* RDP Port Status
* Remote Desktop Licensing Service Status
* Remote Desktop Services Service Status


## 1. HOST PREPARATION
Monitoring itself requires some adjustments to be made to the host prior to data collection. As an example in my environment there are some default directories that I use for Scripts and UserParameters.
```
Scripts: C:\app\zabbix\scripts
UserParameters: C:\app\zabbix\conf\rdp
```
**NOTE:** Adjust according to your environment, within Host zabbix_agentd.conf, adjust the parameter: Include = and point to
directory where it will contain your .conf files with the UserParameters.

## 2. INITIAL REQUIREMENTS

* Open Powershell as Administrator and run the command and confirm:
``` 
Set-ExecutionPolicy Unrestricted
```
* If you have already done the above procedure on the Host, disregard and skip to the next request.
* Put rdp.terminal.server.ps1 in the directory of your choice.
* Put rdp.terminal.server.conf in the directory of your choice.
* Install the rdp.terminal.server.msi Module
* After installation, copy the folder C:\Users\YourUser\Documents\WindowsPowerShell\modules\PSTerminalServices\
* Paste the PSTerminalServices folder into C:\Windows\System32\WindowsPowerShell\v1.0\Modules\
* Restart Zabbix Agent on the Host.

## 3. TESTS
Open powershell and navigate to the script folder and test with the commands available below:
* .\rdp.terminal.server.ps1 AСTIVE
* .\rdp.terminal.server.ps1 ACTIVENUM
* .\rdp.terminal.server.ps1 IP
* .\rdp.terminal.server.ps1 DEVICE
* .\rdp.terminal.server.ps1 INACTIVE
* .\rdp.terminal.server.ps1 INACTIVENUM

**NOTE:** If any errors appear while executing the commands, review all previous steps.

## 4. HOST MACROS
The template uses separate macros, and must be registered in the monitored Host.
{$RDPPORT} = Port that the RDP server is listening on, default 3389.
{$RDPA} = Used for triggering, eg 5 if you want an alarm if there are more than 5 active users connected.
{$RDPI} = Used for triggering, eg 5 if you want an alarm if there are more than 5 idle users connected.

## 5. TEMPLATE
Import the Template - *Template__Windows_RDP_Terminal_Server.xml* into your Zabbix Frontend.
* Register the above Macros on the Host.
* Associate the Template with the monitored Host and wait for the collection.
* Adjust the collection intervals, History retention period and Trend of items according to your environment.

**NOTE:** If data is not collected, use and abuse zabbix_get to validate data collection.