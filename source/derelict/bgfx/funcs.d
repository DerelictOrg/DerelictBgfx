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
module derelict.bgfx.funcs;


// For function documentation, see the original header here: https://github.com/bkaradzic/bgfx/blob/master/include/bgfx.c99.h

private
{
    import derelict.bgfx.types;
    import derelict.util.xtypes;
    import derelict.util.wintypes;
    import derelict.util.system;
}

extern(C) @nogc nothrow 
{
    alias da_bgfx_vertex_decl_begin = void function(bgfx_vertex_decl_t* _decl, bgfx_renderer_type_t _renderer = BGFX_RENDERER_TYPE_NULL);

    alias da_bgfx_vertex_decl_add = void function(bgfx_vertex_decl_t* _decl, bgfx_attrib_t _attrib, uint8_t _num, bgfx_attrib_type_t _type, bool _normalized = false, bool _asInt = false);
    alias da_bgfx_vertex_decl_skip = void function(bgfx_vertex_decl_t* _decl, uint8_t _num);
    alias da_bgfx_vertex_decl_end = void function(bgfx_vertex_decl_t* _decl);
    alias da_bgfx_vertex_pack = void function(const float _input[4], bool _inputNormalized, bgfx_attrib_t _attr, const bgfx_vertex_decl_t* _decl, void* _data, uint32_t _index = 0);
    alias da_bgfx_vertex_unpack = void function(float _output[4], bgfx_attrib_t _attr, const bgfx_vertex_decl_t* _decl, const void* _data, uint32_t _index = 0);
    alias da_bgfx_vertex_convert = void function(const bgfx_vertex_decl_t* _destDecl, void* _destData, const bgfx_vertex_decl_t* _srcDecl, const void* _srcData, uint32_t _num = 1);
    alias da_bgfx_weld_vertices = uint16_t function(uint16_t* _output, const bgfx_vertex_decl_t* _decl, const void* _data, uint16_t _num, float _epsilon = 0.001f);
    alias da_bgfx_image_swizzle_bgra8 = void function(uint32_t _width, uint32_t _height, uint32_t _pitch, const void* _src, void* _dst);
    alias da_bgfx_image_rgba8_downsample_2x2 = void function(uint32_t _width, uint32_t _height, uint32_t _pitch, const void* _src, void* _dst);
    alias da_bgfx_get_supported_renderers = uint8_t function(bgfx_renderer_type_t _enum[BGFX_RENDERER_TYPE_COUNT]);
    alias da_bgfx_get_renderer_name = const char* function(bgfx_renderer_type_t _type);

    // TODO once DMD 2.066 is release, pass extern(C++) interfaces here
    alias da_bgfx_init = void function(bgfx_renderer_type_t _type = BGFX_RENDERER_TYPE_COUNT, CallbackI _callback = null, ReallocatorI _allocator = null);
    alias da_bgfx_shutdown = void function();
    alias da_bgfx_reset = void function(uint32_t _width, uint32_t _height, uint32_t _flags = BGFX_RESET_NONE);
    alias da_bgfx_frame = uint32_t function();
    alias da_bgfx_get_renderer_type = bgfx_renderer_type_t function();
    alias da_bgfx_get_caps = bgfx_caps_t* function();
    alias da_bgfx_alloc = const bgfx_memory_t* function(uint32_t _size);
    alias da_bgfx_copy = const bgfx_memory_t* function(const(void)* _data, uint32_t _size);
    alias da_bgfx_make_ref = const bgfx_memory_t* function(const(void)* _data, uint32_t _size);
    alias da_bgfx_set_debug = void function(uint32_t _debug);
    alias da_bgfx_dbg_text_clear = void function(uint8_t _attr = 0, bool _small = false);
    alias da_bgfx_dbg_text_printf = void function(uint16_t _x, uint16_t _y, uint8_t _attr, const(char)* _format, ...);
    alias da_bgfx_create_index_buffer = bgfx_index_buffer_handle_t function(const(bgfx_memory_t)* _mem);
    alias da_bgfx_destroy_index_buffer = void function(bgfx_index_buffer_handle_t _handle);
    alias da_bgfx_create_vertex_buffer = bgfx_vertex_buffer_handle_t function(const(bgfx_memory_t)* _mem, const(bgfx_vertex_decl_t)* _decl);
    alias da_bgfx_destroy_vertex_buffer = void function(bgfx_vertex_buffer_handle_t _handle);
    alias da_bgfx_create_dynamic_index_buffer = bgfx_dynamic_index_buffer_handle_t function(uint32_t _num);
    alias da_bgfx_create_dynamic_index_buffer_mem = bgfx_dynamic_index_buffer_handle_t function(const(bgfx_memory_t)* _mem);
    alias da_bgfx_update_dynamic_index_buffer = void function(bgfx_dynamic_index_buffer_handle_t _handle, const bgfx_memory_t* _mem);
    alias da_bgfx_destroy_dynamic_index_buffer = void function(bgfx_dynamic_index_buffer_handle_t _handle);
    alias da_bgfx_create_dynamic_vertex_buffer = bgfx_dynamic_vertex_buffer_handle_t function(uint16_t _num, const(bgfx_vertex_decl_t)* _decl);
    alias da_bgfx_create_dynamic_vertex_buffer_mem = bgfx_dynamic_vertex_buffer_handle_t function(const(bgfx_memory_t)* _mem, const(bgfx_vertex_decl_t)* _decl);
    alias da_bgfx_update_dynamic_vertex_buffer = void function(bgfx_dynamic_vertex_buffer_handle_t _handle, const(bgfx_memory_t)* _mem);
    alias da_bgfx_destroy_dynamic_vertex_buffer = void function(bgfx_dynamic_vertex_buffer_handle_t _handle);
    alias da_bgfx_check_avail_transient_index_buffer = bool function(uint32_t _num);
    alias da_bgfx_check_avail_transient_vertex_buffer = bool function(uint32_t _num, const(bgfx_vertex_decl_t)* _decl);
    alias da_bgfx_check_avail_instance_data_buffer = bool function(uint32_t _num, uint16_t _stride);
    alias da_bgfx_check_avail_transient_buffers = bool function(uint32_t _numVertices, const(bgfx_vertex_decl_t)* _decl, uint32_t _numIndices);
    alias da_bgfx_alloc_transient_index_buffer = void function(bgfx_transient_index_buffer_t* _tib, uint32_t _num);
    alias da_bgfx_alloc_transient_vertex_buffer = void function(bgfx_transient_vertex_buffer_t* _tvb, uint32_t _num, const(bgfx_vertex_decl_t)* _decl);
    alias da_bgfx_alloc_transient_buffers = bool function(bgfx_transient_vertex_buffer_t* _tvb, const(bgfx_vertex_decl_t)* _decl, uint16_t _numVertices, bgfx_transient_index_buffer_t* _tib, uint16_t _numIndices);
    alias da_bgfx_alloc_instance_data_buffer = const(bgfx_instance_data_buffer_t)* function(uint32_t _num, uint16_t _stride);
    alias da_bgfx_create_shader = bgfx_shader_handle_t function(const bgfx_memory_t* _mem);
    alias da_bgfx_get_shader_uniforms = uint16_t function(bgfx_shader_handle_t _handle, bgfx_uniform_handle_t* _uniforms = null, uint16_t _max = 0);
    alias da_bgfx_destroy_shader = void function(bgfx_shader_handle_t _handle);
    alias da_bgfx_create_program = bgfx_program_handle_t function(bgfx_shader_handle_t _vsh, bgfx_shader_handle_t _fsh, bool _destroyShaders = false);
    alias da_bgfx_destroy_program = void function(bgfx_program_handle_t _handle);
    alias da_bgfx_calc_texture_size = void function(bgfx_texture_info_t* _info, uint16_t _width, uint16_t _height, uint16_t _depth, uint8_t _numMips, bgfx_texture_format_t _format);
    alias da_bgfx_create_texture = bgfx_texture_handle_t function(const bgfx_memory_t* _mem, uint32_t _flags = BGFX_TEXTURE_NONE, uint8_t _skip = 0, bgfx_texture_info_t* _info = null);
    alias da_bgfx_create_texture_2d = bgfx_texture_handle_t function(uint16_t _width, uint16_t _height, uint8_t _numMips, bgfx_texture_format_t _format, uint32_t _flags = BGFX_TEXTURE_NONE, const bgfx_memory_t* _mem = null);
    alias da_bgfx_create_texture_3d = bgfx_texture_handle_t function(uint16_t _width, uint16_t _height, uint16_t _depth, uint8_t _numMips, bgfx_texture_format_t _format, uint32_t _flags = BGFX_TEXTURE_NONE, const bgfx_memory_t* _mem = null);
    alias da_bgfx_create_texture_cube = bgfx_texture_handle_t function(uint16_t _size, uint8_t _numMips, bgfx_texture_format_t _format, uint32_t _flags = BGFX_TEXTURE_NONE, const bgfx_memory_t* _mem = null);
    alias da_bgfx_update_texture_2d = void function(bgfx_texture_handle_t _handle, uint8_t _mip, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height, const bgfx_memory_t* _mem, uint16_t _pitch = uint16_t.max);
    alias da_bgfx_update_texture_3d = void function(bgfx_texture_handle_t _handle, uint8_t _mip, uint16_t _x, uint16_t _y, uint16_t _z, uint16_t _width, uint16_t _height, uint16_t _depth, const bgfx_memory_t* _mem);
    alias da_bgfx_update_texture_cube = void function(bgfx_texture_handle_t _handle, uint8_t _side, uint8_t _mip, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height, const bgfx_memory_t* _mem, uint16_t _pitch = uint16_t.max);
    alias da_bgfx_destroy_texture = void function(bgfx_texture_handle_t _handle);
    alias da_bgfx_create_frame_buffer = bgfx_frame_buffer_handle_t function(uint16_t _width, uint16_t _height, bgfx_texture_format_t _format, uint32_t _textureFlags = (BGFX_TEXTURE_U_CLAMP | BGFX_TEXTURE_V_CLAMP) );
    alias da_bgfx_create_frame_buffer_from_handles = bgfx_frame_buffer_handle_t function(uint8_t _num, bgfx_texture_handle_t* _handles, bool _destroyTextures = false);
    alias da_bgfx_destroy_frame_buffer = void function(bgfx_frame_buffer_handle_t _handle);
    alias da_bgfx_create_uniform = bgfx_uniform_handle_t function(const char* _name, bgfx_uniform_type_t _type, uint16_t _num = 1);
    alias da_bgfx_destroy_uniform = void function(bgfx_uniform_handle_t _handle);
    alias da_bgfx_set_view_name = void function(uint8_t _id, const char* _name);
    alias da_bgfx_set_view_rect = void function(uint8_t _id, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height);
    alias da_bgfx_set_view_rect_mask = void function(uint32_t _viewMask, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height);
    alias da_bgfx_set_view_scissor = void function(uint8_t _id, uint16_t _x = 0, uint16_t _y = 0, uint16_t _width = 0, uint16_t _height = 0);
    alias da_bgfx_set_view_scissor_mask = void function(uint32_t _viewMask, uint16_t _x = 0, uint16_t _y = 0, uint16_t _width = 0, uint16_t _height = 0);
    alias da_bgfx_set_view_clear = void function(uint8_t _id, uint8_t _flags, uint32_t _rgba = 0x000000ff, float _depth =  1.0f, uint8_t _stencil = 0);
    alias da_bgfx_set_view_clear_mask = void function(uint32_t _viewMask, uint8_t _flags, uint32_t _rgba = 0x000000ff, float _depth =  1.0f, uint8_t _stencil = 0);
    alias da_bgfx_set_view_seq = void function(uint8_t _id, bool _enabled);
    alias da_bgfx_set_view_seq_mask = void function(uint32_t _viewMask, bool _enabled);
    alias da_bgfx_set_view_frame_buffer = void function(uint8_t _id, bgfx_frame_buffer_handle_t _handle);
    alias da_bgfx_set_view_frame_buffer_mask = void function(uint32_t _viewMask, bgfx_frame_buffer_handle_t _handle);
    alias da_bgfx_set_view_transform = void function(uint8_t _id, const void* _view, const void* _proj);
    alias da_bgfx_set_view_transform_mask = void function(uint32_t _viewMask, const void* _view, const void* _proj);
    alias da_bgfx_set_marker = void function(const char* _marker);
    alias da_bgfx_set_state = void function(uint64_t _state, uint32_t _rgba = 0);
    alias da_bgfx_set_stencil = void function(uint32_t _fstencil, uint32_t _bstencil = BGFX_STENCIL_NONE);
    alias da_bgfx_set_scissor = uint16_t function(uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height);
    alias da_bgfx_set_scissor_cached = void function(uint16_t _cache = uint16_t.max);
    alias da_bgfx_set_transform = uint32_t function(const void* _mtx, uint16_t _num = 1);
    alias da_bgfx_set_transform_cached = void function(uint32_t _cache, uint16_t _num = 1);
    alias da_bgfx_set_uniform = void function(bgfx_uniform_handle_t _handle, const void* _value, uint16_t _num = 1);
    alias da_bgfx_set_index_buffer = void function(bgfx_index_buffer_handle_t _handle, uint32_t _firstIndex = 0, uint32_t _numIndices = uint32_t.max);
    alias da_bgfx_set_dynamic_index_buffer = void function(bgfx_dynamic_index_buffer_handle_t _handle, uint32_t _firstIndex = 0, uint32_t _numIndices = uint32_t.max);
    alias da_bgfx_set_transient_index_buffer = void function(const bgfx_transient_index_buffer_t* _tib, uint32_t _firstIndex = 0, uint32_t _numIndices = uint32_t.max);
    alias da_bgfx_set_vertex_buffer = void function(bgfx_vertex_buffer_handle_t _handle, uint32_t _startVertex = 0, uint32_t _numVertices = uint32_t.max);
    alias da_bgfx_set_dynamic_vertex_buffer = void function(bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _numVertices = uint32_t.max);
    alias da_bgfx_set_transient_vertex_buffer = void function(const bgfx_transient_vertex_buffer_t* _tvb, uint32_t _startVertex = 0, uint32_t _numVertices = uint32_t.max);
    alias da_bgfx_set_instance_data_buffer = void function(const bgfx_instance_data_buffer_t* _idb, uint16_t _num = uint16_t.max);
    alias da_bgfx_set_program = void function(bgfx_program_handle_t _handle);
    alias da_bgfx_set_texture = void function(uint8_t _stage, bgfx_uniform_handle_t _sampler, bgfx_texture_handle_t _handle, uint32_t _flags = uint32_t.max);
    alias da_bgfx_set_texture_from_frame_buffer = void function(uint8_t _stage, bgfx_uniform_handle_t _sampler, bgfx_frame_buffer_handle_t _handle, uint8_t _attachment = 0, uint32_t _flags = uint32_t.max);
    alias da_bgfx_submit = uint32_t function(uint8_t _id, int32_t _depth = 0);
    alias da_bgfx_submit_mask = uint32_t function(uint32_t _viewMask, int32_t _depth = 0);
    alias da_bgfx_set_image = void function(uint8_t _stage, bgfx_uniform_handle_t _sampler, bgfx_texture_handle_t _handle, uint8_t _mip, bgfx_texture_format_t _format, bgfx_access_t _access);
    alias da_bgfx_set_image_from_frame_buffer = void function(uint8_t _stage, bgfx_uniform_handle_t _sampler, bgfx_frame_buffer_handle_t _handle, uint8_t _attachment, bgfx_texture_format_t _format, bgfx_access_t _access);
    alias da_bgfx_dispatch = void function(uint8_t _id, bgfx_program_handle_t _handle, uint16_t _numX, uint16_t _numY, uint16_t _numZ);
    alias da_bgfx_discard = void function();
    alias da_bgfx_save_screen_shot = void function(const char* _filePath);

    // bgfxplatform.c99.h

    alias da_bgfx_render_frame = bgfx_render_frame_t function();

    version (Android)
    {
        struct ANativeWindow;
        alias da_bgfx_android_set_window = void function(ANativeWindow* _window);
    }
    version(linux)
    {
        struct Display;
        alias da_bgfx_x11_set_display_window = void function(Display* _display, Window _window);
    }

    version(OSX)
    {
        alias da_bgfx_osx_set_ns_window = void function(void* _window);
    }

    version(Windows)
    {
        alias da_bgfx_win_set_hwnd = void function(HWND _window);
    }

    // TODO when iOS supported
    //BGFX_C_API void bgfx_ios_set_eagl_layer(void* _layer);
}

