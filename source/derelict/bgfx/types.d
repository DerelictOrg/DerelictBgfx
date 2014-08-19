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
module derelict.bgfx.types;


alias uint8_t = ubyte;
alias uint16_t = ushort;
alias uint32_t = uint;
alias uint64_t = ulong;
alias int8_t = byte;
alias int16_t = short;
alias int32_t = int;
alias int64_t = long;

// bgfxdefines.h

enum ulong BGFX_STATE_RGB_WRITE            = 0x0000000000000001;
enum ulong BGFX_STATE_ALPHA_WRITE          = 0x0000000000000002;
enum ulong BGFX_STATE_DEPTH_WRITE          = 0x0000000000000004;
enum ulong BGFX_STATE_DEPTH_TEST_LESS      = 0x0000000000000010;
enum ulong BGFX_STATE_DEPTH_TEST_LEQUAL    = 0x0000000000000020;
enum ulong BGFX_STATE_DEPTH_TEST_EQUAL     = 0x0000000000000030;
enum ulong BGFX_STATE_DEPTH_TEST_GEQUAL    = 0x0000000000000040;
enum ulong BGFX_STATE_DEPTH_TEST_GREATER   = 0x0000000000000050;
enum ulong BGFX_STATE_DEPTH_TEST_NOTEQUAL  = 0x0000000000000060;
enum ulong BGFX_STATE_DEPTH_TEST_NEVER     = 0x0000000000000070;
enum ulong BGFX_STATE_DEPTH_TEST_ALWAYS    = 0x0000000000000080;
enum BGFX_STATE_DEPTH_TEST_SHIFT     = 4;
enum ulong BGFX_STATE_DEPTH_TEST_MASK      = 0x00000000000000f0;
enum ulong BGFX_STATE_BLEND_ZERO           = 0x0000000000001000;
enum ulong BGFX_STATE_BLEND_ONE            = 0x0000000000002000;
enum ulong BGFX_STATE_BLEND_SRC_COLOR      = 0x0000000000003000;
enum ulong BGFX_STATE_BLEND_INV_SRC_COLOR  = 0x0000000000004000;
enum ulong BGFX_STATE_BLEND_SRC_ALPHA      = 0x0000000000005000;
enum ulong BGFX_STATE_BLEND_INV_SRC_ALPHA  = 0x0000000000006000;
enum ulong BGFX_STATE_BLEND_DST_ALPHA      = 0x0000000000007000;
enum ulong BGFX_STATE_BLEND_INV_DST_ALPHA  = 0x0000000000008000;
enum ulong BGFX_STATE_BLEND_DST_COLOR      = 0x0000000000009000;
enum ulong BGFX_STATE_BLEND_INV_DST_COLOR  = 0x000000000000a000;
enum ulong BGFX_STATE_BLEND_SRC_ALPHA_SAT  = 0x000000000000b000;
enum ulong BGFX_STATE_BLEND_FACTOR         = 0x000000000000c000;
enum ulong BGFX_STATE_BLEND_INV_FACTOR     = 0x000000000000d000;
enum BGFX_STATE_BLEND_SHIFT                = 12;
enum ulong BGFX_STATE_BLEND_MASK           = 0x000000000ffff000;

enum ulong BGFX_STATE_BLEND_EQUATION_SUB    = 0x0000000010000000;
enum ulong BGFX_STATE_BLEND_EQUATION_REVSUB = 0x0000000020000000;
enum ulong BGFX_STATE_BLEND_EQUATION_MIN    = 0x0000000030000000;
enum ulong BGFX_STATE_BLEND_EQUATION_MAX    = 0x0000000040000000;
enum BGFX_STATE_BLEND_EQUATION_SHIFT        = 28;
enum ulong BGFX_STATE_BLEND_EQUATION_MASK   = 0x00000003f0000000;

enum ulong BGFX_STATE_BLEND_INDEPENDENT     = 0x0000000400000000;

enum ulong BGFX_STATE_CULL_CW               = 0x0000001000000000;
enum ulong BGFX_STATE_CULL_CCW              = 0x0000002000000000;
enum BGFX_STATE_CULL_SHIFT                  = 36;
enum ulong BGFX_STATE_CULL_MASK             = 0x0000003000000000;

