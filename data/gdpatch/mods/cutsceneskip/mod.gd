extends Node

func _ready() -> void:
    # register with coremod if installed
    if ResourceLoader.exists("res://gdpatch/mods/snapticbase/mod.gd"):
        var SnapticBase = load("res://gdpatch/mods/snapticbase/mod.gd")
        SnapticBase.register("cutsceneskip", get_script().resource_path.get_base_dir())