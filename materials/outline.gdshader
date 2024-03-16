shader_type spatial;
//render_mode unshaded;
//render_mode cull_front;

//uniform vec3 uv_scale;
//uniform vec3 uv_offset;

void vertex() {
	// Called for every vertex the material is visible on.
	
	//vec3 outlineOffset = NORMAL * 0.1;
	//vec3 position = VERTEX + outlineOffset;
	//vec4 newPosition = vec4((position), 1.0);
	
	//POSITION = newPosition;
	 
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 _Color;
	
	_Color.r = 1.0;
	_Color.g = 0.0;
	_Color.b = 0.0;
	
	ALBEDO = _Color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
