
extern Image tex;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
    // vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
    
    vec4 c = Texel(tex, (screen_coords /vec2(love_ScreenSize.xy)));
    c.a =1.0;
    return c;
}