# Topic 4.2 - 角色类与道具类的设计与实现

本节我们将实现两个比较简单的类：角色类 `Character` 和道具类 `Item`，以及它们的子类。

## 1. 角色类 `Character`

角色类 `Character` 用于表示游戏中的角色，包括玩家和敌人。它包含以下属性和方法：

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

我们的代码实现如下：

```python
# character.py
class Character:
    def __init__(self, name: str, hp: int, attack: int, defense: int):
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defense = defense

    def is_alive(self):
        return self.hp > 0

class Monster(Character):
    def __init__(self, name: str = "怪物"):
        super().__init__(name=name, hp=20, attack=8, defense=3)

class Player(Character):
    def __init__(self, name: str = "玩家"):
        super().__init__(name=name, hp=30, attack=7, defense=3)
```

这里，我们的组织方式比较复杂，因为我们把每个类都放在了单独的文件中：

- 这种方式的好处是每个类都有自己独立的文件，便于维护和扩展
- 但是有些开发者的习惯是，如果代码很简单，三个类都放在一个文件中也是可以的
- 这里大家可以根据自己的习惯来组织代码结构

## 2. 道具类 `Item`

道具类 `Item` 用于表示游戏中的道具。它包含以下属性和方法：

- 道具类 `Item` 是个抽象类

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

我们的代码实现如下：

```python
from abc import ABC, abstractmethod

class Item(ABC):
    def __init__(self, name: str):
        self.name = name

    @abstractmethod
    def apply(self, player):
        pass

class Potion(Item):
    def __init__(self):
        super().__init__(name="生命药水")

    def apply(self, player):
        player.hp += 10

class Shield(Item):
    def __init__(self):
        super().__init__(name="盾牌")
    def apply(self, player):
        player.defense += 3

class Sword(Item):
    def __init__(self):
        super().__init__(name="剑")

    def apply(self, player):
        player.attack += 3
```

同样，这里我们把每个类都放在了单独的文件中，大家可以根据自己的习惯来组织代码结构。

## 3. 测试角色类与道具类

在编写测试代码之前，我们先把一些路径常量放到 `test/config_test.py` 文件中：

```python
# test/config_test.py
class ConfigTest:
    PATH_SRC = "codes/Module2/Topic04/fnd_v1/src"

import sys
sys.path.append(f"{ConfigTest.PATH_SRC}")
```

由于角色类和道具类是联系比较紧密的，而且实现比较简单，我们这里就把测试代码放在同一个测试文件中，实现在 `tests/test_character_item.py` 文件中：

```python
# tests/test_character_item.py
from config_test import *
from character import Player, Monster
from item import Sword, Shield, Potion 

def test_character_item():
    
    player = Player(name="测试玩家")

    sword = Sword()
    print(f"使用剑前，玩家攻击力：{player.attack}")
    sword.apply(player)
    print(f"使用剑后，玩家攻击力：{player.attack}")

    shield = Shield()
    print(f"使用盾牌前，玩家防御力：{player.defense}")
    shield.apply(player)
    print(f"使用盾牌后，玩家防御力：{player.defense}")

    potion = Potion()
    print(f"使用生命药水前，玩家血量：{player.hp}")
    potion.apply(player)
    print(f"使用生命药水后，玩家血量：{player.hp}")

if __name__ == "__main__":
    test_character_item()
```

这段代码的输出结果如下：

```text
使用剑前，玩家攻击力：10
使用剑后，玩家攻击力：13
使用盾牌前，玩家防御力：5
使用盾牌后，玩家防御力：8
使用生命药水前，玩家血量：30
使用生命药水后，玩家血量：40
```

看到这个结果，我们就可以确认角色类和道具类都实现正确了。

## 4. 战斗函数的实现与测试

在角色类和道具类实现完毕后，我们接下来要实现游戏中的战斗逻辑：

- 首先，战斗的逻辑我们设计成这样：

    - 玩家和怪物轮流攻击对方，直到一方血量归零
    - 每次攻击时，计算有效攻击力 = 攻击力 - 防御力，如果小于等于零，则有效攻击力为1（设置为0有点不太合理）
    - 每次攻击后，打印双方的剩余血量
    - 因此，我们需要一个 `while` 循环来实现战斗轮次的功能

- 其次，我们想让战斗过程更惊心动魄一些，因此我们在每个回合之间加入 `time.sleep(1)`，让程序暂停一秒钟

我们把战斗逻辑实现成一个函数 `fight(player, monster)`，放在 `src/character/fight.py` 文件中，代码如下：

```python
# fight.py
import time

def fight(player, monster):
    
    print(f"\n【战斗开始】 {player.name} VS {monster.name}")

    player_power = max(1, player.attack - monster.defense)
    monster_power = max(1, monster.attack - player.defense)

    print(f"你的有效攻击：{player_power}")
    print(f"怪物的有效攻击：{monster_power}")

    round = 1

    while player.is_alive() and monster.is_alive():
        print(f"\n--- 第 {round} 回合 ---")
        round += 1
        time.sleep(1)

        monster.hp -= player_power
        print(f"{player.name} 攻击了 {monster.name}，{monster.name} 剩余血量：{max(0, monster.hp)}")
        if not monster.is_alive():
            print(f"{monster.name} 被击败了！")
            return True
        
        time.sleep(1)

        player.hp -= monster_power
        print(f"{monster.name} 攻击了 {player.name}，{player.name} 剩余血量：{max(0, player.hp)}")
        if not player.is_alive():
            print(f"{player.name} 被击败了！")
            return False
        
        time.sleep(1)
```

这个函数实现好之后，我们在 `tests/test_fight.py` 文件中编写测试代码，代码如下：

```python
# tests/test_fight.py
from config_test import *
from character import Player, Monster
from item import Sword, Shield, Potion 
from fight import fight

def test_fight():
    
    player = Player(name="测试玩家")
    monster = Monster(name="测试怪物")

    result = fight(player, monster)

    if result:
        print("玩家获胜！")
    else:
        print("怪物获胜！")

    print(f"战斗结束后，玩家血量：{player.hp}, 怪物血量：{monster.hp}")

if __name__ == "__main__":
    test_fight()
```

我们运行一下测试代码，可以看到类似如下的输出结果：

```text
战斗开始】 测试玩家 VS 测试怪物
你的有效攻击：7
怪物的有效攻击：3

--- 第 1 回合 ---
测试玩家 攻击了 测试怪物，测试怪物 剩余血量：13
测试怪物 攻击了 测试玩家，测试玩家 剩余血量：27

--- 第 2 回合 ---
测试玩家 攻击了 测试怪物，测试怪物 剩余血量：6
测试怪物 攻击了 测试玩家，测试玩家 剩余血量：24

--- 第 3 回合 ---
测试玩家 攻击了 测试怪物，测试怪物 剩余血量：0
测试怪物 被击败了！
玩家获胜！
战斗结束后，玩家血量：24, 怪物血量：-1
```

这里我们发现，我们把 `player` 和 `monster` 对象传递给了 `fight` 函数，函数内部对它们的属性进行了修改：

- 函数内部修改的属性值在函数外部也是可以访问到的
- 这个其实就是我们之前讲过的“可变参数”的特性
- 在 Python 中，只有数字、字符串和元组是不可变对象，其他的对象，包括自定义的对象都是可变对象
- 因此，我们在函数内部修改对象的属性时，外部也能看到修改后的结果

到这里，我们的角色类、道具类和战斗函数都实现完毕了。下一节我们将实现地图类 `Map`，这个是游戏中的最重要组成部分。
