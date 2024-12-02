# WeChat, don't steal my focus

Wine-ed `com.qq.weixin.deepin` grabs the input focus and brings itself to foreground every time the mouse moves into the screen which its window resides.

This library preloads the `XSetInputFocus()` call and makes it a no-op.

# Usage
```shell
make
sudo make install
````