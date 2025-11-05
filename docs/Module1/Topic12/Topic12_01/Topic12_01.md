# Topic 12.1 - 模块与包的引用


## 1. 模块与包的区分

模块（Module）和包（Package）这两个东西可以统称为“库”（Library），它们都是为了代码的复用而设计的。

这两个概念的区别其实很简单：

- **模块**：就是一个以 `.py` 结尾的 Python 源代码文件

    - 这个我们其实比较熟悉了，因为我们自己也会去创建 `.py` 文件来编写代码，其实我们创建的一个个 `.py` 文件就是一个个模块
    - 模块中可以定义各种变量、函数、类等**功能**，这些功能可以带到其他模块中去使用，从而实现代码的复用
    - 我们之前引用的其他模块，有些就是以 `.py` 文件形式存在的，当然还有些不是以 `.py` 文件编写的，例如 `math` 模块就是用 C 语言编写的
    - 我们可以在 Python 安装目录中的 `lib` 目录下找到哪些模块是以 `.py` 文件形式存在的

- **包**：就是一个包含多个模块，也就是多个 `.py` 文件的文件夹，文件夹中包含一个名为 `__init__.py` 的初始化文件

    - 包当的思想其实就是把多个相关的模块放在一个文件夹中，方便管理和使用
    - 当然包文件夹中还可能包括子文件夹，这些子文件夹也可以看作是**子包**，子包中也可以包含多个模块

- 因此，一句话总结模块和包的关系，那就是：**`包 ⊂ 子包 ⊂ 模块 ⊂ 功能`**


这里我们举例一些常见的模块和包：

- 常用的模块（module）有：`math`、`random`、`json`、`csv`
- 常用的包（package）有：`numpy`、`pandas`、`matplotlib`

其实模块和包这两个概念，同学们在后续的学习和工作中，会越来越淡化这二者的区别，因为除非搞专业 Python 开发，否则这两者后续大家就统称为“库”就可以了。

## 2. 模块的引用

### (1) 模块引用：使用 `import 模块名` 的形式

我们目前其实已经接触过一些模块了，比如说 `math` 模块和 `random` 模块。

我们在使用这些模块时：

- 引用的格式是 `import 模块名` 的形式
- 调用的格式是 `模块名.功能名` 的形式


```python
import math

print(math.sqrt(16))
```

    4.0


`import` 语句可以将整个模块导入到当前的**命名空间**中

- **命名空间**可以理解为当前的 Python 环境中定义了哪些变量和函数
- 在上述代码中，通过 `import` 语句导入 `math` 模块后，`math` 这个名字就会成为当前环境中的一个东西，我们在自己命名变量或函数时就要避免使用 `math` 这个名字，否则会发生冲突
- 如果发生命名冲突，并不会报错，而是后定义的会覆盖先定义的（**有时候不报错反而问题更大，会让我们忽略问题**）

### (2) 模块引用：使用 `from` 与 `import` 语句引用特定功能

还有一种引用的方式是使用 `from` 与 `import` 语句来引用模块中的特定功能：

- 引用格式为 `from 模块名 import 功能名`，
- 调用格式为 `功能名`，注意在这种引用方式下，我们**直接使用 `功能名`** 来调用模块中的功能，而不需要再加上 `模块名.` 前缀



```python
from math import sqrt

print(sqrt(16))
```

    4.0


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

    4.0
    2.718281828459045
    3.141592653589793


在这段代码中：

- 我们把 `sqrt`、`exp` 和 `pi` 都导入到了当前的命名空间中
- 我们自己定义的变量或函数就不能使用 `sqrt`、`exp` 和 `pi` 这些名字，否则就会发生冲突
- 如果发生命名冲突，后定义的会覆盖先定义的

要注意，如果使用 `from 模块名 import 功能名` 这种方式导入：

- **模块名**并没有被导入到当前命名空间中  
- 该模块中的**其他功能**也没有被导入到当前命名空间中


```python
# 以下代码会报错，请取消注释后尝试运行
# from math import sqrt, exp, pi

# print(math.sqrt(16))  # 这里会报错，因为 math 并没有被导入
# print(log(10))  # 这里会报错，因为 log 并没有被导入
```

因此，如果我们想使用模块中的其他功能，还是需要再引用：

- 要么再次使用 `import` 语句把整个模块导入，或者再次使用 `from 模块名 import 功能名` 的方式把需要的功能都导入
- 所以，我们推荐这两种方式只使用其中的一种，而不是混用，否则会让代码变得混乱，不容易阅读和维护

```python
# 推荐写法1
import math

# 推荐写法2
from math import sqrt, exp, pi

# 不推荐的写法
import math
from math import sqrt, exp, pi
```

### (3) 模块引用：使用 `from` 与 `import` 语句引用所有功能

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

    4.0
    2.718281828459045
    3.141592653589793
    2.302585092994046


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

    这是我学习Python的第10天，加油！


在这段代码中：

