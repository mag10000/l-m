extends CanvasLayer

var date_dict = Time.get_date_dict_from_system()  

var current_month = date_dict["month"] 

var current_day = date_dict["day"]

var time = ("")

var time2 = 60

var countdown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.position.x = 458


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#check when new years over/starting
	if current_month == 12 && current_day == 31:
		self.visible = true


#get time
	if countdown == false:
		time = Time.get_time_string_from_system()
		$Label.text = time

#get countdown start time
	if time == ("23:59:00"):
		countdown = true

#countdown fuctions
	if time == ("23:59:57"):
		$AnimatedSprite2D.play("default")
		$AnimatedSprite2D2.play("default")
		$AnimatedSprite2D3.play("default")
		$AnimatedSprite24.play("default")
	if countdown == true:
		$Label.position.x = 507
		$ColorRect.visible = true
		$Label.text = str(time2)
func _on_timer_timeout():
	if countdown == true && time2 > 0:
		time2 -= 1
