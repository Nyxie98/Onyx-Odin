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

	renderer := SDL.CreateRenderer(windowManager.m_window,
		-1,
		SDL.RENDERER_ACCELERATED)
	
	if renderer == nil {
		fmt.eprintln("Failed to create a renderer")
		return
	}
	
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

			SDL.RenderPresent(renderer)
		}
	}

	SDL.DestroyRenderer(renderer)
	onyx.DestroyWindowManager(windowManager)
}
