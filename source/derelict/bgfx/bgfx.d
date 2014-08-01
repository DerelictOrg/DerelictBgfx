/*
 * Copyright (c) 2014 Derelict Developers
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the names 'Derelict', 'DerelictILUT', nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module derelict.bgfx.bgfx;

public
{
    import derelict.bgfx.types;
    import derelict.bgfx.funcs;
}

private
{
    import derelict.util.loader;    
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    static if(Derelict_OS_Windows)
        enum libNames = "bgfx-shared-libRelease.dll, bgfx-shared-libDebug.dll";
    else static if (Derelict_OS_Mac)
         assert(0, "Need to implement BASS libNames for this operating system.");
    else static if (Derelict_OS_Linux)
        enum libNames = "libbgfx-shared-libRelease.so, libbgfx-shared-libDebug.so"; 
    else
        static assert(0, "Need to implement BASS libNames for this operating system.");
}

class DerelictBgfxLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {
            bindFunc(cast(void**)&bgfx_vertex_decl_begin, "bgfx_vertex_decl_begin");
            bindFunc(cast(void**)&bgfx_vertex_decl_add, "bgfx_vertex_decl_add");
            bindFunc(cast(void**)&bgfx_vertex_decl_skip, "bgfx_vertex_decl_skip");
            bindFunc(cast(void**)&bgfx_vertex_decl_end, "bgfx_vertex_decl_end");
            bindFunc(cast(void**)&bgfx_vertex_pack, "bgfx_vertex_pack");
            bindFunc(cast(void**)&bgfx_vertex_unpack, "bgfx_vertex_unpack");
            bindFunc(cast(void**)&bgfx_vertex_convert, "bgfx_vertex_convert");
            bindFunc(cast(void**)&bgfx_weld_vertices, "bgfx_weld_vertices");
            bindFunc(cast(void**)&bgfx_image_swizzle_bgra8, "bgfx_image_swizzle_bgra8");
            bindFunc(cast(void**)&bgfx_image_rgba8_downsample_2x2, "bgfx_image_rgba8_downsample_2x2");
            bindFunc(cast(void**)&bgfx_get_supported_renderers, "bgfx_get_supported_renderers");
            bindFunc(cast(void**)&bgfx_get_renderer_name, "bgfx_get_renderer_name");
            bindFunc(cast(void**)&bgfx_init, "bgfx_init");
            bindFunc(cast(void**)&bgfx_shutdown, "bgfx_shutdown");
            bindFunc(cast(void**)&bgfx_reset, "bgfx_reset");
            bindFunc(cast(void**)&bgfx_frame, "bgfx_frame");
            bindFunc(cast(void**)&bgfx_get_renderer_type, "bgfx_get_renderer_type");
            bindFunc(cast(void**)&bgfx_get_caps, "bgfx_get_caps");
            bindFunc(cast(void**)&bgfx_alloc, "bgfx_alloc");
            bindFunc(cast(void**)&bgfx_copy, "bgfx_copy");
            bindFunc(cast(void**)&bgfx_make_ref, "bgfx_make_ref");
            bindFunc(cast(void**)&bgfx_set_debug, "bgfx_set_debug");
            bindFunc(cast(void**)&bgfx_dbg_text_clear, "bgfx_dbg_text_clear");
            bindFunc(cast(void**)&bgfx_dbg_text_printf, "bgfx_dbg_text_printf");
            bindFunc(cast(void**)&bgfx_create_index_buffer, "bgfx_create_index_buffer");
            bindFunc(cast(void**)&bgfx_destroy_index_buffer, "bgfx_destroy_index_buffer");
            bindFunc(cast(void**)&bgfx_create_vertex_buffer, "bgfx_create_vertex_buffer");
            bindFunc(cast(void**)&bgfx_destroy_vertex_buffer, "bgfx_destroy_vertex_buffer");
            bindFunc(cast(void**)&bgfx_create_dynamic_index_buffer, "bgfx_create_dynamic_index_buffer");
            bindFunc(cast(void**)&bgfx_create_dynamic_index_buffer_mem, "bgfx_create_dynamic_index_buffer_mem");
            bindFunc(cast(void**)&bgfx_update_dynamic_index_buffer, "bgfx_update_dynamic_index_buffer");
            bindFunc(cast(void**)&bgfx_destroy_dynamic_index_buffer, "bgfx_destroy_dynamic_index_buffer");
            bindFunc(cast(void**)&bgfx_create_dynamic_vertex_buffer, "bgfx_create_dynamic_vertex_buffer");
            bindFunc(cast(void**)&bgfx_create_dynamic_vertex_buffer_mem, "bgfx_create_dynamic_vertex_buffer_mem");
            bindFunc(cast(void**)&bgfx_update_dynamic_vertex_buffer, "bgfx_update_dynamic_vertex_buffer");
            bindFunc(cast(void**)&bgfx_destroy_dynamic_vertex_buffer, "bgfx_destroy_dynamic_vertex_buffer");
            bindFunc(cast(void**)&bgfx_check_avail_transient_index_buffer, "bgfx_check_avail_transient_index_buffer");
            bindFunc(cast(void**)&bgfx_check_avail_transient_vertex_buffer, "bgfx_check_avail_transient_vertex_buffer");
            bindFunc(cast(void**)&bgfx_check_avail_instance_data_buffer, "bgfx_check_avail_instance_data_buffer");
            bindFunc(cast(void**)&bgfx_check_avail_transient_buffers, "bgfx_check_avail_transient_buffers");
            bindFunc(cast(void**)&bgfx_alloc_transient_index_buffer, "bgfx_alloc_transient_index_buffer");
            bindFunc(cast(void**)&bgfx_alloc_transient_vertex_buffer, "bgfx_alloc_transient_vertex_buffer");
            bindFunc(cast(void**)&bgfx_alloc_transient_buffers, "bgfx_alloc_transient_buffers");
            bindFunc(cast(void**)&bgfx_alloc_instance_data_buffer, "bgfx_alloc_instance_data_buffer");
            bindFunc(cast(void**)&bgfx_create_shader, "bgfx_create_shader");
            bindFunc(cast(void**)&bgfx_get_shader_uniforms, "bgfx_get_shader_uniforms");
            bindFunc(cast(void**)&bgfx_destroy_shader, "bgfx_destroy_shader");
            bindFunc(cast(void**)&bgfx_create_program, "bgfx_create_program");
            bindFunc(cast(void**)&bgfx_destroy_program, "bgfx_destroy_program");
            bindFunc(cast(void**)&bgfx_calc_texture_size, "bgfx_calc_texture_size");
            bindFunc(cast(void**)&bgfx_create_texture, "bgfx_create_texture");
            bindFunc(cast(void**)&bgfx_create_texture_2d, "bgfx_create_texture_2d");
            bindFunc(cast(void**)&bgfx_create_texture_3d, "bgfx_create_texture_3d");
            bindFunc(cast(void**)&bgfx_create_texture_cube, "bgfx_create_texture_cube");
            bindFunc(cast(void**)&bgfx_update_texture_2d, "bgfx_update_texture_2d");
            bindFunc(cast(void**)&bgfx_update_texture_3d, "bgfx_update_texture_3d");
            bindFunc(cast(void**)&bgfx_update_texture_cube, "bgfx_update_texture_cube");
            bindFunc(cast(void**)&bgfx_destroy_texture, "bgfx_destroy_texture");
            bindFunc(cast(void**)&bgfx_create_frame_buffer, "bgfx_create_frame_buffer");
            bindFunc(cast(void**)&bgfx_create_frame_buffer_from_handles, "bgfx_create_frame_buffer_from_handles");
            bindFunc(cast(void**)&bgfx_destroy_frame_buffer, "bgfx_destroy_frame_buffer");
            bindFunc(cast(void**)&bgfx_create_uniform, "bgfx_create_uniform");
            bindFunc(cast(void**)&bgfx_destroy_uniform, "bgfx_destroy_uniform");
            bindFunc(cast(void**)&bgfx_set_view_name, "bgfx_set_view_name");
            bindFunc(cast(void**)&bgfx_set_view_rect, "bgfx_set_view_rect");
            bindFunc(cast(void**)&bgfx_set_view_rect_mask, "bgfx_set_view_rect_mask");
            bindFunc(cast(void**)&bgfx_set_view_scissor, "bgfx_set_view_scissor");
            bindFunc(cast(void**)&bgfx_set_view_scissor_mask, "bgfx_set_view_scissor_mask");
            bindFunc(cast(void**)&bgfx_set_view_clear, "bgfx_set_view_clear");
            bindFunc(cast(void**)&bgfx_set_view_clear_mask, "bgfx_set_view_clear_mask");
            bindFunc(cast(void**)&bgfx_set_view_seq, "bgfx_set_view_seq");
            bindFunc(cast(void**)&bgfx_set_view_seq_mask, "bgfx_set_view_seq_mask");
            bindFunc(cast(void**)&bgfx_set_view_frame_buffer, "bgfx_set_view_frame_buffer");
            bindFunc(cast(void**)&bgfx_set_view_frame_buffer_mask, "bgfx_set_view_frame_buffer_mask");
            bindFunc(cast(void**)&bgfx_set_view_transform, "bgfx_set_view_transform");
            bindFunc(cast(void**)&bgfx_set_view_transform_mask, "bgfx_set_view_transform_mask");
            bindFunc(cast(void**)&bgfx_set_marker, "bgfx_set_marker");
            bindFunc(cast(void**)&bgfx_set_state, "bgfx_set_state");
            bindFunc(cast(void**)&bgfx_set_stencil, "bgfx_set_stencil");
            bindFunc(cast(void**)&bgfx_set_scissor, "bgfx_set_scissor");
            bindFunc(cast(void**)&bgfx_set_scissor_cached, "bgfx_set_scissor_cached");
            bindFunc(cast(void**)&bgfx_set_transform, "bgfx_set_transform");
            bindFunc(cast(void**)&bgfx_set_transform_cached, "bgfx_set_transform_cached");
            bindFunc(cast(void**)&bgfx_set_uniform, "bgfx_set_uniform");
            bindFunc(cast(void**)&bgfx_set_index_buffer, "bgfx_set_index_buffer");
            bindFunc(cast(void**)&bgfx_set_dynamic_index_buffer, "bgfx_set_dynamic_index_buffer");
            bindFunc(cast(void**)&bgfx_set_transient_index_buffer, "bgfx_set_transient_index_buffer");
            bindFunc(cast(void**)&bgfx_set_vertex_buffer, "bgfx_set_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_dynamic_vertex_buffer, "bgfx_set_dynamic_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_transient_vertex_buffer, "bgfx_set_transient_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_instance_data_buffer, "bgfx_set_instance_data_buffer");
            bindFunc(cast(void**)&bgfx_set_program, "bgfx_set_program");
            bindFunc(cast(void**)&bgfx_set_texture, "bgfx_set_texture");
            bindFunc(cast(void**)&bgfx_set_texture_from_frame_buffer, "bgfx_set_texture_from_frame_buffer");
            bindFunc(cast(void**)&bgfx_submit, "bgfx_submit");
            bindFunc(cast(void**)&bgfx_submit_mask, "bgfx_submit_mask");
            bindFunc(cast(void**)&bgfx_discard, "bgfx_discard");
            bindFunc(cast(void**)&bgfx_save_screen_shot, "bgfx_save_screen_shot");

            bindFunc(cast(void**)&bgfx_render_frame, "bgfx_render_frame");

            version (Android)
            {
                bindFunc(cast(void**)&bgfx_android_set_window, "bgfx_android_set_window");
            }

            version(linux)
            {
                bindFunc(cast(void**)&bgfx_x11_set_display_window, "bgfx_x11_set_display_window");
            }

            version(OSX)
            {
                bindFunc(cast(void**)&bgfx_osx_set_ns_window, "bgfx_osx_set_ns_window");
            }

            version(Windows)
            {
                bindFunc(cast(void**)&bgfx_win_set_hwnd, "bgfx_win_set_hwnd");
            }
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictBgfxLoader DerelictBgfx;

shared static this()
{
    DerelictBgfx = new DerelictBgfxLoader();
}
