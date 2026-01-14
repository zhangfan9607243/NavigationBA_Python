# Topic 12.2 - 自定义模块与包

## 1. 自定义模块

### (1) 创建自定义模块

在 Python 中，我们是可以自己创建模块的，而且方式我们上一章介绍过：自定义模块就是创建一个 Python 文件，并在其中定义函数、类和变量等内容。

我们来看以下例子：

- 我们创建一个名为 `mymodule1.py` 的文件，在其中定义一些函数和变量：

    ```python
    def add(x, y):
        return x + y

    def subtract(x, y):
        return x - y

    PI = 3.14
    ```

- 然后我们就可以在其他 `.py` 或 `.ipynb` 文件中引用这个模块，注意，新文件必须和自定义模块在同一目录下：


```python
import mymodule1

print(mymodule1.add(5, 3))
print(mymodule1.subtract(5, 3))
print(mymodule1.PI)
```

    8
    2
    3.14


- 除了在本 `.ipynb` 文件引用外，我们再创建一个新的 `.py` 文件 `test_mymodule1.py`，尝试在 `.py` 文件中引用自定义模块`

- 注意，我们这里展示了使用 `import 模块名` 的方式引用自定义模块，上一章讲到的其他引用方式也是完全适用的。

运行完这段代码，我们会发现 `mypackage` 文件夹中多了一个 `__pycache__` 文件夹：

- 这是 Python 在引用时自动生成的缓存文件夹，用于存放编译后的字节码文件，以提高下次引用的速度
- 我们一般不需要关心这个文件夹，可以忽略它，删除了也不会影响包的使用

通过这种方式，我们就可以将代码进行模块化管理：

- 我们并不需要把所有代码都写在一个文件中，而是可以根据功能将代码拆分到不同的模块中
- 这样不仅可以让代码结构更加清晰，还能提高代码的可维护性，当我们需要使用某个功能时，只需引用对应的模块即可

### (2) 引用其他目录下的自定义模块

如果我们目前的 Python 文件和自定义模块不在同一目录下，就会导致 `ModuleNotFoundError` 错误。

这时，我们可以使用 `sys.path` 来添加模块所在目录到系统路径中，从而实现引用。

例如：

- 我们把相同的代码复制到一个新的文件 `mymodule2.py` 中

    ```python
    def add(x, y):
        return x + y

    def subtract(x, y):
        return x - y

    PI = 3.14
    ```

- 我们把 `mymodule2.py` 放在一个名为 `other_path` 的子目录下，然后我们在当前目录下引用它

- 文件目录结构为：

    ```text
    codes/Module1/Topic12/Topic12_02/ # 这是当前目录
    │
    │── other_path/
    │   │
    │   └── mymodule2.py
    │
    └── 当前文件.ipynb  # 这是我们运行代码的 Jupyter Notebook 文件
    ```

- 但是，Jupyter Notebook 在引用的时候比较麻烦，因为它必须指定绝对路径，我们还需要使用 `os` 模块来获取当前 Notebook 所在目录，然后拼接出目标路径：


```python
# 自动获取当前 Notebook 所在目录
import os
notebook_dir = os.path.dirname(os.path.abspath("__file__"))
target_path = notebook_dir + "/other_path"
```


```python
# 将目标路径添加到 sys.path 中
import sys
sys.path.append(target_path)

import mymodule2

