# Topic 13.2 - Python 程序开发演示 - 动物园程序开发

## 1. 动物园程序回顾

我们之前实现的动物园程序，功能比较简单，就是根据用户输入，来展示不同动物的ASCII艺术字，具体的需求如下：

- 用户刚进入程序的时候，看到标题页面和菜单
- 菜单提示用户可以选择查看不同的动物，也可以选择退出程序
- 根据用户不同的输入，展示不同的动物，展示完后，提示用户退回到菜单
- 如果用户选择退出程序，程序终止
- 如果用户输入错误（不是看动物或退出的指令），提示用户重新输入

我们先来看一下我们当时实现的代码：

```python
ascii_camel = r"""
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
"""

ascii_cow = r"""
    ^__^
    (oo)\_______
    (__)\       )\/\
        ||----w |
        ||     ||
"""

ascii_horse = r"""
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
"""

assic_title = r"""
    *****************************
    *       欢迎来到动物园       *
    *****************************
"""

while True:
    
    print(assic_title)

    print("请选择你想查看的动物：")
    print("输入 '1'：看骆驼")
    print("输入 '2'：看牛")
    print("输入 '3'：看马")
    print("输入 'q'：退出程序")

    while True:
        user_input = input("请输入你的选择: ")
        if user_input in ['1', '2', '3', 'q']:
            break
        else:
            print("输入有误，请重新输入")

    if user_input == '1':
        print("这是一头骆驼，请看：")
        print(assic_camel)
        input("输入任意内容退回到菜单")
    elif user_input == '2':
        print("这是一头牛，请看：")
        print(ascii_cow)
        input("输入任意内容退回到菜单")
    elif user_input == '3':
        print("这是一匹马，请看：")
        print(ascii_horse)
        input("输入任意内容退回到菜单")
    elif user_input == 'q':
        print("感谢你的访问，欢迎下次再来！")
        break
```

在这个版本中，我们主要使用了以下技术点：

- 使用 `while True` 无限循环来让程序持续运行，直到用户选择退出
- 使用 `input()` 函数获取用户输入，并使用嵌套的 `while` 循环来检验用户输入的有效性
- 使用 `if-elif-else` 语句来根据用户输入执行不同的操作
- 使用 `print()` 函数将程序运行结果展示给用户

现在我们已经了解了 Python 程序开发的基本要素和流程，接下来我们使用一些新的技术点来改进这个程序：

- 使用正式的 **Python 项目组织结构**来管理程序代码和数据文件，使用不同的**文件夹和模块**来分离不同的功能
- 使用**函数**来组织代码，将能封装成函数的部分都封装成函数，提高代码的可重复性和可维护性
- 将动物的 ASCII 艺术字存放在单独的数据**文件**中，通过文件读取来获取数据
- 使用**异常处理**来应对文件读取过程中可能出现的错误，并将用户的错误输入作为一种**主动抛出的异常**来处理
- 使用**日志**来记录每次程序的开启和退出、用户的操作、以及报错信息

注意，我们这个动物园程序比较简单，使用正式的项目组织结构和流程有些“大炮轰蚊子”的感觉，我们主要是通过这个例子，帮助大家更好地理解 Python 程序开发的基本流程和实践方法，为后续更复杂的程序开发打下基础。

## 2. 动物园程序需求分析与设计思路

根据上面的改进目标，我们对程序的需求进行分析，并设计程序的整体思路：

首先，我们可以较为清晰地将程序分为几个主要的文件夹和模块：

- `data/` 文件夹用于存放动物的 ASCII 艺术字数据文件，每个动物一个文件，标题也可以单独存放一个文件
- `src/` 文件夹包含程序的核心源代码，主要模块包括：

    - `main.py`：程序的入口文件，负责整体流程控制，就是将我们之前的主循环代码放在这里
    - `ui.py`：负责展示标题和菜单的功能
    - `animal_viewer.py`：负责读取数据文件，展示动物的功能
    - `input_handler.py`：负责处理用户输入的功能，包括输入的检验和解析
    - `logger.py`：负责日志记录的功能，将程序运行结果记录到日志文件中，方便后续查看和分析
    - `config.py`：用于存放程序的配置信息，我们在开发中遇到一些全局性的变量，都可以放在这里，如文件路径等