- 我们使用 `from math import *` 导入了 `math` 模块中的所有功能，其中就有一个 `log` 函数
- 然后我们又自己定义了一个 `log` 函数
- 由于我们自己定义的 `log` 函数覆盖了 `math` 模块中的 `log` 函数，所以当我们调用 `log(10)` 时，实际上调用的是我们自己定义的函数，而不是 `math` 模块中的函数


### (4) 模块引用方式的小结

目前为止我们讲了以下几种引用模块的方式，我们来做个简单总结：

| 引用方式                         | 调用方式           | 导入内容                     | 备注                         |
| ------------------------------ | ---------------- | -------------------------- | -------------------------- |
| `import 模块名`                 | `模块名.功能名`    | 导入整个模块                 | 推荐                         |
| `from 模块名 import 功能名`     | `功能名`         | 只导入指定的功能               | 推荐                         |
| `from 模块名 import 功能名1, 功能名2` | `功能名`         | 只导入指定的多个功能             | 推荐                         |
| `from 模块名 import *`            | `功能名`         | 导入模块中的所有功能            | 不推荐，容易导致命名冲突 |


## 3. 使用 `as` 关键字起别名

在将模块或功能导入到当前命名空间时，我们还可以使用 `as` 关键字为模块或功能指定一个别名，有如下的具体形式：

- `import 模块名 as 模块别名`：调用时使用 `模块别名.功能名`


```python
import math as m
print(m.sqrt(16))
```

    4.0


- `from 模块名 import 功能名 as 功能别名`：调用时使用 `功能别名`


```python
from math import sqrt as genhao
print(genhao(16))

from math import exp as e_de_cifang
print(e_de_cifang(1))
```

    4.0
    2.718281828459045


## 4. 包的引用

### (1) 包的层级结构

总的来说，包的引用方式和模块的引用方式是类似的：

- 使用 `import ...` 的形式，或者 `from ... import ...` 的形式引用
- 使用 `as` 关键字起别名
- 但是由于包当中又包括子包，子包中有包含模块，所以包的引用就稍微复杂一些。

因此，包的引用，其实最重要的就是了解包的**层级结构**：

- 具体来说，要清楚，我们想要的东西，是包，子包，模块，还是模块中的功能
- 然后根据具体情况选择合适的引用方式即可

我们拿 `xml` 包来举例：

- `xml` 包是 Python 内置的一个包，其功能是处理 XML 数据
- 我们这里不讲解 `xml` 包的具体功能，只是用它来说明包与模块的区别，因为 `xml` 是 Python 包中结构比较清晰的一个例子

完整的 `xml` 包的目录结构如下：

```text
xml/                          ← 包
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

- `minidom` 模块位于 `xml` 包的 `dom` 子包中

    - 如果要想引用这个模块，要 `import xml.dom.minidom`
    - 如果要想引用这个模块中的功能，可以使用 `from xml.dom.minidom import 功能名` 的方式




```python
# 以下代码不理解没关系，你只需要知道 xml.dom.minidom 这个模块调用成功即可：
import xml.dom.minidom
doc = xml.dom.minidom.parseString("<root><a>1</a></root>")
print(doc.documentElement.tagName)
```

    root



```python
# 以下代码不理解没关系，你只需要知道 xml.dom.minidom 这个模块调用成功即可：
from xml.dom.minidom import parseString
doc = parseString("<root><b>2</b></root>")
print(doc.documentElement.tagName)
```

    root


- `ElementTree` 模块位于 `xml` 包的 `etree` 子包中

    - 如果要想引用这个模块，要 `import xml.etree.ElementTree`
    - 如果要想引用这个模块中的功能，可以使用 `from xml.etree.ElementTree import 功能名` 的方式


```python
# 以下代码不理解没关系，你只需要知道 xml.etree.ElementTree 这个模块调用成功即可：
import xml.etree.ElementTree as ET
root = ET.fromstring("<root><a>1</a></root>")
print(root.tag)
```

    root



```python
# 以下代码不理解没关系，你只需要知道 xml.etree.ElementTree 这个模块调用成功即可：
from xml.etree.ElementTree import fromstring
root = fromstring("<root><b>2</b></root>")
print(root.tag)
```

    root


### (2) 包的引用的注意事项

之前我们介绍过包和模块的关系，就是：**`包 ⊂ 子包 ⊂ 模块 ⊂ 功能`**。

这里有一个需要注意的点，就是使用 `import a.b.c` 这种形式引用时，最多只能具体到模块这个层级，不能具体到功能这个层级。


```python
# 以下代码都不会报错，import 可以具体到包、子包、模块这三个层级
import xml  # 包
import xml.etree  # 子包
import xml.etree.ElementTree  # 模块
```


```python
# 以下代码会报错
# import xml.etree.ElementTree.fromstring  # 不能具体到功能层级
```


```python
# 更常见的错误是以下这种，math 中的 log 也是具体到的功能层级
# import math.log
```
