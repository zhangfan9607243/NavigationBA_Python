# Topic 3.3 - Python 面向对象程序 - 石头剪刀布程序改进

上一节我们使用面向对象的方法实现了一个简单的“石头剪刀布”游戏程序，本节我们将对该程序进行一些改进，使其功能更加完善。

改进点包括：

- 1 增加游戏轮数功能
- 2 增加玩家名称输入功能
- 3 增加游戏结果统计排行榜功能

在本节正式开始前，我们先把上节课的代码文件夹 `rps_game_v1` 复制一份，命名为 `rps_game_v2`，并且要记得将配置类中的文件路径也进行相应修改。


## 1. 增加游戏轮数的功能

在上一个版本中，游戏只进行了一轮，双方各出一次拳就结束了

- 现在我们希望能够让玩家选择游戏的轮数，比如说玩一轮、三轮、五轮等
- 并且在每轮结束后，显示当前比分
- 在日志记录中，要记录每一轮的结果，也要记录总比分

这个功能的实现其实比较简单，只需在 `Game` 类中增加一个属性 `rounds` 来表示总轮数，并在 `play` 方法中增加一个循环来进行多轮游戏即可

- 但是比较麻烦的是，我们还需要修改输出的内容，不仅显示本轮结果，还要在每轮后显示当前比分，最后还要显示总比分和最终获胜者
- 我们还需要修改 `play` 方法返回的内容，以用于日志记录，让它能够记录每一轮的结果和总比分
- 当然，这部分麻烦是麻烦，但是难度是不大的，就是多一些打印和变量维护而已

修改后的代码如下：

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

        print("请选择游戏轮数：\n1. 一局定胜负\n2. 三局两胜\n3. 五局三胜（）")
        rounds_choice = input("请输入您的选择（默认为一局定胜负）：").strip()
        if rounds_choice == '2':
            self.rounds = 3
        elif rounds_choice == '3':
            self.rounds = 5
        else:
            self.rounds = 1

    def play(self):

        player1_score = 0
        player2_score = 0
        
        for i in range(1, self.rounds + 1):
            print(f"第 {i} 轮开始！")
            choice1 = self.player1.make_choice()
            choice2 = self.player2.make_choice()
            result = self.decide(choice1, choice2)
            if result == 1:
                player1_score += 1
            elif result == 2:
                player2_score += 1
            print(f"{self.player1.name}出了{choice1}，{self.player2.name}出了{choice2}，结果：{result}")
            print(f"当前比分：{self.player1.name} {player1_score} vs {player2_score} {self.player2.name}")
        print("游戏结束！")
        print(f"最终比分：{self.player1.name} {player1_score} vs {player2_score} {self.player2.name}")
        print("最终获胜者：", end="")
        if player1_score > player2_score:
            print(self.player1.name)
        elif player2_score > player1_score:
            print(self.player2.name)
        else:
            print("平局！")

    def decide(self, choice1, choice2):
        if choice1 == choice2:
            return 0
        elif (choice1 == "石头" and choice2 == "剪刀") or (choice1 == "剪刀" and choice2 == "布") or (choice1 == "布" and choice2 == "石头"):
            return 1
        else:
            return 2

```

这里我们其实是修改了一下设计思路，冗长的打印内容放在了 `play` 方法中，而不是返回给调用者去打印

- 因此，我们需要在调用了 `play` 方法的地方，把打印调用结果的代码删除掉
- 其实只有两个地方调用了，一个是主程序中，一个是测试代码中，这里大家自行把调用结果打印的代码删除掉即可，我们就不展示了

在进行了上述修改后，我们就可以运行一下 `src/game.py` 对应的测试程序 `test/test_game.py`，测试一下多轮游戏的效果了

```text
测试单人模式：
请选择游戏轮数：
1. 一局定胜负
2. 三局两胜
3. 五局三胜
请输入您的选择（默认为一局定胜负）：1
------------------------------
第 1 轮开始！
玩家，请输入你的选择（石头/剪刀/布）：石头  
玩家选择了：石头
电脑选择了：布
第 1 轮：玩家 出了 石头，电脑 出了 布，结果：电脑 获胜
第 1 轮后的比分：玩家 0 vs 1 电脑
******************************
游戏结束！
最终比分：玩家 0 vs 1 电脑
最终获胜者：电脑