print(mymodule2.add(5, 3))
print(mymodule2.subtract(5, 3))
print(mymodule2.PI)
```

    8
    2
    3.14


- 但是，如果是 `.py` 文件，就相对简单一些，可以直接使用相对路径，我们尝试在 `test_mymodule2.py` 文件中引用 `mymodule2` 模块

我们这里举例是放在了同级子目录下：

- 事实上 `sys.path.append` 中的路径可以是任意路径，只要确保路径正确即可
- 因此在实际开发中，我们可以根据需要将自定义模块放在任何目录下，然后通过 `sys.path.append` 来引用

### (3) 引用自定义模块时的注意事项

#### (a) 模块名要符合 Python 命名规范

在创建自定义模块时，我们需要注意模块名的命名规范，和 Python 标识符命名规范一致：
- 必须遵守：模块名只能包含字母、数字和下划线，且不能以数字开头（**这就是为什么我给 Python 文件命名时不用数字开头且不用空格**）
- 推荐遵守：模块名最好使用小写字母和下划线，并且避免与其他常用的模块名冲突

#### (b) 模块被引用时会先执行一遍

在引用自定义模块时，Python 实际上会将模块文件先执行一遍：

- 这意味着如果模块文件中有一些不必要的代码（例如打印语句或测试代码），这些代码在引用模块时也会被执行：
- 我们把之前相同的代码复制到 `mymodule3.py` 中，就放在当前目录即可，并且尝试在 `mymodule3.py` 中添加一些打印语句：

    ```python
    def add(x, y):
        return x + y

    def subtract(x, y):
        return x - y

    PI = 3.14
    print(f"PI 的值是 {PI}")
    ```

- 当我们引用这个模块时，会发现其中的打印语句也被执行了：


```python
import mymodule3
print(mymodule3.add(5, 3))
```

    8


为了避免这种情况，我们通常会在模块文件中使用 `if __name__ == "__main__":` 语句来保护这些不必要的代码：

- `__name__` 是 Python 中的一个特殊变量

    - 当模块被直接运行时，`__name__` 的值为 `"__main__"`
    - 而当模块被引用时，`__name__` 的值为模块的名称 

- 因此，我们可以将不必要的代码放在 `if __name__ == "__main__":` 语句块中

    - 这样只有在直接运行模块时这些代码才会被执行
    - 而在引用模块时则不会被执行

我们来尝试把以下代码复制到 `mymodule4.py` 中，就放在当前目录，并且添加 `if __name__ == "__main__":` 语句：

```python
def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

PI = 3.14

if __name__ == "__main__":
    print(f"PI 的值是 {PI}")
```

- 这样，当我们直接运行 `mymodule4.py` 时，打印语句会被执行，我们可以尝试直接运行一下 `mymodule4.py`
- 而当我们在其他文件中引用 `mymodule4` 时，打印语句则不会被执行，我们可以尝试在当前文件中引用 `mymodule4`：



```python
import mymodule4
print(mymodule4.add(5, 3))
```

    8


其实，`if __name__ == "__main__":` 是 Python 开发中的一个惯用语法，我们在后续的学习中还会经常遇到。

#### (c) 模块引用时的命名空间问题

在引用模块时，不仅要注意自定义的模块中定义了哪些内容，还要注意自定义模块中导入的其他模块，否则就会产生很复杂的命名空间冲突的问题。

- 我们来看以下例子，我们把同样的代码复制到 `mymodule5.py` 中，并且在其中导入了 `math` 模块：

    ```python
    import math

    def add(x, y):
        return x + y

    def subtract(x, y):
        return x - y

    PI = 3.14

    if __name__ == "__main__":
        print(f"PI 的值是 {PI}")
    ```

- 这时，`math` 和 `sqrt` 就都是 `mymodule5` 模块中的内容了

- 当我们引用 `mymodule5` 模块时，`math` 和 `sqrt` 也会被导入到当前命名空间中：


```python
# 使用 import 导入模块
import mymodule5
print(mymodule5.add(5, 3))
print(mymodule5.math.log(5))  # 注意这里必须通过 mymodule5.math 访问 math 模块
print(mymodule5.sqrt(16))     # 注意这里必须通过 mymodule5.sqrt 访问 sqrt 函数
```

    8
    1.6094379124341003
    4.0



```python
# 如果使用 from 导入
from mymodule5 import add, math, sqrt
print(add(5, 3))
print(math.log(5))  # 直接使用 math 访问 math 模块
print(sqrt(16))     # 直接使用 sqrt 函数
```

    8
    1.6094379124341003
    4.0



```python
# 如果使用 from ... import * 导入 - 不推荐使用这种方式，除非你非常清楚会导入哪些内容
from mymodule5 import *
print(add(5, 3))
print(math.log(5))  # 直接使用 math 访问 math 模块
print(sqrt(16))     # 直接使用 sqrt 函数
```

    8
    1.6094379124341003
    4.0


这里我们再次强调，引用自定义模块时，一定要注意模块中导入的其他模块，不要和当前命名空间中的名称冲突。

## 2. 自定义包

### (1) 创建自定义包

在上一章我们讲到过，包其实就是将多个模块放到一个文件夹里，我们自己也可以通过这个方式来创建包。

例如，我们创建一个名为 `mypackage1` 的文件夹，并在其中创建两个模块文件 `tool1.py` 和 `tool2.py`

- 其中 `tool1.py` 的代码如下：

    ```python
    def greet(name):
        return f"Hello, {name}!"
    ```

- 其中 `tool2.py` 的代码如下：

    ```python
    def farewell(name):
        return f"Goodbye, {name}!"
    ```

- 接着，最重要的一步，我们需要在 `mypackage1` 文件夹中创建一个名为 `__init__.py` 的空文件，这个文件告诉 Python 这个文件夹是一个包

- 这些操作下来，我们的文件目录结构如下：

    ```text
    codes/Module1/Topic12/Topic12_02/ # 这是当前目录
    │
    │── mypackage1/
    │   │── __init__.py
    │   │── tool1.py
    │   │── tool2.py
    │
    └── 当前文件.ipynb  # 这是我们运行代码的 Jupyter Notebook 文件
    ``` 

之后，我们就可以在当前文件中引用这个包中的模块了：


```python
from mypackage1 import tool1, tool2