- `tests/` 文件夹用于存放测试代码，与 `src/` 文件夹中的模块一一对应，负责对各个模块进行单元测试

    - 首先 `config.py` 模块通常不需要单独测试，我们可以不为它创建测试文件
    - 其次，我们这个程序中大部分模块比较简单，测试代码就会比较少，我们就可以**直接在原模块的 `if __name__ == "__main__":` 中编写测试代码，而不必单独创建测试文件**
    - 因此，我们就只给 `main.py` 和 `animal_viewer.py` 创建测试文件，其实这两个模块也很简单，大家来体会以下测试代码怎么用就行了

- `logs/` 文件夹用于存放程序运行的日志文件

- `README.md` 文件用于介绍程序的功能和使用方法

- `requirements.txt` 文件我们可以先创建，如果后续需要第三方库就添加到这个文件中，如果没有第三方库，这个文件可以为空

在正式开始代码编写之前，我们可以先将目录结构创建好：

```text
zoo_program_v1/
|
├── data/
│   ├── animal1_camel.txt
│   ├── animal2_cow.txt
│   ├── animal3_horse.txt
│   └── title.txt
│
├── logs/
│   └── zoo.log
│
├── src/
│   ├── main.py
│   ├── ui.py
│   ├── animal_viewer.py
│   ├── input_handler.py
│   ├── logger.py
│   └── config.py
│
├── tests/
│   ├── test_main.py
│   └── test_animal_viewer.py
│
├── README.md
└── requirements.txt
```

## 3. 主程序设计

### (1) 根据新需求设计主程序框架

根据上面的设计思路，我们可以设计主程序的整体流程，我们先将之前实现过的代码放到 `src/main.py` 中：

- 主要逻辑不变：

    - 使用 `while True` 无限循环来持续运行程序
    - 根据 `if-elif-else` 语句来处理用户输入

- 根据我们新提出的需求稍作调整：

    - 将之前部分代码使用函数表示，这些函数还没有具体实现，但是没关系，我们先把函数调用注释掉，之后再来实现这些函数：

        - 展示标题和菜单，可以封装成 `display_title_menu()` 函数
        - 获取并处理用户输入，就是之前的那个嵌套 `while` 循环，其实就是为了获取用户输入，我们可以封装成 `get_user_input()` 函数，并返回给一个变量 `user_input`
        - 展示不同的动物，可以封装成 `display_animal(animal_id)` 函数，参数 `animal_id` 用于表示用户选择的动物编号
        - 日志记录，可以封装成 `logger(message)` 函数，参数 `message` 用于表示需要记录的日志信息
    
    - 将主循环的每一圈都用 `try-except` 语句包裹起来，捕获用户输入错误和程序运行错误，并进行相应的处理
    - 在程序开始和结束时、用户做出输入时、与程序报错时，调用日志记录函数 `logger()` 记录日志

根据新的设计思路，我们将主程序代码修改如下：

```python
# src/main.py
def main():
    
    # TODO: 日志记录
    # logger("程序启动")

    while True:
        try:
            # TODO: 展示标题和菜单
            # display_title_menu()
            
            # TODO: 获取并处理用户输入
            # user_input = get_user_input()
            
            if user_input == 'q':
                # logger("程序退出")
                break
            elif user_input == '1':
                # TODO: 展示骆驼
                # display_animal("1")
                # logger("用户查看动物1")
                pass
            elif user_input == '2':
                # TODO: 展示牛
                # display_animal("2")
                # logger("用户查看动物2")
                pass
            elif user_input == '3':
                # TODO: 展示马
                # display_animal("3")
                # logger("用户查看动物3")
                pass
        
        except Exception as e:
            # TODO: 记录错误日志
            # logger(时间, f"程序错误: {e}")
            pass

if __name__ == "__main__":
    main()
```