测试多人模式：
请选择游戏轮数：
1. 一局定胜负
2. 三局两胜
3. 五局三胜
请输入您的选择（默认为一局定胜负）：2
------------------------------
第 1 轮开始！
玩家1，请输入你的选择（石头/剪刀/布）：石头
玩家1选择了：石头
玩家2，请输入你的选择（石头/剪刀/布）：剪刀
玩家2选择了：剪刀
第 1 轮：玩家1 出了 石头，玩家2 出了 剪刀，结果：玩家1 获胜
第 1 轮后的比分：玩家1 1 vs 0 玩家2
******************************
第 2 轮开始！
玩家1，请输入你的选择（石头/剪刀/布）：石头
玩家1选择了：石头
玩家2，请输入你的选择（石头/剪刀/布）：布
玩家2选择了：布
第 2 轮：玩家1 出了 石头，玩家2 出了 布，结果：玩家2 获胜
第 2 轮后的比分：玩家1 1 vs 1 玩家2
******************************
第 3 轮开始！
玩家1，请输入你的选择（石头/剪刀/布）：石头
玩家1选择了：石头
玩家2，请输入你的选择（石头/剪刀/布）：石头
玩家2选择了：石头
第 3 轮：玩家1 出了 石头，玩家2 出了 石头，结果：平局
第 3 轮后的比分：玩家1 1 vs 1 玩家2
******************************
游戏结束！
最终比分：玩家1 1 vs 1 玩家2
最终获胜者：平局！
```

## 2. 增加玩家名称输入功能

### (1) 分析修改需求

这个功能实现起来比较简单，我们只需在 `Game` 类的初始化方法中，增加玩家名称的输入即可

- 但是这里我们想做一个升级，这个升级操作起来就有一点难度了，那就是增加一个玩家系统到游戏中，这个功能和我们后续要实现的排行榜功能是相关联的，因此我们先把这个功能实现好，后续再来实现排行榜功能
- 具体来说，当玩家输入名称后，我们需要把该名称保存到一个玩家数据库文件中：

    - 如果该名称已经存在，则要询问玩家是否使用该名称对应的玩家信息，如果是，则加载该玩家信息，如果否，则覆盖该名称对应的玩家信息
    - 如果不存在，则直接创建一个新的玩家信息并保存到文件中

- 说到这里，其实大家已经可以想到了，我们需要一个 `json` 文件来保存玩家信息

    - 当需要读取玩家信息时，就从该 `json` 文件中读取，读取为 Python 中的字典
    - 当需要保存玩家信息时，就把 Python 中的字典写入到该 `json` 文件中

那么首先，我们来确定一下 `json` 文件的结构

- 假设我们把玩家信息保存到 `player.json` 文件中，那么该文件的结构可以设计为：

```json
{
    "张三": {
        "胜利": 10,
        "失败": 5,
        "平局": 3
    },
    "李四": {
        "胜利": 7,
        "失败": 8,
        "平局": 2
    }
}
```

- 通常这个文件的位置比较灵活，在 `data/` 中也可以，在 `log/` 中也可以，这里我们就放在 `data/` 文件夹中，文件名为 `player.json` 即可

### (2) 修改和测试玩家类

在保存好这个文件后，我们就可以开始修改代码了

首先要修改 `HumanPlayer` 类（只修改真人玩家，因为电脑玩家不统计分数）：

- 在初始化函数中，先要继承父类的初始化函数，再提示玩家输入玩家名称，并且检验该名称是否存在于 `player.json` 文件中
- 之后，我们需要加一个属性 `stats`，用来保存统计到的玩家分数，就是我们上面提到的分数字典

```python
# src/human_player.py
import json
from config import Config
from player import Player

