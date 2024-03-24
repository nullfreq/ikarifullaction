extends CharacterBody2D

@export var type:int = 1
@export var startHit:bool = false
@onready var animator = $Sprite2D/AnimationTree
# will add objects that come out later
var hit = false
func _ready():
	if startHit: hit = true
	animator.play(('idle' + str(type)) if !hit else 'empty' + str(type))
	
func _physics_process(delta):
	if !hit:
		move_and_slide()
	if is_on_floor_only() && !hit:
		print('owie!')
		animator.play('hit' + str(type))
		hit = true
		position -= get_position_delta() # hacky fix but fuck you


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == 'hit'+str(type):
		animator.play('empty'+str(type))