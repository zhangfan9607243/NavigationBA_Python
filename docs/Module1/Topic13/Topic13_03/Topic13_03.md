# Topic 13.3 - Python 程序开发演示 - 动物园程序改进

本节我们继续完善和改进动物园程序，体验一下项目开发的版本迭代过程

- 我们把这个版本的程序称为 `zoo_program_v2`。

- 所以，首先，我们要把 `zoo_program_v1` 目录复制一份，到该目录下命名为 `zoo_program_v2`

- 接着，我们将 `config.py` 中的 `PATH_PREFIX` 修改为 `zoo_program_v2` 目录下的路径

```python
PATH_PREFIX = "codes/Module1/Topic13/Topic13_03/zoo_program_v2/"

## 1. 测试模块中的路径硬编码问题

首先我们能想到的一个可以改进的地方是：

- 我们在 `src` 目录下，设置了一个 `config.py` 模块，专门用来存放全局配置参数，比如前面提到的 `PATH_PREFIX` 变量来管理文件路径前缀
- 但是，在 `test` 目录下的测试模块中，并没有使用这个全局配置变量，而是直接写死了文件路径
- 于是我们可以把测试模块中的文件路径，也保存成变量，然后导入使用

我们在 `test` 目录下，创建一个新的模块 `config_test.py`，内容如下：

```python
# test/config_test.py
PATH_SRC = "codes/Module1/Topic13/Topic13_03/zoo_program_v2/src"
```

- 然后我们修改 `test_main.py` 模块中的代码：

```python
# test/test_main.py
import sys
from config_test import PATH_SRC
sys.path.append(PATH_SRC)

from main import main

if __name__ == "__main__":
    main()
```

- 同样地，我们修改 `test_animal_viewer.py` 模块中的代码：

```python
# test/test_animal_viewer.py
import sys
from config_test import PATH_SRC
sys.path.append(PATH_SRC)

from animal_viewer import display_animal

if __name__ == "__main__":
    display_animal("1")
    display_animal("2")
    display_animal("3")
```

写到这里，我们发现一个问题，那就是 `sys.path.append(PATH_SRC)` 这行代码，在每个测试模块中都要写一次，显得有些重复冗余：

- 于是，我们可以把这行代码，也放到 `config_test.py` 模块中，然后测试模块只需要导入 `config_test` 模块
- 之前我们提到过，Python 模块在被导入时，模块中的代码会被执行一次，所以 `sys.path.append(PATH_SRC)` 这行代码会被执行，从而把路径添加到 `sys.path` 中
- 于是，我们的 `config_test.py` 模块变成了这样：

```python
# test/config_test.py
import sys
PATH_SRC = "codes/Module1/Topic13/Topic13_03/zoo_program_v2/src"
sys.path.append(PATH_SRC)
```

- 然后，我们的主程序测试模块就可以简化为：

```python
# test/test_main.py
from config_test import *
from main import main

if __name__ == "__main__":
    main()
```

- 同样地，`test_animal_viewer.py` 模块也可以简化为：

```python
# test/test_animal_viewer.py
from config_test import *
from animal_viewer import display_animal

if __name__ == "__main__":
    display_animal("1")
    display_animal("2")
    display_animal("3")