__gshared
{
    da_bgfx_vertex_decl_begin bgfx_vertex_decl_begin;
    da_bgfx_vertex_decl_add bgfx_vertex_decl_add;
    da_bgfx_vertex_decl_skip bgfx_vertex_decl_skip;
    da_bgfx_vertex_decl_end bgfx_vertex_decl_end;
    da_bgfx_vertex_pack bgfx_vertex_pack;
    da_bgfx_vertex_unpack bgfx_vertex_unpack;
    da_bgfx_vertex_convert bgfx_vertex_convert;
    da_bgfx_weld_vertices bgfx_weld_vertices;
    da_bgfx_image_swizzle_bgra8 bgfx_image_swizzle_bgra8;
    da_bgfx_image_rgba8_downsample_2x2 bgfx_image_rgba8_downsample_2x2;
    da_bgfx_get_supported_renderers bgfx_get_supported_renderers;
    da_bgfx_get_renderer_name bgfx_get_renderer_name;
    da_bgfx_init bgfx_init;
    da_bgfx_shutdown bgfx_shutdown;
    da_bgfx_reset bgfx_reset;
    da_bgfx_frame bgfx_frame;
    da_bgfx_get_renderer_type bgfx_get_renderer_type;
    da_bgfx_get_caps bgfx_get_caps;
    da_bgfx_alloc bgfx_alloc;
    da_bgfx_copy bgfx_copy;
    da_bgfx_make_ref bgfx_make_ref;
    da_bgfx_set_debug bgfx_set_debug;
    da_bgfx_dbg_text_clear bgfx_dbg_text_clear;
    da_bgfx_dbg_text_printf bgfx_dbg_text_printf;
    da_bgfx_create_index_buffer bgfx_create_index_buffer;
    da_bgfx_destroy_index_buffer bgfx_destroy_index_buffer;
    da_bgfx_create_vertex_buffer bgfx_create_vertex_buffer;
    da_bgfx_destroy_vertex_buffer bgfx_destroy_vertex_buffer;
    da_bgfx_create_dynamic_index_buffer bgfx_create_dynamic_index_buffer;
    da_bgfx_create_dynamic_index_buffer_mem bgfx_create_dynamic_index_buffer_mem;
    da_bgfx_update_dynamic_index_buffer bgfx_update_dynamic_index_buffer;
    da_bgfx_destroy_dynamic_index_buffer bgfx_destroy_dynamic_index_buffer;
    da_bgfx_create_dynamic_vertex_buffer bgfx_create_dynamic_vertex_buffer;
    da_bgfx_create_dynamic_vertex_buffer_mem bgfx_create_dynamic_vertex_buffer_mem;
    da_bgfx_update_dynamic_vertex_buffer bgfx_update_dynamic_vertex_buffer;
    da_bgfx_destroy_dynamic_vertex_buffer bgfx_destroy_dynamic_vertex_buffer;
    da_bgfx_check_avail_transient_index_buffer bgfx_check_avail_transient_index_buffer;
    da_bgfx_check_avail_transient_vertex_buffer bgfx_check_avail_transient_vertex_buffer;
    da_bgfx_check_avail_instance_data_buffer bgfx_check_avail_instance_data_buffer;
    da_bgfx_check_avail_transient_buffers bgfx_check_avail_transient_buffers;
    da_bgfx_alloc_transient_index_buffer bgfx_alloc_transient_index_buffer;
    da_bgfx_alloc_transient_vertex_buffer bgfx_alloc_transient_vertex_buffer;
    da_bgfx_alloc_transient_buffers bgfx_alloc_transient_buffers;
    da_bgfx_alloc_instance_data_buffer bgfx_alloc_instance_data_buffer;
    da_bgfx_create_shader bgfx_create_shader;
    da_bgfx_get_shader_uniforms bgfx_get_shader_uniforms;
    da_bgfx_destroy_shader bgfx_destroy_shader;
    da_bgfx_create_program bgfx_create_program;
    da_bgfx_destroy_program bgfx_destroy_program;
    da_bgfx_calc_texture_size bgfx_calc_texture_size;
    da_bgfx_create_texture bgfx_create_texture;
    da_bgfx_create_texture_2d bgfx_create_texture_2d;
    da_bgfx_create_texture_3d bgfx_create_texture_3d;
    da_bgfx_create_texture_cube bgfx_create_texture_cube;
    da_bgfx_update_texture_2d bgfx_update_texture_2d;
    da_bgfx_update_texture_3d bgfx_update_texture_3d;
    da_bgfx_update_texture_cube bgfx_update_texture_cube;
    da_bgfx_destroy_texture bgfx_destroy_texture;
    da_bgfx_create_frame_buffer bgfx_create_frame_buffer;
    da_bgfx_create_frame_buffer_from_handles bgfx_create_frame_buffer_from_handles;
    da_bgfx_destroy_frame_buffer bgfx_destroy_frame_buffer;
    da_bgfx_create_uniform bgfx_create_uniform;
    da_bgfx_destroy_uniform bgfx_destroy_uniform;
    da_bgfx_set_view_name bgfx_set_view_name;
    da_bgfx_set_view_rect bgfx_set_view_rect;
    da_bgfx_set_view_rect_mask bgfx_set_view_rect_mask;
    da_bgfx_set_view_scissor bgfx_set_view_scissor;
    da_bgfx_set_view_scissor_mask bgfx_set_view_scissor_mask;
    da_bgfx_set_view_clear bgfx_set_view_clear;
    da_bgfx_set_view_clear_mask bgfx_set_view_clear_mask;
    da_bgfx_set_view_seq bgfx_set_view_seq;
    da_bgfx_set_view_seq_mask bgfx_set_view_seq_mask;
    da_bgfx_set_view_frame_buffer bgfx_set_view_frame_buffer;
    da_bgfx_set_view_frame_buffer_mask bgfx_set_view_frame_buffer_mask;
    da_bgfx_set_view_transform bgfx_set_view_transform;
    da_bgfx_set_view_transform_mask bgfx_set_view_transform_mask;
    da_bgfx_set_marker bgfx_set_marker;
    da_bgfx_set_state bgfx_set_state;
    da_bgfx_set_stencil bgfx_set_stencil;
    da_bgfx_set_scissor bgfx_set_scissor;
    da_bgfx_set_scissor_cached bgfx_set_scissor_cached;
    da_bgfx_set_transform bgfx_set_transform;
    da_bgfx_set_transform_cached bgfx_set_transform_cached;
    da_bgfx_set_uniform bgfx_set_uniform;
    da_bgfx_set_index_buffer bgfx_set_index_buffer;
    da_bgfx_set_dynamic_index_buffer bgfx_set_dynamic_index_buffer;
    da_bgfx_set_transient_index_buffer bgfx_set_transient_index_buffer;
    da_bgfx_set_vertex_buffer bgfx_set_vertex_buffer;
    da_bgfx_set_dynamic_vertex_buffer bgfx_set_dynamic_vertex_buffer;
    da_bgfx_set_transient_vertex_buffer bgfx_set_transient_vertex_buffer;
    da_bgfx_set_instance_data_buffer bgfx_set_instance_data_buffer;
    da_bgfx_set_program bgfx_set_program;
    da_bgfx_set_texture bgfx_set_texture;
    da_bgfx_set_texture_from_frame_buffer bgfx_set_texture_from_frame_buffer;
    da_bgfx_submit bgfx_submit;
    da_bgfx_submit_mask bgfx_submit_mask;
    da_bgfx_set_image bgfx_set_image;
    da_bgfx_set_image_from_frame_buffer bgfx_set_image_from_frame_buffer;
    da_bgfx_dispatch bgfx_dispatch;
    da_bgfx_discard bgfx_discard;
    da_bgfx_save_screen_shot bgfx_save_screen_shot;

    da_bgfx_render_frame bgfx_render_frame;

    version (Android)
    {
        da_bgfx_android_set_window bgfx_android_set_window;
    }
    version(linux)
    {
        da_bgfx_x11_set_display_window bgfx_x11_set_display_window;
    }

    version(OSX)
    {
        da_bgfx_osx_set_ns_window bgfx_osx_set_ns_window;
    }

    version(Windows)
    {  
        da_bgfx_win_set_hwnd bgfx_win_set_hwnd;
    }
}
