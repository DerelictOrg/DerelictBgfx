module bgfx_utils;

import derelict.bgfx.bgfx;

bgfx_program_handle_t loadProgram(string _vsName, string _fsName)
{
    return bgfx_create_program(loadShader(_vsName), loadShader(_fsName), true);
}

bgfx_shader_handle_t loadShader(string _name)
{
    string shaderPath = "../runtime/shaders/dx9/";

    switch (bgfx_get_renderer_type())
    {
    case BGFX_RENDERER_TYPE_DIRECT3D11:
        shaderPath = "../runtime/shaders/dx11/";
        break;

    case BGFX_RENDERER_TYPE_OPENGL:
        shaderPath = "../runtime/shaders/glsl/";
        break;

    case BGFX_RENDERER_TYPE_OPENGLES:
        shaderPath = "../runtime/shaders/gles/";
        break;

    default:
        break;
    }

    shaderPath = shaderPath  ~ _name ~ ".bin";

    import std.file;
    if (!std.file.exists(shaderPath))
        throw new Exception("File unknown");

    bgfx_memory_t* mem = loadMem(shaderPath);
    return bgfx_create_shader(mem);
}


bgfx_memory_t* loadMem(string filename)
{
    import core.stdc.stdlib : malloc;
    import core.stdc.string : memcpy;
    import std.file;
    ubyte[] content = cast(ubyte[]) std.file.read(filename);
    content ~= 0;
    return bgfx_copy(content.ptr, content.length);
}
