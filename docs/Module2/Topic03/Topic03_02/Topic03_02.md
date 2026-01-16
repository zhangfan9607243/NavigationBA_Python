# Topic 3.2 - Python 面向对象程序 - 石头剪刀布程序开发

上一节我们介绍了 Python 面向对象程序设计的基本规范，本节我们将通过一个简单的“石头剪刀布”游戏来演示如何使用面向对象的方法来设计和实现一个小程序

- 在这个程序的开发过程中，我们将严格遵循面向对象的设计原则

- 和之前的动物园程序一样，我们其实也是把一个简单的需求的实现的方式复杂化，有点“杀鸡用牛刀”的感觉，但是目的是让大家完整地理解编程设计思路和实现方法

## 1. 项目基本需求

我们的“石头剪刀布”游戏需要满足以下基本需求：

- 首先，刚刚进入游戏时，会展示标题和菜单，在标题界面，玩家可以选择单人模式、双人模式、查看规则、查看记录、或者退出游戏
- 单人模式下，玩家将与计算机对战，玩家会选择石头、剪刀或布，计算机会随机选择石头、剪刀或布
- 双人模式下，两个玩家将轮流输入他们的选择
- 游戏结束后，将直接展示胜负结果，并返回主菜单
- 查看规则选项将展示游戏的基本规则
- 查看记录选项将展示玩家的历史游戏记录

## 2. 项目需求分析

根据我们对游戏设计的基本需求，我们可以对程序的功能进行分析，并确定需要实现的类和方法。

首先，我们在面向过程编程中，程序的主循环会直接写在一个主循环里，但是在面向对象编程中，我们通常将主循环封装在一个类中，比如 `Program` 类，放在 `main.py` 中，这个类会有一个 `run()` 方法来启动程序，在 `main.py` 中的 `if __name__ == "__main__":` 中，我们只需要创建一个 `Program` 类的实例并调用 `run()` 方法即可    

其次，我们梳理一下游戏需要哪些类：

- `Player` 类：表示游戏中的玩家，应该是个抽象类，因为出拳的具体实现会根据玩家类型（人类或计算机）有所不同

    - 属性包括：

        - `name`：玩家名称
    
    - 方法包括：
    
        - `make_choice()`：让玩家做出选择（石头、剪刀或布），是个抽象方法，需要在子类中实现

- `HumanPlayer` 类：继承自 `Player` 类，表示人类玩家，包含输入选择的方法
    
    - 属性包括：
    
        - `name`：玩家名称（直接继承自 `Player` 类）
    
    - 方法包括：
    
        - `make_choice()`：通过用户输入获取玩家的选择

- `ComputerPlayer` 类：继承自 `Player` 类，表示计算机玩家，包含随机选择的方法

    - 属性包括：
    
        - `name`：玩家名称（直接继承自 `Player` 类）
    
    - 方法包括：
    
        - `make_choice()`：随机生成计算机的选择

- `Game` 类：负责游戏的主要逻辑处理，包括单人模式和双人模式的实现

    - 属性包括：
    
        - `player1`：第一个玩家
        - `player2`：第二个玩家
    
    - 方法包括：
    
        - `play()`：实现游戏运行的逻辑
        - `decide(choice1, choice2)`：根据两个玩家的选择确定胜负结果

- `Logger` 类：负责记录和展示游戏历史记录，其实就是将动物园和金融计算器程序的 `logger.py` 中的功能封装到类中

    - 属性包括：

        - `path`：日志文件路径
    
    - 方法包括：
    
        - `log_read()`：读取历史记录
        - `log_write(result)`：记录新的游戏结果

- `UI` 类：负责用户界面的展示和交互

    - 属性包括：    

        - `path`：界面资源路径
    
    - 方法包括：

        - `display_title()`：展示游戏标题
        - `display_menu()`：展示主菜单
        - `display_rules()`：展示游戏规则

当我们将游戏中的所有类都设计好后，游戏的基本逻辑其实就已经很明确了：
    
- 首先，游戏开始时应该先初始化一个 `Program` 类的实例，在初始化的过程中，我们会创建一个 `Logger` 类的实例和一个 `UI` 类的实例

