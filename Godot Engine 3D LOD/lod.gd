extends Spatial
class_name LOD, "icon.svg"

# Export Variables
export(NodePath) var lod0
export(NodePath) var lod1
export(NodePath) var lod2 # Leave LOD 2 and/or 3 blank if they are unused.

export(float) var lod1_min_distance = 150
export(float) var lod2_min_distance = 300
export(float) var cull_distance = 450 # Set to 0 to disable culling.

# LOD References
onready var lod0_ref = get_node(lod0)
onready var lod1_ref = get_node(lod1)
onready var lod2_ref = get_node(lod2)

# LOD System
func run_lod():
	if get_viewport().get_camera().get_global_transform().origin.distance_to(get_global_transform().origin) < lod1_min_distance:
		lod1_ref.visible = false
		lod2_ref.visible = false
		lod0_ref.visible = true
	if lod1_ref != null and get_viewport().get_camera().get_global_transform().origin.distance_to(get_global_transform().origin) >= lod1_min_distance:
		lod0_ref.visible = false
		lod2_ref.visible = false
		lod1_ref.visible = true
	if lod2_ref != null and get_viewport().get_camera().get_global_transform().origin.distance_to(get_global_transform().origin) >= lod2_min_distance:
		lod0_ref.visible = false
		lod1_ref.visible = false
		lod2_ref.visible = true
	if cull_distance != 0 and get_viewport().get_camera().get_global_transform().origin.distance_to(get_global_transform().origin) >= cull_distance:
		lod0_ref.visible = false
		lod1_ref.visible = false
		lod2_ref.visible = false

# _Process
func _process(delta):
	run_lod() # Always keep this in _process for LOD to compute.