class HumanPlayer(Player):

    def __init__(self, name=None):
        # 继承父类的初始化方法
        super().__init__(name)
        # 初始化玩家名称与状态，以下代码比较复杂，其实可以封装为一个方法
        if name is None:
            self.name = input("请输入玩家名称：").strip()
        else:
            self.name = name
        self.players_info = self.load_players_info()
        if self.name in self.players_info:
            use_existing = input(f"玩家名称'{self.name}'已存在，是否使用该名称对应的玩家信息？（y/n）(默认为否)：").strip().lower()
            if use_existing in ['y', 'yes', '是']:
                self.stats = self.players_info[self.name]
            else:
                self.stats = {"胜利": 0, "失败": 0, "平局": 0}
        else:
            self.stats = {"胜利": 0, "失败": 0, "平局": 0}
    
    def load_players_info(self):
        with open(f'{Config.PATH_UI}/player.json', 'r', encoding='utf-8') as f:
            return json.load(f)

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

之后，我们修改相应的测试代码 `test/test_human_player.py`，来测试能否正确显示玩家分数字典：

```python
# test/test_human_player.py
from config_test import *
from human_player import HumanPlayer

def test_human_player_make_choice():
    player = HumanPlayer()
    print(player.stats)
    choice = player.make_choice()
    print(f"玩家选择是：{choice}")

if __name__ == "__main__":
    test_human_player_make_choice()
    print()
    test_human_player_make_choice()
    print()
    test_human_player_make_choice()
```

```text
请输入玩家名称：张三
玩家名称'张三'已存在，是否使用该名称对应的玩家信息？（y/n）(默认为否)：y
{'胜利': 10, '失败': 5, '平局': 3}
张三，请输入你的选择（石头/剪刀/布）：石头
张三选择了：石头
玩家选择是：石头

请输入玩家名称：李四
玩家名称'李四'已存在，是否使用该名称对应的玩家信息？（y/n）(默认为否)：n
{'胜利': 0, '失败': 0, '平局': 0}
李四，请输入你的选择（石头/剪刀/布）：石头
李四选择了：石头
玩家选择是：石头

请输入玩家名称：王五
{'胜利': 0, '失败': 0, '平局': 0}
王五，请输入你的选择（石头/剪刀/布）：石头
王五选择了：石头
玩家选择是：石头
```

注意，我们运行这段代码，只是展示每个玩家的分数字典，并不会更新 `player.json` 文件中的内容，更新文件内容的操作会在游戏类中进行

### (3) 修改和测试游戏类

游戏类中的修改主要是两点：

- 一是不再对真人玩家使用默认名称，而是让玩家输入名称
- 二是在每轮游戏结束后，更新每位玩家的分数字典，并在游戏结束后保存玩家的分数统计信息，这主要涉及两个新的方法：

    - `update_stats`，用来根据游戏结果更新玩家分数
    - `save_stats`，用来保存玩家分数统计信息到文件


