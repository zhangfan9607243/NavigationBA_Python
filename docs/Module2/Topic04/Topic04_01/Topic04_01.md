# Topic 4.1 - 游戏项目介绍

## 1. 项目基本需求

在本章，我们将开发一个完整的 Python 面向对象游戏项目：勇士与地下城

- 这个游戏的玩法十分简单，大家肯定也玩过这种小游戏：

    - 玩家控制一个角色，在地图上可以上下左右移动
    - 地图上有怪物，玩家遇到怪物时就会进入战斗，战斗是由玩家和怪物的攻击、防御、血量等属性决定胜负的
    - 除了怪物，地图上还有宝道具，可以提高玩家的属性

- 大家玩过的类似游戏，都是有游戏界面的，而我们这里用命令行界面来实现这个游戏

根据这个需求，我们可以大概把这个游戏拆解成这几个关键要素：

- **地图**：

    - 地图上有玩家、怪物、以及道具这些游戏要素，并且有障碍物
    - 地图我们将保存在 `data/` 文件夹中
    - 我们来看一个简单的地图示例：

    ```text
    #####################
    #P....S......^......#
    #.....^^^^....^..H..#
    #..........^..^.....#
    #..~~~~~~..^..^..M..#
    #..~.M.....^........#
    #..~.......^^^^^^...#
    #..~~~~~~...........#
    #..............D....#
    #####################
    ```

    - 地图中的符号代表的含义如下：

        - `P`：玩家的初始位置
        - `M`：怪物
        - `S`：剑道具，增加攻击力
        - `D`：盾牌道具，增加防御力
        - `H`：生命药水道具，增加血量
        - `.`：空地，角色可以通过
        - `#`：边界，角色无法通过
        - `~`：水域，角色无法通过
        - `^`：山地，角色无法通过

- **角色**：

    - 我们准备将**角色**设计为**玩家**和**怪物**的父类
    - 因为玩家和怪物都有一些相似的属性，例如攻击力、防御力、血量等

- **道具**：

    - 我们可以先设计一个抽象的道具父类，然后再设计具体的道具子类，例如剑、盾牌、生命药水等
    - 剑可以增加玩家的攻击力，盾牌可以增加防御力，生命药水可以增加血量

- **战斗**：

    - 这里的战斗类似于石头剪刀布游戏里的一局对战，我们传入玩家和怪物两个角色，然后根据双方的属性计算战斗结果
    - 玩家遇到怪物时会进入战斗，战斗结束后根据结果更新玩家的状态

通过以上的关键要素拆解，游戏运行的逻辑就呼之欲出了：

- 首先，运行游戏前我们会加载地图

    - 当我们把地图文件读取进来以后，基本上就知道玩家、怪物、道具、障碍物的位置了
    - 并且也可以知道怪物和道具的数量

- 之后，玩家可以通过输入命令来控制角色在地图上移动

    - 每次移动后，我们都需要检查玩家是否遇到了怪物或者道具
    - 如果遇到怪物，就进入战斗模块

        - 战斗模块会根据玩家和怪物的属性计算战斗结果
        - 如果玩家获胜，就将怪物从地图上移除，并更新玩家的属性
        - 如果玩家失败，游戏结束

    - 如果遇到道具，就拾取道具

        - 拾取道具后，直接更新玩家的属性
        - 并且需要将道具从地图上移除

- 最后，当玩家消灭所有怪物后，游戏胜利

## 2. 游戏中类的设计

根据以上的需求分析，我们可以设计以下几个类来实现这个游戏。

### (1) 角色类几其子类：玩家类和怪物类

首先，比较好理解的就是角色类 `Character` 以及它的子类玩家类 `Player` 和怪物类 `Monster`，这三个类的逻辑比较简单

- 角色类 `Character` 包含以下属性和方法：

    - 属性包括：

        - `name`：角色名称
        - `attack`：攻击力
        - `defense`：防御力
        - `hp`：血量

    - 方法包括：

        - `is_alive()`：判断角色是否存活

- 玩家类 `Player` 完全继承自角色类 `Character`，无需额外属性和方法

- 怪物类 `Monster` 也继承自角色类 `Character`，也无需额外属性和方法


### (2) 道具类及其子类：剑类、盾牌类、生命药水类

接下来是道具类 `Item` 以及它的子类剑类 `Sword`、盾牌类 `Shield` 和生命药水类 `HealthPotion`，这几个类的逻辑也比较简单

- 道具类 `Item` 作为父类应该是个抽象类，因为道具本身没有具体的效果，具体效果要在子类中实现

    - 属性包括：

        - `name`：道具名称

    - 方法包括：

        - `apply(player)`：应用道具效果到玩家身上

