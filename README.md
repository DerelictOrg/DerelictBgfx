DerelictBgfx
============

A dynamic binding to [bgfx](https://github.com/bkaradzic/bgfx/) for the D Programming Language.
 please see the post [Using Derelict](http://dblog.aldacron.net/derelict-help/using-derelict/) at the The One With D.
 [2]: http://dblog.aldacron.net/derelict-help/using-derelict/
For information on how to build DerelictBgfx and link it with your programs, please see the post [Building and Using Packages in DerelictOrg](http://dblog.aldacron.net/forum/index.php?topic=841.0) at the Derelict forums.

For information on how to load the bgfx library via DerelictBgfx, see the page [DerelictUtil for Users](https://github.com/DerelictOrg/DerelictUtil/wiki/DerelictUtil-for-Users) at the DerelictUtil Wiki. In the meantime, here's some sample code.

**This binding does not come with bgfx binaries. You have to build it by yourself.**

```D
import derelict.bgfx.bgfx;

void main() {
    // Load the bgfx library.
    DerelictBgfx.load();

    // Now bgfx functions can be called.
    ...
}
```
