# Topic 2.3 - 类对象

## 1. 类对象的概念

之前我们介绍过，在 Python 中，一切皆对象：

- 因此类本身也是对象，可以有属性和方法，这些属性和方法称为类属性和类方法
- **类属性**是直接绑定在类上的属性，而不是绑定在实例对象上的属性，在类体缩进中直接定义，不需要在 `__init__` 方法中定义
- **类方法**是绑定在类上的方法，第一个参数通常命名为 `cls`，表示类本身，可以通过 `@classmethod` 装饰器来定义类方法

这样说有些抽象，我们来看一个例子：


```python
class Student:

    info = "该类用于创建学生对象"
    count = 0

    def __init__(self, name, age):
        self.name = name
        self.age = age
        Student.count += 1

    def show_info(self):
        print(f"学生姓名: {self.name}, 年龄: {self.age}")
    
    @classmethod
    def display_class_info(cls):
        print(cls.info)

    @classmethod
    def display_student_count(cls):
        print(f"学生总数: {cls.count}")
```


```python
# 创建学生对象
zhangsan = Student("张三", 20)
lisi = Student("李四", 22)

# 调用实例属性
print(zhangsan.name)
print(lisi.name)

# 调用实例方法
zhangsan.show_info()
lisi.show_info()
```

    张三
    李四
    学生姓名: 张三, 年龄: 20
    学生姓名: 李四, 年龄: 22



```python
# 调用类属性
print(Student.info)
print(Student.count)

# 调用类方法
Student.display_class_info()
Student.display_student_count()
```

    该类用于创建学生对象
    2
    该类用于创建学生对象
    学生总数: 2


在上面的例子中，我们定义了一个 `Student` 类，在这个类中：

- 我们定义了实例属性和实例对象，这是我们比较熟悉的：

    - `name` 和 `age` 是实例属性，每个实例对象都有自己不同的 `name` 和 `age`，定义是在 `__init__` 方法中定义，调用是通过 `实例名.属性名` 的方式调用
    - `show_info` 是实例方法，通过实例对象调用，每个实例都展示不同的信息，定义要使用 `self` 作为第一个参数，调用是通过 `实例名.方法名()` 的方式调用

- 除此之外，我们还定义了类属性和类方法：

    - `info` 和 `count` 是类属性，`info` 是一个字符串，表示学生的信息，`count` 是一个整数，表示学生的数量，这些属性是绑定在类上的，所有实例对象共享同一个类属性，定义是在类体缩进中直接定义，调用是通过 `类名.属性名` 的方式调用
    - `display_class_info` 和 `display_student_count` 是类方法，通过类本身调用，这些方法通常用于操作类属性或提供与类相关的功能，定义要使用 `@classmethod` 装饰器，并且第一个参数是 `cls`，调用是通过 `类名.方法名()` 的方式调用

通过以上例子，我们可以清楚地区分实例的属性方法和类的属性方法，以及它们各自的定义和调用方式：

- 大家在实际编程中可以根据需求选择使用实例属性方法还是类属性方法
- 简言之就是，如果是需要因实例而异的，就使用实例属性方法；如果是所有实例共享的属性和方法，就使用类属性方法

## 2. 特殊的类与对象

### (1) 抽象类（Abstract Class）

抽象类是一种不能被实例化的类，它通常用作其他类的基类

- 抽象类需要通过 `abc` 模块中的 `ABC` 类来定义
- 抽象类中可以包含抽象方法，通过 `abc` 模块中的 `@abstractmethod` 装饰器来定义，这些方法在抽象类中没有实现，必须在子类中实现
- 注意许多编程语言中是默认支持抽象类的，而 Python 需要通过 `abc` 模块来实现

我们来看一个例子，我们可以把动物类定义为一个抽象类，然后让具体的动物类继承它：


```python
from abc import ABC, abstractmethod

class Animal(ABC):
    @abstractmethod
    def make_sound(self):
        pass

class Dog(Animal):
    def __init__(self, name):
        self.name = name
    def make_sound(self):
        return "汪～"

class Cat(Animal):
    def __init__(self, name):
        self.name = name
    def make_sound(self):
        return "喵～"
```


```python
# 以下代码会报错，因为 Animal 是抽象类，不能被实例化，大家可以取消注释试试看
# wangcai = Animal()
```


```python
wangcai = Dog("旺财")
print(wangcai.make_sound())

miaomiao = Cat("喵喵")
print(miaomiao.make_sound())
```

    汪～
    喵～


抽象类和抽象方法的逻辑其实很简单，和我们之前介绍过的覆写父类方法类似，只不过抽象的父类中的方法是没有实现的，我们就不再赘述了。

### (2) 工具类与静态方法

工具类是一种只包含静态方法的类，通常用于封装一些通用的功能

