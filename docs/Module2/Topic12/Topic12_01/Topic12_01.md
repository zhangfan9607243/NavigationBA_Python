# Topic 12.1 - 模块与包的引用

## 1. 模块引用：使用 `import` 关键字

### (1) 模块引用：使用 `import 模块名` 的形式

我们目前其实已经接触过一些模块了，比如说 `math` 模块和 `random` 模块。

我们在使用这些模块时：

- 引用的格式是 `import 模块名` 的形式
- 调用的格式是 `模块名.功能名` 的形式

```python
import math

print(math.sqrt(16))
```

```text
4.0
```

`import` 语句可以将整个模块导入到当前的**命名空间**中

- **命名空间**可以理解为当前的 Python 环境中定义了哪些变量和函数
- 在上述代码中，通过 `import` 语句导入 `math` 模块后，`math` 这个名字就会成为当前环境中的一个东西，我们在自己命名变量或函数时就要避免使用 `math` 这个名字，否则会发生冲突
- 如果发生命名冲突，并不会报错，而是后定义的会覆盖先定义的（**有时候不报错反而问题更大，会让我们忽略问题**）

### (2) 模块引用：使用 `import 模块名.功能名` 的形式

有时候我们并不需要使用模块中的所有功能，如果只调取其中的某几个功能：

- 引用的格式是 `import 模块名.功能名` 的形式
- 调用的格式是 `模块名.功能名` 的形式
- 注意，这种方式并不会把整个模块导入到当前的命名空间中，也不会把该模块中的其他功能导入到当前的命名空间中

我们尝试只引用 `math` 模块中的 `sqrt` 功能：

```python
import math.sqrt
print(math.sqrt(16))
```

```text
4.0
```

如果我们尝试调用 `math` 模块中的其他功能，比如 `log` 功能，就会报错：

```python
import math.sqrt
print(math.log(10))  # 这里会报错，因为我们并没有把 math 模块导入到当前的命名空间中
```

```text
AttributeError: module 'math' has no attribute 'log'
```

因此，如果我们想使用模块中的其他功能，还是需要再引用：

- 要么再次使用 `import 模块名` 语句把整个模块导入，或者再次使用 `import 模块名.功能名` 的方式把需要的功能都导入
- 我们推荐这两种方式，只使用其中的一种，而不是混用，否则会让代码变得混乱，不容易阅读和维护

```python
# 推荐写法1
import math

# 推荐写法2
import math.sqrt
import math.log

# 不推荐的写法
import math
import math.sqrt
import math.log
```

## 2. 模块引用：使用 `from` 与 `import` 语句

### (1) 模块引用：使用 `from` 与 `import` 语句引用特定功能

还有一种引用的方式是使用 `from` 与 `import` 语句来引用模块中的特定功能：

- 引用格式为 `from 模块名 import 功能名`，
- 调用格式为 `功能名`，注意在这种引用方式下，我们**直接使用 `功能名`** 来调用模块中的功能，而不需要再加上 `模块名.` 前缀

```python
from math import sqrt

print(sqrt(16))
```

```text
4.0
```

在这段代码中：

- 我们把 `sqrt` 导入到了当前的命名空间中
- 我们自己定义的变量或函数就不能使用 `sqrt` 这个名字，否则就会发生冲突

使用 `from` 与 `import` 语句还可以引用模块中的多个功能：

```python
from math import sqrt, exp, pi
# from math import (sqrt, exp, pi) # 也可以使用括号来把所有功能括起来

print(sqrt(16))
print(exp(1))
print(pi)
```

```text
4.0
2.718281828459045
3.141592653589793
```

在这段代码中：

- 我们把 `sqrt`、`exp` 和 `pi` 都导入到了当前的命名空间中
- 我们自己定义的变量或函数就不能使用 `sqrt`、`exp` 和 `pi` 这些名字，否则就会发生冲突
- 如果发生命名冲突，后定义的会覆盖先定义的