- 剑类 `Sword` 继承自道具类 `Item`

    - 重写 `apply(player)` 方法，增加玩家的攻击力

- 盾牌类 `Shield` 继承自道具类 `Item`

    - 重写 `apply(player)` 方法，增加玩家的防御力

- 生命药水类 `HealthPotion` 继承自道具类 `Item`

    - 重写 `apply(player)` 方法，增加玩家的血量

### (3) 战斗类

战斗类 `Battle` 负责处理玩家和怪物之间的战斗逻辑

- 战斗类 `Battle` 包含以下方法：

    - `fight(player, monster)`：处理玩家和怪物之间的战斗逻辑

        - 计算双方的伤害
        - 更新双方的血量
        - 判断战斗结果

然而，涉及到这里大家可能发现一个问题

- 战斗类，没有属性，只有一个方法
- 这种情况下，我们其实可以不需要专门设计一个战斗类，而是直接把战斗逻辑写成一个独立的函数
- 这样设计会更简单一些

因此，我们直接设置一个独立的函数 `fight(player, monster)` 来处理战斗逻辑即可

### (4) 地图类

地图类 `World` 负责处理地图的加载、显示以及玩家移动等逻辑，这个是最复杂的一个类了

- 首先，地图类会加载地图文件，并将地图内容存储在一个二维列表中

    - 例如，如果我们的地图中的两行是 `#P..S..^...#` 和 `#^^^..~..H.#`，那么存储在二维列表中的形式就是：

    ```python
    [   
        ['#', 'P', '.', '.', 'S', '.', '.', '^', '.', '.', '.', '#'],
        ['#', '^', '^', '^', '.', '.', '~', '.', '.', 'H', '.', '#']
    ]
    ```

    - 并且，我们使用一个二元组 `(x, y)` 来表示地图上的位置坐标，`x` 表示列索引，`y` 表示行索引，比方说上面例子中：
    
        - 玩家 `P` 的位置就是 `(1, 0)`，在二维列表中的索引是 `[0][1]`
        - 剑 `S` 的位置是 `(4, 0)`，在二维列表中的索引是 `[0][4]`
        - 生命药水 `H` 的位置是 `(9, 1)`，在二维列表中的索引是 `[1][9]`
    
    - 为什么坐标和索引是反过来的呢？

        - 因为我们习惯表示坐标时，先写横坐标 `x` 再写纵坐标 `y`
        - 而在二维列表中，是先写行索引再写列索引
        - 例如，玩家 `P` 在二维列表中的索引是 `[0][1]`，表示第 0 行第 1 列，而它的横坐标是 1，纵坐标是 0，所以坐标是 `(1, 0)`   

- 其次，地图还负责玩家移动

    - 比方说，玩家当前的位置是 `(1, 0)`，玩家输入向右移动，那么新的位置就是 `(2, 0)`
    - 玩家在到了新的位置 `(2, 0)` 后，如果该位置是空地 `.`，那么玩家就可以成功移动过去，此时 `(2, 0)` 应该是 `P`，而 `(1, 0)` 变成空地 `.`
    - 如果新位置 `(2, 0)` 是障碍物 `#`、`^`、`~`，那么玩家就无法移动过去，玩家位置不变
    - 如果新位置 `(2, 0)` 是怪物 `M`，那么就触发战斗逻辑

        - 如果玩家获胜，那么 `(2, 0)` 位置就应该是玩家 `P`，而 `(1, 0)` 变成空地 `.`，怪物 `M` 就从地图上移除了
        - 如果玩家失败，游戏结束

    - 如果新位置 `(2, 0)` 是道具 `S`、`D`、`H`，那么玩家就拾取道具

        - 拾取道具后，玩家位置变成 `(2, 0)` 的 `P`，而 `(1, 0)` 变成空地 `.`，原来的道具 `S`、`D`、`H` 就从地图上移除了
        - 并且道具的效果会应用到玩家身上

### (5) 其他类

其他的一些辅助类，我们在石头剪刀布项目中已经讲过，比方说：

- 程序运行类 `Program`
- 配置类 `Config`
- 界面类 `UI`
- 日志类 `Logger`

这些类的设计单一，实现方式简单，我们这里就不再赘述了

## 3. 游戏主程序和辅助类的实现

我们先来实现比较简单的游戏主程序和辅助类。

### (1) 游戏主程序类 `Program`

游戏主程序类 `Program` 负责游戏的整体运行逻辑：

- 其中，`run()` 方法大家比较熟悉了，我们在石头剪刀布项目中已经体验过，就是程序的主循环