- 在 `Program` 类的 `run()` 方法中，我们首先会调用 `UI` 类的 `display_title()` 方法和 `display_menu()` 方法来展示标题和菜单

- 如果选择了进行游戏：

    - 如果选择了单人模式或多人模式，我们就会创建一个 `Game` 类的实例，在 `Game` 类的初始化中，我们会根据玩家类型创建相应的 `Player` 类实例（`HumanPlayer` 或 `ComputerPlayer`）

    - 之后 `Game` 类的 `play()` 方法中，我们会让两个玩家分别调用 `Player` 类的 `make_choice()` 方法获取他们的选择

    - 然后调用 `Game` 类的 `decide(choice1, choice2)` 方法来确定胜负结果

    - 最后将结果传递给 `Logger` 类的 `log_write(result)` 方法进行记录，并返回主菜单

- 如果选择了查看规则，我们会调用 `UI` 类的 `display_rules()` 方法来展示游戏规则

- 如果选择了查看记录，我们会调用 `Logger` 类的 `log_read()` 方法来读取并展示历史记录

- 如果选择了退出游戏，我们就结束主循环

## 3. 项目目录结构

在需求分析结束后，我们可以确定项目的目录结构如下所示：

```text
rps_game_v1/
│
├── data/                  # 存放游戏数据的目录
│   ├── title.txt               # 存放游戏标题的文本文件
│   ├── menu.txt                # 存放游戏菜单的文本文件
│   └── rules.txt               # 存放游戏规则的文本文件
│
├── src/                   # 存放源代码的目录
│   ├── main.py                # 程序入口文件
│   ├── program.py             # Program 类的实现
│   ├── player.py              # Player 类的实现
│   ├── human_player.py        # HumanPlayer 类的实现
│   ├── computer_player.py     # ComputerPlayer 类的实现
│   ├── game.py                # Game 类的实现
│   ├── ui.py                  # UI 类的实现
│   ├── config.py              # 配置类的实现
│   └── logger.py              # Logger 类的实现
│
├── tests/                 # 存放测试代码的目录
│   ├── config_test.py          # 测试文件所使用的配置文件
│   ├── test_human_player.py    # 测试 HumanPlayer 类的
│   ├── test_computer_player.py # 测试 ComputerPlayer 类的测试文件
│   └── test_game.py            # 测试 Game 类的测试文件
│
├── log/                   # 存放日志文件的目录
│   └── game_log.txt
│
├── requirements.txt       # 项目依赖文件
└── README.md              # 项目说明文件
```


## 4. 项目代码实现

和之前的动物园程序与金融计算器程序类似，在石头剪刀布游戏项目中，我们应该根据由框架到细节的原则，先实现项目的整体框架，然后逐步完善各个类的具体实现。

### (1) `main.py` - 程序入口文件

这里我们先展示 `main.py` 文件的代码实现

- 实现的逻辑比较简单，就是将我们比较熟悉的主循环封装在 `Program` 类中，并调用其 `run()` 方法来启动程序
- 其中没有实现的功能我们先用占位符表示，后续会在相应的类中进行实现

```python
# src/main.py
from config import Config

class Program:
    def __init__(self):
        pass
        # TODO: 实现logger和ui的初始化
        # self.logger = Logger(Config.PATH_LOG)
        # self.ui = UI(Config.PATH_UI)

    def run(self):

        while True:
            # TODO: 实现标题和菜单的显示
            # self.ui.display_title()
            # self.ui.display_menu()
            choice = input("请输入您的选择：")
            if choice == '1':
                pass
                # TODO: 实现单人模式
            elif choice == '2':
                pass
                # TODO: 实现双人模式
            elif choice == 'h':
                pass
                # TODO: 实现规则的显示
                # self.ui.display_rules()
            elif choice == 'l':
                pass
                # TODO: 实现记录的显示
                # self.logger.log_read()
            elif choice == 'q':
                print("感谢游玩，再见！")
                break
            else:
                print("无效选择，请重新输入。")

if __name__ == "__main__":
    program = Program()
    program.run()
```