### (2) 改进主程序代码 - 提高代码复用性和可扩展性

但是，上面的代码框架其实有一个问题，那就是 `display_animal()` 这个函数我们调用了3次，

- 首先来说，这个函数重复调用了3次，代码有些冗余
- 其次来说，假设我们以后想增加更多的动物，我们就不得不继续添加更多的 `elif` 分支，不仅代码会变得越来越冗长，而且维护复杂度也会越来越高
- 因此我们可以做以下改进：

    - 将用户输入的动物编号直接传递给 `display_animal()` 函数
    - 在 `display_animal()` 函数内部，直接根据传入的动物编号来决定展示哪个动物

- 改进后的主程序代码如下：

```python
# src/main.py
def main():
    
    # TODO: 日志记录
    # logger("程序启动")

    while True:
        try:
            # TODO: 展示标题和菜单
            # display_title_menu()
            
            # TODO: 获取并处理用户输入
            # user_input = get_user_input()
            
            if user_input == 'q':
                # logger("程序退出")
                break
            elif user_input in ['1', '2', '3']:
                # display_animal(user_input)
                # logger(f"用户查看动物{user_input}")
                pass
        
        except Exception as e:
            # TODO: 记录错误日志
            # logger(f"程序错误: {e}")
            pass

if __name__ == "__main__":
    main()
```

这一点改进给我们以下两点启示：

- 首先就是，当我们发现代码中有重复的部分时，一定要想办法**提高代码的复用性**，例如封装函数、命名变量、使用高级数据结构等
- 其次就是，我们在开发时一定要考虑代码的可扩展性，尽量**避免“硬编码”**，让代码更容易适应未来的需求变化

### (3) 主程序测试

接下来，我们准备对主程序进行测试。

但是，此时，虽然我们设计完了主程序的框架，并且尽可能地用占位符来保证代码完整性，但此时程序还不能运行。

- 运行到 `if` 语句时会报错，因为 `get_user_input()` 函数还没有定义，导致 `user_input` 变量未定义
- 但是我们发现，只要实现了 `get_user_input()` 函数，程序是可以正常运行的，虽然还没能实现项目需求，但是程序已经可以正常启动和运行了
- 所以我们可以先实现一个临时的 `get_user_input()` 函数，我们只需要它能帮助程序运行起来就行了

```python
# src/main.py
def get_user_input():
    # 临时实现，直接复制之前的输入处理代码
    while True:
        user_input = input("请输入你的选择: ")
        if user_input in ['1', '2', '3', 'q']:
            break
        else:
            print("输入有误，请重新输入")
    return user_input

def main():
    
    # TODO: 日志记录
    # logger("程序启动")

    while True:
        try:
            # TODO: 展示标题和菜单
            # display_title_menu()
            
            # TODO: 只是临时实现，后续要改成调用真正的函数
            user_input = get_user_input()
            
            if user_input == 'q':
                # logger("程序退出")
                break
            elif user_input in ['1', '2', '3']:
                # display_animal(user_input)
                # logger(f"用户查看动物{user_input}")
                pass
        
        except Exception as e:
            # TODO: 记录错误日志
            # logger(f"程序错误: {e}")
            pass

if __name__ == "__main__":
    main()
```

接着，我们在 `tests/test_main.py` 中编写测试代码，对主程序进行测试：

```python
# tests/test_main.py
# 需要先添加项目路径到 sys.path 中
import sys
sys.path.append("codes/Module1/Topic13/Topic13_02/zoo_program_v1/src")

from src.main import main

if __name__ == "__main__":
    main()
```

```text
请输入你的选择: 1
请输入你的选择: 2
请输入你的选择: 3
请输入你的选择: 4
输入有误，请重新输入
请输入你的选择: q
```

看到这个运行结果，说明我们的主程序框架设计是正确的，程序可以正常启动和运行。

