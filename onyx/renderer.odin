// Onyx Renderer
// Creates and manages a renderer
package onyx

import math "core:math/linalg/glsl"
import SDL "vendor:sdl2"
import image "vendor:sdl2/image"
import "core:fmt"

Line :: struct {
	bounds: math.ivec4,
	color: math.ivec4
}

Rect :: struct {
	bounds: math.ivec4,
	color: math.ivec4
}

GfxPrimitiveBuffer :: struct {
	lines: [dynamic]Line,
	rects: [dynamic]Rect
}

Texture :: struct {
	texture: ^SDL.Texture,
	w: i32,
	h: i32
}

GfxBuffer :: struct {
	textures: [dynamic]Texture,
	primitives: GfxPrimitiveBuffer
}

RenderingManager :: struct {
	m_renderer: ^SDL.Renderer,
	m_gfxBuffer: GfxBuffer
}

CreateRenderingManager :: proc(window: ^SDL.Window) -> RenderingManager {
	renderingManager := RenderingManager{}

	renderingManager.m_renderer = SDL.CreateRenderer(
		window,
		-1,
		SDL.RENDERER_ACCELERATED)

	return renderingManager
}

LoadTexture :: proc(renderer: ^SDL.Renderer, filepath: cstring) -> Texture {
	res: Texture
	image: ^SDL.Texture = image.LoadTexture(renderer, filepath)

	if image == nil {
		fmt.eprintln("Failed to load texture")
		return res
	}

	w: i32
	h: i32
	
	SDL.QueryTexture(image, nil, nil, &w, &h)

	res.texture = image
	res.w = w
	res.h = h

	return res
}
