shader_type canvas_item;

// Clips a TextureRect/ColorRect to a rounded rectangle with anti-aliased edges.
// The corner radius is a fraction of the node's height (0.5 = pill or circle), so it
// stays correct at any node size and any canvas stretch scale.
uniform float corner_radius_ratio : hint_range(0.0, 0.5) = 0.5;

void fragment() {
	vec2 size = 1.0 / fwidth(UV);
	vec2 half_size = size * 0.5;
	float radius = corner_radius_ratio * size.y;
	vec2 q = abs(UV * size - half_size) - (half_size - vec2(radius));
	float dist = length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - radius;
	COLOR.a *= clamp(0.5 - dist, 0.0, 1.0);
}
