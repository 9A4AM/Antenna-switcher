VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00FFFF80&
   Caption         =   "Antenna switcher by 9A4AM@2021"
   ClientHeight    =   2820
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8175
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2820
   ScaleWidth      =   8175
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      BackColor       =   &H000080FF&
      Caption         =   "Change Antenna"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   238
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   2400
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   1200
      Width           =   3015
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   3960
      Top             =   1320
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   9
      DTREnable       =   -1  'True
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFF80&
      Caption         =   "Antenna switcher by 9A4AM@2021"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   238
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   360
      Left            =   1560
      TabIndex        =   3
      Top             =   2280
      Width           =   4905
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFF80&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   238
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   5040
      TabIndex        =   2
      Top             =   480
      Width           =   105
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFF80&
      Caption         =   "Current antenna:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   238
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   480
      Width           =   2535
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Port_Nr As Integer
Dim AntennaName1 As String
Dim AntennaName2 As String

Private Sub Command1_Click()
If Label2.Caption = AntennaName1 Then
MSComm1.Output = "1" & Chr$(13)
Label2.Caption = AntennaName2
Label2.BackColor = vbYellow
Else
MSComm1.Output = "0" & Chr$(13)
Label2.Caption = AntennaName1
Label2.BackColor = vbGreen
End If
End Sub

Private Sub Form_Load()
Port_Nr = ReadIniFile(App.Path & "\Config.ini", "Port", "Port")
AntennaName1 = ReadIniFile(App.Path & "\Config.ini", "AntennaName", "Antenna1")
AntennaName2 = ReadIniFile(App.Path & "\Config.ini", "AntennaName", "Antenna2")
Label2.Caption = AntennaName1
Label2.BackColor = vbGreen
MSComm1.CommPort = Port_Nr
MSComm1.PortOpen = True
MSComm1.Output = "0" & Chr$(13)
End Sub

Private Sub Form_Unload(Cancel As Integer)
MSComm1.Output = "0" & Chr$(13)
Label2.BackColor = vbGreen
If MSComm1.PortOpen = True Then
MSComm1.PortOpen = False
End If
End Sub