```python
# src/game.py
from human_player import HumanPlayer
from computer_player import ComputerPlayer
from config import Config
import json

class Game:

    def __init__(self, mode):

        if mode == 'single':
            self.player1 = HumanPlayer()
            self.player2 = ComputerPlayer("电脑")
        elif mode == 'multi':
            self.player1 = HumanPlayer()
            self.player2 = HumanPlayer()
        
        self.player_info = self.load_players_info()
        
        print("请选择游戏轮数：\n1. 一局定胜负\n2. 三局两胜\n3. 五局三胜")
        rounds_choice = input("请输入您的选择（默认为一局定胜负）：").strip()
        if rounds_choice == '2':
            self.rounds = 3
        elif rounds_choice == '3':
            self.rounds = 5
        else:
            self.rounds = 1
        
        print("-" * 30)

    def load_players_info(self):
        with open(f'{Config.PATH_UI}/player.json', 'r', encoding='utf-8') as f:
            return json.load(f)
    
    def play(self):

        # 初始化比分与日志内容
        player1_score = 0
        player2_score = 0
        log_content = ""
        
        # 每轮游戏
        for i in range(1, self.rounds + 1):

            # 轮次开始提示
            rounds_content1 = f"第 {i} 轮开始！"
            print(rounds_content1)
            log_content += rounds_content1 + "\n"

            # 玩家出拳与结果判定
            choice1 = self.player1.make_choice()
            choice2 = self.player2.make_choice()
            result = self.decide(choice1, choice2)
            if result == 1:
                player1_score += 1
            elif result == 2:
                player2_score += 1
            
            # 展示当前轮的结果
            rounds_content2 = f"第 {i} 轮：{self.player1.name} 出了 {choice1}，{self.player2.name} 出了 {choice2}，结果："
            if result == 0:
                rounds_content2 += "平局"
            elif result == 1:
                rounds_content2 += f"{self.player1.name} 获胜"
                # 更新玩家统计信息
                self.update_stats(self.player1, {"胜利": 1, "失败": 0, "平局": 0})
                if isinstance(self.player2, HumanPlayer):
                    self.update_stats(self.player2, {"胜利": 0, "失败": 1, "平局": 0})
            else:
                rounds_content2 += f"{self.player2.name} 获胜"
                # 更新玩家统计信息
                self.update_stats(self.player1, {"胜利": 0, "失败": 1, "平局": 0})
                if isinstance(self.player2, HumanPlayer):
                    self.update_stats(self.player2, {"胜利": 1, "失败": 0, "平局": 0})
            print(rounds_content2)
            log_content += rounds_content2 + "\n"

            # 展示当前轮后的比分
            rounds_content3 = f"第 {i} 轮后的比分：{self.player1.name} {player1_score} vs {player2_score} {self.player2.name}"
            print(rounds_content3)
            log_content += rounds_content3 + "\n"

            print("*" * 30)
        
        # 游戏结束
        game_content1 = "游戏结束！"
        print(game_content1)
        log_content += game_content1 + "\n"

        # 展示最终比分
        game_content2 = f"最终比分：{self.player1.name} {player1_score} vs {player2_score} {self.player2.name}"
        print(game_content2)
        log_content += game_content2 + "\n"

        # 展示最终获胜者
        game_content3 = "最终获胜者："
        if player1_score > player2_score:
            game_content3 += f"{self.player1.name}"
        elif player2_score > player1_score:
            game_content3 += f"{self.player2.name}"
        else:
            game_content3 += "平局！"
        print(game_content3)
        log_content += game_content3 + "\n"

        # 保存玩家统计信息
        self.save_stats(self.player1)
        if isinstance(self.player2, HumanPlayer):
            self.save_stats(self.player2)

        # 返回日志内容
        return log_content

    def decide(self, choice1, choice2):
        if choice1 == choice2:
            return 0
        elif (choice1 == "石头" and choice2 == "剪刀") or (choice1 == "剪刀" and choice2 == "布") or (choice1 == "布" and choice2 == "石头"):
            return 1
        else:
            return 2
    
    def update_stats(self, player, result_stats):
        for key in result_stats:
            player.stats[key] += result_stats[key]
    
    def save_stats(self, player):
        self.player_info[player.name] = player.stats
        with open(f'{Config.PATH_UI}/player.json', 'w', encoding='utf-8') as f:
            json.dump(self.player_info, f, ensure_ascii=False, indent=4)
```

之后，我们修改相应的测试代码 `test/test_game.py`，来测试我们新增的功能是否正确：

```python
# test/test_game.py
from config_test import *
from game import Game

def test_game_single_mode():
    game = Game(mode='single')
    print(game.player1.stats)
    result = game.play()
    print(game.player1.stats)

def test_game_multi_mode():
    game = Game(mode='multi')
    print(game.player1.stats)
    print(game.player2.stats)
    result = game.play()
    print(game.player1.stats)
    print(game.player2.stats)

if __name__ == "__main__":
    print("测试单人模式：")
    test_game_single_mode()
    print()
    print("测试多人模式：")
    test_game_multi_mode()
```

