shader_type canvas_item;

const vec2 _center = vec2(0.5, 0.5);
uniform float _WarpIntensity : hint_range(0.0, 20.0) = 9.0;
varying float _Angle;
varying float _Time; 
uniform float _Radius : hint_range(0.0, 10.0)= 5.0;

uniform lowp float alpha : hint_range(0.0, 1.0) = 1.0;
uniform lowp float scale : hint_range(0.0, 2.0) = 1.0;

uniform lowp float red_shift;
uniform lowp float green_shift;
uniform lowp float blue_shift;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D main_texture; 

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//vec2 uv = SCREEN_UV;
	vec2 uv = UV * scale;
	
	//Check if pixel is outside of radius given
	if (length(_center - uv)> _Radius){
		COLOR = texture(screen_texture, uv);
	}
	
	//If its not, do swirl logic
	else{
		_Time = (cos(TIME * 0.5));
		
		//Making the angle relative to the distance of the center
		_Angle = _WarpIntensity * ((length(_center - uv) - sqrt(0.5)) * _Time);
		
		//Rotate the UV coordinates around the center of the image
		uv = uv - vec2(0.5, 0.5); //Centering the UVs 
		
		//2D Rotation Matrix applied to our texture uvs
		uv = vec2(uv.x * cos(_Angle) - uv.y * sin(_Angle), uv.x * sin(_Angle) + uv.y * cos(_Angle));
		
		//Returning UVs to correct origin
		uv = uv + vec2(0.5, 0.5);
		
		//Output the result
		//vec3 color = texture(screen_texture, uv).rgb;
		vec4 color =  texture(screen_texture, uv);
		
		float r = texture(screen_texture, uv + vec2(SCREEN_PIXEL_SIZE * red_shift), 0.0).r * 1.0;
		float g = texture(screen_texture, uv + vec2(SCREEN_PIXEL_SIZE * green_shift), 0.0).g * 1.0;
		float b = texture(screen_texture, uv + vec2(SCREEN_PIXEL_SIZE * blue_shift), 0.0).b * 1.0;
		
		COLOR = vec4(r, g, b, alpha);
	}
}