enum BGFX_STATE_ALPHA_REF_SHIFT             = 40;
enum ulong BGFX_STATE_ALPHA_REF_MASK        = 0x0000ff0000000000;

enum ulong BGFX_STATE_PT_TRISTRIP           = 0x0001000000000000;
enum ulong BGFX_STATE_PT_LINES              = 0x0002000000000000;
enum ulong BGFX_STATE_PT_POINTS             = 0x0003000000000000;
enum BGFX_STATE_PT_SHIFT                    = 48;
enum ulong BGFX_STATE_PT_MASK               = 0x0003000000000000;

enum BGFX_STATE_POINT_SIZE_SHIFT            = 52;
enum ulong BGFX_STATE_POINT_SIZE_MASK       = 0x0ff0000000000000;

enum ulong BGFX_STATE_MSAA                  = 0x1000000000000000;

enum ulong BGFX_STATE_RESERVED_MASK         = 0xe000000000000000;

enum ulong BGFX_STATE_NONE    = 0x0000000000000000;
enum ulong BGFX_STATE_MASK    = 0xffffffffffffffff;
enum ulong BGFX_STATE_DEFAULT = 0
          | BGFX_STATE_RGB_WRITE
          | BGFX_STATE_ALPHA_WRITE
          | BGFX_STATE_DEPTH_TEST_LESS
          | BGFX_STATE_DEPTH_WRITE
          | BGFX_STATE_CULL_CW
          | BGFX_STATE_MSAA;

ulong BGFX_STATE_ALPHA_REF(ulong _ref) pure nothrow
{
    return (_ref << BGFX_STATE_ALPHA_REF_SHIFT) & BGFX_STATE_ALPHA_REF_MASK;
} 

ulong BGFX_STATE_POINT_SIZE(ulong _size) pure nothrow
{
    return (_size << BGFX_STATE_POINT_SIZE_SHIFT) & BGFX_STATE_POINT_SIZE_MASK;
} 

ulong BGFX_STATE_BLEND_FUNC_SEPARATE(ulong _srcRGB, ulong _dstRGB, ulong _srcA, ulong _dstA) pure nothrow
{
    return _srcRGB | (_dstRGB << 4) | (_srcA << 8) | (_dstA << 12);
}

ulong BGFX_STATE_BLEND_EQUATION_SEPARATE(ulong _rgb, ulong _a) pure nothrow
{
    return _rgb | (_a << 3);
}

ulong BGFX_STATE_BLEND_FUNC(ulong _src, ulong _dst) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_SEPARATE(_src, _dst, _src, _dst);
}

ulong BGFX_STATE_BLEND_EQUATION(ulong _equation) pure nothrow
{
    return BGFX_STATE_BLEND_EQUATION_SEPARATE(_equation, _equation);
}


enum ulong BGFX_STATE_BLEND_ADD         = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE,       BGFX_STATE_BLEND_ONE          );
enum ulong BGFX_STATE_BLEND_ALPHA       = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_SRC_ALPHA, BGFX_STATE_BLEND_INV_SRC_ALPHA);
enum ulong BGFX_STATE_BLEND_DARKEN      = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE,       BGFX_STATE_BLEND_ONE          ) | BGFX_STATE_BLEND_EQUATION(BGFX_STATE_BLEND_EQUATION_MIN);
enum ulong BGFX_STATE_BLEND_LIGHTEN     = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE,       BGFX_STATE_BLEND_ONE          ) | BGFX_STATE_BLEND_EQUATION(BGFX_STATE_BLEND_EQUATION_MAX);
enum ulong BGFX_STATE_BLEND_MULTIPLY    = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_DST_COLOR, BGFX_STATE_BLEND_ZERO         );
enum ulong BGFX_STATE_BLEND_NORMAL      = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE,       BGFX_STATE_BLEND_INV_SRC_ALPHA);
enum ulong BGFX_STATE_BLEND_SCREEN      = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE,       BGFX_STATE_BLEND_INV_SRC_COLOR);
enum ulong BGFX_STATE_BLEND_LINEAR_BURN = BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_DST_COLOR, BGFX_STATE_BLEND_INV_DST_COLOR) | BGFX_STATE_BLEND_EQUATION(BGFX_STATE_BLEND_EQUATION_SUB);


