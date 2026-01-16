# Topic 12.3 - 自定义模块与包的高级技巧（补充）

本章我们将介绍一些关于自定义模块与包的高级技巧，对于商业分析专业的同学们来说使用的频率并不高，但是有些开发者喜欢这样的编程技巧，我们学习本章的目的还是让大家能看懂别人写的代码。

## 1. 相互引用的问题

我们先来看一个简单的情况，那就是模块间的相互引用，简单来说就是 A 模块引用 B 模块，而 B 模块又引用 A 模块：

- 这个情况大家一听就是有问题的，如果 A 模块要引用 B 模块，那么 B 模块肯定还没有被加载，A 模块就无法引用 B 模块中的内容
- 这样的代码运行起来肯定会报错，提示循环引用的问题 `ImportError: cannot import name '...' from partially initialized module '...' (most likely due to a circular import)`

这里我们使用两个模块 `mynewmodule_a.py` 和 `mynewmodule_b.py` 来演示这个问题：

- 在 `mynewmodule_a.py` 中，我们引用了 `mynewmodule_b.py` 模块：

```python
# mynewmodule_a.py
from mynewmodule_b import func_b

def func_a():
    print("func_a")
```

- 在 `mynewmodule_b.py` 中，我们引用了 `mynewmodule_a.py` 模块：

```python
# mynewmodule_b.py
from mynewmodule_a import func_a

def func_b():
    print("func_b")
```

- 这时候，不论我们是运行 `mynewmodule_a.py` 还是 `mynewmodule_b.py`，都会报错提示循环引用的问题：


```python
# 以下代码会报错，大家取消注释后自行尝试一下
# from mynewmodule_a import func_a
# func_a()
```


```python
# 以下代码会报错，大家取消注释后自行尝试一下
# from mynewmodule_b import func_b
# func_b()
```

为了避免这个问题，我们可以使用**延迟引用**的技巧：

- 比方说我们再定义两个新的模块 `mynewmodule_c.py` 和 `mynewmodule_d.py`，在这两个模块中，我们将引用语句放到函数内部，这样只有在函数被调用时才会进行引用：

- 在 `mynewmodule_c.py` 中：

```python
# mynewmodule_c.py
def func_c():
    print("func_c start")
    from mynewmodule_d import func_d
    print("func_c end")
```

- 在 `mynewmodule_d.py` 中：

```python
# mynewmodule_d.py
def func_d():
    print("func_d start")
    from mynewmodule_c import func_c
    print("func_d end")
```

- 这时候，再运行 `mynewmodule_c.py` 或者 `mynewmodule_d.py`，就不会报错了：


```python
from mynewmodule_c import func_c
func_c()

from mynewmodule_d import func_d
func_d()
```

    func_c start
    func_c end
    func_d start
    func_d end


其实，只要有一个模块中的引用语句被放到了函数内部，就可以避免循环引用的问题。

- 我们再来看一个例子，我们定义一个 `mynewmodule_e.py` 和 `mynewmodule_f.py`，这两个模块中都引用了对方的内容

- 在 `mynewmodule_e.py` 中：

```python
# mynewmodule_e.py
from mynewmodule_f import func_f

def func_e():
    print("func_e")
```

- 在 `mynewmodule_f.py` 中：

```python
# mynewmodule_f.py
def func_f():
    print("func_f start")
    from mynewmodule_e import func_e
    print("func_f end")
```

- 这时候，我们不论运行 `mynewmodule_e.py` 还是 `mynewmodule_f.py`，都不会报错：


```python
from mynewmodule_e import func_e
func_e()

from mynewmodule_f import func_f
func_f()
```

    func_e
    func_f start
    func_f end


事实上，循环引用并不是一个很好的编程习惯，因为程序结构会变得很复杂，难以维护，大家在实际开发中尽量避免这种情况的发生。

## 2. 绝对引用与相对引用

这一节我们关注的重点是，**在同一个包内，不同模块之间如何相互引用**。

在这部分，我们先将上一节的 `mypackage2` 包复制一份，并起名为 `mynewpackage1`，在文件夹结构上作以下调整：