- 工具类可以被实例化，但是通常不需要实例化，而是直接使用类名就可以调用静态方法，因此也不需要初始化方法来定义属性
- 静态方法通过 `@staticmethod` 装饰器来定义，静态方法不需要访问类的实例或类本身，因此不需要传递 `self` 参数

我们来看一个例子，我们可以定义一个数学工具类，包含一些常用的数学运算方法：


```python
class MathTools:
    @staticmethod
    def add(a, b):
        return a + b

    @staticmethod
    def subtract(a, b):
        return a - b
```


```python
print(MathTools.add(5, 3)) 
print(MathTools.subtract(5, 3))
```

    8
    2


可以看到，我们定义了一个 `MathTools` 工具类，包含两个静态方法 `add` 和 `subtract`，用于实现加法和减法运算：

- 我们可以直接通过类名调用这些静态方法，而不需要创建类的实例
- 并且，我们在定义静态方法时，不需要初始化函数，也不需要传递 `self` 参数，因为静态方法不依赖于类的实例

### (3) 配置类

配置类是一种用于存储配置信息的类，通常包含一些常量属性

- 配置类通常不需要实例化，而是通过类名直接访问其属性
- 由于我们使用类名直接访问属性，因此配置类通常不需要定义初始化方法，所有的属性直接在类体缩进中定义为类属性
- 配置类和工具类事实上属于两个极端：

  - 工具类通常只包含静态方法，没有属性
  - 配置类通常只包含属性，没有方法

我们来看一个例子，比方说我们要做一个游戏，我们在配置类中定义一些游戏的配置信息：

- 地图长度： 1000
- 地图宽度： 800
- 最大玩家数量： 4


```python
class Config:
    MAP_LENGTH = 1000
    MAP_WIDTH = 800
    MAX_PLAYERS = 4
```


```python
print(Config.MAP_LENGTH)
print(Config.MAP_WIDTH)
print(Config.MAX_PLAYERS)
```

    1000
    800
    4


可以看到，我们定义了一个 `Config` 配置类，包含三个类属性 `MAP_LENGTH`、`MAP_WIDTH` 和 `MAX_PLAYERS`，用于存储游戏的配置信息：

- 由于所有属性都是类属性，因此我们可以直接通过类名访问这些属性，而不需要创建类的实例
- 并且，我们在定义类属性时，不需要初始化函数，而是直接在类体缩进中定义，因为这些属性是类级别的，不依赖于类的实例

# 3. 装饰器

## (1) 装饰器的概念

这里我们简单介绍一下 `@abstractmethod` 、 `@staticmethod` 等等，这种带 `@` 的写法：

- 这种写法叫做**装饰器（Decorator）**，是一种特殊的语法结构，用于修改函数或方法的行为
- 大家接触到的装饰器种类并不多，掌握固定用法就可以了，不需要掌握它的本质原理
- 目前大家已经见过的装饰器有：

    - `@classmethod`：用于定义类方法，表示该方法绑定在类上，第一个参数是类本身 `cls`
    - `@abstractmethod`：用于定义抽象方法，表示该方法在抽象类中没有实现，必须在子类中实现
    - `@staticmethod`：用于定义静态方法，表示该方法不依赖于类的实例，可以通过类名直接调用

- 除此之外还有一个常见的是 `@property`，用于定义属性方法，可以让方法像属性一样访问，我们在下一节简单介绍，同样，只掌握固定用法即可

## (2) 属性方法 - `@property` 装饰器

有时候，实例的属性需要通过一些复杂的计算或验证才能得到，写在初始化函数中会特别繁琐，这时候我们可以使用 `@property` 装饰器来定义属性方法：

- 首先，我们定义一个方法，方法要使用 `@property` 装饰器进行装饰，并且这个方法的第一个参数是 `self`，表示实例对象本身
- 接着，在方法中，我们要实现这个属性的计算逻辑，最后返回计算结果
- 这样，我们就可以通过访问这个方法的方式来获取属性值，而不需要调用方法

我们来看一个例子：


```python
class Rectangle:

    def __init__(self, width, height):
        self.width = width
        self.height = height
    
    @property
    def area(self):
        if self.width is None or self.height is None:
            raise ValueError("宽度或高度未设置")
        return self.width * self.height
```


```python
rect1 = Rectangle(5, 10)
print(rect1.area)
```

    50


在上面这个例子中，我们定义了一个 `Rectangle` 类，表示矩形：

- 在初始化函数中，我们定义了两个实例属性 `width` 和 `height`，表示矩形的宽度和高度
- 然后，我们定义了一个属性方法 `area`，用于计算矩形的面积，这个方法使用了 `@property` 装饰器进行装饰
- 在 `area` 方法中，先是验证了高和宽是否为 `None`，接着，我们通过 `self.width` 和 `self.height` 计算矩形的面积，并返回计算结果
- 我们可以通过访问 `area` 属性来获取矩形的面积，而不需要调用方法（调用时不加括号）