uint BGFX_STATE_BLEND_FUNC_RT_x(uint _src, uint _dst) pure nothrow
{
    return (_src >> BGFX_STATE_BLEND_SHIFT) | ((_dst >> BGFX_STATE_BLEND_SHIFT) << 4);
}

uint BGFX_STATE_BLEND_FUNC_RT_xE(uint _src, uint _dst, uint _equation) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_RT_x(_src, _dst) | ((_equation >> BGFX_STATE_BLEND_EQUATION_SHIFT) << 8);
}

uint BGFX_STATE_BLEND_FUNC_RT_1(uint _src, uint _dst) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_RT_x(_src, _dst) << 0;
}

uint BGFX_STATE_BLEND_FUNC_RT_2(uint _src, uint _dst) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_RT_x(_src, _dst) << 11;
}

uint BGFX_STATE_BLEND_FUNC_RT_3(uint _src, uint _dst) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_RT_x(_src, _dst) << 22;
}

uint BGFX_STATE_BLEND_FUNC_RT_1E(uint _src, uint _dst, uint _equation) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_RT_xE(_src, _dst, _equation) << 0;
}

uint BGFX_STATE_BLEND_FUNC_RT_2E(uint _src, uint _dst, uint _equation) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_RT_xE(_src, _dst, _equation) << 11;
}

uint BGFX_STATE_BLEND_FUNC_RT_3E(uint _src, uint _dst, uint _equation) pure nothrow
{
    return BGFX_STATE_BLEND_FUNC_RT_xE(_src, _dst, _equation) << 22;
}

///
enum BGFX_STENCIL_FUNC_REF_SHIFT           = 0;
enum uint BGFX_STENCIL_FUNC_REF_MASK       = 0x000000ff;
enum BGFX_STENCIL_FUNC_RMASK_SHIFT         = 8;
enum uint BGFX_STENCIL_FUNC_RMASK_MASK     = 0x0000ff00;

enum uint BGFX_STENCIL_TEST_LESS           = 0x00010000;
enum uint BGFX_STENCIL_TEST_LEQUAL         = 0x00020000;
enum uint BGFX_STENCIL_TEST_EQUAL          = 0x00030000;
enum uint BGFX_STENCIL_TEST_GEQUAL         = 0x00040000;
enum uint BGFX_STENCIL_TEST_GREATER        = 0x00050000;
enum uint BGFX_STENCIL_TEST_NOTEQUAL       = 0x00060000;
enum uint BGFX_STENCIL_TEST_NEVER          = 0x00070000;
enum uint BGFX_STENCIL_TEST_ALWAYS         = 0x00080000;
enum BGFX_STENCIL_TEST_SHIFT               = 16;
enum uint BGFX_STENCIL_TEST_MASK           = 0x000f0000;

enum uint BGFX_STENCIL_OP_FAIL_S_ZERO      = 0x00000000;
enum uint BGFX_STENCIL_OP_FAIL_S_KEEP      = 0x00100000;
enum uint BGFX_STENCIL_OP_FAIL_S_REPLACE   = 0x00200000;
enum uint BGFX_STENCIL_OP_FAIL_S_INCR      = 0x00300000;
enum uint BGFX_STENCIL_OP_FAIL_S_INCRSAT   = 0x00400000;
enum uint BGFX_STENCIL_OP_FAIL_S_DECR      = 0x00500000;
enum uint BGFX_STENCIL_OP_FAIL_S_DECRSAT   = 0x00600000;
enum uint BGFX_STENCIL_OP_FAIL_S_INVERT    = 0x00700000;
enum BGFX_STENCIL_OP_FAIL_S_SHIFT          = 20;
enum uint BGFX_STENCIL_OP_FAIL_S_MASK      = 0x00f00000;