```text
codes/Module1/Topic12/Topic12_03/ # 这是当前目录
│
│── mynewpackage1/
│   │── __init__.py
│   │
│   │── subpackage1/
│   │   │── __init__.py
│   │   │── tool1.py
│   │   │── tool2.py
│   │   │── util1.py  # 新增的模块，当中引用了 tool1.py 和 tool2.py
│   │   │── util2.py  # 新增的模块，当中引用了 tool1.py 和 tool2.py
│   │   │── util3.py  # 新增的模块，当中引用了 tool1.py 和 tool2.py
│   │
│   │── subpackage2/
│       │── __init__.py
│       │── tool3.py
│       │── tool4.py
│       │── util2.py  # 新增的模块，当中引用了 tool1.py 和 tool2.py
│
└── 当前文件.ipynb  # 这是我们运行代码的 Jupyter Notebook 文件
```

### (1) 同一子包中模块的相互引用

在同一包中的模块之间是可以相互引用的，如果引用模块和被引用模块在同一包中，这种情景比较简单，我们可以直接使用相对引用的方式：

- 例如在 `mynewpackage1/subpackage1/util1.py` 中引用 `tool1.py` 和 `tool2.py`：

```python
# mynewpackage1/subpackage1/util1.py
from tool1 import greet
from tool2 import farewell

def welcome_and_farewell(name):
    greeting = greet(name)
    goodbye = farewell(name)
    return f"{greeting} ... {goodbye}"

if __name__ == "__main__":
    print(welcome_and_farewell("Alice"))
```

- 如果我们直接运行 `util1.py`，会输出 `Hello, Alice! ... Goodbye, Alice!`

- 但是如果我们在当前文件中引用 `util1` 模块，却会报错，提示 `ModuleNotFoundError: No module named 'tool1'`


```python
# 以下代码会报错，大家取消注释后可以尝试运行
# from mynewpackage1.subpackage1 import util1
# print(util1.welcome_and_farewell("Eve"))
```

- 为什么会报错呢？这是因为当我们在 `util1.py` 中使用 `from tool1 import greet` 时，Python 会在当前命名空间中查找 `tool1` 模块：

    - 当我们直接运行 `util1.py` 时，`tool1` 模块就在同一包中，因此可以找到
    - 但是当我们在当前文件中引用 `util1` 模块时，`tool1` 模块并不在当前命名空间中，因此找不到

为了解决这个问题，我们需要使用**相对引用**的方式来引用同一包中的模块：

- 我们把 `util1.py` 中的引用先复制到 `util2.py` 中，然后修改为以下内容：

```python
# mynewpackage1/subpackage1/util2.py
from .tool1 import greet
from .tool2 import farewell

def welcome_and_farewell(name):
    greeting = greet(name)
    goodbye = farewell(name)
    return f"{greeting} ... {goodbye}"

if __name__ == "__main__":
    print(welcome_and_farewell("Alice"))
```

- 这里我们使用了 `from .tool1 import greet` 的方式来引用 `tool1` 模块，注意前面的点号 `.`，表示当前包
- 这样，我们在当前文件中引用 `util1` 模块，就不会报错了：


```python
from mynewpackage1.subpackage1 import util2
print(util2.welcome_and_farewell("Eve"))
```

    Hello, Eve! ... Goodbye, Eve!


- 然而，这个时候，当我们直接运行 `util2.py` 时，却会报错，提示 `ImportError: attempted relative import with no known parent package`：

    - 这是因为我们在 VSCode 中直接运行 `util2.py` 时，Python 使用的默认命令是 `python3 ".../codes/Module1/Topic12/Topic12_03/mynewpackage1/subpackage1/util2.py"`
    - 当具体到某个模块文件时，Python 并不知道它属于哪个包，因此无法解析相对引用
    - 因此，如果我们想要测试 `util2.py`，只能在外部文件中引用它（比方说当前 Jupyter Notebook 就在根目录 `Topic12_03/` 中），或者以下命令

    ```bash
    cd codes/Module1/Topic12/Topic12_03/
    python3 -m mynewpackage1.subpackage1.util2
    ```

    - 这个命令先切换到包的根目录下，然后使用 `-m` 参数来运行模块，这样 Python 就知道它属于哪个包了

除了相对引用，我们还可以使用**绝对引用**的方式来引用同一包中的模块：

