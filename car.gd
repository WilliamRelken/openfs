extends VehicleBody3D

var max_rpm = 20000
var max_torque = 5000

func _physics_process(delta):
    steering = lerp(steering, Input.get_axis("right", "left") * 0.4, 5 * delta)
    var handbrake = Input.get_action_strength("handbrake")
    var acceleration = Input.get_axis("back", "forward")
    var calc_force = func(rpm: int) -> float: 
        return int(!handbrake) * (acceleration * max_torque * ( 1 - rpm / max_rpm))
    
    var diameter = 2 * $bl_wheel.wheel_radius
    var mph = abs(diameter * PI * $bl_wheel.get_rpm() * 60 / 63360) * 100
    $camera/CanvasLayer/Control/mph.text = str(int(mph))
    
    $bl_wheel.brake = 1000 * handbrake
    $br_wheel.brake = 1000 * handbrake
    $bl_wheel.engine_force = calc_force.call($bl_wheel.get_rpm())
    $br_wheel.engine_force = calc_force.call($br_wheel.get_rpm())

