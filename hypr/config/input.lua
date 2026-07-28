-- Input configuration

hl.config({
    input = {
        accel_profile = "flat",
	kb_layout = "us,ru",
        kb_options = "grp:lalt_lshift_toggle",
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
	name = "elan0678:00-04f3:3195-touchpad",
	accel_profile = "adaptive",
	sensitivity = 0.0
})


hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })

