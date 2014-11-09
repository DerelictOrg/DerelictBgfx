DerelictBgfx
============

A dynamic binding to [bgfx](https://github.com/bkaradzic/bgfx/) for the D Programming Language.


For information on how to build DerelictBgfx and link it with your programs, please see the post [Using Derelict](http://dblog.aldacron.net/derelict-help/using-derelict/) at the The One With D.

For information on how to load the bgfx library via DerelictBgfx, see the page [DerelictUtil for Users](https://github.com/DerelictOrg/DerelictUtil/wiki/DerelictUtil-for-Users) at the DerelictUtil Wiki. In the meantime, here's some sample code.

**Warning: these bindings do not come with bgfx binaries.**

**Note: this DerelictBgfx binding commit is in sync with bgfx Nov 6, 2014 commit titled "Added .editorconfig."**

More information on how to build bgfx is available here: https://github.com/bkaradzic/bgfx/

```D
import derelict.bgfx.bgfx;

void main() {
    // Load the bgfx library.
    DerelictBgfx.load();

    // Now bgfx functions can be called.
    ...
}
```
