varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float shift;

vec3 toHSV(vec3 color) {                                                    // color: rgb
    vec4 K = vec4(0.0,      -1.0 / 3.0,         2.0 / 3.0,      -1.0);      // K: xyzw
    vec4 p = mix(vec4(color.b, color.g, K.w, K.z),      vec4(color.g, color.b, K.x, K.y),       step(color.b, color.g));        // p: xyzw
    vec4 q = mix(vec4(p.x, p.y, p.w, color.r),          vec4(color.r, p.y, p.z, p.x),           step(p.x, color.r));            // q: xyzw
    
    float d = q.x - min(q.w, q.y);
    float e = 0.00001;
    
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)),         d / (q.x + e),          q.x);               // hsv: xyz
}

vec3 toRGB(vec3 color) {                                                    // hsv: xyz
    vec4 K = vec4(1.0,      2.0 / 3.0,          1.0 / 3.0,      3.0);       // K: xyzw
    vec3 p = abs(fract(vec3(color.x + K.x, color.x + K.y, color.x + K.z)) * 6.0 - vec3(K.w, K.w, K.w));     // p: xyz
    return mix(vec3(K.x, K.x, K.x),                     clamp(p - vec3(K.x, K.x, K.x), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0)),       color.y) * color.z;
}

vec3 hueShift(vec3 color) {
    vec3 hsv = toHSV(color);
    
    hsv.x += shift;
    hsv.x = fract(hsv.x);
    
    return toRGB(hsv);
}

void main() {
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor.rgb = hueShift(gl_FragColor.rgb);
}