在实现其他类的代码之前，我们先把 `config.py` 文件实现好，这里我们只有两个常量，分别是日志文件路径和界面资源路径：

```python
# src/config.py
class Config:
    PATH_LOG = "codes/Module2/Topic03/Topic03_02/rps_game_v1/log"
    PATH_UI = "codes/Module2/Topic03/Topic03_02/rps_game_v1/data"
```

### (2) `Player` 类及其子类的实现

#### (a) 实现源代码

首先，在 `player.py` 文件中，我们实现 `Player` 抽象类

```python
# src/player.py
from abc import ABC, abstractmethod

class Player(ABC):
    def __init__(self, name):
        self.name = name

    @abstractmethod
    def make_choice(self):
        pass
```

接下来，在 `human_player.py` 文件中，我们实现 `HumanPlayer` 类

```python
# src/human_player.py
from player import Player

class HumanPlayer(Player):
    def make_choice(self):
        while True:
            choice = input(f"{self.name}，请输入你的选择（石头/剪刀/布）：")
            if choice in ['石头', '剪刀', '布']:
                break
            else:
                print("无效的选择，请重新输入。")
        print(f"{self.name}选择了：{choice}")
        return choice
```

最后，在 `computer_player.py` 文件中，我们实现 `ComputerPlayer` 类

```python
# src/computer_player.py
import random
from player import Player

class ComputerPlayer(Player):
    def make_choice(self):
        choice = random.choice(['石头', '剪刀', '布'])
        print(f"{self.name}选择了：{choice}")
        return choice
```

#### (b) 实现测试代码

在实现完 `Player` 类及其子类后，我们需要为它们编写测试代码，以确保它们的功能正确。

首先，在 `test/` 目录一下，我们创建一个 `config_test.py` 文件，用于测试时的配置，其实目前就只有一个源代码路径：

```python
# tests/config_test.py
import sys

class ConfigTest:
    PATH_SRC = "codes/Module2/Topic03/Topic03_02/rps_game_v1/src"

sys.path.append(ConfigTest.PATH_SRC)
```

在配置好测试的配置文件后，我们就可以进行测试代码的编写了：

- 我们可以编写 `test_human_player.py` 文件来测试 `HumanPlayer` 类：

```python
# tests/test_human_player.py
from config_test import *
from human_player import HumanPlayer

def test_human_player_make_choice():
    player = HumanPlayer("测试玩家")
    choice = player.make_choice()

if __name__ == "__main__":
    test_human_player_make_choice()
```

- 我们运行一次，看下效果

```text
测试玩家，请输入你的选择（石头/剪刀/布）：大锤
无效的选择，请重新输入。
测试玩家，请输入你的选择（石头/剪刀/布）：石头
测试玩家选择了：石头
```

同样的，我们可以测试一下电脑玩家：

- 我们可以编写 `test_computer_player.py` 文件来测试 `ComputerPlayer` 类：

```python
# tests/test_computer_player.py
from config_test import *
from computer_player import ComputerPlayer

def test_computer_player_make_choice():
    player = ComputerPlayer("电脑玩家")
    choice = player.make_choice()
    
if __name__ == "__main__":
    test_computer_player_make_choice()
```

- 我们运行一次，看下效果：

```text
电脑玩家选择了：剪刀
```

注意，由于 `ComputerPlayer` 类和 `HumanPlayer` 类的父类 `Player` 类是抽象类，不能直接实例化，所以我们只能测试它的子类

### (3) `Game` 类的实现

#### (a) 实现源代码

在 `game.py` 文件中，我们实现 `Game` 类：

