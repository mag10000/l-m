extends Control

func auto_login(token : String):
	%KeyLine.text = token
	%ContinueButton.pressed.emit()