```

## 2. 增加一个新的动物

这里我们简单提出一个新的需求 - 增加一个动物：猫，这个需求的实现其实比较简单：

- 我们在 `data` 目录下，创建一个新的文件 `animal4_cat.txt`，内容如下：

```text
    /\_____/\
   /  o   o  \
  ( ==  ^  == )
   )         (
  (           )
 ( (  )   (  ) )
(__(__)___(__)__)
```

- 然后我们在 `src/animal_viewer.py` 模块中，增加对猫的支持，只需增加一个新的元素到 `animal_info` 字典中：

```python
# src/animal_viewer.py
animal_info ={
    "1": {
        "name": "骆驼", 
        "file": "data/animal1_camel.txt"
        },
    "2": {
        "name": "牛", 
        "file": "data/animal2_cow.txt"
        },
    "3": {
        "name": "马", 
        "file": "data/animal3_horse.txt"
    },
    "4": {
        "name": "猫", 
        "file": "data/animal4_cat.txt"
    }
}
```


- 之后，我们可以直接在 `animal_viewer.py` 模块中，或者者在 `test_animal_viewer.py` 模块中，调用 `display_animal("4")` 来查看猫的图案：

```python
# test/test_animal_viewer.py
display_animal("4")
```

```text
请看，这是一头猫：
    /\_____/\
   /  o   o  \
  ( ==  ^  == )
   )         (
  (           )
 ( (  )   (  ) )
(__(__)___(__)__)
输入任意内容退回到菜单
```

## 3. 增加量词处理

在增加了猫这个动物之后，我们发现一个问题：

- 在输出结果中，“请看，这是一头猫”，好像不太对，应该是“请看，这是一只猫”才对
- 于是我们需要对程序进行改进，来处理不同动物的量词问题

首先，我们需要在 `animal_info` 字典中，增加一个 `measure` 字段，用来存放该动物对应的量词：

```python
# src/animal_viewer.py
animal_info ={
    "1": {
        "name": "骆驼", 
        "measure": "头",
        "file": "data/animal1_camel.txt"
        },
    "2": {
        "name": "牛", 
        "measure": "头",
        "file": "data/animal2_cow.txt"
        },
    "3": {
        "name": "马", 
        "measure": "匹",
        "file": "data/animal3_horse.txt"
    },
    "4": {
        "name": "猫", 
        "measure": "只",
        "file": "data/animal4_cat.txt"
    }
}
```

之后，我们需要修改 `display_animal` 函数中的输出语句，来使用这个量词字段：

```python
# src/animal_viewer.py
def display_animal(animal_id):    
    # 获取对应的文件路径
    file_path = PATH_PREFIX + animal_info[animal_id]["file"]

    # 读取动物ASCII艺术字
    with open(file_path, "r", encoding="utf-8") as f:
        animal_ascii = f.read()
    
    # 展示动物
    print(f"请看，这是一{animal_info[animal_id]['measure']}{animal_info[animal_id]['name']}：")
    print(animal_ascii)
    input("输入任意内容退回到菜单")
```

我们再次分别查看不同动物的展示效果，确保量词使用正确：

```python
# test/test_animal_viewer.py
display_animal("1")  # 骆驼
display_animal("2")  # 牛
display_animal("3")  # 马
display_animal("4")  # 猫
```

```text
请看，这是一头骆驼：
        _
    .--' |
   /___^ |     .--.
       ) |    /    \
      /  |  /`      '.
     |   '-'    /     \
     \         |      |\
      \    /   \      /\|
       \  /'----`\   /
       |||       \\ |
       ((|        ((|
       |||        |||
      //_(       //_(
输入任意内容退回到菜单
请看，这是一头牛：
    ^__^
    (oo)\_______
    (__)\       )\/\
        ||----w |
        ||     ||
输入任意内容退回到菜单
请看，这是一匹马：
                                 |\    /|
                              ___| \,,/_/
                           ---__/ \/    \
                          __--/    (D)(D)\
                          _ -/    (_      \
                         // /       \_ /  -\
   __-------_____--___--/           / \_ O o)
  /                                 /   \__/
 /                                 /
||          )                   \_/\
||         /              _      /  |
| |      /--______      ___\    /\  :
| /   __-  - _/   ------    |  |   \ \
 |   -  -   /                | |     \ )
 |  |   -  |                 | )     | |
  | |    | |                 | |    | |
  | |    < |                 | |   |_/
  < |    /__\                <  \
  /__\                       /___\
输入任意内容退回到菜单
请看，这是一只猫：
    /\_____/\
   /  o   o  \
  ( ==  ^  == )
   )         (
  (           )
 ( (  )   (  ) )
(__(__)___(__)__)
输入任意内容退回到菜单
```

可以看到，此时，程序已经正确地处理了不同动物的量词问题。

## 4. 小结

通过本节的内容，我们体验了一个程序从版本 1 到版本 2 的迭代过程，主要包括以下几个方面的改进：

- 解决了测试模块中的路径硬编码问题，使得测试代码更加灵活和可维护
- 增加了一个新的动物 - 猫，丰富了程序的功能
- 处理了不同动物的量词问题，使得输出更加符合语言习惯

通过本节和上节的内容，大家大致体会了一个程序开发和迭代的过程，当然我们练手的这个项目太简单了，下一章我们会开发一个复杂一些的项目，作为我们 Python 基础部分的结课项目。