## 4. 各个功能实现

### (1) 查看动物函数设计

在实现 `display_animal(animal_id)` 函数之前，我们先在 `data/` 文件夹中，为每个动物创建一个单独的文本文件：

- `animal1_camel.txt` 文件内容：

```text
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
```

- `animal2_cow.txt` 文件内容：

```text
    ^__^
    (oo)\_______
    (__)\       )\/\
        ||----w |
        ||     ||
```

- `animal3_horse.txt` 文件内容：

```text
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
```


接着我们来看一下 `display_animal(animal_id)` 函数的代码实现，这部分我们放在 `src/animal_viewer.py` 模块中：

- 我们之前提到过，像如下这种使用 `if-elif-else` 语句通常不是一个好的实践，因为它会导致代码冗长且难以维护：

```python
# src/animal_viewer.py
def display_animal(animal_id):
    if animal_id == '1':
        file_path = "data/animal1_camel.txt"
    elif animal_id == '2':
        file_path = "data/animal2_cow.txt"
    elif animal_id == '3':
        file_path = "data/animal3_horse.txt"
    else:
        raise InvalidInputError("无效的动物编号")
    
    with open(file_path, "r", encoding="utf-8") as f:
        animal_art = f.read()
    print(animal_art)
```

- 我们想做到的效果是其实就是动物id与文件名来一一对应，那么有什么更好的方法吗？我们可以使用**字典**来映射动物编号和文件路径：

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
    },  # 字典结尾的逗号是允许的
}

def display_animal(animal_id):    
    # 获取对应的文件路径
    file_path = animal_info[animal_id]["file"]

    # 读取动物ASCII艺术字
    with open(file_path, "r", encoding="utf-8") as f:
        animal_ascii = f.read()
    
    # 展示动物
    print(f"请看，这是一头{animal_info[animal_id]['name']}：")
    print(animal_ascii)
    input("输入任意内容退回到菜单")

if __name__ == "__main__":
    display_animal("1")
```

我们直接通过运行 `animal_viewer.py` 模块来测试一下 `display_animal()` 函数：

```text
FileNotFoundError: No such file or directory: 'data/animal1_camel.txt'
```

为什么会报这个错呢？这是因为我们当前的工作目录是 `src/`，而数据文件在 `data/` 文件夹中，因此我们需要调整文件路径：

- 正确的相对路径应该是 `codes/Module1/Topic13/zoo_program_v1/data/animal1_camel.txt`，这样才能从 `src/` 目录访问到 `data/` 目录中的文件
- 但是我们如果每个文件都这样写路径，代码会变得很冗长
- 所以我们可以直接把前缀 `codes/Module1/Topic13/zoo_program_v1/` 放在 `config.py` 模块中，作为一个全局变量 `PATH_PREFIX`，然后在其他模块中导入使用

我们在 `config.py` 模块中加入如下设置：

```python
# src/config.py
PATH_PREFIX = "codes/Module1/Topic13/zoo_program_v1/"
```

我们修改 `animal_viewer.py` 模块中的文件路径代码：

```python
# src/animal_viewer.py
from config import PATH_PREFIX

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
    },  # 字典结尾的逗号是允许的
}

def display_animal(animal_id):    
    # 获取对应的文件路径
    file_path = PATH_PREFIX + animal_info[animal_id]["file"]

    # 读取动物ASCII艺术字
    with open(file_path, "r", encoding="utf-8") as f:
        animal_ascii = f.read()
    
    # 展示动物
    print(f"请看，这是一头{animal_info[animal_id]['name']}：")
    print(animal_ascii)
    input("输入任意内容退回到菜单")

if __name__ == "__main__":
    display_animal("1")
```

现在我们再运行一下 `animal_viewer.py` 模块，看看效果如何：

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
```

此外，我们还可以在 `animal_viewer.py` 对应的测试文件 `tests/test_animal_viewer.py` 中编写测试代码：