enum uint BGFX_STENCIL_OP_FAIL_Z_ZERO      = 0x00000000;
enum uint BGFX_STENCIL_OP_FAIL_Z_KEEP      = 0x01000000;
enum uint BGFX_STENCIL_OP_FAIL_Z_REPLACE   = 0x02000000;
enum uint BGFX_STENCIL_OP_FAIL_Z_INCR      = 0x03000000;
enum uint BGFX_STENCIL_OP_FAIL_Z_INCRSAT   = 0x04000000;
enum uint BGFX_STENCIL_OP_FAIL_Z_DECR      = 0x05000000;
enum uint BGFX_STENCIL_OP_FAIL_Z_DECRSAT   = 0x06000000;
enum uint BGFX_STENCIL_OP_FAIL_Z_INVERT    = 0x07000000;
enum BGFX_STENCIL_OP_FAIL_Z_SHIFT          = 24;
enum uint BGFX_STENCIL_OP_FAIL_Z_MASK      = 0x0f000000;

enum uint BGFX_STENCIL_OP_PASS_Z_ZERO      = 0x00000000;
enum uint BGFX_STENCIL_OP_PASS_Z_KEEP      = 0x10000000;
enum uint BGFX_STENCIL_OP_PASS_Z_REPLACE   = 0x20000000;
enum uint BGFX_STENCIL_OP_PASS_Z_INCR      = 0x30000000;
enum uint BGFX_STENCIL_OP_PASS_Z_INCRSAT   = 0x40000000;
enum uint BGFX_STENCIL_OP_PASS_Z_DECR      = 0x50000000;
enum uint BGFX_STENCIL_OP_PASS_Z_DECRSAT   = 0x60000000;
enum uint BGFX_STENCIL_OP_PASS_Z_INVERT    = 0x70000000;
enum BGFX_STENCIL_OP_PASS_Z_SHIFT          = 28;
enum uint BGFX_STENCIL_OP_PASS_Z_MASK      = 0xf0000000;

enum uint BGFX_STENCIL_NONE                = 0x00000000;
enum uint BGFX_STENCIL_MASK                = 0xffffffff;
enum uint BGFX_STENCIL_DEFAULT             = 0x00000000;

uint BGFX_STENCIL_FUNC_REF(uint _ref) pure nothrow
{
  return (_ref << BGFX_STENCIL_FUNC_REF_SHIFT) & BGFX_STENCIL_FUNC_REF_MASK;
}

uint BGFX_STENCIL_FUNC_RMASK(uint _mask) pure nothrow
{
  return (_mask << BGFX_STENCIL_FUNC_RMASK_SHIFT) & BGFX_STENCIL_FUNC_RMASK_MASK;
}


enum ubyte BGFX_CLEAR_NONE                  = 0x00;
enum ubyte BGFX_CLEAR_COLOR_BIT             = 0x01;
enum ubyte BGFX_CLEAR_DEPTH_BIT             = 0x02;
enum ubyte BGFX_CLEAR_STENCIL_BIT           = 0x04;

enum uint BGFX_DEBUG_NONE                  = 0x00000000;
enum uint BGFX_DEBUG_WIREFRAME             = 0x00000001;
enum uint BGFX_DEBUG_IFH                   = 0x00000002;
enum uint BGFX_DEBUG_STATS                 = 0x00000004;
enum uint BGFX_DEBUG_TEXT                  = 0x00000008;

