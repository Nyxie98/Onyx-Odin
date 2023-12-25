package main

import "core:fmt"
import SDL "vendor:sdl2"

import onyx "./onyx"

main :: proc() {
	WINDOW_WIDTH :: 800
	WINDOW_HEIGHT :: 600

	onyx.testCore()

	windowManager := onyx.CreateWindowManager(
		SDL.WINDOWPOS_CENTERED,
		SDL.WINDOWPOS_CENTERED,
		WINDOW_WIDTH,
		WINDOW_HEIGHT)
	
	if windowManager.m_window == nil {
		fmt.eprintln("Failed to create a window")
		return
	}

	renderingManager := onyx.CreateRenderingManager(
		windowManager.m_window)

	renderer := renderingManager.m_renderer
	
	if renderer == nil {
		fmt.eprintln("Failed to create a renderer")
		return
	}

	image := onyx.LoadTexture(renderer, "Assets/player.png")
	texr := SDL.Rect{10, 10, image.w, image.h}
	
	lastUpdateTime: u32 = 0

	loop: for {
		event: SDL.Event
		for SDL.PollEvent(&event) != false {
			#partial switch event.type {
			case .KEYDOWN:
				#partial switch event.key.keysym.sym {
				case .ESCAPE:
					break loop
				}	
			case .QUIT:
				break loop
			}
		}

		if lastUpdateTime + 30 < SDL.GetTicks() {
			lastUpdateTime = SDL.GetTicks()
			SDL.RenderClear(renderer)

			SDL.RenderCopy(renderer, image.texture, nil, &texr)

			SDL.RenderPresent(renderer)
		}
	}

	SDL.DestroyRenderer(renderer)
	onyx.DestroyWindowManager(windowManager)
}