- 还有一个比较复杂的方法要实现，那就是我们如何处理玩家在进入游戏后，输入上下左右移动的命令

    - 这个方法，听上去是放在 `World` 里比较合适
    - 但是，我们一个常见的设计原则是，所有处理用户输入的逻辑，都应该放在程序主循环里
    - 因此，我们把这个方法也放在 `Program` 类里实现

```python
# src/main.py
# from config import Config
# from ui import UI
# from world import World

class Program:

    def run(self):

        # 游戏主循环
        while True:
            
            # TODO: 展示标题和菜单
            # UI.display_title()
            # UI.display_menu()

            # 获取玩家输入
            choice = input("请输入选项：")

            if choice == "p":

                while True:

                    print("请选择游戏难度：")
                    print("1. 简单（小地图）")
                    print("2. 普通（中地图）")
                    print("3. 困难（大地图）")
                    print("q. 返回主菜单")

                    choice_play = input("请选择游戏难度：").strip()

                    if choice_play == "1":
                        # TODO: 开始游戏
                        # self.start_game(f"{Config.PATH_DATA}/map/map_small.txt")
                        pass
                    elif choice_play == "2":
                        # TODO: 开始游戏
                        # self.start_game(f"{Config.PATH_DATA}/map/map_medium.txt")
                        pass
                    elif choice_play == "3":
                        # TODO: 开始游戏
                        # self.start_game(f"{Config.PATH_DATA}/map/map_large.txt")
                        pass
                    elif choice_play == "q":
                        break
                    else:
                        print("无效的选项，请重新输入！")
            
            if choice == "r":
                # TODO: 展示游戏规则
                # UI.display_rule()
                pass

            if choice == "q":
                print("感谢游玩，期待下次再见！")
                break
    
    def start_game(self, map_path):

        world = World(map_path)

        print("游戏开始！")
        print("使用 w/a/s/d 控制上下左右移动，q 退出本局游戏。")
        
        while True:

            world.map_show()
            
            cmd = input("您的指令：").strip().lower()

            if cmd == 'q':
                print("你退出了本次游戏。")
                break
            elif cmd == 'w':
                pass
                # TODO: 玩家移动
            elif cmd == 's':
                pass
                # TODO: 玩家移动
            elif cmd == 'a':
                pass
                # TODO: 玩家移动
            elif cmd == 'd':
                pass
                # TODO: 玩家移动
            else:
                print("无效的命令，请重新输入！")

            if not world.player.is_alive():
                print("你的生命值归零，游戏结束。")
                break
            
            if world.monsters == {}:
                print("恭喜你，击败了所有怪物，赢得了游戏！")
                break

        input("按回车返回主菜单...")

```

### (2) 配置类

配置类 `Config` 的实现也比较简单，这里我们只放置文件路径

```python
# src/config.py
class Config:
    PATH_DATA = "codes/Module2/Topic04/fnd_v1/data"
    PATH_LOG = "codes/Module2/Topic04/fnd_v1/log"
```

### (3) 界面类

界面类 `UI` 也很简单，主要就是读取文件并且打印在控制台上

```python
# src/ui.py
from config import Config

class UI:

    @staticmethod
    def display_title():
        with open(f"{Config.PATH_DATA}/ui/title.txt", "r", encoding="utf-8") as f:
            title = f.read()
        print(title)

    @staticmethod
    def display_menu():
        with open(f"{Config.PATH_DATA}/ui/menu.txt", "r", encoding="utf-8") as f:
            menu = f.read()
        print(menu)

    @staticmethod
    def display_rule():
        with open(f"{Config.PATH_DATA}/ui/rule.txt", "r", encoding="utf-8") as f:
            rule = f.read()
        print(rule)
```

注意，我们在石头剪刀布的项目中，是把 `UI` 类设计成了需要实例化的类，但是其实是多此一举的：

- 因为 `UI` 类中没有任何属性，只有方法
- 所以完全可以把这些方法都设计成静态方法 `@staticmethod`，这样就不需要实例化 `UI` 类了

### (4) 日志类

日志类 `Logger` 我们也设计成一个静态类，和石头剪刀布项目中不同：

```python
# src/logger.py
from config import Config
import datetime

class Logger:

    @staticmethod
    def log_write(message):
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(f"{Config.PATH_LOG}/game.log", "a", encoding="utf-8") as f:
            f.write(f"[{timestamp}]\n{message}\n")
    
    @staticmethod
    def log_read():
        with open(f"{Config.PATH_LOG}/game.log", "r", encoding="utf-8") as f:
            return f.read()
```

同样，这里我们只设计了读写的逻辑，没有设计日志的格式，日志的格式我们放在游戏中实现

到此为止，我们的游戏主程序和辅助类就实现完毕了，我们下一节开始实现游戏的核心类：角色类、道具类、地图类等。