```python
# tests/test_animal_viewer.py
# 需要先添加项目路径到 sys.path 中
import sys
sys.path.append("codes/Module1/Topic13/Topic13_02/zoo_program_v1/src")

from animal_viewer import display_animal

if __name__ == "__main__":
    display_animal("1")
    display_animal("2")
    display_animal("3")
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
请看，这是一头马：
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

通过 `test_main.py` 和 `test_animal_viewer.py` 这两个测试文件，我们体验了一下使用单独测试文件来验证程序功能的过程

- 但是，由于我们这个程序比较简单，测试代码也比较少，使用单独的测试文件显得有些多余
- 所以我们只是让大家知道有这个方法，以后接触到复杂的项目时，我们就可以使用这种方法来进行测试

### (2) 展示标题和菜单函数设计

接着我们来实现展示标题和菜单的 `display_title_menu()` 函数：

- 函数的实现我们准备放在 `src/ui.py` 模块中
- 由于标题比较复杂，我们就先把标题的 ASCII 艺术字直接写在函数内部，但是菜单比较简单，菜单部分我们直接使用 `print()` 函数展示即可

首先，标题的艺术字我们放在 `data/title.txt` 文件中，内容如下：

```text
*****************************
*       欢迎来到动物园        *
*****************************
```

接着，我们来看一下 `display_title_menu()` 函数的代码实现，这部分很简单：

```python
# src/ui.py
def display_title_menu():
    # 读取标题文件
    with open("data/title.txt", "r", encoding="utf-8") as f:
        title = f.read()
    # 打印标题
    print(title)
    # 打印菜单
    print("请选择你想查看的动物：")
    print("1. 查看骆驼")
    print("2. 查看牛")
    print("3. 查看马")
    print("q. 退出")

if __name__ == "__main__":
    display_title_menu()
```

这里其实又涉及到了我们之前提到的“硬编码”的问题

- 如果我们以后想增加动物，难道要挨个修改菜单代码吗？
- 当然不用，我们之前在 `animal_viewer.py` 模块中定义了 `animal_info` 字典，里面就有所有动物的信息
- 因此我们完全可以把这个字典导入到 `ui.py` 模块中，然后根据字典内容动态生成菜单

改进后的代码如下：

```python
# src/ui.py
from animal_viewer import animal_info

def display_title_menu():
    # 读取标题文件
    with open("data/title.txt", "r", encoding="utf-8") as f:
        title = f.read()
    
    # 打印标题
    print(title)
    
    # 打印菜单
    # 打印动物列表
    print("请选择你想查看的动物：")
    for animal_id, info in animal_info.items():
        print(f"{animal_id}. 查看{info['name']}")
    # 打印退出选项
    print("q. 退出")
```

我们来运行一下 `ui.py` 模块，看看效果如何：

```text
*****************************
*       欢迎来到动物园        *
*****************************
请选择你想查看的动物：
1. 查看骆驼
2. 查看牛
3. 查看马
q. 退出
```

可以看到，效果不错，标题和菜单都展示出来了。

### (3) 获取并处理用户输入函数设计

接着我们来实现获取用户输入的 `get_user_input()` 函数，这个函数的实现我们准备放在 `src/input_handler.py` 模块中：

- 这一部分也比较简单，我们把之前实现过的嵌套 `while` 循环代码放在这个函数中，并将用户输入作为返回值返回：

```python
# src/main.py
def get_user_input():
    while True:
        user_input = input("请输入你的选择: ")
        if user_input in ['1', '2', '3', 'q']:
            break
        else:
            print("输入有误，请重新输入")
    return user_input
```

写到这儿同学们应该已经看出来了，这个函数其实也有“硬编码”的问题：

- 如果我们以后增加了更多的动物，我们还得修改这个函数的输入检验代码，就是那个列表 `['1', '2', '3', 'q']`
- 因此我们也可以使用 `animal_info` 字典来灵活地生成有效输入

改进后的代码如下：

```python
# src/input_handler.py
from animal_viewer import animal_info

