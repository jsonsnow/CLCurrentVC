
#### 本工程通过运行时来获取当前栈顶控制器
传统方法通过递归系统控制器结果获得顶层控制器存在一个问题--dismiss为一个异步过程，导致在一个dismiss方法后获得的控制器是一个将要销毁的，导致错误。

#### 注意事项
通过该sdk来获取栈顶控制器，需要注意，先dismiss,pop，再回调，不然会导致获得的控制器也是错误的


#### 2018.06.29修改
* 对tabbar选择方法修改，判断选中是否为navc,为navc则当前控制器为navc的top
* 对present方法修改，判断present是否为navc,为navc则当前控制器为navc的top
* 对navc的push方法修改，如果push的时候navc的view未load则表面该方法只是创建并赋值rooter的时候调用的，过滤掉