```text
测试单人模式：
请输入玩家名称：张三
玩家名称'张三'已存在，是否使用该名称对应的玩家信息？（y/n）(默认为否)：y
请选择游戏轮数：
1. 一局定胜负
2. 三局两胜
3. 五局三胜
请输入您的选择（默认为一局定胜负）：1
------------------------------
{'胜利': 10, '失败': 5, '平局': 3}
第 1 轮开始！
张三，请输入你的选择（石头/剪刀/布）：石头
张三选择了：石头
电脑选择了：布
第 1 轮：张三 出了 石头，电脑 出了 布，结果：电脑 获胜
第 1 轮后的比分：张三 0 vs 1 电脑
******************************
游戏结束！
最终比分：张三 0 vs 1 电脑
最终获胜者：电脑
{'胜利': 10, '失败': 6, '平局': 3}

测试多人模式：
请输入玩家名称：李四
玩家名称'李四'已存在，是否使用该名称对应的玩家信息？（y/n）(默认为否)：y
请输入玩家名称：王五
请选择游戏轮数：
1. 一局定胜负
2. 三局两胜
3. 五局三胜
请输入您的选择（默认为一局定胜负）：2
------------------------------
{'胜利': 7, '失败': 8, '平局': 2}
{'胜利': 0, '失败': 0, '平局': 0}
第 1 轮开始！
李四，请输入你的选择（石头/剪刀/布）：石头
李四选择了：石头
王五，请输入你的选择（石头/剪刀/布）：布
王五选择了：布
第 1 轮：李四 出了 石头，王五 出了 布，结果：王五 获胜
第 1 轮后的比分：李四 0 vs 1 王五
******************************
第 2 轮开始！
李四，请输入你的选择（石头/剪刀/布）：石头
李四选择了：石头
王五，请输入你的选择（石头/剪刀/布）：布
王五选择了：布
第 2 轮：李四 出了 石头，王五 出了 布，结果：王五 获胜
第 2 轮后的比分：李四 0 vs 2 王五
******************************
第 3 轮开始！
李四，请输入你的选择（石头/剪刀/布）：石头
李四选择了：石头
王五，请输入你的选择（石头/剪刀/布）：布
王五选择了：布
第 3 轮：李四 出了 石头，王五 出了 布，结果：王五 获胜
第 3 轮后的比分：李四 0 vs 3 王五
******************************
游戏结束！
最终比分：李四 0 vs 3 王五
最终获胜者：王五
{'胜利': 7, '失败': 11, '平局': 2}
{'胜利': 3, '失败': 0, '平局': 0}
```

测试代码运行完成后，我们可以打开 `data/player.json` 文件，查看玩家信息是否正确保存

```json
{
    "张三": {
        "胜利": 10,
        "失败": 6,
        "平局": 3
    },
    "李四": {
        "胜利": 7,
        "失败": 11,
        "平局": 2
    },
    "王五": {
        "胜利": 3,
        "失败": 0,
        "平局": 0
    }
}
```

## 3. 增加游戏结果统计排行榜功能

最后，我们来实现排行榜功能

- 首先，我们需要一个新的类 `Leaderboard`，用来处理排行榜的相关功能，这个类的调用需要放到主程序中

- 其次，我们可以简单制定一下排行榜的规则：

    - 排行榜显示前10名玩家（不满10名则显示全部），按照胜利次数从高到低排序
    - 如果胜利次数相同，则按照失败次数从低到高排序
    - 如果失败次数也相同，则按照平局次数从高到低排序

- 当然，这个规则的实现其实比较复杂，我们直接借助AI的力量帮我们实现

根据上述需求分析，排行榜类的实现如下：

```python
# src/leaderboard.py
import json
from config import Config

class Leaderboard:

    def __init__(self):
        self.players_info = self.load_players_info()
    
    def load_players_info(self):
        with open(f'{Config.PATH_UI}/player.json', 'r', encoding='utf-8') as f:
            return json.load(f)
    
    def display_leaderboard(self):
        sorted_players = sorted(self.players_info.items(), key=lambda x: (-x[1]['胜利'], x[1]['失败'], -x[1]['平局']))
        print("排行榜前10名：")
        print("{:<15} \t {:<6} \t {:<6} \t {:<6}".format("玩家名称", "胜利", "失败", "平局"))
        print("-" * 65)
        for i, (name, stats) in enumerate(sorted_players[:10], start=1):
            print("{:<15} \t {:<6} \t {:<6} \t {:<6}".format(name, stats['胜利'], stats['失败'], stats['平局']))

if __name__ == "__main__":
    leaderboard = Leaderboard()
    leaderboard.display_leaderboard()
```