enum uint BGFX_TEXTURE_NONE                = 0x00000000;
enum uint BGFX_TEXTURE_U_MIRROR            = 0x00000001;
enum uint BGFX_TEXTURE_U_CLAMP             = 0x00000002;
enum BGFX_TEXTURE_U_SHIFT                  = 0;
enum uint BGFX_TEXTURE_U_MASK              = 0x00000003;
enum uint BGFX_TEXTURE_V_MIRROR            = 0x00000004;
enum uint BGFX_TEXTURE_V_CLAMP             = 0x00000008;
enum BGFX_TEXTURE_V_SHIFT                  = 2;
enum uint BGFX_TEXTURE_V_MASK              = 0x0000000c;
enum uint BGFX_TEXTURE_W_MIRROR            = 0x00000010;
enum uint BGFX_TEXTURE_W_CLAMP             = 0x00000020;
enum BGFX_TEXTURE_W_SHIFT                  = 4;
enum uint BGFX_TEXTURE_W_MASK              = 0x00000030;
enum uint BGFX_TEXTURE_MIN_POINT           = 0x00000040;
enum uint BGFX_TEXTURE_MIN_ANISOTROPIC     = 0x00000080;
enum BGFX_TEXTURE_MIN_SHIFT                = 6;
enum uint BGFX_TEXTURE_MIN_MASK            = 0x000000c0;
enum uint BGFX_TEXTURE_MAG_POINT           = 0x00000100;
enum uint BGFX_TEXTURE_MAG_ANISOTROPIC     = 0x00000200;
enum BGFX_TEXTURE_MAG_SHIFT                = 8;
enum uint BGFX_TEXTURE_MAG_MASK            = 0x00000300;
enum uint BGFX_TEXTURE_MIP_POINT           = 0x00000400;
enum BGFX_TEXTURE_MIP_SHIFT                = 10;
enum uint BGFX_TEXTURE_MIP_MASK            = 0x00000400;
enum uint BGFX_TEXTURE_RT                  = 0x00001000;
enum uint BGFX_TEXTURE_RT_MSAA_X2          = 0x00002000;
enum uint BGFX_TEXTURE_RT_MSAA_X4          = 0x00003000;
enum uint BGFX_TEXTURE_RT_MSAA_X8          = 0x00004000;
enum uint BGFX_TEXTURE_RT_MSAA_X16         = 0x00005000;
enum BGFX_TEXTURE_RT_MSAA_SHIFT            = 12;
enum uint BGFX_TEXTURE_RT_MSAA_MASK        = 0x00007000;
enum uint BGFX_TEXTURE_RT_BUFFER_ONLY      = 0x00008000;
enum uint BGFX_TEXTURE_RT_MASK             = 0x0000f000;
enum uint BGFX_TEXTURE_COMPARE_LESS        = 0x00010000;
enum uint BGFX_TEXTURE_COMPARE_LEQUAL      = 0x00020000;
enum uint BGFX_TEXTURE_COMPARE_EQUAL       = 0x00030000;
enum uint BGFX_TEXTURE_COMPARE_GEQUAL      = 0x00040000;
enum uint BGFX_TEXTURE_COMPARE_GREATER     = 0x00050000;
enum uint BGFX_TEXTURE_COMPARE_NOTEQUAL    = 0x00060000;
enum uint BGFX_TEXTURE_COMPARE_NEVER       = 0x00070000;
enum uint BGFX_TEXTURE_COMPARE_ALWAYS      = 0x00080000;
enum BGFX_TEXTURE_COMPARE_SHIFT            = 16;
enum uint BGFX_TEXTURE_COMPARE_MASK        = 0x000f0000;
enum uint BGFX_TEXTURE_COMPUTE_WRITE       = 0x00100000;
enum BGFX_TEXTURE_RESERVED_SHIFT           = 24;
enum uint BGFX_TEXTURE_RESERVED_MASK       = 0xff000000;

enum uint BGFX_TEXTURE_SAMPLER_BITS_MASK = 0 
      | BGFX_TEXTURE_U_MASK
      | BGFX_TEXTURE_V_MASK
      | BGFX_TEXTURE_W_MASK
      | BGFX_TEXTURE_MIN_MASK
      | BGFX_TEXTURE_MAG_MASK
      | BGFX_TEXTURE_MIP_MASK
      | BGFX_TEXTURE_COMPARE_MASK;

enum uint BGFX_RESET_NONE                  = 0x00000000;
enum uint BGFX_RESET_FULLSCREEN            = 0x00000001;
enum BGFX_RESET_FULLSCREEN_SHIFT           = 0;
enum uint BGFX_RESET_FULLSCREEN_MASK       = 0x00000001;
enum uint BGFX_RESET_MSAA_X2               = 0x00000010;
enum uint BGFX_RESET_MSAA_X4               = 0x00000020;
enum uint BGFX_RESET_MSAA_X8               = 0x00000030;
enum uint BGFX_RESET_MSAA_X16              = 0x00000040;
enum BGFX_RESET_MSAA_SHIFT                 = 4;
enum uint BGFX_RESET_MSAA_MASK             = 0x00000070;
enum uint BGFX_RESET_VSYNC                 = 0x00000080;
enum uint BGFX_RESET_CAPTURE               = 0x00000100;

