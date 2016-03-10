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
 * * Neither the names 'Derelict', 'DerelictBgfx', nor the names of its contributors
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
        enum libNames = "libbgfx-shared-libRelease.dylib, libbgfx-shared-libDebug.dylib"; 
    else static if (Derelict_OS_Linux)
        enum libNames = "libbgfx-shared-libRelease.so, libbgfx-shared-libDebug.so, ./libbgfx-shared-libRelease.so, ./libbgfx-shared-libDebug.so";
    else
        static assert(0, "Need to implement bgfx libNames for this operating system.");
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
            bindFunc(cast(void**)&bgfx_get_hmd, "bgfx_get_hmd");
            bindFunc(cast(void**)&bgfx_get_stats, "bgfx_get_stats");
            bindFunc(cast(void**)&bgfx_alloc, "bgfx_alloc");
            bindFunc(cast(void**)&bgfx_copy, "bgfx_copy");
            bindFunc(cast(void**)&bgfx_make_ref, "bgfx_make_ref");
            bindFunc(cast(void**)&bgfx_make_ref_release, "bgfx_make_ref_release");
            bindFunc(cast(void**)&bgfx_set_debug, "bgfx_set_debug");
            bindFunc(cast(void**)&bgfx_dbg_text_clear, "bgfx_dbg_text_clear");
            bindFunc(cast(void**)&bgfx_dbg_text_printf, "bgfx_dbg_text_printf");
            bindFunc(cast(void**)&bgfx_dbg_text_image, "bgfx_dbg_text_image");
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
            bindFunc(cast(void**)&bgfx_create_indirect_buffer, "bgfx_create_indirect_buffer");
            bindFunc(cast(void**)&bgfx_destroy_indirect_buffer, "bgfx_destroy_indirect_buffer");
            bindFunc(cast(void**)&bgfx_create_shader, "bgfx_create_shader");
            bindFunc(cast(void**)&bgfx_get_shader_uniforms, "bgfx_get_shader_uniforms");
            bindFunc(cast(void**)&bgfx_destroy_shader, "bgfx_destroy_shader");
            bindFunc(cast(void**)&bgfx_create_program, "bgfx_create_program");
            bindFunc(cast(void**)&bgfx_create_compute_program, "bgfx_create_compute_program");
            bindFunc(cast(void**)&bgfx_destroy_program, "bgfx_destroy_program");
            bindFunc(cast(void**)&bgfx_calc_texture_size, "bgfx_calc_texture_size");
            bindFunc(cast(void**)&bgfx_create_texture, "bgfx_create_texture");
            bindFunc(cast(void**)&bgfx_create_texture_2d, "bgfx_create_texture_2d");
            bindFunc(cast(void**)&bgfx_create_texture_2d_scaled, "bgfx_create_texture_2d_scaled");
            bindFunc(cast(void**)&bgfx_create_texture_3d, "bgfx_create_texture_3d");
            bindFunc(cast(void**)&bgfx_create_texture_cube, "bgfx_create_texture_cube");
            bindFunc(cast(void**)&bgfx_update_texture_2d, "bgfx_update_texture_2d");
            bindFunc(cast(void**)&bgfx_update_texture_3d, "bgfx_update_texture_3d");
            bindFunc(cast(void**)&bgfx_update_texture_cube, "bgfx_update_texture_cube");
            bindFunc(cast(void**)&bgfx_read_texture, "bgfx_read_texture");
            bindFunc(cast(void**)&bgfx_read_frame_buffer, "bgfx_read_frame_buffer");
            bindFunc(cast(void**)&bgfx_destroy_texture, "bgfx_destroy_texture");
            bindFunc(cast(void**)&bgfx_create_frame_buffer, "bgfx_create_frame_buffer");
            bindFunc(cast(void**)&bgfx_create_frame_buffer_scaled, "bgfx_create_frame_buffer_scaled");
            bindFunc(cast(void**)&bgfx_create_frame_buffer_from_attachment, "bgfx_create_frame_buffer_from_attachment");
            bindFunc(cast(void**)&bgfx_destroy_frame_buffer, "bgfx_destroy_frame_buffer");
            bindFunc(cast(void**)&bgfx_create_uniform, "bgfx_create_uniform");
            bindFunc(cast(void**)&bgfx_destroy_uniform, "bgfx_destroy_uniform");
            bindFunc(cast(void**)&bgfx_create_occlusion_query, "bgfx_create_occlusion_query");
            bindFunc(cast(void**)&bgfx_get_result, "bgfx_get_result");
            bindFunc(cast(void**)&bgfx_destroy_occlusion_query, "bgfx_destroy_occlusion_query");
            bindFunc(cast(void**)&bgfx_set_palette_color, "bgfx_set_palette_color");
            bindFunc(cast(void**)&bgfx_set_view_name, "bgfx_set_view_name");
            bindFunc(cast(void**)&bgfx_set_view_rect, "bgfx_set_view_rect");
            bindFunc(cast(void**)&bgfx_set_view_rect_auto, "bgfx_set_view_rect_auto");
            bindFunc(cast(void**)&bgfx_set_view_scissor, "bgfx_set_view_scissor");
            bindFunc(cast(void**)&bgfx_set_view_clear, "bgfx_set_view_clear");
            bindFunc(cast(void**)&bgfx_set_view_clear_mrt, "bgfx_set_view_clear_mrt");
            bindFunc(cast(void**)&bgfx_set_view_seq, "bgfx_set_view_seq");
            bindFunc(cast(void**)&bgfx_set_view_frame_buffer, "bgfx_set_view_frame_buffer");
            bindFunc(cast(void**)&bgfx_set_view_transform, "bgfx_set_view_transform");
            bindFunc(cast(void**)&bgfx_set_view_transform_stereo, "bgfx_set_view_transform_stereo");
            bindFunc(cast(void**)&bgfx_set_view_remap, "bgfx_set_view_remap");
            bindFunc(cast(void**)&bgfx_reset_view, "bgfx_reset_view");
            bindFunc(cast(void**)&bgfx_set_marker, "bgfx_set_marker");
            bindFunc(cast(void**)&bgfx_set_state, "bgfx_set_state");
            bindFunc(cast(void**)&bgfx_set_condition, "bgfx_set_condition");
            bindFunc(cast(void**)&bgfx_set_stencil, "bgfx_set_stencil");
            bindFunc(cast(void**)&bgfx_set_scissor, "bgfx_set_scissor");
            bindFunc(cast(void**)&bgfx_set_scissor_cached, "bgfx_set_scissor_cached");
            bindFunc(cast(void**)&bgfx_set_transform, "bgfx_set_transform");
            bindFunc(cast(void**)&bgfx_alloc_transform, "bgfx_alloc_transform");
            bindFunc(cast(void**)&bgfx_set_transform_cached, "bgfx_set_transform_cached");
            bindFunc(cast(void**)&bgfx_set_uniform, "bgfx_set_uniform");
            bindFunc(cast(void**)&bgfx_set_index_buffer, "bgfx_set_index_buffer");
            bindFunc(cast(void**)&bgfx_set_dynamic_index_buffer, "bgfx_set_dynamic_index_buffer");
            bindFunc(cast(void**)&bgfx_set_transient_index_buffer, "bgfx_set_transient_index_buffer");
            bindFunc(cast(void**)&bgfx_set_vertex_buffer, "bgfx_set_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_dynamic_vertex_buffer, "bgfx_set_dynamic_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_transient_vertex_buffer, "bgfx_set_transient_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_instance_data_buffer, "bgfx_set_instance_data_buffer");
            bindFunc(cast(void**)&bgfx_set_instance_data_from_vertex_buffer, "bgfx_set_instance_data_from_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_instance_data_from_dynamic_vertex_buffer, "bgfx_set_instance_data_from_dynamic_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_texture, "bgfx_set_texture");
            bindFunc(cast(void**)&bgfx_set_texture_from_frame_buffer, "bgfx_set_texture_from_frame_buffer");
            bindFunc(cast(void**)&bgfx_touch, "bgfx_touch");
            bindFunc(cast(void**)&bgfx_submit, "bgfx_submit");
            bindFunc(cast(void**)&bgfx_submit_occlusion_query, "bgfx_submit_occlusion_query");
            bindFunc(cast(void**)&bgfx_submit_indirect, "bgfx_submit_indirect");
            bindFunc(cast(void**)&bgfx_set_image, "bgfx_set_image");
            bindFunc(cast(void**)&bgfx_set_image_from_frame_buffer, "bgfx_set_image_from_frame_buffer");
            bindFunc(cast(void**)&bgfx_set_compute_index_buffer, "bgfx_set_compute_index_buffer");
            bindFunc(cast(void**)&bgfx_set_compute_vertex_buffer, "bgfx_set_compute_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_compute_dynamic_index_buffer, "bgfx_set_compute_dynamic_index_buffer");
            bindFunc(cast(void**)&bgfx_set_compute_dynamic_vertex_buffer, "bgfx_set_compute_dynamic_vertex_buffer");
            bindFunc(cast(void**)&bgfx_set_compute_indirect_buffer, "bgfx_set_compute_indirect_buffer");
            bindFunc(cast(void**)&bgfx_dispatch, "bgfx_dispatch");
            bindFunc(cast(void**)&bgfx_dispatch_indirect, "bgfx_dispatch_indirect");
            bindFunc(cast(void**)&bgfx_discard, "bgfx_discard");
            bindFunc(cast(void**)&bgfx_blit, "bgfx_blit");
            bindFunc(cast(void**)&bgfx_blit_frame_buffer, "bgfx_blit_frame_buffer");
            bindFunc(cast(void**)&bgfx_save_screen_shot, "bgfx_save_screen_shot");

            bindFunc(cast(void**)&bgfx_render_frame, "bgfx_render_frame");
	        bindFunc(cast(void**)&bgfx_set_platform_data, "bgfx_set_platform_data");
	        bindFunc(cast(void**)&bgfx_get_internal_data, "bgfx_get_internal_data");
	        bindFunc(cast(void**)&bgfx_override_internal_texture_ptr, "bgfx_override_internal_texture_ptr");
	        bindFunc(cast(void**)&bgfx_override_internal_texture, "bgfx_override_internal_texture");
	        
			
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