- 绝对引用指的是从包的根目录开始，逐级指定模块的完整路径

- 这里我们把 `util1.py` 中的引用再复制到 `util3.py` 中，然后修改为以下内容：

```python
# mynewpackage1/subpackage1/util3.py
from mynewpackage1.subpackage1.tool1 import greet
from mynewpackage1.subpackage1.tool2 import farewell

def welcome_and_farewell(name):
    greeting = greet(name)
    goodbye = farewell(name)
    return f"{greeting} ... {goodbye}"

if __name__ == "__main__":
    print(welcome_and_farewell("Alice"))
```

- 然后我们在当前文件中引用 `util3` 模块，同样不会报错了：


```python
from mynewpackage1.subpackage1 import util3
print(util3.welcome_and_farewell("Frank"))
```

    Hello, Frank! ... Goodbye, Frank!


- 同样，如果我们在 VSCode 中直接运行 `util3.py`，也会报错，提示 `ModuleNotFoundError: No module named 'mynewpackage1'`：

    - 这是因为绝对引用需要从包的根目录开始，而直接运行模块文件时，Python 并不知道包的根目录在哪里
    - 因此，同样的道理，如果我们想要测试 `util3.py`，只能在外部文件中引用它（比方说当前 Jupyter Notebook 就在根目录 `Topic12_03/` 中），或者使用以下命令

    ```bash
    cd codes/Module1/Topic12/Topic12_03/
    python3 -m mynewpackage1.subpackage1.util3
    ```

### (2) 跨子包模块的相互引用

如果是引用其他包中的模块，也需要注意使用相对引用的方式，否则也会报错：

- 例如，我们在 `mynewpackage1/subpackage2/util4.py` 中引用 `mynewpackage1/subpackage1/tool1.py` 和 `mynewpackage1/subpackage1/tool2.py`：

```python
# mynewpackage1/subpackage2/util4.py
from ..subpackage1.tool1 import greet
from ..subpackage1.tool2 import farewell

def welcome_and_farewell(name):
    greeting = greet(name)
    goodbye = farewell(name)
    return f"{greeting} ... {goodbye}"

if __name__ == "__main__":
    print(welcome_and_farewell("Alice"))
```

- 这里我们使用了 `from ..subpackage1.tool1 import greet` 的方式来引用 `tool1` 模块，注意前面的两个点号 `..`，表示上一级包
- 这样，我们在当前文件中引用 `util4` 模块，可以正常运行：


```python
from mynewpackage1.subpackage2 import util4
print(util4.welcome_and_farewell("Grace"))
```

    Hello, Grace! ... Goodbye, Grace!


- 和上面提到的问题一样，如果我们直接运行 `util4.py`，也会报错，提示 `ImportError: attempted relative import beyond top-level package`：

    - 这是因为相对引用只能在包中使用，而不能直接在 VSCode 中运行模块文件
    - 因此，如果我们想要测试 `util4.py`，只能在外部文件中引用它（比方说当前 Jupyter Notebook 就在根目录 `Topic12_03/` 中），或者使用以下命令

    ```bash
    cd codes/Module1/Topic12/Topic12_03/
    python3 -m mynewpackage1.subpackage2.util4
    ```

当然，跨子包的情景中，绝对引用也是可以的：

- 例如，我们在 `mynewpackage1/subpackage2/util5.py` 中引用 `mynewpackage1/subpackage1/tool1.py` 和 `mynewpackage1/subpackage1/tool2.py`：

```python
# mynewpackage1/subpackage2/util5.py
from mynewpackage1.subpackage1.tool1 import greet
from mynewpackage1.subpackage1.tool2 import farewell

def welcome_and_farewell(name):
    greeting = greet(name)
    goodbye = farewell(name)
    return f"{greeting} ... {goodbye}"

if __name__ == "__main__":
    print(welcome_and_farewell("Alice"))
```

- 然后我们在当前文件中引用 `util5` 模块，同样不会报错了：


```python
from mynewpackage1.subpackage2 import util5
print(util5.welcome_and_farewell("Helen"))
```

    Hello, Helen! ... Goodbye, Helen!


