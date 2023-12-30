Attribute VB_Name = "readini"
Option Explicit
Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal lSize As Long, ByVal lpFileName As String) As Long
Public Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As Any, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lplFilename As String) As Long

Public Const gintMAX_SIZE% = 255
Public Const gintMAX_PATH_LEN% = 260

'-----------------------------------------------------------
' FUNCTION: ReadIniFile
'
' Reads a value from the specified section/key of the
' specified .INI file
'
' IN: [strIniFile] - name of .INI file to read
' [strSection] - section where key is found
' [strKey] - name of key to get the value of
'
' Returns: non-zero terminated value of .INI file key
'-----------------------------------------------------------
'
Public Function ReadIniFile(ByVal strIniFile As String, ByVal strSection As String, ByVal strKey As String) As String
Dim strBuffer As String

'
'If successful read of .INI file, strip any trailing zero returned by the Windows API GetPrivateProfileString
'
strBuffer = Space$(gintMAX_SIZE)

If GetPrivateProfileString(strSection, strKey, vbNullString, strBuffer, gintMAX_SIZE, strIniFile) Then
ReadIniFile = StringFromBuffer(strBuffer)
End If
End Function


Public Function StringFromBuffer(Buffer As String) As String
Dim nPos As Long

nPos = InStr(Buffer, vbNullChar)
If nPos > 0 Then
StringFromBuffer = Left$(Buffer, nPos - 1)
Else
StringFromBuffer = Buffer
End If
End Function

'citanje fajla
'Dim str As Variant
'str = ReadIniFile("d:\config.ini", "NAME", "3")
Public Function WriteIniFile(ByVal strIniFile As String, ByVal strSection As String, ByVal strKey As String, ByVal Value As String)
WritePrivateProfileString strSection, strKey, Value, strIniFile

End Function