print(tool1.greet("Alice"))
print(tool2.farewell("Bob"))
```

    Hello, Alice!
    Goodbye, Bob!


当然，我们这里展示了使用 `from 包名 import 模块名` 的方式引用包中的模块，上一章讲到的其他引用方式也是完全适用的。


这里我们简单了解了以下自定义包的基本用法，其实自定义包中有些注意事项是和自定义模块类似的，我们这里简单总结以下，就不再赘述了：

- 包的路径如果不在当前目录下，可以使用 `sys.path.append` 来添加包所在目录到系统路径中
- 包名要符合 Python 命名规范
- 包被引用时，当中的所有模块会先执行一遍，因此要加上 `if __name__ == "__main__":` 语句来保护不必要的代码
- 包引用会将包中所有模块的命名空间导入到当前命名空间

### (2) 创建带有子包的自定义包

当然，我们还可以创建带有子包的自定义包：

- 例如，我们创建一个名为 `mypackage2` 的文件夹：

    - 在其中创建一个子包文件夹 `subpackage1`，以及两个模块文件 `tool1.py` （Hello） 和 `tool2.py` （Goodbye） 
    - 在其中创建一个子包文件夹 `subpackage2`，以及两个模块文件 `tool3.py` （Sorry） 和 `tool4.py` (Thanks)

- 最重要的是在每个包和子包文件夹中都要创建一个名为 `__init__.py` 的空文件，这个文件告诉 Python 这个文件夹是一个包或子包
- 这样操作下来，我们的文件目录结构如下：

```text
codes/Module1/Topic12/Topic12_02/ # 这是当前目录
│
│── mypackage2/
│   │── __init__.py
│   │
│   │── subpackage1/
│   │   │── __init__.py
│   │   │── tool1.py
│   │   │── tool2.py
│   │
│   │── subpackage2/
│       │── __init__.py
│       │── tool3.py
│       │── tool4.py
│
└── 当前文件.ipynb  # 这是我们运行代码的 Jupyter Notebook 文件
```

之后，我们就可以在当前文件中引用这个包中的子包和模块了：


```python
from mypackage2.subpackage1 import tool1, tool2
from mypackage2.subpackage2 import tool3, tool4

print(tool1.greet("Alice"))
print(tool2.farewell("Bob"))
print(tool3.apologize("Charlie"))
print(tool4.thank("Diana"))
```

    Hello, Alice!
    Goodbye, Bob!
    Sorry, Charlie.
    Thank you, Diana!





