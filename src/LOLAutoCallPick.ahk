global ProgramStatus
global EnableChampionSelection
global ChampionSelected
global RoleSelectedMode
global RoleSelectedRadio
global RoleSelectedEdit
global CloseProgramAfterAutoCallPick

#SingleInstance force
Init()

F11::Reload
Escape::ExitApp

GuiClose:
ExitApp

Init()
{
	Menu, Tray, Icon, shell32.dll, 44

	Gui, Add, GroupBox, x10 y10 w210 h10, Select Hero
	Gui, Add, Checkbox, x10 y30 w210 h13 Checked vEnableChampionSelection, Enable champion selection (Ranked)
	gui, add, DropDownList
		, x10 y50 w210 h21 Choose1 Sort r20 vChampionSelected
		,Aatrox|Ahri|Akali|Alistar|Amumu|Anivia|Annie|Ashe|Blitzcrank|Brand|Caitlyn|Cassiopeia|Cho'Gath|Corki|Darius|Diana|Dr. Mundo|Draven
		|Elise|Evelynn|Ezreal|Fiddlesticks|Fiora|Fizz|Galio|Gangplank|Garen|Gragas|Graves|Hecarim|Heimerdinger|Irelia|Janna|Jarvan IV|Jax|Jayce
		|Karma|Karthus|Kassadin|Katarina|Kayle|Kennen|Kha'Zix|Kog'Maw|LeBlanc|Lee|Leona|Lulu|Lux Mage|Malphite|Malzahar|Maokai|Master Yi|Miss Fortune|Mordekaiser|Morgana
		|Nami|Nasus|Nautilus|Nidalee|Nocturne|Nunu|Olaf|Orianna|Pantheon|Poppy|Quinn|Rammus|Renekton|Rengar|Riven|Rumble|Ryze
		|Sejuani|Shaco|Shen|Shyvana|Singed|Sion|Sivir|Skarner|Sona|Soraka|Swain|Syndra|Talon|Taric|Teemo|Thresh|Tristana|Trundle|Tryndamere|Twisted Fate|Twitch
		|Udyr|Urgot|Varus|Vayne|Veigar|Vi|Viktor|Vladimir|Volibear|Warwick|Wukong|Xerath|Xin Zhao|Yorick|Zac|Zed|Ziggs|Zilean|Zyra

	Gui, Add, GroupBox, x10 y200 w210 h10,
	Gui, Add, Button, x10 y220 w210 h40 gUserReadyLabel, Start!
	Gui, Add, Button, x10 y270 w100 h30 gSaveProfileLabel, Save profile
	Gui, Add, Button, x120 y270 w100 h30 gSaveProfileLabel, Load profile

	Gui, Add, GroupBox, x12 y339 w210 h10, Status
	Gui, Add, Text, x12 y359 w210 r4 vProgramStatus, Waiting user to be ready :)
	Gui, Add, GroupBox, x12 y419 w210 h10 , About
	Gui, Add, Link, x12 y439 w210 r4 c008080, Created by k014 (LAS Server summoner)`n`nCheck last version in the website:`n<a href="http://bit.ly/lolautocallpick">http://bit.ly/lolautocallpick</a>

	Gui, Add, CheckBox, x12 y309 w210 h20 checked vCloseProgramAfterAutoCallPick, Close program after AutoCallPick

	Gui, Add, GroupBox, x10 y80 w210 h10 , Select Role
	Gui, Add, Tab, x10 y100 w210 h100 vRoleSelectedMode, Standard|Custom
	Gui, Add, Radio, x25 y130 w70 h20 Checked vRoleSelectedRadio, Top
	Gui, Add, Radio, x25 y150 w70 h20 , Mid
	Gui, Add, Radio, x25 y170 w70 h20 , Bot
	Gui, Add, Radio, x130 y130 w70 h20 , Jungle
	Gui, Add, Radio, x130 y150 w70 h20 , Support
	Gui, Add, Radio, x130 y170 w70 h20 , ADC
	Gui, Tab, Custom
	Gui, Add, Text, x20 y130 w190 h20 , Write your custom "call" message
	Gui, Add, Edit, x20 y150 w190 h40 vRoleSelectedEdit, I go mid, I type super fast!

	Gui, show, AutoSize Center, LOLAutoCallPick
	Return

	SaveProfileLabel:
		msgbox, 48, Soon..., This feature is not yet implemented`nJust give me some time :)`nCheck the website!
		return

	UserReadyLabel:
		gui, submit, nohide
		UserReady()
		return
}

UserReady()
{
	static role

	MatchFound = False

	if RoleSelectedMode = Standard
	{
		if RoleSelectedRadio = 1
		{
			role = top
		}
		if RoleSelectedRadio = 2
		{
			role = mid
		}
		if RoleSelectedRadio = 3
		{
			role = bot
		}
		if RoleSelectedRadio = 4
		{
			role = jungle
		}
		if RoleSelectedRadio = 5
		{
			role = support
		}
		if RoleSelectedRadio = 6
		{
			role = adc
		}
	}
	else
	{
		role = %RoleSelectedEdit%
	}

	MsgBox, 64, Status, Champion:      %ChampionSelected%`nRole:                 %role%, 2

	;UPDATE STATUS
	guicontrol, , ProgramStatus, Waiting for Champion Selection Screen`n`nChampion:   %ChampionSelected%`nRole:            %role%

	Loop
	{
		WinWaitActive ahk_class ApolloRuntimeContentWindow
		{
			PixelSearch, FoundaX, FoundaY, 852, 121, 1001, 150, 0xFFFFFF, 0, Fast ;Find Search Box
			if ErrorLevel = 0
			{
				guicontrol, , ProgramStatus, Auto calling and picking...

				;CALL ROLE
				Sleep, 500

				Click 300, 735 ;TEAM CHAT
				Send, %role%{enter}

				;CALL ROLE
				Sleep, 300
				Click 300, 735 ;TEAM CHAT
				Send, %role%{enter}

				if EnableChampionSelection = 1
				{
					;PICK HERO
					Sleep, 50
					Click 920, 130, 2 ;HERO FILTER
					Send, %ChampionSelected%
					Sleep, 200
					Click 325, 212

					;RESET HERO FILTER
					Sleep, 200
					Click 920, 130 ;HERO FILTER
				}

				;CALL ROLE ONE LAST TIME
				Sleep, 200
				Click 300, 735 ;TEAM CHAT
				Send, %role%{enter}

				;CALL ROLE ONE LAST TIME
				Sleep, 2200
				Click 300, 735 ;TEAM CHAT
				Send, %role%.{enter}

				guicontrol, , ProgramStatus, Auto call and pick done...`nClick Start button again to begin another round :)

				if CloseProgramAfterAutoCallPick = 1
				{
					ExitApp
				}

				return
			}
		}
	}
}

;DEPRECATED, BUT DONT WANT TO DELETE
;IT WILL BE USEFUL IN FUTURE, OR OTHER
;PROJECTS, GO OPENSOURCE!

checkMatchFound(){
	;PixelSearch, pixelX, pixelY, 129, 45, 133, 48, 0xE4CF6F, 0, Fast RGB
	PixelSearch, pixelX, pixelY, 129, 45, 133, 48, 0x72683A, 0, Fast RGB
	if ErrorLevel = 0
	{
		;DEBUG
		;MouseMove, pixelX, pixelY, 0
		;PixelGetColor, OutputVar, pixelX, pixelY, RGB
		;MsgBox encontrado color %OutputVar%

		;SET FLAG
		MatchFound = True

		;Click Accept Button
		Sleep, 100
		Click 544, 445
	}
}

; TOOLS USED
; AutoHotKey
; SmartGUI Creator 4.0