def get_user_input():
    # 生成有效输入列表
    valid_inputs = list(animal_info.keys()) + ['q']
    while True:
        user_input = input("请输入您的选择: ")
        if user_input in valid_inputs:
            break
        else:
            print("输入有误，请重新输入")
    return user_input
```

### (4) 日志记录函数设计

最后我们来实现日志记录的 `logger(message)` 函数，这个函数的实现我们准备放在 `src/logger.py` 模块中：

- 这个函数就比较简单，其实就是做了一个文件写入操作，将日志信息写入到日志文件中：
- 并且，我们希望日志文件能够记录每条日志的时间戳，因此我们可以使用 `datetime` 模块来获取当前时间
- 注意，我们这里应该使用追加模式打开日志文件，这样每次写入日志时不会覆盖之前的日志内容

```python
# src/logger.py
from datetime import datetime

def logger(message):
    # 日志文件路径
    log_file_path = "logs/zoo.log"

    # 获取当前时间
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # 定义日志信息
    log_content = f"""
    时间：{current_time}
    消息：{message}
    """

    # 写入日志
    with open(log_file_path, "a", encoding="utf-8") as f:
        f.write(log_content)

if __name__ == "__main__":
    logger("开发者测试日志记录功能")
```

之后，我们测试一下 `logger()` 函数，并多运行几次，打开 `logs/zoo.log` 文件，看到内容如下：

```text

    时间：2025-10-23 16:22:56
    消息：开发者测试日志记录功能
    
    时间：2025-10-23 16:22:57
    消息：开发者测试日志记录功能
    
    时间：2025-10-23 16:22:58
    消息：开发者测试日志记录功能
    
```

运行结束后，我们发现，日志文件里的格式好像不太对劲：

- 为什么每条日志前都空了4个空格呢？这是因为我们在定义 `log_content` 字符串时，使用了多行字符串，而**多行字符串会原封不动地保留代码中的缩进**
- 也就是说，这个字符串是在函数内部定义的，函数的代码格式必须缩进4个空格，而多行字符串也会保留这4个空格
- 因此我们可以把多行字符串改成单行字符串，使用 `\n` 来表示换行，这样就不会有缩进的问题了

改进后的代码如下：

```python
# src/logger.py
from datetime import datetime

def logger(message):
    # 日志文件路径
    log_file_path = "Topic13/zoo_program/logs/zoo.log"

    # 获取当前时间
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # 定义日志信息
    log_content = f"时间：{current_time}\n消息：{message}\n\n"  # 结尾两个换行，一个用于分隔日志条目，一个用于空一行

    # 写入日志
    with open(log_file_path, "a", encoding="utf-8") as f:
        f.write(log_content)

if __name__ == "__main__":
    logger("开发者测试日志记录功能")
```

在运行改进版代码之前，我们把前面的日志文件内容删除，然后重新运行几次测试代码，打开 `logs/zoo.log` 文件，可以看到内容如下：

```text
时间：2025-10-23 16:50:20
消息：开发者测试日志记录功能

时间：2025-10-23 16:50:21
消息：开发者测试日志记录功能

时间：2025-10-23 16:50:22
消息：开发者测试日志记录功能

```

## 5. 整合各功能到主程序

到这里，我们已经实现了所有预留的功能，接下来我们把各个模块整合到 `main.py` 主程序中：

```python
# src/main.py
from ui import display_title_menu
from input_handler import get_user_input
from animal_viewer import display_animal
from logger import logger

def main():
    
    logger("程序启动")

    while True:
        try:
            display_title_menu()
            
            user_input = get_user_input()
            
            if user_input == 'q':
                logger("程序退出")
                break
            elif user_input in ['1', '2', '3']:
                display_animal(user_input)
                logger(f"用户查看动物{user_input}")
        
        except Exception as e:
            logger(f"程序错误: {e}")
            print("程序出现错误，请稍后再试。")

if __name__ == "__main__":
    main()
