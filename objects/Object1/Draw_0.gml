x = 100;
y = 100;
image_xscale = 2;
image_yscale = 2;

var shift = pi;
shift = current_time / 2000;

draw_text(20, 20, "Shift: " + string(shift % (pi * 2)) + " (" + string(radtodeg(shift) % 360) + " degrees)");

draw_text(x, y - 20, "Default sprite");
draw_self();

x = 400;
y = 100;

draw_text(x, y - 20, "HSV conversion");
shader_set(shd_hue_hsv_conversion);
shader_set_uniform_f(shader_get_uniform(shd_hue_hsv_conversion, "shift"), shift / 6.28);
draw_self();
shader_reset();

x = 100;
y = 400;

draw_text(x, y - 20, "RGB rotation");
shader_set(shd_hue_rgb_rotation);
shader_set_uniform_f(shader_get_uniform(shd_hue_rgb_rotation, "shift"), shift);
draw_self();
shader_reset();

x = 400;
y = 400;

draw_text(x, y - 20, "YIQ conversion");
shader_set(shd_hue_yiq_conversion);
shader_set_uniform_f(shader_get_uniform(shd_hue_yiq_conversion, "shift"), -shift);
draw_self();
shader_reset();