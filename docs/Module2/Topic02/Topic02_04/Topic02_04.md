# Topic 2.4 - 单例

## 1. 单例的概念

在编程中，有时我们希望一个类只有一个实例，这种设计模式称为**单例模式**：

- 单例模式确保一个类只有一个实例，并提供一个全局访问点来获取该实例

- 这种模式大家其实已经很熟悉了：

    - 比方说手机上的 APP，就拿微信来说，不论点击多少次微信图标，系统都只会创建一个微信 APP 实例，不会存在同时运行多个微信的情况
    - 再比方说，游戏里的主角，对于大部分游戏来说，一个游戏里只有一个主角实例，不会存在同时控制多个主角的情况

## 2. 在 Python 中实现单例模式

在 Python 面向对象中，实现单例的方式：

- 并不是人为约定某个类只能创建一个实例，或者创建第二个实例时就报错
- 而是通过内存管理机制，确保无论创建多少次实例，都返回同一个实例对象

### (1) 面向对象中的 `__new__` 方法

在 Python 中，创建新的实例时，其实是有一个 `__new__` 方法，是比 `__init__` 方法更早被调用的：

- `__new__` 方法会为实例分配内存空间，并返回该实例对象，传递给 `__init__` 方法进行初始化
- 也就是说，`__init__` 方法接收的第一个参数 `self`，其实就是 `__new__` 方法创建的
- 由于我们之前不涉及到内存管理，因此 Python 会使用默认的 `__new__` 方法来创建实例，不需要我们重写

因为 `__new__` 方法会为实例分配内存空间，并返回该实例对象，因此，要想实现单例的内存管理的机制，就需要重写 `__new__` 方法

### (2) 重写 `__new__` 方法实现单例模式

使用 `__new__` 方法实现单例模式的思路如下：

- 在类体中定义一个类属性 `instance`，用于存储类的唯一实例，初始值为 `None`

- 重写 `__new__` 方法，在方法中检查 `instance` 属性是否为 `None`

    - 如果是 `None`，说明还没有创建实例，这时候调用父类的 `__new__` 方法来创建实例，并将创建的实例赋值给 `instance` 属性
    - 如果不是 `None`，说明已经创建过实例了，直接返回 `instance` 属性即可

- 我们来看一个具体的代码例子


```python
class WeChatAPP(object):

    # 定义类属性记录单例对象引用
    instance = None

    def __new__(cls, *args, **kwargs):

        # 1. 判断类属性是否已经被赋值
        if cls.instance is None:
            cls.instance = super().__new__(cls)

        # 2. 返回类属性的单例引用
        return cls.instance
    
    def __init__(self, user_name):
        self.user_name = user_name
        print(f"微信登录成功，用户：{self.user_name}")
```


```python
# 创建第一个微信实例
wechat1 = WeChatAPP("zhangsan")

# 检查内存地址
print(f"WeChatAPP 实例 wechat1 的内存地址：{id(wechat1)}")


# 创建第二个微信实例
wechat2 = WeChatAPP("lisi")

# 检查内存地址
print(f"WeChatAPP 实例 wechat2 的内存地址：{id(wechat2)}")
```

    微信登录成功，用户：zhangsan
    WeChatAPP 实例 wechat1 的内存地址：5461004752
    微信登录成功，用户：lisi
    WeChatAPP 实例 wechat2 的内存地址：5461004752



```python
print(wechat1.user_name)
print(wechat2.user_name)
```

    lisi
    lisi


在上面这个例子中，我们创建了一个 `WeChatAPP` 类，表示微信 APP：

- 在这个类中，我们重写了 `__new__` 方法，通过类属性 `instance` 来存储唯一实例，这样每次创建 `WeChatAPP` 实例时，都会返回同一个实例对象
- 之后，我们先创建了第一个微信实例 `wechat1`，并传入用户名参数 `zhangsan`，然后创建了第二个微信实例 `wechat2`，并传入另一个用户名参数 `lisi`
- 我们发现，两个微信对象的内存地址是相同的，并且调用出来的用户名都是 `lisi`，这说明它们实际上是同一个实例对象，只是最后一次初始化时传入的用户名覆盖了之前的用户名

上面这种单例的模式是：

- 每次创建实例时，都会调用 `__init__` 方法进行初始化，相当于新的属性会覆盖之前的属性
- 如果不想要覆盖旧属性，则需要一个单独的类属性来标记是否已经初始化过实例
- 只有在第一次创建实例时，才调用 `__init__` 方法进行初始化，之后的实例创建都不再调用 `__init__` 方法
- 我们来看具体例子：


```python
class WeChatAPP(object):

    # 定义类属性记录单例对象引用
    instance = None

    # 标记是否已经初始化过实例
    initialized = False

    def __new__(cls, *args, **kwargs):

        # 1. 判断类属性是否已经被赋值
        if cls.instance is None:
            cls.instance = super().__new__(cls)

        # 2. 返回类属性的单例引用
        return cls.instance
    
    def __init__(self, user_name):
        # 只有在第一次创建实例时，才进行初始化
        if not self.initialized:
            self.user_name = user_name
            print(f"微信登录成功，用户：{self.user_name}")
            # 标记已经初始化过实例
            self.initialized = True
```


```python
# 创建第一个微信实例
wechat1 = WeChatAPP("zhangsan")

# 检查内存地址
print(f"WeChatAPP 实例 wechat1 的内存地址：{id(wechat1)}")


# 创建第二个微信实例
wechat2 = WeChatAPP("lisi")

# 检查内存地址
print(f"WeChatAPP 实例 wechat2 的内存地址：{id(wechat2)}")
```

    微信登录成功，用户：zhangsan
    WeChatAPP 实例 wechat1 的内存地址：5461002704
    WeChatAPP 实例 wechat2 的内存地址：5461002704



```python
print(wechat1.user_name)
print(wechat2.user_name)
```

    zhangsan
    zhangsan


在这个新的例子中：

- 我们在 `WeChatAPP` 类中增加了一个类属性 `initialized`，用于标记是否已经初始化过实例，初始值为 `False`
- 在 `__init__` 方法中，我们先检查 `initialized` 属性是否为 `False`，如果是 `False`，说明是第一次创建实例，这时候才进行初始化，并将 `initialized` 属性设置为 `True`
- 之后，再次创建实例时，由于 `initialized` 属性已经是 `True`，因此不会再进行初始化，避免了属性被覆盖的问题
- 因此，我们创造了两个微信实例 `wechat1` 和 `wechat2`，但是只有第一次创建实例时，才会打印出登录成功的信息，第二次创建实例时不会再打印任何信息，并且两个实例的属性都是 `zhangsan`，说明属性没有被覆盖

以上我们介绍了两种实现单例模式的方式：

- 一种是每次创建实例时，都会调用 `__init__` 方法进行初始化，新的属性会覆盖旧的属性，这种模式类似于大家打游戏里，主角死了以后复活，属性会被重置
- 另一种是通过一个标记属性，确保只有第一次创建实例时才进行初始化，避免属性被覆盖，这种模式类似于大家打开 APP，每次打开都是同一个 APP 实例，属性不会被重置
- 大家需要根据实际的编程需求，选择合适的单例实现方式