///
enum ulong BGFX_CAPS_TEXTURE_COMPARE_LEQUAL = 0x0000000000000001;
enum ulong BGFX_CAPS_TEXTURE_COMPARE_ALL    = 0x0000000000000003;
enum ulong BGFX_CAPS_TEXTURE_3D             = 0x0000000000000004;
enum ulong BGFX_CAPS_VERTEX_ATTRIB_HALF     = 0x0000000000000008;
enum ulong BGFX_CAPS_INSTANCING             = 0x0000000000000010;
enum ulong BGFX_CAPS_RENDERER_MULTITHREADED = 0x0000000000000020;
enum ulong BGFX_CAPS_FRAGMENT_DEPTH         = 0x0000000000000040;
enum ulong BGFX_CAPS_BLEND_INDEPENDENT      = 0x0000000000000080;
enum ulong BGFX_CAPS_COMPUTE                = 0x0000000000000100;
enum ulong BGFX_CAPS_FRAGMENT_ORDERING      = 0x0000000000000200;

// bgfx.c99.h

alias bgfx_renderer_type_t = int;
enum : bgfx_renderer_type_t
{
    BGFX_RENDERER_TYPE_NULL,
    BGFX_RENDERER_TYPE_DIRECT3D9,
    BGFX_RENDERER_TYPE_DIRECT3D11,
    BGFX_RENDERER_TYPE_OPENGLES,
    BGFX_RENDERER_TYPE_OPENGL,

    BGFX_RENDERER_TYPE_COUNT

}

alias bgfx_access_t = int;
enum : bgfx_access_t
{
    BGFX_ACCESS_READ,
    BGFX_ACCESS_WRITE,
    BGFX_ACCESS_READWRITE,

    BGFX_ACCESS_COUNT

}

alias bgfx_attrib_t = int;
enum : bgfx_attrib_t
{
    BGFX_ATTRIB_POSITION,
    BGFX_ATTRIB_NORMAL,
    BGFX_ATTRIB_TANGENT,
    BGFX_ATTRIB_BITANGENT,
    BGFX_ATTRIB_COLOR0,
    BGFX_ATTRIB_COLOR1,
    BGFX_ATTRIB_INDICES,
    BGFX_ATTRIB_WEIGHT,
    BGFX_ATTRIB_TEXCOORD0,
    BGFX_ATTRIB_TEXCOORD1,
    BGFX_ATTRIB_TEXCOORD2,
    BGFX_ATTRIB_TEXCOORD3,
    BGFX_ATTRIB_TEXCOORD4,
    BGFX_ATTRIB_TEXCOORD5,
    BGFX_ATTRIB_TEXCOORD6,
    BGFX_ATTRIB_TEXCOORD7,

    BGFX_ATTRIB_COUNT

}

alias bgfx_attrib_type_t = int;
enum : bgfx_attrib_type_t
{
    BGFX_ATTRIB_TYPE_UINT8,
    BGFX_ATTRIB_TYPE_INT16,
    BGFX_ATTRIB_TYPE_HALF,
    BGFX_ATTRIB_TYPE_FLOAT,

    BGFX_ATTRIB_TYPE_COUNT

}

alias bgfx_texture_format_t = int;
enum : bgfx_texture_format_t
{
    BGFX_TEXTURE_FORMAT_BC1,
    BGFX_TEXTURE_FORMAT_BC2,
    BGFX_TEXTURE_FORMAT_BC3,
    BGFX_TEXTURE_FORMAT_BC4,
    BGFX_TEXTURE_FORMAT_BC5,
    BGFX_TEXTURE_FORMAT_BC6H,
    BGFX_TEXTURE_FORMAT_BC7,
    BGFX_TEXTURE_FORMAT_ETC1,
    BGFX_TEXTURE_FORMAT_ETC2,
    BGFX_TEXTURE_FORMAT_ETC2A,
    BGFX_TEXTURE_FORMAT_ETC2A1,
    BGFX_TEXTURE_FORMAT_PTC12,
    BGFX_TEXTURE_FORMAT_PTC14,
    BGFX_TEXTURE_FORMAT_PTC12A,
    BGFX_TEXTURE_FORMAT_PTC14A,
    BGFX_TEXTURE_FORMAT_PTC22,
    BGFX_TEXTURE_FORMAT_PTC24,

