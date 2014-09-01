/*
 * Copyright 2011-2014 Branimir Karadzic. All rights reserved.
 * License: http://www.opensource.org/licenses/BSD-2-Clause
 */

module metaballs;

import std.typecons;
import std.math;
import gfm.core;
import gfm.sdl2;
import gfm.math;


import derelict.bgfx.bgfx;

import vs_metaballs;
import fs_metaballs;




struct PosNormalColorVertex
{
	vec3f m_pos;
	vec3f m_normal;
	uint32_t m_abgr;

	static void init()
	{
        bgfx_vertex_decl_begin(&ms_decl);
        bgfx_vertex_decl_add(&ms_decl, BGFX_ATTRIB_POSITION, 3, BGFX_ATTRIB_TYPE_FLOAT);
        bgfx_vertex_decl_add(&ms_decl, BGFX_ATTRIB_NORMAL, 3, BGFX_ATTRIB_TYPE_FLOAT);
        bgfx_vertex_decl_add(&ms_decl, BGFX_ATTRIB_COLOR0, 3, BGFX_ATTRIB_TYPE_UINT8, true);
        bgfx_vertex_decl_end(&ms_decl);
	};

	static bgfx_vertex_decl_t ms_decl;
};


struct Grid
{
	float m_val = 0;
	vec3f m_normal = vec3f(0, 0, 0);
};

// Triangulation tables taken from:
// http://paulbourke.net/geometry/polygonise/

static immutable uint16_t[256] s_edges =
[
	0x000, 0x109, 0x203, 0x30a, 0x406, 0x50f, 0x605, 0x70c,
	0x80c, 0x905, 0xa0f, 0xb06, 0xc0a, 0xd03, 0xe09, 0xf00,
	0x190, 0x099, 0x393, 0x29a, 0x596, 0x49f, 0x795, 0x69c,
	0x99c, 0x895, 0xb9f, 0xa96, 0xd9a, 0xc93, 0xf99, 0xe90,
	0x230, 0x339, 0x033, 0x13a, 0x636, 0x73f, 0x435, 0x53c,
	0xa3c, 0xb35, 0x83f, 0x936, 0xe3a, 0xf33, 0xc39, 0xd30,
	0x3a0, 0x2a9, 0x1a3, 0x0aa, 0x7a6, 0x6af, 0x5a5, 0x4ac,
	0xbac, 0xaa5, 0x9af, 0x8a6, 0xfaa, 0xea3, 0xda9, 0xca0,
	0x460, 0x569, 0x663, 0x76a, 0x66 , 0x16f, 0x265, 0x36c,
	0xc6c, 0xd65, 0xe6f, 0xf66, 0x86a, 0x963, 0xa69, 0xb60,
	0x5f0, 0x4f9, 0x7f3, 0x6fa, 0x1f6, 0x0ff, 0x3f5, 0x2fc,
	0xdfc, 0xcf5, 0xfff, 0xef6, 0x9fa, 0x8f3, 0xbf9, 0xaf0,
	0x650, 0x759, 0x453, 0x55a, 0x256, 0x35f, 0x055, 0x15c,
	0xe5c, 0xf55, 0xc5f, 0xd56, 0xa5a, 0xb53, 0x859, 0x950,
	0x7c0, 0x6c9, 0x5c3, 0x4ca, 0x3c6, 0x2cf, 0x1c5, 0x0cc,
	0xfcc, 0xec5, 0xdcf, 0xcc6, 0xbca, 0xac3, 0x9c9, 0x8c0,
	0x8c0, 0x9c9, 0xac3, 0xbca, 0xcc6, 0xdcf, 0xec5, 0xfcc,
	0x0cc, 0x1c5, 0x2cf, 0x3c6, 0x4ca, 0x5c3, 0x6c9, 0x7c0,
	0x950, 0x859, 0xb53, 0xa5a, 0xd56, 0xc5f, 0xf55, 0xe5c,
	0x15c, 0x55 , 0x35f, 0x256, 0x55a, 0x453, 0x759, 0x650,
	0xaf0, 0xbf9, 0x8f3, 0x9fa, 0xef6, 0xfff, 0xcf5, 0xdfc,
	0x2fc, 0x3f5, 0x0ff, 0x1f6, 0x6fa, 0x7f3, 0x4f9, 0x5f0,
	0xb60, 0xa69, 0x963, 0x86a, 0xf66, 0xe6f, 0xd65, 0xc6c,
	0x36c, 0x265, 0x16f, 0x066, 0x76a, 0x663, 0x569, 0x460,
	0xca0, 0xda9, 0xea3, 0xfaa, 0x8a6, 0x9af, 0xaa5, 0xbac,
	0x4ac, 0x5a5, 0x6af, 0x7a6, 0x0aa, 0x1a3, 0x2a9, 0x3a0,
	0xd30, 0xc39, 0xf33, 0xe3a, 0x936, 0x83f, 0xb35, 0xa3c,
	0x53c, 0x435, 0x73f, 0x636, 0x13a, 0x033, 0x339, 0x230,
	0xe90, 0xf99, 0xc93, 0xd9a, 0xa96, 0xb9f, 0x895, 0x99c,
	0x69c, 0x795, 0x49f, 0x596, 0x29a, 0x393, 0x099, 0x190,
	0xf00, 0xe09, 0xd03, 0xc0a, 0xb06, 0xa0f, 0x905, 0x80c,
	0x70c, 0x605, 0x50f, 0x406, 0x30a, 0x203, 0x109, 0x000,
];

