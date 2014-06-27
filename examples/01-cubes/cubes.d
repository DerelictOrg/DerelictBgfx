/*
 * Copyright 2011-2014 Branimir Karadzic. All rights reserved.
 * License: http://www.opensource.org/licenses/BSD-2-Clause
 */
import std.typecons;
import gfm.core;
import gfm.sdl2;
import gfm.math;

import derelict.bgfx.bgfx;
import bgfx_utils;

struct PosColorVertex
{
    float m_x;
    float m_y;
    float m_z;
    uint32_t m_abgr;

    static void init()
    {
        bgfx_vertex_decl_begin(&ms_decl);
        bgfx_vertex_decl_add(&ms_decl, BGFX_ATTRIB_POSITION, 3, BGFX_ATTRIB_TYPE_FLOAT);
        bgfx_vertex_decl_add(&ms_decl, BGFX_ATTRIB_COLOR0, 4, BGFX_ATTRIB_TYPE_UINT8, true);
        bgfx_vertex_decl_end(&ms_decl);
    };

    static bgfx_vertex_decl_t ms_decl;
};

static PosColorVertex s_cubeVertices[8] =
[
    PosColorVertex(-1.0f,  1.0f,  1.0f, 0xff000000 ),
    PosColorVertex( 1.0f,  1.0f,  1.0f, 0xff0000ff ),
    PosColorVertex(-1.0f, -1.0f,  1.0f, 0xff00ff00 ),
    PosColorVertex( 1.0f, -1.0f,  1.0f, 0xff00ffff ),
    PosColorVertex(-1.0f,  1.0f, -1.0f, 0xffff0000 ),
    PosColorVertex( 1.0f,  1.0f, -1.0f, 0xffff00ff ),
    PosColorVertex(-1.0f, -1.0f, -1.0f, 0xffffff00 ),
    PosColorVertex( 1.0f, -1.0f, -1.0f, 0xffffffff ),
];

static const uint16_t s_cubeIndices[36] =
[
    0, 1, 2, // 0
    1, 3, 2,
    4, 6, 5, // 2
    5, 6, 7,
    0, 2, 4, // 4
    4, 2, 6,
    1, 5, 3, // 6
    5, 7, 3,
    0, 4, 1, // 8
    4, 5, 1,
    2, 3, 6, // 10
    6, 3, 7,
];






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


    // Create vertex stream declaration.
    PosColorVertex.init();

    // Create static vertex buffer.
    bgfx_vertex_buffer_handle_t vbh = bgfx_create_vertex_buffer(bgfx_make_ref(s_cubeVertices.ptr, s_cubeVertices.sizeof), &PosColorVertex.ms_decl);
    scope(exit) bgfx_destroy_vertex_buffer(vbh);

    // Create static index buffer.
    bgfx_index_buffer_handle_t ibh = bgfx_create_index_buffer(
                                                      // Static data can be passed with bgfx::makeRef
                                                      bgfx_make_ref(s_cubeIndices.ptr, s_cubeIndices.sizeof)
                                                      );
    scope(exit) bgfx_destroy_index_buffer(ibh);

    // Create program from shaders.

    bgfx_program_handle_t program = loadProgram("vs_cubes", "fs_cubes");
    scope(exit) bgfx_destroy_program(program);


    vec3f at = vec3f(0.0f, 0.0f, 0.0f);
    vec3f eye = vec3f(0.0f, 0.0f, -35.0f);
    vec3f up = vec3f(0.0f, 1.0f, 0.0f);

    uint timeOffset = SDL_GetTicks();
    uint last = timeOffset;

    while (!sdl2.keyboard().isPressed(SDLK_ESCAPE))
    {
        sdl2.processEvents();

        mat4f view = mat4f.lookAt(eye, at, up);
        mat4f proj = mat4f.perspective(degrees(60.0f), cast(float)width / height, 0.1f, 100.0f);

        // bgfx use 

        // Set view and projection matrix for view 0.
        bgfx_set_view_transform(0, view.transposed().ptr, proj.transposed().ptr);

        // Set view 0 default viewport.
        bgfx_set_view_rect(0, 0, 0, cast(ushort)width, cast(ushort)height);

        // This dummy draw call is here to make sure that view 0 is cleared
        // if no other draw calls are submitted to view 0.
        bgfx_submit(0);

        uint now = SDL_GetTicks();
        immutable uint frameTime = now - last;
        last = now;
        immutable double freq = 1000.0;
        immutable double toMs = 1000.0/freq;

        float time = cast(float)( (now-timeOffset)/1000.0 );

        // Use debug font to print information about this example.
        bgfx_dbg_text_clear();
        bgfx_dbg_text_printf(0, 1, 0x4f, "bgfx/examples/01-cube");
        bgfx_dbg_text_printf(0, 2, 0x6f, "Description: Rendering simple static mesh.");
        bgfx_dbg_text_printf(0, 3, 0x0f, "Frame: % 7.3f[ms]", cast(double)(frameTime));


        // Submit 11x11 cubes.
        for (uint yy = 0; yy < 11; ++yy)
        {
            for (uint xx = 0; xx < 11; ++xx)
            {
                mat4f mtx = mat4f.rotateX(time + xx*0.21f) * mat4f.rotateY(time + yy*0.37f);                
                mtx.c[0][3] = -15.0f + xx * 3.0f;
                mtx.c[1][3] = -15.0f + yy * 3.0f;
                mtx.c[2][3] = 0.0f;

                // Set model matrix for rendering.
                bgfx_set_transform(mtx.transposed().ptr);

                // Set vertex and fragment shaders.
                bgfx_set_program(program);

                // Set vertex and index buffer.
                bgfx_set_vertex_buffer(vbh);
                bgfx_set_index_buffer(ibh);

                // Set render states.
                bgfx_set_state(BGFX_STATE_DEFAULT);

                // Submit primitive for rendering to view 0.
                bgfx_submit(0);
            }
        }

        // Advance to next frame. Rendering thread will be kicked to 
        // process submitted rendering primitives.
        bgfx_frame();
    
    }
}