- 和上面的问题一样，如果我们直接运行 `util5.py`，也会报错，提示 `ModuleNotFoundError: No module named 'mynewpackage1'`：

    - 这是因为绝对引用需要从包的根目录开始，而直接运行模块文件时，Python 并不知道包的根目录在哪里
    - 因此，同样的道理，如果我们想要测试 `util5.py`，只能在外部文件中引用它（比方说当前 Jupyter Notebook 就在根目录 `Topic12_03/` 中），或者使用以下命令

    ```bash
    cd codes/Module1/Topic12/Topic12_03/
    python3 -m mynewpackage1.subpackage2.util5
    ```

### (3) 相对引用和绝对引用的注意事项

首先，在相对引用中，我们已经见识到了点号 `.` 和双点号 `..` 的用法：

- 事实上，大家应该已经发现规律了，点号的数量表示当前包的层级：

    - 一个点号 `.` 表示当前包
    - 两个点号 `..` 表示上一级包
    - 三个点号 `...` 表示上上一级包
    - 以此类推

- 然而在实际开发中，如果引用层级太多，使用相对引用会变得非常复杂且难以维护：

    - 例如，如果我们需要从一个子包中的模块引用另一个子包中的模块，可能需要使用多个点号来表示层级
    - 这时，我们就要考虑直接使用绝对引用的方式来引用模块

除此之外，无论是相对引用还是绝对引用，都需要注意一个问题，那就是 Python 包和电脑中的文件还是有区别的：

- Python 包中要想实现相互引用，必须要满足的一个条件是，这个包必须是一个合法的 Python 包，也就是说，包文件夹中必须包含一个 `__init__.py` 文件

- 如果哪个层级中少了 `__init__.py` 文件，那么这个包就不是一个合法的 Python 包，包的层级链条就会断掉，引用时就会报错

- 因此，在创建自定义包时，一定要记得在每个包和子包文件夹中都创建一个名为 `__init__.py` 的空文件

其实，大家应该已经发现了，使用绝对引用和相对引用，这种方法是有利有弊的：

- 优点在于，可以实现包内模块的相互引用，增强了代码的组织性和可维护性
- 缺点在于，引用方式比较复杂，而且在直接运行模块文件时，可能会遇到各种报错

因此，一个万金油，就是 `sys.path`：

- 这种方法其实是遭到很多专业开发者鄙弃的，因为它破坏了包的封装性和模块的独立性
- 但是我们商业分析专业的学生基本上不会去写复杂的包结构代码，很少接触工程级 Python 开发
- 所以使用 `sys.path` 这种方法来解决引用问题也是可以接受的，只要大家管理好路径即可

## 3. 通过 `__init__.py` 文件来管理包的接口

在开发 Python 包时，一个常见的需求就是：

- 如果包的层级太复杂，用户在引用包的时候就要层层指定模块路径，使用起来非常不方便
- 这时我们就可以通过 `__init__.py` 文件来管理包的接口，简化用户的引用方式

### (1) 将包或子包中的模块导入到 `__init__.py` 文件中

首先，我们先把上一节的 `mypackage2` 包复制一份，并起名为 `mynewpackage2`，在文件夹结构上作以下调整：

```text
codes/Module1/Topic12/Topic12_03/ # 这是当前目录
│
│── mynewpackage2/
│   │── __init__.py
│   │
│   │── subpackage1/
│   │   │── __init__.py
│   │   │── tool1.py        # greet 函数在这里定义
│   │   │── tool2.py        # farewell 函数在这里定义
│   │
│   │── subpackage2/
│       │── __init__.py
│       │── tool3.py        # apologize 函数在这里定义
│       │── tool4.py        # thank 函数在这里定义
│
└── 当前文件.ipynb  # 这是我们运行代码的 Jupyter Notebook 文件
```

在当前的目录结构中：

- 用户如果想用 `greet` 函数，就必须要引用 `mynewpackage2.subpackage1.tool1`
- 如果我们觉得这样的引用方式太麻烦了，可以通过修改 `mynewpackage2/subpackage1/__init__.py` 文件来简化引用方式：

```python
# mynewpackage2/subpackage1/__init__.py
from .util1 import welcome_and_farewell
```

