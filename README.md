# ConfigurationFileAutomateBackupTool
## Usage
Fill the CSV file and run the script.
## Explain
Host is the remote server name, if on localhost, then leave as blank
Folder is the path where the configuaration file located
FileName is the configuration file name, also you can use *.extension to match
Comment is just for note
UserName is the account when you need to connect to remote server to backup the files
Enabled is the flag to do backup or not

## Reference
If you want to enable backup function for remote server, you need to make sure you have enabled remote commands. Refer to https://learn.microsoft.com/en-us/powershell/scripting/learn/remoting/running-remote-commands?view=powershell-7.3#run-a-remote-command