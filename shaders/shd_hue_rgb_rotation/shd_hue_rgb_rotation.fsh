varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float shift;

vec3 hueShift(vec3 color) {
    return color;
}

void main() {
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor.rgb = hueShift(gl_FragColor.rgb);
}