在运行这段代码前，我们先将 `data/player.json` 文件中的玩家信息修改补充完整一些，以便测试排行榜功能：

```json
{
    "张三": {
        "胜利": 10,
        "失败": 6,
        "平局": 3
    },
    "李四": {
        "胜利": 7,
        "失败": 11,
        "平局": 2
    },
    "王五": {
        "胜利": 3,
        "失败": 0,
        "平局": 0
    },
    "赵六": {
        "胜利": 11,
        "失败": 4,
        "平局": 0
    },
    "牛七": {
        "胜利": 6,
        "失败": 7,
        "平局": 3
    },
    "马八": {
        "胜利": 14,
        "失败": 1,
        "平局": 0
    },
    "Alice": {
        "胜利": 5,
        "失败": 8,
        "平局": 2
    },
    "Bob": {
        "胜利": 4,
        "失败": 9,
        "平局": 1
    },
    "Charlie": {
        "胜利": 3,
        "失败": 10,
        "平局": 0
    },
    "David": {
        "胜利": 2,
        "失败": 11,
        "平局": 1
    },
    "Eve": {
        "胜利": 1,
        "失败": 12,
        "平局": 0
    }
}
```

之后，我们再运行 `leaderboard.py` 文件，查看排行榜的显示效果（注意由于 Markdown 格式限制，表格对齐可能不完美，但是在终端中显示是对齐的）：

```text
排行榜前10名：
玩家名称                 胜利            失败            平局    
-----------------------------------------------------------------
马八                     14              1               0     
赵六                     11              4               0     
张三                     10              6               3     
李四                     7               11              2     
牛七                     6               7               3     
Alice                    5               8               2     
Bob                      4               9               1     
王五                     3               0               0     
Charlie                  3               10              0     
David                    2               11              1 
```

## 4. 在主程序中集合所有更新的功能

最后，我们需要在主程序 `src/main.py` 中集合所有更新的功能：

- 首先，我们增加了一个新的选项 `s`，用来显示排行榜（这里我们已经修改了 `data/menu.txt` 中的菜单选项，这里就不展示了）
- 其次，由于每局游戏的输出我们已经放在了 `Game` 类的 `play` 方法中，因此我们不再打印 `play` 方法的返回结果，而是直接调用即可

```python
# src/main.py
from config import Config
from logger import Logger
from ui import UI
from game import Game
from leaderboard import Leaderboard
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
                game = Game(mode='single')
                result = game.play()
                self.logger.log_write(result)
            elif choice == '2':
                game = Game(mode='multi')
                result = game.play()
                self.logger.log_write(result)
            elif choice == 'h':
                self.ui.display_rules()
            elif choice == 'l':
                self.logger.log_read()
            elif choice == 's':
                leaderboard = Leaderboard()
                leaderboard.display_leaderboard()
            elif choice == 'q':
                print("感谢游玩，再见！")
                break
            else:
                print("无效选择，请重新输入。")

if __name__ == "__main__":
    program = Program()
    program.run()
```

我们运行一下主程序 `src/main.py`，测试一下所有功能是否正确：

