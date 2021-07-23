varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float shift;

vec3 toYIQ(vec3 color) {
    mat3 convert = mat3(
        0.299,  0.596,  0.211,
        0.587, -0.274, -0.523,
        0.114, -0.322,  0.312
    );
    return convert * color;
}

vec3 toRGB(vec3 color) {
    mat3 convert = mat3(
        1.0,    1.0,    1.0,
        0.956, -0.272, -1.106,
        0.621, -0.647,  1.703
    );
    return convert * color;
}

vec3 hueShift(vec3 color) {
    vec3 yiq = toYIQ(color);
    
    mat2 rotMatrix = mat2(
        cos(shift), -sin(shift),
        sin(shift), cos(shift)
    );
    
    yiq.yz *= rotMatrix;
    
    return toRGB(yiq);
}

void main() {
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor.rgb = hueShift(gl_FragColor.rgb);
}