```python
# src/game.py
from human_player import HumanPlayer
from computer_player import ComputerPlayer

class Game:

    def __init__(self, mode):
        if mode == 'single':
            self.player1 = HumanPlayer("玩家")
            self.player2 = ComputerPlayer("电脑")
        elif mode == 'multi':
            self.player1 = HumanPlayer("玩家1")
            self.player2 = HumanPlayer("玩家2")

    def play(self):
        choice1 = self.player1.make_choice()
        choice2 = self.player2.make_choice()
        result = self.decide(choice1, choice2)
        return f"{self.player1.name}出了{choice1}，{self.player2.name}出了{choice2}，结果：{result}"

    def decide(self, choice1, choice2):
        if choice1 == choice2:
            return "平局！"
        elif (choice1 == "石头" and choice2 == "剪刀") or (choice1 == "剪刀" and choice2 == "布") or (choice1 == "布" and choice2 == "石头"):
            return f"{self.player1.name}胜利！"
        else:
            return f"{self.player2.name}胜利！"
```

#### (b) 实现测试代码

在 `test/` 目录下，我们创建一个 `test_game.py` 文件来测试 `Game` 类：

```python
# tests/test_game.py
from config_test import *
from game import Game

def test_game_single_mode():
    game = Game(mode='single')
    result = game.play()
    print(result)

def test_game_multi_mode():
    game = Game(mode='multi')
    result = game.play()
    print(result)

if __name__ == "__main__":
    print("测试单人模式：")
    test_game_single_mode()
    print("测试多人模式：")
    test_game_multi_mode()
```

我们运行一下这段代码，看看效果：

```text
测试单人模式：
玩家，请输入你的选择（石头/剪刀/布）：石头
玩家选择了：石头
电脑选择了：布
玩家出了石头，电脑出了布，结果：电脑胜利！
测试多人模式：
玩家1，请输入你的选择（石头/剪刀/布）：石头
玩家1选择了：石头
玩家2，请输入你的选择（石头/剪刀/布）：剪刀
玩家2选择了：剪刀
玩家1出了石头，玩家2出了剪刀，结果：玩家1胜利！
```

### (4) `UI` 类的实现

首先，我们现在 `data/` 目录下创建三个文本文件，分别是 `title.txt`、`menu.txt` 和 `rules.txt`，内容如下：

- 标题 `title.txt` 内容：

```text
=========================
       石头剪刀布游戏
=========================
```

- 菜单 `menu.txt` 内容：

```text
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
q. 退出游戏
```

- 规则 `rules.txt` 内容：

```text
游戏规则：
- 石头胜剪刀
- 剪刀胜布
- 布胜石头
- 选择相同则为平局
```

接着，我们在 `src/ui.py` 文件中实现 `UI` 类，这一类比较简单，我们主要是读取数据文件并展示内容：

```python
# src/ui.py
from config import Config

class UI:
    def __init__(self, path):
        self.path = path

    def display_title(self):
        with open(f"{self.path}/title.txt", "r", encoding="utf-8") as file:
            title = file.read()
        print(title)

    def display_menu(self):
        with open(f"{self.path}/menu.txt", "r", encoding="utf-8") as file:
            menu = file.read()
        print(menu)

    def display_rules(self):
        with open(f"{self.path}/rules.txt", "r", encoding="utf-8") as file:
            rules = file.read()
        print(rules)

if __name__ == "__main__":
    ui = UI(Config.PATH_UI)
    ui.display_title()
    ui.display_menu()
    ui.display_rules()
```

由于这部分代码比较简单，我们就不单独编写测试代码了，可以直接运行 `ui.py` 文件来验证其功能是否正确：

```text
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
q. 退出游戏
游戏规则：
- 石头胜剪刀
- 剪刀胜布
- 布胜石头
- 选择相同则为平局
```

### (5) `Logger` 类的实现

`Logger` 类的实现也很简单，就是文件的读写操作。

首先，我们在 `src/logger.py` 文件中，我们实现 `Logger` 类：

```python
# src/logger.py
from config import Config
import datetime

class Logger:
    def __init__(self, path):
        self.path = path

    def log_read(self):
        with open(f"{self.path}/game_log.txt", "r", encoding="utf-8") as file:
            logs = file.read()
        print("游戏记录：")
        print(logs)
        
    def log_write(self, content):
        with open(f"{self.path}/game_log.txt", "a", encoding="utf-8") as file:
            timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            content = f"""[{timestamp}]\n{content}\n"""
            file.write(content + "\n")

if __name__ == "__main__":
    logger = Logger(Config.PATH_LOG)
    log_content = "游戏模式：测试模式\n游戏结果：玩家出布，电脑出石头，玩家胜利"
    logger.log_write(log_content)
    logger.log_read()
```

