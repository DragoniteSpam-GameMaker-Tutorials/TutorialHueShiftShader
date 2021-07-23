varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float shift;

vec3 hueShift(vec3 color) {
    vec3 K = vec3(0.57735);
    float cosAngle = cos(shift);
    float sinAngle = sin(shift);
    return vec3(color * cosAngle + cross(K, color) * sinAngle + K * dot(K, color) * (1.0 - cosAngle));
}

void main() {
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor.rgb = hueShift(gl_FragColor.rgb);
}