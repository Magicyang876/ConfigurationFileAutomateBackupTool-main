# ConfigurationFileAutomateBackupTool
## Usage
Fill the CSV file and run the script.

## CSV Sample
|Host|Folder|FileName|Comment|UserName|Enabled|
|---|---|---|---|---|---|
|   |D:\A   |  *.xml\|People.csv |   |   | N  |
| sps2019  |C:\inetpub\wwwroot\wss\VirtualDirectories   |web.config   | sharepoint  |  contoso\op1 |  Y |
|  192.168.23.12 |  C:\inetpub\wwwroot\wss\VirtualDirectories | web.config  |sharepoint   |   | Y  |

## Explain
1. Host is the remote server name, if on localhost, then leave as blank
2. Folder is the path where the configuaration file located
3. FileName is the configuration file name, also you can use *.extension to match
4. Comment is just for note
5. UserName is the account when you need to connect to remote server to backup the files
6. Enabled is the flag to do backup or not

## Reference
If you want to enable backup function for remote server, you need to make sure you have enabled remote commands. Refer to https://learn.microsoft.com/en-us/powershell/scripting/learn/remoting/running-remote-commands?view=powershell-7.3#run-a-remote-command