同样，由于这部分代码比较简单，我们就不单独编写测试代码了，可以直接运行 `logger.py` 文件，并且多运行几次，来验证其功能是否正确：

```text
游戏记录：
[2026-01-04 22:24:56]
游戏模式：测试模式
游戏结果：玩家出布，电脑出石头，玩家胜利

[2026-01-04 22:25:06]
游戏模式：测试模式
游戏结果：玩家出布，电脑出石头，玩家胜利

```

### (6) 将所有部分整合到 `main.py` 中

在实现完所有类之后，我们需要将它们整合到 `main.py` 文件中的 `Program` 类中：

```python
# src/main.py
from config import Config
from logger import Logger
from ui import UI
from game import Game
from human_player import HumanPlayer
from computer_player import ComputerPlayer

class Program:
    def __init__(self):
        self.logger = Logger(Config.PATH_LOG)
        self.ui = UI(Config.PATH_UI)

    def run(self):

        while True:
            self.ui.display_title()
            self.ui.display_menu()
            choice = input("请输入您的选择：")
            if choice == '1':
                game = Game(mode='single', logger=self.logger)
                result = game.play()
                print(result)
                self.logger.log_write(result)
            elif choice == '2':
                game = Game(mode='multi', logger=self.logger)
                result = game.play()
                print(result)
                self.logger.log_write(result)
            elif choice == 'h':
                self.ui.display_rules()
            elif choice == 'l':
                self.logger.log_read()
            elif choice == 'q':
                print("感谢游玩，再见！")
                break
            else:
                print("无效选择，请重新输入。")

if __name__ == "__main__":
    program = Program()
    program.run()
```

我们运行一下主程序，看看效果：

```text
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
q. 退出游戏
请输入您的选择：1
玩家，请输入你的选择（石头/剪刀/布）：石头
玩家选择了：石头
电脑选择了：石头
玩家出了石头，电脑出了石头，结果：平局！
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
q. 退出游戏
请输入您的选择：2
玩家1，请输入你的选择（石头/剪刀/布）：石头  
玩家1选择了：石头
玩家2，请输入你的选择（石头/剪刀/布）：布
玩家2选择了：布
玩家1出了石头，玩家2出了布，结果：玩家2胜利！
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
q. 退出游戏
请输入您的选择：h
游戏规则：
- 石头胜剪刀
- 剪刀胜布
- 布胜石头
- 选择相同则为平局
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
q. 退出游戏
请输入您的选择：l
游戏记录：
[2026-01-04 22:24:56]
游戏模式：测试模式
游戏结果：玩家出布，电脑出石头，玩家胜利

[2026-01-04 22:25:06]
游戏模式：测试模式
游戏结果：玩家出布，电脑出石头，玩家胜利

[2026-01-04 22:43:12]
玩家出了石头，电脑出了石头，结果：平局！

[2026-01-04 22:43:28]
玩家1出了石头，玩家2出了布，结果：玩家2胜利！


=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
q. 退出游戏
请输入您的选择：q
感谢游玩，再见！
```

看到这个结果，就说明所有的功能都已经实现完毕了！

### (7) 完善说明文档

由于我们这个项目没有使用任何第三方库，所以 `requirements.txt` 文件可以保持为空，最后我们只需完善一下 `README.md` 文件，说明项目的基本信息、目录结构、运行方法等内容：

```markdown

# 石头剪刀布游戏

## 项目简介

这是一个使用 Python 面向对象编程实现的简单石头剪刀布游戏。

## 功能特点

- 单人模式：玩家与计算机对战
- 双人模式：两个玩家轮流输入选择
- 查看游戏规则
- 查看历史游戏记录

## 使用方法

1. 克隆项目到本地
2. 运行 `main.py` 文件，或在终端中执行 `python src/main.py`
3. 按照提示进行操作

```


下一节，我们将对这个项目进行一些小改进，体验一下面向对象开发的项目迭代。