- 这样，外部访问者在引用 `mynewpackage2.subpackage1` 包时，就可以直接使用 `greet` 函数，而不需要具体到 `tool1.py`：


```python
from mynewpackage2.subpackage1 import greet
print(greet("Ivy"))
```

    Hello, Ivy!


- 然而，这样做并不代表原来完整的引用路径就不能用了：

    - 现在只是多了一种更简洁的引用方式 `from mynewpackage2.subpackage1 import greet`
    - 用户仍然可以使用 `from mynewpackage2.subpackage1.tool1 import greet` 的方式来引用 `greet` 函数
    


```python
from mynewpackage2.subpackage1.tool1 import greet
print(greet("Jack"))
```

    Hello, Jack!


其实大家可以发现，这种做法其实就是把包中功能往前挪了，当然可以不止挪一层：

- 例如，我们接下来把 `mynewpackage2/subpackage2/tool3.py` 中的 `apologize` 函数导入到 `mynewpackage2/__init__.py` 文件中：

```python
# mynewpackage2/__init__.py
from .subpackage2.tool3 import apologize
```

- 这样，如果想使用 `apologize` 函数，用户就可以直接引用 `mynewpackage2` 包，而不需要具体到 `subpackage2.tool3` 模块：


```python
from mynewpackage2 import apologize
print(apologize("Kate"))
```

    Sorry, Kate.


### (2) 在 `__init__.py` 文件中定义 `__all__` 列表

本小节之前，我们先把上一节的 `mypackage2` 包复制一份，并起名为 `mynewpackage3`，在文件夹结构上作以下调整（我们先把所有 `__init__.py` 文件清空）：

```text
codes/Module1/Topic12/Topic12_03/ # 这是当前目录
│
│── mynewpackage3/
│   │── __init__.py
│   │
│   │── subpackage1/
│   │   │── __init__.py
│   │   │── tool1.py        # greet 函数在这里定义
│   │   │── tool2.py        # farewell 函数在这里定义
│   │
│   │── subpackage2/
│       │── __init__.py
│       │── tool3.py        # apologize 函数在这里定义
│       │── tool4.py        # thank 函数在这里定义
│
└── 当前文件.ipynb  # 这是我们运行代码的 Jupyter Notebook 文件
```



在 `__init__.py` 文件中，我们还可以定义一个名为 `__all__` 的列表，用来指定包的公共接口，也就是，用户在使用 `from package import *` 的方式引用包时，哪些模块或函数会被导入：

- 例如，如果我们想让用户在引用 `from mynewpackage3.subpackage1 import *` 时，能导入 `greet` 函数与 `farewell` 函数：

- 我们就可以先在 `mynewpackage3/subpackage1/__init__.py` 文件中导入 `greet` 函数与 `farewell` 函数：

- 再在 `mynewpackage3/subpackage1/__init__.py` 文件中定义 `__all__` 列表，注意所有的功能写成字符串类型：

```python
# mynewpackage3/subpackage1/__init__.py
from .tool1 import greet
from .tool2 import farewell

__all__ = ["greet", "farewell"]
```

- 这样，当用户使用 `from mynewpackage3.subpackage1 import *` 时，就会导入 `greet` 函数与 `farewell` 函数：




```python
from mynewpackage3.subpackage1 import *
print(greet("Liam"))
print(farewell("Mia"))
```

    Hello, Liam!
    Goodbye, Mia!


## 4. 小结

相信学完这一小节之后，大部分同学都是云里雾里的：

- 再次强调，这些高级技巧对于商业分析专业的同学们来说，并不是很实用，大家只需要知道这些技巧的存在即可
- 我们的目的是能够看懂别人写的代码，而不是自己去写复杂的包结构代码

这里给大家总结一下重要的几点，作为大家以后自定义模块与包时的参考：

- 包的结构一定要简单，基本上所有模块放到一个包中就可以了，不要有子包，这样就不用考虑什么绝对引用与相对引用的问题，而且 `__init__.py` 文件也可以直接为空
- 甚至可以不用创建包，就是不要 `__init__.py`，直接把模块放到一个文件夹中即可
- 如果要引用其它路径的模块，可以使用 `sys.path` 来添加路径，注意一定要管理好路径
- 尽量避免模块之间的循环引用
