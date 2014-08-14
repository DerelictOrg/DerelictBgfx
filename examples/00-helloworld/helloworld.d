/*
 * Copyright 2011-2014 Branimir Karadzic. All rights reserved.
 * License: http://www.opensource.org/licenses/BSD-2-Clause
 */
import std.stdio;
import std.typecons;
import gfm.core;
import gfm.sdl2;

import derelict.bgfx.bgfx;

void main() 
{
    // create a logger
    auto log = new ConsoleLogger();

    // load dynamic libraries
    auto sdl2 = scoped!SDL2(log);

    int width = 1280;
    int height = 720;
    // create an OpenGL-enabled SDL window
    auto window = scoped!SDL2Window(sdl2, 
                                    SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                                    width, height, 0);
   

    DerelictBgfx.load();

    version(Windows)
    {
        bgfx_win_set_hwnd(window.getWindowInfo().info.win.window);
    }
    version(linux)
    {
        bgfx_x11_set_display_window(cast(Display*)window.getWindowInfo().info.x11.display,window.getWindowInfo().info.x11.window);
    }
    else
    {
        static assert(false, "TODO implement passing window handle to bgfx for this system");
    }

    bgfx_init();
    scope(exit) bgfx_shutdown();
    bgfx_reset(width, height, BGFX_RESET_VSYNC);
    bgfx_set_debug(BGFX_DEBUG_TEXT);
   
    // Set view 0 clear state.
    bgfx_set_view_clear(0
                        , BGFX_CLEAR_COLOR_BIT|BGFX_CLEAR_DEPTH_BIT
                        , 0x303030ff
                        , 1.0f
                        , 0
                        );

    while (!sdl2.keyboard().isPressed(SDLK_ESCAPE))
    {
        sdl2.processEvents();

        // Set view 0 default viewport.
        bgfx_set_view_rect(0, 0, 0, cast(ushort)width, cast(ushort)height);

        // This dummy draw call is here to make sure that view 0 is cleared
        // if no other draw calls are submitted to view 0.
        bgfx_submit(0);

        // Use debug font to print information about this example.
        bgfx_dbg_text_clear();
        bgfx_dbg_text_printf(0, 1, 0x4f, "bgfx/examples/00-helloworld");
        bgfx_dbg_text_printf(0, 2, 0x6f, "Description: Initialization and debug text.");

        // Advance to next frame. Rendering thread will be kicked to
        // process submitted rendering primitives.
        bgfx_frame();
    }

}