    BGFX_TEXTURE_FORMAT_UNKNOWN,

    BGFX_TEXTURE_FORMAT_R1,
    BGFX_TEXTURE_FORMAT_R8,
    BGFX_TEXTURE_FORMAT_R16,
    BGFX_TEXTURE_FORMAT_R16F,
    BGFX_TEXTURE_FORMAT_R32,
    BGFX_TEXTURE_FORMAT_R32F,
    BGFX_TEXTURE_FORMAT_RG8,
    BGFX_TEXTURE_FORMAT_RG16,
    BGFX_TEXTURE_FORMAT_RG16F,
    BGFX_TEXTURE_FORMAT_RG32,
    BGFX_TEXTURE_FORMAT_RG32F,
    BGFX_TEXTURE_FORMAT_BGRA8,
    BGFX_TEXTURE_FORMAT_RGBA16,
    BGFX_TEXTURE_FORMAT_RGBA16F,
    BGFX_TEXTURE_FORMAT_RGBA32,
    BGFX_TEXTURE_FORMAT_RGBA32F,
    BGFX_TEXTURE_FORMAT_R5G6B5,
    BGFX_TEXTURE_FORMAT_RGBA4,
    BGFX_TEXTURE_FORMAT_RGB5A1,
    BGFX_TEXTURE_FORMAT_RGB10A2,

    BGFX_TEXTURE_FORMAT_UNKNOWN_DEPTH,

    BGFX_TEXTURE_FORMAT_D16,
    BGFX_TEXTURE_FORMAT_D24,
    BGFX_TEXTURE_FORMAT_D24S8,
    BGFX_TEXTURE_FORMAT_D32,
    BGFX_TEXTURE_FORMAT_D16F,
    BGFX_TEXTURE_FORMAT_D24F,
    BGFX_TEXTURE_FORMAT_D32F,
    BGFX_TEXTURE_FORMAT_D0S8,

    BGFX_TEXTURE_FORMAT_COUNT

}

alias bgfx_uniform_type_t = int;
enum : bgfx_uniform_type_t
{
    BGFX_UNIFORM_TYPE_UNIFORM1I,
    BGFX_UNIFORM_TYPE_UNIFORM1F,
    BGFX_UNIFORM_TYPE_END,

    BGFX_UNIFORM_TYPE_UNIFORM1IV,
    BGFX_UNIFORM_TYPE_UNIFORM1FV,
    BGFX_UNIFORM_TYPE_UNIFORM2FV,
    BGFX_UNIFORM_TYPE_UNIFORM3FV,
    BGFX_UNIFORM_TYPE_UNIFORM4FV,
    BGFX_UNIFORM_TYPE_UNIFORM3X3FV,
    BGFX_UNIFORM_TYPE_UNIFORM4X4FV,

    BGFX_UNIFORM_TYPE_COUNT

}

struct bgfx_dynamic_index_buffer_handle_t
{
    ushort idx;
}

struct bgfx_dynamic_vertex_buffer_handle_t
{
    ushort idx;
}

struct bgfx_frame_buffer_handle_t 
{
    ushort idx;
}

struct bgfx_index_buffer_handle_t 
{
    ushort idx;
}

struct bgfx_program_handle_t 
{
    ushort idx;
}

struct bgfx_shader_handle_t 
{
    ushort idx;
}

struct bgfx_texture_handle_t 
{
    ushort idx;
}

struct bgfx_uniform_handle_t 
{
    ushort idx;
}

struct bgfx_vertex_buffer_handle_t 
{
    ushort idx;
}

struct bgfx_vertex_decl_handle_t 
{
    ushort idx;
}

struct bgfx_memory_t
{
    uint8_t* data;
    uint32_t size;
}

/**
 * Vertex declaration.
 */