```

此时的主程序是可以完整运行的，但是其实我们又发现了一个“硬编码”的问题：

- 就是判断用户输入是否在 `['1', '2', '3']` 这个列表中
- 我们按照之前的做法，也可以使用 `animal_info` 字典来动态生成有效输入列表
- 改进后的代码如下：

```python
# src/main.py
from ui import display_title_menu
from input_handler import get_user_input
from animal_viewer import display_animal, animal_info
from logger import logger

def main():
    
    logger("程序启动")

    while True:
        try:
            display_title_menu()
            
            user_input = get_user_input()
            
            if user_input == 'q':
                logger("程序退出")
                break
            elif user_input in list(animal_info.keys()):
                display_animal(user_input)
                logger(f"用户查看动物{user_input}")
        
        except Exception as e:
            logger(f"程序错误: {e}")
            print("程序出现错误，请稍后再试。")

if __name__ == "__main__":
    main()
```

我们再运行一下 `main.py` 主程序，或者在 `test/test_main.py`看看效果如何：

```text
*****************************
*       欢迎来到动物园      *
*****************************
请选择你想查看的动物：
1. 查看骆驼
2. 查看牛
3. 查看马
q. 退出
请输入您的选择: 1
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
*****************************
*       欢迎来到动物园      *
*****************************
请选择你想查看的动物：
1. 查看骆驼
2. 查看牛
3. 查看马
q. 退出
请输入您的选择: 2
请看，这是一头牛：
    ^__^
    (oo)\_______
    (__)\       )\/\
        ||----w |
        ||     ||
输入任意内容退回到菜单
*****************************
*       欢迎来到动物园      *
*****************************
请选择你想查看的动物：
1. 查看骆驼
2. 查看牛
3. 查看马
q. 退出
请输入您的选择: 3
请看，这是一头马：
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
*****************************
*       欢迎来到动物园      *
*****************************
请选择你想查看的动物：
1. 查看骆驼
2. 查看牛
3. 查看马
q. 退出
请输入您的选择: q
感谢使用动物园程序，再见！
```

此时，程序已经可以完整运行，并且各个功能模块也都实现了，我们可以查看一下日志文件 `logs/zoo.log` 的内容：

```text
时间：2025-11-07 00:17:49
消息：程序启动

时间：2025-11-07 00:17:52
消息：用户查看动物1

时间：2025-11-07 00:17:54
消息：用户查看动物2

时间：2025-11-07 00:17:56
消息：用户查看动物3

时间：2025-11-07 00:17:57
消息：程序退出
```

## 6. 编写 README 文件

到此为止，我们的动物园程序已经开发完成，我们还剩下一个 `requirements.txt` 文件和一个 `README.md` 文件需要编写。

- 由于我们的程序没有使用任何第三方库，因此 `requirements.txt` 文件可以为空。
- 所以我们只需要再编写一个 `README.md` 文件，介绍程序的功能和使用方法即可

`README.md` 文件是一个 Markdown 格式的文本文件，主要用于介绍项目的基本信息、功能特点、使用方法等

- 对于一个项目的 `README.md` 文件，需要包括哪些内容，要具体到什么程度，其实是没有通俗的标准的
- 我们这里给出一个比较简单的示例，大家可以根据自己的需要进行修改和完善

本项目的 `README.md` 文件内容如下：

```markdown
# 动物园程序

## 项目介绍

该项目是一个简单的动物展示系统，主要用于展示动物和日志记录。

## 功能特点

- 查看动物的 ASCII 艺术字，包括骆驼、牛和马
- 记录用户操作日志

## 使用方法

1. 克隆项目到本地
2. 运行 `main.py` 文件，或在终端中执行 `python src/main.py`
3. 按照提示进行操作
```

## 7. 小结

到此为止，我们已经完成了动物园程序的开发工作，带着大家完整地体验了一遍 Python 程序开发的基本流程和实践方法。

下一节，我们讲体验一下项目开发的版本迭代，根据新的需求和出现的新的问题，对程序进行改进和优化。
