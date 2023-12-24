// Onyx Window
// Defines structs and procs for controlling SDL windows

package onyx

import SDL "vendor:sdl2"

WindowManager :: struct {
	m_window: ^SDL.Window,
	m_width: i32,
	m_height: i32
}

CreateWindowManager :: proc( x: i32, y: i32, w: i32, h: i32) -> WindowManager {
	window := SDL.CreateWindow(
		"Onyx Window",
		x,
		y,
		w,
		h,
		SDL.WINDOW_SHOWN)

	windowManager := WindowManager{ window, w, h }

	return windowManager
}

DestroyWindowManager :: proc(windowManager: WindowManager) {
	SDL.DestroyWindow(windowManager.m_window)
}