struct bgfx_vertex_decl_t
{
    uint32_t hash;
    uint16_t stride;
    uint16_t offset[BGFX_ATTRIB_COUNT];
    uint8_t  attributes[BGFX_ATTRIB_COUNT];
}

/**
 */
struct bgfx_transient_index_buffer_t
{
    uint8_t* data;
    uint32_t size;
    bgfx_index_buffer_handle_t handle;
    uint32_t startIndex;
}

/**
 */
struct bgfx_transient_vertex_buffer_t
{
    uint8_t* data;
    uint32_t size;
    uint32_t startVertex;
    uint16_t stride;
    bgfx_vertex_buffer_handle_t handle;
    bgfx_vertex_decl_handle_t decl;

}

/**
 */
struct bgfx_instance_data_buffer_t
{
    uint8_t* data;
    uint32_t size;
    uint32_t offset;
    uint16_t stride;
    uint16_t num;
    bgfx_vertex_buffer_handle_t handle;

}

/**
 */
struct bgfx_texture_info_t
{
    bgfx_texture_format_t format;
    uint32_t storageSize;
    uint16_t width;
    uint16_t height;
    uint16_t depth;
    uint8_t numMips;
    uint8_t bitsPerPixel;

}

/**
 *  Renderer capabilities.
 */
struct bgfx_caps_t
{
    /**
     *  Renderer backend type.
     */
    bgfx_renderer_type_t rendererType;

    /**
     *  Supported functionality, it includes emulated functionality.
     *  Checking supported and not emulated will give functionality
     *  natively supported by renderer.
     */
    uint64_t supported;

    /**
     *  Emulated functionality. For example some texture compression
     *  modes are not natively supported by all renderers. The library
     *  internally decompresses texture into supported format.
     */
    uint64_t emulated;

    uint16_t maxTextureSize;    /* < Maximum texture size.             */
    uint16_t maxDrawCalls;      /* < Maximum draw calls.               */
    uint8_t  maxFBAttachments;  /* < Maximum frame buffer attachments. */

    /**
     * Supported texture formats.
     * 0 - not supported
     * 1 - supported
     * 2 - emulated
     */
     uint8_t formats[BGFX_TEXTURE_FORMAT_COUNT];
}

/**
 */

alias bgfx_fatal_t = int;
enum : bgfx_fatal_t
{
    BGFX_FATAL_DEBUG_CHECK,
    BGFX_FATAL_MINIMUM_REQUIRED_SPECS,
    BGFX_FATAL_INVALID_SHADER,
    BGFX_FATAL_UNABLE_TO_INITIALIZE,
    BGFX_FATAL_UNABLE_TO_CREATE_TEXTURE,
}

//TODO: use namespace when DMD 2.066 is released
extern(C++)/*, bgfx)*/ interface CallbackI
{    
    void fatal(bgfx_fatal_t _code, const(char)* _str);
    uint32_t cacheReadSize(uint64_t _id);
    bool cacheRead(uint64_t _id, void* _data, uint32_t _size);
    void cacheWrite(uint64_t _id, const(void)* _data, uint32_t _size);
    void screenShot(const(char)* _filePath, uint32_t _width, uint32_t _height, uint32_t _pitch, const(void)* _data, uint32_t _size, bool _yflip);
    void captureBegin(uint32_t _width, uint32_t _height, uint32_t _pitch, bgfx_texture_format_t _format, bool _yflip);
    void captureEnd();
    void captureFrame(const(void)* _data, uint32_t _size);
}

//TODO: use namespace when DMD 2.066 is released
extern(C++ /*, bx */) interface ReallocatorI
{    
    void* alloc(size_t _size, size_t _align, const(char)* _file, uint32_t _line);
    void free(void* _ptr, size_t _align, const(char)* _file, uint32_t _line);
    void* realloc(void* _ptr, size_t _size, size_t _align, const(char)* _file, uint32_t _line);
}

// bgfxplatform.c99.h

alias bgfx_render_frame_t = int;
enum : bgfx_render_frame_t
{
    BGFX_RENDER_FRAME_NO_CONTEXT,
    BGFX_RENDER_FRAME_RENDER,
    BGFX_RENDER_FRAME_EXITING,

    BGFX_RENDER_FRAME_COUNT
}

