DerelictBgfx
============

A dynamic binding to [bgfx](https://github.com/bkaradzic/bgfx/) for the D Programming Language.

**Warning: these bindings do not come with bgfx binaries.**

**Note: this DerelictBgfx binding commit is in sync with bgfx Mar 20, 2016 commit titled ["ios-simulator: Disable Metal."](https://github.com/bkaradzic/bgfx/commit/a7a49ead60d304472e71ec2866081eeebdfa1526)**

More information on how to build bgfx is available here: https://github.com/bkaradzic/bgfx/

Please see the pages [Building and Linking Derelict](http://derelictorg.github.io/compiling.html) and [Using Derelict](http://derelictorg.github.io/using.html), or information on how to build DerelictBgfx and load the bgfx library at run time. In the meantime, here's some sample code.

```D
import derelict.bgfx.bgfx;

void main() {
    // Load the bgfx library.
    DerelictBgfx.load();

    // Now bgfx functions can be called.
    ...
}
```
