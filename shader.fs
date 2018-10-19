
extern Image tex;

vec4 effect(vec4 color, Image texture, vec2 texture_coords,
            vec2 screen_coords) {
  // vec4 pixel = Texel(texture, texture_coords );//This is the current pixel
  // color
  vec4 c = vec4(0., 0., 0., 1.);
  vec4 data = Texel(tex, (screen_coords / vec2(love_ScreenSize.xy)));
  data.r *= 10.;
  if (data.r > 5.1) {
    c = vec4(1.2, 0.3, 0.1, 1.0) * data.g;
  } else if (data.r > 4.1) {
    c = vec4(0.9, 0.8, 0.5, 1.0) * data.g;
  } else if (data.r > 3.1) {
    c = vec4(0.5, 0.5, 0.5, 1.0) * data.g;
  } else if (data.r > 2.1) {
    c = vec4(1.2, 0.9, 0.9, 1.0) * data.g;
  } else if (data.r > 1.1) {
    c = vec4(0.3, 0.3, 0.9, 1.0) * data.g;
  } else if (data.r > 0.1) {
    c = vec4(0.9, 0.4, 0.4, 1.0) * data.g;
  }
  c.a = 1.0;
  return c;
}