要注意，如果使用 `from 模块名 import 功能名` 这种方式导入：

- **模块名**并没有被导入到当前命名空间中  
- 该模块中的**其他功能**也没有被导入到当前命名空间中

```python
from math import sqrt, exp, pi

print(math.sqrt(16))  # 这里会报错，因为 math 并没有被导入
print(log(10))  # 这里会报错，因为 log 并没有被导入
```

```text
NameError: name 'math' is not defined
NameError: name 'log' is not defined
```

因此，如果我们想使用模块中的其他功能，还是需要再引用：

- 要么再次使用 `import` 语句把整个模块导入，或者再次使用 `from 模块名 import 功能名` 的方式把需要的功能都导入
- 同样，我们推荐这两种方式，只使用其中的一种，而不是混用，否则会让代码变得混乱，不容易阅读和维护

```python
# 推荐写法1
import math

# 推荐写法2
from math import sqrt, exp, pi

# 不推荐的写法
import math
from math import sqrt, exp, pi
```


### (2) 模块引用：使用 `from` 与 `import` 语句引用所有功能

我们还可以使用 `from` 与 `import` 语句引用模块中的所有功能：

- 引用格式为 `from 模块名 import *`
- 调用格式为 `功能名`，同样，在这种引用方式下，我们**直接使用 `功能名`** 来调用模块中的功能，而不需要再加上 `模块名.` 前缀

我们来尝试引用 `math` 模块中的所有功能：

```python
from math import *
print(sqrt(16))
print(exp(1))
print(pi)
print(log(10))
```

```text
4.0
2.718281828459045
3.141592653589793
2.302585092994046
```

注意：

- 这种方式会把模块中的**所有功能都导入到当前的命名空间中**，很可能会导致命名冲突
- 除非我们知道模块中所有功能的名字，并且能保证这些名字不会与我们自己定义的变量或函数冲突，否则**不建议使用这种方式**

我们来看一个命名冲突的例子：

```python
from math import *

def log(x):
    return f"这是我学习Python的第{x}天，加油！"

print(log(10))  # 这里会调用我们自己定义的 log 函数，而不是 math 模块中的 log 函数
```

```text
这是我学习Python的第10天，加油！
```

在这段代码中：

- 我们使用 `from math import *` 导入了 `math` 模块中的所有功能，其中就有一个 `log` 函数
- 然后我们又自己定义了一个 `log` 函数
- 由于我们自己定义的 `log` 函数覆盖了 `math` 模块中的 `log` 函数，所以当我们调用 `log(10)` 时，实际上调用的是我们自己定义的函数，而不是 `math` 模块中的函数

## 3. 模块引用方式的小结

目前为止我们讲了5种引用模块的方式，我们来做个简单总结：

| 引用方式                         | 调用方式           | 导入内容                     | 备注                         |
| ------------------------------ | ---------------- | -------------------------- | -------------------------- |
| `import 模块名`                 | `模块名.功能名`    | 导入整个模块                 | 推荐                         |
| `import 模块名.功能名`          |  `模块名.功能名`    | 只导入指定的功能               | 推荐                         |
| `from 模块名 import 功能名`     | `功能名`         | 只导入指定的功能               | 推荐                         |
| `from 模块名 import 功能名1, 功能名2` | `功能名`         | 只导入指定的多个功能             | 推荐                         |
| `from 模块名 import *`            | `功能名`         | 导入模块中的所有功能            | 不推荐，容易导致命名冲突 |

## 4. 模块引用：使用 `as` 关键字为模块或功能指定别名

在将模块或功能导入到当前命名空间时，我们还可以使用 `as` 关键字为模块或功能指定一个别名，有如下的具体形式：

- `import 模块名 as 模块别名`：调用时使用 `模块别名.功能名`

```python
import math as m
print(m.sqrt(16))
```

```text
4.0
```


- `from 模块名 import 功能名 as 功能别名`：调用时使用 `功能别名`

```python
from math import sqrt as genhao
print(genhao(16))

from math import exp as e_de_cifang
print(e_de_cifang(1))
```

