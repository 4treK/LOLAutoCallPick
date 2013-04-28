global ChampionSelected
global RoleSelected

#SingleInstance force
Init()

F11::Reload
F12::ExitApp

Init()
{
	gui, new, , LOL AutoPick
	gui, add, groupbox, section, Choose Hero:
	gui, add, DropDownList
		, xp+10 yp+20 vChampionSelected
		,Ahri|Akali|Alistar|Amumu|Anivia|Annie|Ashe|Blitzcrank|Brand|Caitlyn|Cassiopeia|Cho'Gath|Corki|Darius|Diana|Dr. Mundo|Draven
		|Elise|Evelynn|Ezreal|Fiddlesticks|Fiora|Fizz|Galio|Gangplank|Garen|Gragas|Graves|Hecarim|Heimerdinger|Irelia|Janna|Jarvan IV|Jax|Jayce
		|Karma|Karthus|Kassadin|Katarina|Kayle|Kennen|Kha'Zix|Kog'Maw|LeBlanc|Lee|Leona|Lulu|Lux Mage|Malphite|Malzahar|Maokai|Master Yi|Miss Fortune|Mordekaiser|Morgana
		|Nami|Nasus|Nautilus|Nidalee|Nocturne|Nunu|Olaf|Orianna|Pantheon|Poppy|Quinn and Valor|Rammus|Renekton|Rengar|Riven|Rumble|Ryze
		|Sejuani|Shaco|Shen|Shyvana|Singed|Sion|Sivir|Skarner|Sona|Soraka|Swain|Syndra|Talon|Taric|Teemo|Thresh|Tristana|Trundle|Tryndamere|Twisted Fate|Twitch
		|Udyr|Urgot|Varus|Vayne|Veigar|Vi|Viktor|Vladimir|Volibear|Warwick|Wukong|Xerath|Xin Zhao|Yorick|Zac|Zed|Ziggs|Zilean|Zyra

	gui, add, groupbox, xs r6 section, Choose Role:
	gui, add, Radio
		, xp+10 yp+20 section vRoleSelected
		,Top
	gui, add, Radio
		,xs
		,Mid
	gui, add, Radio
		,xs
		,Bot
	gui, add, Radio
		,xs
		,Jungle
	gui, add, Radio
		,xs
		,Support
	gui, add, Radio
		,xs
		,ADC

	gui, add, groupbox, xm r1 section
	Gui, Add, Button, xp+10 yp+10 w120 Default gUserReadyLabel, Done

	gui, show, AutoSize Center
	return

	UserReadyLabel:
		UserReady()
		return
}

UserReady()
{
	gui,submit,nohide
	gui, destroy
	;msgbox Hero: %ChampionSelected%`nRole: %RoleSelected%

	static role

	if RoleSelected = 1
	{
		role = top
	}
	if RoleSelected = 2
	{
		role = mid
	}
	if RoleSelected = 3
	{
		role = bot
	}
	if RoleSelected = 4
	{
		role = jungle
	}
	if RoleSelected = 5
	{
		role = support
	}
	if RoleSelected = 6
	{
		role = adc
	}

	Loop
	{
		WinWaitActive ahk_class ApolloRuntimeContentWindow
		{
			PixelSearch, FoundaX, FoundaY, 852, 121, 1001, 150, 0xFFFFFF, 0, Fast ;Find Search Box
			if ErrorLevel = 0
			{
				;CALL ROLE
				Sleep, 100
				MouseClick, left, 300, 735
				Send, %role%{enter}
				Sleep, 100

				;PICK HERO
				MouseClick, left, 920, 130
				Send, %ChampionSelected%
				Sleep, 100
				MouseClick, Left, 325, 212
				Sleep, 100

				Pause
			}

			;PixelSearch, FoundbX, FoundbY, 296, 182, 349, 233, 0x303030, 0, Fast
			;if ErrorLevel = 0
			;{
			;	Pause
			;	;ExitApp
			;}
		}
	}
}