static immutable int8_t[16][256] s_indices =
[
	[  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  1,  9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  8,  3,  9,  8,  1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  3,  1,  2, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  2, 10,  0,  2,  9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  8,  3,  2, 10,  8, 10,  9,  8, -1, -1, -1, -1, -1, -1, -1 ],
	[   3, 11,  2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0, 11,  2,  8, 11,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  9,  0,  2,  3, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1, 11,  2,  1,  9, 11,  9,  8, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[   3, 10,  1, 11, 10,  3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0, 10,  1,  0,  8, 10,  8, 11, 10, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  9,  0,  3, 11,  9, 11, 10,  9, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  8, 10, 10,  8, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  7,  8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  3,  0,  7,  3,  4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  1,  9,  8,  4,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  1,  9,  4,  7,  1,  7,  3,  1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2, 10,  8,  4,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  4,  7,  3,  0,  4,  1,  2, 10, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  2, 10,  9,  0,  2,  8,  4,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[   2, 10,  9,  2,  9,  7,  2,  7,  3,  7,  9,  4, -1, -1, -1, -1 ],
	[   8,  4,  7,  3, 11,  2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[  11,  4,  7, 11,  2,  4,  2,  0,  4, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  0,  1,  8,  4,  7,  2,  3, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  7, 11,  9,  4, 11,  9, 11,  2,  9,  2,  1, -1, -1, -1, -1 ],
	[   3, 10,  1,  3, 11, 10,  7,  8,  4, -1, -1, -1, -1, -1, -1, -1 ],
	[   1, 11, 10,  1,  4, 11,  1,  0,  4,  7, 11,  4, -1, -1, -1, -1 ],
	[   4,  7,  8,  9,  0, 11,  9, 11, 10, 11,  0,  3, -1, -1, -1, -1 ],
	[   4,  7, 11,  4, 11,  9,  9, 11, 10, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  5,  4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  5,  4,  0,  8,  3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  5,  4,  1,  5,  0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  5,  4,  8,  3,  5,  3,  1,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2, 10,  9,  5,  4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  0,  8,  1,  2, 10,  4,  9,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   5,  2, 10,  5,  4,  2,  4,  0,  2, -1, -1, -1, -1, -1, -1, -1 ],
	[   2, 10,  5,  3,  2,  5,  3,  5,  4,  3,  4,  8, -1, -1, -1, -1 ],
	[   9,  5,  4,  2,  3, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0, 11,  2,  0,  8, 11,  4,  9,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  5,  4,  0,  1,  5,  2,  3, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  1,  5,  2,  5,  8,  2,  8, 11,  4,  8,  5, -1, -1, -1, -1 ],
	[  10,  3, 11, 10,  1,  3,  9,  5,  4, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  9,  5,  0,  8,  1,  8, 10,  1,  8, 11, 10, -1, -1, -1, -1 ],
	[   5,  4,  0,  5,  0, 11,  5, 11, 10, 11,  0,  3, -1, -1, -1, -1 ],
	[   5,  4,  8,  5,  8, 10, 10,  8, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  7,  8,  5,  7,  9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  3,  0,  9,  5,  3,  5,  7,  3, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  7,  8,  0,  1,  7,  1,  5,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  5,  3,  3,  5,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  7,  8,  9,  5,  7, 10,  1,  2, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  1,  2,  9,  5,  0,  5,  3,  0,  5,  7,  3, -1, -1, -1, -1 ],
	[   8,  0,  2,  8,  2,  5,  8,  5,  7, 10,  5,  2, -1, -1, -1, -1 ],
	[   2, 10,  5,  2,  5,  3,  3,  5,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[   7,  9,  5,  7,  8,  9,  3, 11,  2, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  5,  7,  9,  7,  2,  9,  2,  0,  2,  7, 11, -1, -1, -1, -1 ],
	[   2,  3, 11,  0,  1,  8,  1,  7,  8,  1,  5,  7, -1, -1, -1, -1 ],
	[  11,  2,  1, 11,  1,  7,  7,  1,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  5,  8,  8,  5,  7, 10,  1,  3, 10,  3, 11, -1, -1, -1, -1 ],
	[   5,  7,  0,  5,  0,  9,  7, 11,  0,  1,  0, 10, 11, 10,  0, -1 ],
	[  11, 10,  0, 11,  0,  3, 10,  5,  0,  8,  0,  7,  5,  7,  0, -1 ],
	[  11, 10,  5,  7, 11,  5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  6,  5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  3,  5, 10,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  0,  1,  5, 10,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  8,  3,  1,  9,  8,  5, 10,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  6,  5,  2,  6,  1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  6,  5,  1,  2,  6,  3,  0,  8, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  6,  5,  9,  0,  6,  0,  2,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[   5,  9,  8,  5,  8,  2,  5,  2,  6,  3,  2,  8, -1, -1, -1, -1 ],
	[   2,  3, 11, 10,  6,  5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[  11,  0,  8, 11,  2,  0, 10,  6,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  1,  9,  2,  3, 11,  5, 10,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[   5, 10,  6,  1,  9,  2,  9, 11,  2,  9,  8, 11, -1, -1, -1, -1 ],
	[   6,  3, 11,  6,  5,  3,  5,  1,  3, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8, 11,  0, 11,  5,  0,  5,  1,  5, 11,  6, -1, -1, -1, -1 ],
	[   3, 11,  6,  0,  3,  6,  0,  6,  5,  0,  5,  9, -1, -1, -1, -1 ],
	[   6,  5,  9,  6,  9, 11, 11,  9,  8, -1, -1, -1, -1, -1, -1, -1 ],
	[   5, 10,  6,  4,  7,  8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  3,  0,  4,  7,  3,  6,  5, 10, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  9,  0,  5, 10,  6,  8,  4,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  6,  5,  1,  9,  7,  1,  7,  3,  7,  9,  4, -1, -1, -1, -1 ],
	[   6,  1,  2,  6,  5,  1,  4,  7,  8, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2,  5,  5,  2,  6,  3,  0,  4,  3,  4,  7, -1, -1, -1, -1 ],
	[   8,  4,  7,  9,  0,  5,  0,  6,  5,  0,  2,  6, -1, -1, -1, -1 ],
	[   7,  3,  9,  7,  9,  4,  3,  2,  9,  5,  9,  6,  2,  6,  9, -1 ],
	[   3, 11,  2,  7,  8,  4, 10,  6,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   5, 10,  6,  4,  7,  2,  4,  2,  0,  2,  7, 11, -1, -1, -1, -1 ],
	[   0,  1,  9,  4,  7,  8,  2,  3, 11,  5, 10,  6, -1, -1, -1, -1 ],
	[   9,  2,  1,  9, 11,  2,  9,  4, 11,  7, 11,  4,  5, 10,  6, -1 ],
	[   8,  4,  7,  3, 11,  5,  3,  5,  1,  5, 11,  6, -1, -1, -1, -1 ],
	[   5,  1, 11,  5, 11,  6,  1,  0, 11,  7, 11,  4,  0,  4, 11, -1 ],
	[   0,  5,  9,  0,  6,  5,  0,  3,  6, 11,  6,  3,  8,  4,  7, -1 ],
	[   6,  5,  9,  6,  9, 11,  4,  7,  9,  7, 11,  9, -1, -1, -1, -1 ],
	[  10,  4,  9,  6,  4, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4, 10,  6,  4,  9, 10,  0,  8,  3, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  0,  1, 10,  6,  0,  6,  4,  0, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  3,  1,  8,  1,  6,  8,  6,  4,  6,  1, 10, -1, -1, -1, -1 ],
	[   1,  4,  9,  1,  2,  4,  2,  6,  4, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  0,  8,  1,  2,  9,  2,  4,  9,  2,  6,  4, -1, -1, -1, -1 ],
	[   0,  2,  4,  4,  2,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  3,  2,  8,  2,  4,  4,  2,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  4,  9, 10,  6,  4, 11,  2,  3, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  2,  2,  8, 11,  4,  9, 10,  4, 10,  6, -1, -1, -1, -1 ],
	[   3, 11,  2,  0,  1,  6,  0,  6,  4,  6,  1, 10, -1, -1, -1, -1 ],
	[   6,  4,  1,  6,  1, 10,  4,  8,  1,  2,  1, 11,  8, 11,  1, -1 ],
	[   9,  6,  4,  9,  3,  6,  9,  1,  3, 11,  6,  3, -1, -1, -1, -1 ],
	[   8, 11,  1,  8,  1,  0, 11,  6,  1,  9,  1,  4,  6,  4,  1, -1 ],
	[   3, 11,  6,  3,  6,  0,  0,  6,  4, -1, -1, -1, -1, -1, -1, -1 ],
	[   6,  4,  8, 11,  6,  8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   7, 10,  6,  7,  8, 10,  8,  9, 10, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  7,  3,  0, 10,  7,  0,  9, 10,  6,  7, 10, -1, -1, -1, -1 ],
	[  10,  6,  7,  1, 10,  7,  1,  7,  8,  1,  8,  0, -1, -1, -1, -1 ],
	[  10,  6,  7, 10,  7,  1,  1,  7,  3, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2,  6,  1,  6,  8,  1,  8,  9,  8,  6,  7, -1, -1, -1, -1 ],
	[   2,  6,  9,  2,  9,  1,  6,  7,  9,  0,  9,  3,  7,  3,  9, -1 ],
	[   7,  8,  0,  7,  0,  6,  6,  0,  2, -1, -1, -1, -1, -1, -1, -1 ],
	[   7,  3,  2,  6,  7,  2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  3, 11, 10,  6,  8, 10,  8,  9,  8,  6,  7, -1, -1, -1, -1 ],
	[   2,  0,  7,  2,  7, 11,  0,  9,  7,  6,  7, 10,  9, 10,  7, -1 ],
	[   1,  8,  0,  1,  7,  8,  1, 10,  7,  6,  7, 10,  2,  3, 11, -1 ],
	[  11,  2,  1, 11,  1,  7, 10,  6,  1,  6,  7,  1, -1, -1, -1, -1 ],
	[   8,  9,  6,  8,  6,  7,  9,  1,  6, 11,  6,  3,  1,  3,  6, -1 ],
	[   0,  9,  1, 11,  6,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   7,  8,  0,  7,  0,  6,  3, 11,  0, 11,  6,  0, -1, -1, -1, -1 ],
	[   7, 11,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   7,  6, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  0,  8, 11,  7,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  1,  9, 11,  7,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  1,  9,  8,  3,  1, 11,  7,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  1,  2,  6, 11,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2, 10,  3,  0,  8,  6, 11,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  9,  0,  2, 10,  9,  6, 11,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[   6, 11,  7,  2, 10,  3, 10,  8,  3, 10,  9,  8, -1, -1, -1, -1 ],
	[   7,  2,  3,  6,  2,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   7,  0,  8,  7,  6,  0,  6,  2,  0, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  7,  6,  2,  3,  7,  0,  1,  9, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  6,  2,  1,  8,  6,  1,  9,  8,  8,  7,  6, -1, -1, -1, -1 ],
	[  10,  7,  6, 10,  1,  7,  1,  3,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  7,  6,  1,  7, 10,  1,  8,  7,  1,  0,  8, -1, -1, -1, -1 ],
	[   0,  3,  7,  0,  7, 10,  0, 10,  9,  6, 10,  7, -1, -1, -1, -1 ],
	[   7,  6, 10,  7, 10,  8,  8, 10,  9, -1, -1, -1, -1, -1, -1, -1 ],
	[   6,  8,  4, 11,  8,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  6, 11,  3,  0,  6,  0,  4,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  6, 11,  8,  4,  6,  9,  0,  1, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  4,  6,  9,  6,  3,  9,  3,  1, 11,  3,  6, -1, -1, -1, -1 ],
	[   6,  8,  4,  6, 11,  8,  2, 10,  1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2, 10,  3,  0, 11,  0,  6, 11,  0,  4,  6, -1, -1, -1, -1 ],
	[   4, 11,  8,  4,  6, 11,  0,  2,  9,  2, 10,  9, -1, -1, -1, -1 ],
	[  10,  9,  3, 10,  3,  2,  9,  4,  3, 11,  3,  6,  4,  6,  3, -1 ],
	[   8,  2,  3,  8,  4,  2,  4,  6,  2, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  4,  2,  4,  6,  2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  9,  0,  2,  3,  4,  2,  4,  6,  4,  3,  8, -1, -1, -1, -1 ],
	[   1,  9,  4,  1,  4,  2,  2,  4,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  1,  3,  8,  6,  1,  8,  4,  6,  6, 10,  1, -1, -1, -1, -1 ],
	[  10,  1,  0, 10,  0,  6,  6,  0,  4, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  6,  3,  4,  3,  8,  6, 10,  3,  0,  3,  9, 10,  9,  3, -1 ],
	[  10,  9,  4,  6, 10,  4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  9,  5,  7,  6, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  3,  4,  9,  5, 11,  7,  6, -1, -1, -1, -1, -1, -1, -1 ],
	[   5,  0,  1,  5,  4,  0,  7,  6, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[  11,  7,  6,  8,  3,  4,  3,  5,  4,  3,  1,  5, -1, -1, -1, -1 ],
	[   9,  5,  4, 10,  1,  2,  7,  6, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[   6, 11,  7,  1,  2, 10,  0,  8,  3,  4,  9,  5, -1, -1, -1, -1 ],
	[   7,  6, 11,  5,  4, 10,  4,  2, 10,  4,  0,  2, -1, -1, -1, -1 ],
	[   3,  4,  8,  3,  5,  4,  3,  2,  5, 10,  5,  2, 11,  7,  6, -1 ],
	[   7,  2,  3,  7,  6,  2,  5,  4,  9, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  5,  4,  0,  8,  6,  0,  6,  2,  6,  8,  7, -1, -1, -1, -1 ],
	[   3,  6,  2,  3,  7,  6,  1,  5,  0,  5,  4,  0, -1, -1, -1, -1 ],
	[   6,  2,  8,  6,  8,  7,  2,  1,  8,  4,  8,  5,  1,  5,  8, -1 ],
	[   9,  5,  4, 10,  1,  6,  1,  7,  6,  1,  3,  7, -1, -1, -1, -1 ],
	[   1,  6, 10,  1,  7,  6,  1,  0,  7,  8,  7,  0,  9,  5,  4, -1 ],
	[   4,  0, 10,  4, 10,  5,  0,  3, 10,  6, 10,  7,  3,  7, 10, -1 ],
	[   7,  6, 10,  7, 10,  8,  5,  4, 10,  4,  8, 10, -1, -1, -1, -1 ],
	[   6,  9,  5,  6, 11,  9, 11,  8,  9, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  6, 11,  0,  6,  3,  0,  5,  6,  0,  9,  5, -1, -1, -1, -1 ],
	[   0, 11,  8,  0,  5, 11,  0,  1,  5,  5,  6, 11, -1, -1, -1, -1 ],
	[   6, 11,  3,  6,  3,  5,  5,  3,  1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2, 10,  9,  5, 11,  9, 11,  8, 11,  5,  6, -1, -1, -1, -1 ],
	[   0, 11,  3,  0,  6, 11,  0,  9,  6,  5,  6,  9,  1,  2, 10, -1 ],
	[  11,  8,  5, 11,  5,  6,  8,  0,  5, 10,  5,  2,  0,  2,  5, -1 ],
	[   6, 11,  3,  6,  3,  5,  2, 10,  3, 10,  5,  3, -1, -1, -1, -1 ],
	[   5,  8,  9,  5,  2,  8,  5,  6,  2,  3,  8,  2, -1, -1, -1, -1 ],
	[   9,  5,  6,  9,  6,  0,  0,  6,  2, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  5,  8,  1,  8,  0,  5,  6,  8,  3,  8,  2,  6,  2,  8, -1 ],
	[   1,  5,  6,  2,  1,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  3,  6,  1,  6, 10,  3,  8,  6,  5,  6,  9,  8,  9,  6, -1 ],
	[  10,  1,  0, 10,  0,  6,  9,  5,  0,  5,  6,  0, -1, -1, -1, -1 ],
	[   0,  3,  8,  5,  6, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  5,  6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[  11,  5, 10,  7,  5, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[  11,  5, 10, 11,  7,  5,  8,  3,  0, -1, -1, -1, -1, -1, -1, -1 ],
	[   5, 11,  7,  5, 10, 11,  1,  9,  0, -1, -1, -1, -1, -1, -1, -1 ],
	[  10,  7,  5, 10, 11,  7,  9,  8,  1,  8,  3,  1, -1, -1, -1, -1 ],
	[  11,  1,  2, 11,  7,  1,  7,  5,  1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  3,  1,  2,  7,  1,  7,  5,  7,  2, 11, -1, -1, -1, -1 ],
	[   9,  7,  5,  9,  2,  7,  9,  0,  2,  2, 11,  7, -1, -1, -1, -1 ],
	[   7,  5,  2,  7,  2, 11,  5,  9,  2,  3,  2,  8,  9,  8,  2, -1 ],
	[   2,  5, 10,  2,  3,  5,  3,  7,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  2,  0,  8,  5,  2,  8,  7,  5, 10,  2,  5, -1, -1, -1, -1 ],
	[   9,  0,  1,  5, 10,  3,  5,  3,  7,  3, 10,  2, -1, -1, -1, -1 ],
	[   9,  8,  2,  9,  2,  1,  8,  7,  2, 10,  2,  5,  7,  5,  2, -1 ],
	[   1,  3,  5,  3,  7,  5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  7,  0,  7,  1,  1,  7,  5, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  0,  3,  9,  3,  5,  5,  3,  7, -1, -1, -1, -1, -1, -1, -1 ],
	[   9,  8,  7,  5,  9,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   5,  8,  4,  5, 10,  8, 10, 11,  8, -1, -1, -1, -1, -1, -1, -1 ],
	[   5,  0,  4,  5, 11,  0,  5, 10, 11, 11,  3,  0, -1, -1, -1, -1 ],
	[   0,  1,  9,  8,  4, 10,  8, 10, 11, 10,  4,  5, -1, -1, -1, -1 ],
	[  10, 11,  4, 10,  4,  5, 11,  3,  4,  9,  4,  1,  3,  1,  4, -1 ],
	[   2,  5,  1,  2,  8,  5,  2, 11,  8,  4,  5,  8, -1, -1, -1, -1 ],
	[   0,  4, 11,  0, 11,  3,  4,  5, 11,  2, 11,  1,  5,  1, 11, -1 ],
	[   0,  2,  5,  0,  5,  9,  2, 11,  5,  4,  5,  8, 11,  8,  5, -1 ],
	[   9,  4,  5,  2, 11,  3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  5, 10,  3,  5,  2,  3,  4,  5,  3,  8,  4, -1, -1, -1, -1 ],
	[   5, 10,  2,  5,  2,  4,  4,  2,  0, -1, -1, -1, -1, -1, -1, -1 ],
	[   3, 10,  2,  3,  5, 10,  3,  8,  5,  4,  5,  8,  0,  1,  9, -1 ],
	[   5, 10,  2,  5,  2,  4,  1,  9,  2,  9,  4,  2, -1, -1, -1, -1 ],
	[   8,  4,  5,  8,  5,  3,  3,  5,  1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  4,  5,  1,  0,  5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   8,  4,  5,  8,  5,  3,  9,  0,  5,  0,  3,  5, -1, -1, -1, -1 ],
	[   9,  4,  5, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4, 11,  7,  4,  9, 11,  9, 10, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  8,  3,  4,  9,  7,  9, 11,  7,  9, 10, 11, -1, -1, -1, -1 ],
	[   1, 10, 11,  1, 11,  4,  1,  4,  0,  7,  4, 11, -1, -1, -1, -1 ],
	[   3,  1,  4,  3,  4,  8,  1, 10,  4,  7,  4, 11, 10, 11,  4, -1 ],
	[   4, 11,  7,  9, 11,  4,  9,  2, 11,  9,  1,  2, -1, -1, -1, -1 ],
	[   9,  7,  4,  9, 11,  7,  9,  1, 11,  2, 11,  1,  0,  8,  3, -1 ],
	[  11,  7,  4, 11,  4,  2,  2,  4,  0, -1, -1, -1, -1, -1, -1, -1 ],
	[  11,  7,  4, 11,  4,  2,  8,  3,  4,  3,  2,  4, -1, -1, -1, -1 ],
	[   2,  9, 10,  2,  7,  9,  2,  3,  7,  7,  4,  9, -1, -1, -1, -1 ],
	[   9, 10,  7,  9,  7,  4, 10,  2,  7,  8,  7,  0,  2,  0,  7, -1 ],
	[   3,  7, 10,  3, 10,  2,  7,  4, 10,  1, 10,  0,  4,  0, 10, -1 ],
	[   1, 10,  2,  8,  7,  4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  9,  1,  4,  1,  7,  7,  1,  3, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  9,  1,  4,  1,  7,  0,  8,  1,  8,  7,  1, -1, -1, -1, -1 ],
	[   4,  0,  3,  7,  4,  3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   4,  8,  7, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   9, 10,  8, 10, 11,  8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  0,  9,  3,  9, 11, 11,  9, 10, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  1, 10,  0, 10,  8,  8, 10, 11, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  1, 10, 11,  3, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  2, 11,  1, 11,  9,  9, 11,  8, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  0,  9,  3,  9, 11,  1,  2,  9,  2, 11,  9, -1, -1, -1, -1 ],
	[   0,  2, 11,  8,  0, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   3,  2, 11, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  3,  8,  2,  8, 10, 10,  8,  9, -1, -1, -1, -1, -1, -1, -1 ],
	[   9, 10,  2,  0,  9,  2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   2,  3,  8,  2,  8, 10,  0,  1,  8,  1, 10,  8, -1, -1, -1, -1 ],
	[   1, 10,  2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   1,  3,  8,  9,  1,  8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  9,  1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[   0,  3,  8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
	[  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 ],
];

static immutable float[3][8] s_cube =
[
	[ 0.0f, 1.0f, 1.0f ], // 0
	[ 1.0f, 1.0f, 1.0f ], // 1
	[ 1.0f, 1.0f, 0.0f ], // 2
	[ 0.0f, 1.0f, 0.0f ], // 3
	[ 0.0f, 0.0f, 1.0f ], // 4
	[ 1.0f, 0.0f, 1.0f ], // 5
	[ 1.0f, 0.0f, 0.0f ], // 6
	[ 0.0f, 0.0f, 0.0f ], // 7
];

float vertLerp(float* _result, float _iso, uint32_t _idx0, float _v0, uint32_t _idx1, float _v1)
{
	const float* edge0 = s_cube[_idx0].ptr;
	const float* edge1 = s_cube[_idx1].ptr;

	if (std.math.abs(_iso-_v1) < 0.00001f)
	{
		_result[0] = edge1[0];
		_result[1] = edge1[1];
		_result[2] = edge1[2];
		return 1.0f;
	}

	if (std.math.abs(_iso-_v0) < 0.00001f
	||  std.math.abs(_v0-_v1) < 0.00001f)
	{
		_result[0] = edge0[0];
		_result[1] = edge0[1];
		_result[2] = edge0[2];
		return 0.0f;
	}

	float lerp = (_iso - _v0) / (_v1 - _v0);
	_result[0] = edge0[0] + lerp * (edge1[0] - edge0[0]);
	_result[1] = edge0[1] + lerp * (edge1[1] - edge0[1]);
	_result[2] = edge0[2] + lerp * (edge1[2] - edge0[2]);

	return lerp;
}

uint32_t triangulate(uint8_t* _result, uint32_t _stride, const(float)* _rgb, const(float)* _xyz, const (Grid*)* _val, float _iso)
{
	uint8_t cubeindex = 0;
	cubeindex |= (_val[0].m_val < _iso) ? 0x01 : 0;
	cubeindex |= (_val[1].m_val < _iso) ? 0x02 : 0;
	cubeindex |= (_val[2].m_val < _iso) ? 0x04 : 0;
	cubeindex |= (_val[3].m_val < _iso) ? 0x08 : 0;
	cubeindex |= (_val[4].m_val < _iso) ? 0x10 : 0;
	cubeindex |= (_val[5].m_val < _iso) ? 0x20 : 0;
	cubeindex |= (_val[6].m_val < _iso) ? 0x40 : 0;
	cubeindex |= (_val[7].m_val < _iso) ? 0x80 : 0;

	if (0 == s_edges[cubeindex])
	{
		return 0;
	}

	float verts[12][6];
	uint16_t flags = s_edges[cubeindex];

	for (uint32_t ii = 0; ii < 12; ++ii)
	{
		if (flags & (1<<ii) )
		{
			uint32_t idx0 = ii&7;
			uint32_t idx1 = "\x01\x02\x03\x00\x05\x06\x07\x04\x04\x05\x06\x07"[ii];
			float* vertex = verts[ii].ptr;
			float lerp = vertLerp(vertex, _iso, idx0, _val[idx0].m_val, idx1, _val[idx1].m_val);

			const float* na = _val[idx0].m_normal.ptr;
			const float* nb = _val[idx1].m_normal.ptr;
			vertex[3] = na[0] + lerp * (nb[0] - na[0]);
			vertex[4] = na[1] + lerp * (nb[1] - na[1]);
			vertex[5] = na[2] + lerp * (nb[2] - na[2]);
		}
	}

	float dr = _rgb[3] - _rgb[0];
	float dg = _rgb[4] - _rgb[1];
	float db = _rgb[5] - _rgb[2];

	uint32_t num = 0;
	const int8_t* indices = s_indices[cubeindex].ptr;
	for (uint32_t ii = 0; indices[ii] != -1; ++ii)
	{
		const float* vertex = verts[indices[ii] ].ptr;

		float* xyz = cast(float*)_result;
		xyz[0] = _xyz[0] + vertex[0];
		xyz[1] = _xyz[1] + vertex[1];
		xyz[2] = _xyz[2] + vertex[2];

		xyz[3] = vertex[3];
		xyz[4] = vertex[4];
		xyz[5] = vertex[5];

		uint32_t rr = cast(uint8_t)( (_rgb[0] + vertex[0]*dr)*255.0f);
		uint32_t gg = cast(uint8_t)( (_rgb[1] + vertex[1]*dg)*255.0f);
		uint32_t bb = cast(uint8_t)( (_rgb[2] + vertex[2]*db)*255.0f);

		uint32_t* abgr = cast(uint32_t*)(&_result[24]);
		*abgr = 0xff000000
			  | (bb<<16)
			  | (gg<<8)
			  | rr
			  ;

		_result += _stride;
		++num;
	}

	return num;
}

int main(string[] args)
{
	uint32_t debug_ = BGFX_DEBUG_TEXT;
	uint32_t reset = BGFX_RESET_VSYNC;

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
    else version(linux)
    {
        bgfx_x11_set_display_window(cast(Display*)window.getWindowInfo().info.x11.display,window.getWindowInfo().info.x11.window);
    }
    else
    {
        static assert(false, "TODO implement passing window handle to bgfx for this system");
    }


	bgfx_init();
	bgfx_reset(width, height, reset);

	// Enable debug text.
	bgfx_set_debug(debug_);

	// Set view 0 clear state.
	bgfx_set_view_clear(0
		, BGFX_CLEAR_COLOR_BIT|BGFX_CLEAR_DEPTH_BIT
		, 0x303030ff
		, 1.0f
		, 0
		);

	// Create vertex stream declaration.
	PosNormalColorVertex.init();

	const (bgfx_memory_t)* vs_metaballs;
	const (bgfx_memory_t)* fs_metaballs;

	switch (bgfx_get_renderer_type() )
	{
	case BGFX_RENDERER_TYPE_DIRECT3D9:
		vs_metaballs = bgfx_make_ref(vs_metaballs_dx9.ptr, vs_metaballs_dx9.sizeof );
		fs_metaballs = bgfx_make_ref(fs_metaballs_dx9.ptr, fs_metaballs_dx9.sizeof );
		break;

	case BGFX_RENDERER_TYPE_DIRECT3D11:
		vs_metaballs = bgfx_make_ref(vs_metaballs_dx11.ptr, vs_metaballs_dx11.sizeof );
		fs_metaballs = bgfx_make_ref(fs_metaballs_dx11.ptr, fs_metaballs_dx11.sizeof );
		break;

	default:
		vs_metaballs = bgfx_make_ref(vs_metaballs_glsl.ptr, vs_metaballs_glsl.sizeof );
		fs_metaballs = bgfx_make_ref(fs_metaballs_glsl.ptr, fs_metaballs_glsl.sizeof );
		break;
	}

	bgfx_shader_handle_t vsh = bgfx_create_shader(vs_metaballs);
	bgfx_shader_handle_t fsh = bgfx_create_shader(fs_metaballs);

	// Create program from shaders.
	bgfx_program_handle_t program = bgfx_create_program(vsh, fsh, true /* destroy shaders when program is destroyed */);

    enum DIMS = 32;

	Grid[] grid = new Grid[DIMS*DIMS*DIMS];
	const uint32_t ypitch = DIMS;
	const uint32_t zpitch = DIMS*DIMS;
	const float invdim = 1.0f/cast(float)(DIMS-1);

	int64_t timeOffset = SDL_GetTicks();
    int64_t last = timeOffset;

    while (!sdl2.keyboard().isPressed(SDLK_ESCAPE))
    {
        sdl2.processEvents();

		// Set view 0 default viewport.
		bgfx_set_view_rect(cast(ushort)0, cast(ushort)0, cast(ushort)0, cast(ushort)width, cast(ushort)height);

		// This dummy draw call is here to make sure that view 0 is cleared
		// if no other draw calls are submitted to view 0.
		bgfx_submit(0);

		int64_t now = SDL_GetTicks();
		const int64_t frameTime = now - last;
		last = now;
		float time = cast(float)( (now - timeOffset)/ 1000.0 );

		// Use debug font to print information about this example.
		bgfx_dbg_text_clear();
		bgfx_dbg_text_printf(0, 1, 0x4f, "bgfx/examples/02-metaball");
		bgfx_dbg_text_printf(0, 2, 0x6f, "Description: Rendering with transient buffers and embedding shaders.");

		vec3f at = vec3f( 0.0f, 0.0f, 0.0f );
		vec3f eye = vec3f( 0.0f, 0.0f, -50.0f );
        vec3f up = vec3f( 0.0f, 1.0f, 0.0f );
		
        mat4f view = mat4f.lookAt(eye, at, up);
        mat4f proj = mat4f.perspective(radians(60.0f), cast(float)(width)/height, 0.1f, 100.0f);

		// Set view and projection matrix for view 0.
		bgfx_set_view_transform(0, view.transposed().ptr, proj.transposed().ptr);

		// Stats.
		uint32_t numVertices = 0;
		int64_t profUpdate = 0;
		int64_t profNormal = 0;
		int64_t profTriangulate = 0;

		// Allocate 32K vertices in transient vertex buffer.
		uint32_t maxVertices = (32<<10);
		bgfx_transient_vertex_buffer_t tvb;
        bgfx_alloc_transient_vertex_buffer(&tvb, maxVertices, &PosNormalColorVertex.ms_decl);

		const uint32_t numSpheres = 16;
		float sphere[numSpheres][4];
		for (uint32_t ii = 0; ii < numSpheres; ++ii)
		{
			sphere[ii][0] = sin(time*(ii*0.21f)+ii*0.37f) * (DIMS * 0.5f - 8.0f);
			sphere[ii][1] = sin(time*(ii*0.37f)+ii*0.67f) * (DIMS * 0.5f - 8.0f);
			sphere[ii][2] = cos(time*(ii*0.11f)+ii*0.13f) * (DIMS * 0.5f - 8.0f);
			sphere[ii][3] = 1.0f/(2.0f + (sin(time*(ii*0.13f) )*0.5f+0.5f)*2.0f);
		}

		profUpdate = SDL_GetTicks();
		
		for (uint32_t zz = 0; zz < DIMS; ++zz)
		{
			for (uint32_t yy = 0; yy < DIMS; ++yy)
			{
				uint32_t offset = (zz*DIMS+yy)*DIMS;

				for (uint32_t xx = 0; xx < DIMS; ++xx)
				{
					uint32_t xoffset = offset + xx;

					float dist = 0.0f;
					float prod = 1.0f;
					for (uint32_t ii = 0; ii < numSpheres; ++ii)
					{
						const float* pos = sphere[ii].ptr;
						float dx = pos[0] - (-DIMS*0.5f + cast(float)(xx) );
						float dy = pos[1] - (-DIMS*0.5f + cast(float)(yy) );
						float dz = pos[2] - (-DIMS*0.5f + cast(float)(zz) );
						float invr = pos[3];
						float dot = dx*dx + dy*dy + dz*dz;
						dot *= invr*invr;

						dist *= dot;
						dist += prod;
						prod *= dot;
					}

					grid[xoffset].m_val = dist / prod - 1.0f;
				}
			}
		}

		profUpdate = SDL_GetTicks() - profUpdate;

		profNormal = SDL_GetTicks();

		for (uint32_t zz = 1; zz < DIMS-1; ++zz)
		{
			for (uint32_t yy = 1; yy < DIMS-1; ++yy)
			{
				uint32_t offset = (zz*DIMS+yy)*DIMS;

				for (uint32_t xx = 1; xx < DIMS-1; ++xx)
				{
					uint32_t xoffset = offset + xx;

					vec3f normal = vec3f
                    (
						grid[xoffset-1     ].m_val - grid[xoffset+1     ].m_val,
						grid[xoffset-ypitch].m_val - grid[xoffset+ypitch].m_val,
						grid[xoffset-zpitch].m_val - grid[xoffset+zpitch].m_val,
					);

					grid[xoffset].m_normal = normal.normalized();
				}
			}
		}

		profNormal = SDL_GetTicks() - profNormal;

		profTriangulate = SDL_GetTicks();

		PosNormalColorVertex* vertex = cast(PosNormalColorVertex*)tvb.data;

		for (uint32_t zz = 0; zz < DIMS-1 && numVertices+12 < maxVertices; ++zz)
		{
			float rgb[6];
			rgb[2] = zz*invdim;
			rgb[5] = (zz+1)*invdim;

			for (uint32_t yy = 0; yy < DIMS-1 && numVertices+12 < maxVertices; ++yy)
			{
				uint32_t offset = (zz*DIMS+yy)*DIMS;

				rgb[1] = yy*invdim;
				rgb[4] = (yy+1)*invdim;

				for (uint32_t xx = 0; xx < DIMS-1 && numVertices+12 < maxVertices; ++xx)
				{
					uint32_t xoffset = offset + xx;

					rgb[0] = xx*invdim;
					rgb[3] = (xx+1)*invdim;

					vec3f pos =
					vec3f(
						-DIMS*0.5f + cast(float)(xx),
						-DIMS*0.5f + cast(float)(yy),
						-DIMS*0.5f + cast(float)(zz)
					);

					const Grid* val[8] = [
						&grid[xoffset+zpitch+ypitch  ],
						&grid[xoffset+zpitch+ypitch+1],
						&grid[xoffset+ypitch+1       ],
						&grid[xoffset+ypitch         ],
						&grid[xoffset+zpitch         ],
						&grid[xoffset+zpitch+1       ],
						&grid[xoffset+1              ],
						&grid[xoffset                ],
					];

					uint32_t num = triangulate( cast(uint8_t*)vertex, PosNormalColorVertex.ms_decl.stride, rgb.ptr, pos.ptr, val.ptr, 0.5f);
					vertex += num;
					numVertices += num;
				}
			}
		}

		profTriangulate = SDL_GetTicks() - profTriangulate;

        mat4f mtx = mat4f.rotateX(time*0.67f) * mat4f.rotateY(time);
		
		// Set model matrix for rendering.
		bgfx_set_transform(mtx.transposed().ptr);

		// Set vertex and fragment shaders.
		bgfx_set_program(program);

		// Set vertex and index buffer.
		bgfx_set_transient_vertex_buffer(&tvb, 0, numVertices);

		// Submit primitive for rendering to view 0.
		bgfx_submit(0);

		// Display stats.
		bgfx_dbg_text_printf(1, 4, 0x0f, "Num vertices: %5d (%6.4f%%)", numVertices, cast(float)(numVertices)/maxVertices * 100);
		bgfx_dbg_text_printf(1, 5, 0x0f, "      Update: % 7.3f[ms]", cast(double)(profUpdate));
		bgfx_dbg_text_printf(1, 6, 0x0f, "Calc normals: % 7.3f[ms]", cast(double)(profNormal));
		bgfx_dbg_text_printf(1, 7, 0x0f, " Triangulate: % 7.3f[ms]", cast(double)(profTriangulate));
		bgfx_dbg_text_printf(1, 8, 0x0f, "       Frame: % 7.3f[ms]", cast(double)(frameTime));

		// Advance to next frame. Rendering thread will be kicked to 
		// process submitted rendering primitives.
		bgfx_frame();
	}

	// Cleanup.
	bgfx_destroy_program(program);

	// Shutdown bgfx.
	bgfx_shutdown();

	return 0;
}
