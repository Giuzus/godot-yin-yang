extends RigidBody2D


var direction: Vector2;
var speed: float = 1;

@export
var blackCircle: bool = false;
var atlasCoords: Vector2;

@onready
var tilemap: TileMap = $"../TileMap"



# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1));
	atlasCoords = Vector2(0,1) if blackCircle else Vector2(0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var collision_info: KinematicCollision2D = move_and_collide(direction.normalized() * speed)
	if collision_info:
		var collisionPosition = collision_info.get_position() + position.direction_to(collision_info.get_position()).limit_length(0.1);
		var cellPos :Vector2 = tilemap.local_to_map(collisionPosition)
		
		if tilemap.get_cell_source_id(0,cellPos) == 0:
			tilemap.set_cell(0,cellPos, 0, atlasCoords)
		
		direction = direction.bounce(collision_info.get_normal())