```text
4.0
2.718281828459045
```

## 5. 包的引用

### (1) 模块与包的基本概念

很多同学在学习 Python 的过程中，并不会去区分**模块（module）**与**包（package）**的区别，并且，事实上，我们在后续的学习过程中也会越来越淡化这两者的区别：

- 但是它俩的区别其实说来很简单：**包就是多个模块的文件夹**
- 并且我们知道，文件夹里不光有文件，还有子文件夹，所以**包里还可以有子包，子包里可以有模块**
- 所以，包、子包、模块、功能，这些概念的层级关系是：**`包 ⊂ 子包 ⊂ 模块 ⊂ 功能`**

因此，考虑到这种层级关系，我们在引用包中的模块时，引用格式会变得稍微复杂一些，但是也很容易理解，比如：

- `import 包名.模块名`，之后调用时使用 `包名.模块名.功能名`
- `import 包名.子包名.模块名`，之后调用时使用 `包名.子包名.模块名.功能名`
- `from 包名.模块名 import 功能名`，之后调用时使用 `功能名`
- `from 包名.子包名.模块名 import 功能名`，之后调用时使用 `功能名`

这里我们举例一些常见的模块和包：

- 我们目前接触到的模块（module）有：`math`、`random`、`json`、`csv`
- 我们后续会接触的包（package）有：`numpy`、`pandas`、`matplotlib`

### (2) 包与模块的层级关系

在 Python 中：

- **模块**是一个包含 Python 代码的文件（其实大家创建了这么多的 Python 文件，就是创建了一个个模块）
- **包**是一个包含多个模块的文件夹，文件夹中必须包含一个名为 `__init__.py` 的文件，这个文件告诉 Python 这个文件夹是一个包

我们拿 `xml` 包来举例：

- `xml` 包是 Python 内置的一个包，其功能是处理 XML 数据
- 我们这里不讲解 `xml` 包的具体功能，只是用它来说明包与模块的区别，因为 `xml` 是 Python 包中结构比较清晰的一个例子

完整的 `xml` 包的目录结构如下：

```
xml/                          ← 顶层包
│
├── __init__.py                   ← 包初始化
│
├── dom/                          ← 子包：DOM 解析
│   ├── __init__.py                   ← 子包初始化 
│   ├── minidom.py                    ← 模块：DOM 解析接口
│   └── pulldom.py                    ← 模块：增量式 DOM 解析
│
├── etree/                        ← 子包：ElementTree API 实现
│   ├── __init__.py                   ← 子包初始化
│   └── ElementTree.py                ← 模块：ElementTree
│
├── parsers/                      ← 子包：解析器底层绑定
│   ├── __init__.py                   ← 子包初始化
│   └── expat.py                      ← 模块：Expat 解析接口
│
└── sax/                          ← 子包：SAX 解析器
    ├── __init__.py                   ← 子包初始化
    ├── handler.py                    ← 模块：SAX 处理器
    ├── saxutils.py                   ← 模块：SAX 工具函数
    ├── xmlreader.py                  ← 模块：XML 读取器
    └── expatreader.py                ← 模块：Expat 读取器
```

这里我们可以清晰地看到包与模块的层级关系，例如：

- `minidom` 模块位于 `xml` 包的 `dom` 子包中，要想引用这个模块须要 `import xml.dom.minidom`
- `ElementTree` 模块位于 `xml` 包的 `etree` 子包中，要想引用这个模块须要 `import xml.etree.ElementTree`

以下代码不理解没关系，你只需要知道 `xml.dom.minidom` 和 `xml.etree.ElementTree` 这两个模块调用成功即可：

```python
import xml.dom.minidom
doc = xml.dom.minidom.parseString("<root><a>1</a></root>")
print(doc.documentElement.tagName)

import xml.etree.ElementTree as ET
root = ET.fromstring("<root><child>hi</child></root>")
print(root.tag)
```

```text
root
root
```