```text
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
s. 排行榜
q. 退出游戏
请输入您的选择：1
请输入玩家名称：老张
请选择游戏轮数：
1. 一局定胜负
2. 三局两胜
3. 五局三胜
请输入您的选择（默认为一局定胜负）：3
------------------------------
第 1 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
电脑选择了：剪刀
第 1 轮：老张 出了 石头，电脑 出了 剪刀，结果：老张 获胜
第 1 轮后的比分：老张 1 vs 0 电脑
******************************
第 2 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
电脑选择了：布
第 2 轮：老张 出了 石头，电脑 出了 布，结果：电脑 获胜
第 2 轮后的比分：老张 1 vs 1 电脑
******************************
第 3 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
电脑选择了：石头
第 3 轮：老张 出了 石头，电脑 出了 石头，结果：平局
第 3 轮后的比分：老张 1 vs 1 电脑
******************************
第 4 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
电脑选择了：剪刀
第 4 轮：老张 出了 石头，电脑 出了 剪刀，结果：老张 获胜
第 4 轮后的比分：老张 2 vs 1 电脑
******************************
第 5 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
电脑选择了：布
第 5 轮：老张 出了 石头，电脑 出了 布，结果：电脑 获胜
第 5 轮后的比分：老张 2 vs 2 电脑
******************************
游戏结束！
最终比分：老张 2 vs 2 电脑
最终获胜者：平局！
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
s. 排行榜
q. 退出游戏
请输入您的选择：2
请输入玩家名称：老张
玩家名称'老张'已存在，是否使用该名称对应的玩家信息？（y/n）(默认为否)：y
请输入玩家名称：Eve
玩家名称'Eve'已存在，是否使用该名称对应的玩家信息？（y/n）(默认为否)：y
请选择游戏轮数：
1. 一局定胜负
2. 三局两胜
3. 五局三胜
请输入您的选择（默认为一局定胜负）：3
------------------------------
第 1 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
Eve，请输入你的选择（石头/剪刀/布）：剪刀
Eve选择了：剪刀
第 1 轮：老张 出了 石头，Eve 出了 剪刀，结果：老张 获胜
第 1 轮后的比分：老张 1 vs 0 Eve
******************************
第 2 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
Eve，请输入你的选择（石头/剪刀/布）：布
Eve选择了：布
第 2 轮：老张 出了 石头，Eve 出了 布，结果：Eve 获胜
第 2 轮后的比分：老张 1 vs 1 Eve
******************************
第 3 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
Eve，请输入你的选择（石头/剪刀/布）：石头
Eve选择了：石头
第 3 轮：老张 出了 石头，Eve 出了 石头，结果：平局
第 3 轮后的比分：老张 1 vs 1 Eve
******************************
第 4 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
Eve，请输入你的选择（石头/剪刀/布）：剪刀
Eve选择了：剪刀
第 4 轮：老张 出了 石头，Eve 出了 剪刀，结果：老张 获胜
第 4 轮后的比分：老张 2 vs 1 Eve
******************************
第 5 轮开始！
老张，请输入你的选择（石头/剪刀/布）：石头
老张选择了：石头
Eve，请输入你的选择（石头/剪刀/布）：剪刀
Eve选择了：剪刀
第 5 轮：老张 出了 石头，Eve 出了 剪刀，结果：老张 获胜
第 5 轮后的比分：老张 3 vs 1 Eve
******************************
游戏结束！
最终比分：老张 3 vs 1 Eve
最终获胜者：老张
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
s. 排行榜
q. 退出游戏
请输入您的选择：s
排行榜前10名：
玩家名称                 胜利            失败            平局    
-----------------------------------------------------------------
马八                     14              1               0     
赵六                     11              4               0     
张三                     10              6               3     
李四                     7               11              2     
牛七                     6               7               3     
老张                     5               3               0     
Alice                    5               8               2     
Bob                      4               9               1     
王五                     3               0               0     
Charlie                  3               10              0     
=========================
       石头剪刀布游戏
=========================
请选择游戏模式：
1. 单人模式
2. 双人模式
h. 查看规则
l. 查看记录
s. 排行榜
q. 退出游戏
请输入您的选择：q
感谢游玩，再见！
```

到这里，我们石头剪刀布的游戏开发就先告一段落了，大家可以发挥自己的想象力继续扩展功能。

当然，石头剪刀布这个程序还是比较简单的，下一章我们将学习一个更复杂的项目开发案例：勇士与地下城游戏开发，作为 Python 面向对象编程的综合实践。
