# Topic 14.3 - 现金流功能实现

这一节，我们来实现现金流功能：根据用户输入的现金流数据，计算净现值（NPV）和内部收益率（IRR）。

这里我们程序的基本思路是：

- 让用户定义的现金流数据存储为一个列表
- 如果要计算NPV，我们就单独定义一个函数 `calculate_npv(cash_flows, discount_rate)` 来计算净现值
- 如果要计算IRR，我们就单独定义一个函数 `calculate_irr(cash_flows)` 来计算内部收益率
- 最后我们实现一个主函数 `function_cash_flow_main()` 来处理用户输入和调用计算函数


## 1. 现金流计算功能的主函数

根据上面的思路分析，我们先来实现现金流计算功能的主函数 `function_cash_flow_main()`，参照表达式功能的主函数，我们已经能实现大部分内容：

- 这当中，获得折现率 `get_discount_rate()` 函数比较简单，我们就直接写好了
- 其余的功能，获取现金流列表 `get_cash_flow_list()`、计算IRR `calculate_irr()` 和计算NPV `calculate_npv()`，我们先定义假的函数接口，后续再来实现

```python
# src/function_cash_flow.py
from ui import show_instructions
from logger import log_write

def get_cash_flow_list():
    return [-1000.0, 300.0, 400.0, 500.0, 600.0]

def calculate_irr(cash_flow_list):
    return [0.1234]  # 返回列表形式，方便后续扩展多个IRR结果

def calculate_npv(cash_flow_list, discount_rate):
    return 123.456

def get_discount_rate():
    while True:
        discount_rate_input = input("请输入折现率（小数形式，如 0.05 表示 5%）：").strip()
        try:
            discount_rate = float(discount_rate_input)
            return discount_rate
        except Exception:
            print("折现率格式错误，请输入数字！")

def function_cash_flow_main():
    
    while True:

        # 展示功能菜单
        print("-" * 40)
        print("现金流计算功能：")
        print("0. 使用说明")
        print("1. 输入现金流并进行运算")
        print("q. 返回主菜单")
        print("-" * 40)

        # 获取用户选择
        choice = input("请选择功能（0/1/q）：")
        print("-" * 40)

        # 0. 查看功能说明
        if choice == "0":
            show_instructions(function_key="2")
            print("-" * 40)
        
        # 1. 现金流计算
        elif choice == "1":
            
            while True:
                
                # 获取用户输入的现金流
                cash_flow_list = get_cash_flow_list()
                
                try:
                    # 计算IRR
                    irr = calculate_irr(cash_flow_list)
                    print("该现金流的内部收益率（IRR）为：", irr)

                    # 计算NPV
                    discount_rate = get_discount_rate()
                    npv = calculate_npv(cash_flow_list, discount_rate=discount_rate)

                    # 输出计算结果
                    print("该现金流的净现值（NPV）为：", round(npv, 4))
                    
                    # 记录计算历史日志
                    log_write("计算历史", {
                        "功能": "现金流计算",
                        "现金流列表": cash_flow_list,
                        "IRR": irr,
                        "折现率": discount_rate,
                        "NPV": round(npv, 4)
                    })
                    
                    # 询问是否继续计算
                    print("-" * 40)
                    choice_continue = input("是否继续计算？(y/n)：").strip().lower()
                    print("-" * 40)
                    if choice_continue != "y":
                        break
                
                # 计算过程中出现错误
                except Exception as err:
                    print("计算过程中出现错误：", err)
                    print("请重新输入现金流进行计算。")
                    log_write("计算历史", {
                        "功能": "现金流计算",
                        "现金流列表": cash_flow_list,
                        "结果": "程序错误：" + str(err)
                    })
                    print("-" * 40)
            
        # q. 返回主菜单
        elif choice == "q":
            break
        
        # 其他. 无效输入
        else:
            print("无效输入，请重新选择。")

if __name__ == "__main__":
    function_cash_flow_main()
```

我们尝试运行一下这个主函数，看看效果：

```text
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：0
----------------------------------------
现金流计算NPV与IRR功能使用说明：
请按照提示输入一系列的现金流数据，程序将计算出净现值（NPV）和内部收益率（IRR）。
输入任意内容返回上级菜单：
----------------------------------------
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
该现金流的内部收益率（IRR）为： 0.1234
请输入折现率（小数形式，如 0.05 表示 5%）：0.05
该现金流的净现值（NPV）为： 123.456
----------------------------------------
是否继续计算？(y/n)：y
----------------------------------------
该现金流的内部收益率（IRR）为： 0.1234
请输入折现率（小数形式，如 0.05 表示 5%）：0.08
该现金流的净现值（NPV）为： 123.456
----------------------------------------
是否继续计算？(y/n)：n
----------------------------------------
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：2
----------------------------------------
无效输入，请重新选择。
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：q
----------------------------------------
```

可以看到，目前主函数的框架已经可以运行起来了，接下来我们就来实现各个功能函数。

## 2. 获取现金流列表

我们先来实现获取现金流列表的函数 `get_cash_flow_list()`，基本的思路是：

- 我们可以在一个无限循环中，每一轮让用户输入一个现金流的时间点和金额，并检查输入的合法性，如果合法则添加到现金流列表中
- 关键就是这个现金流列表的存储结构：

    - 我们如果预先创建一个空列表的话，每次用户输入一个现金流金额后，我们需要根据时间点将其插入到正确的位置
    - 但是我们不知道用户会输入一个多大的时间点，比如用户可能输入时间点0、1、2，也可能输入0、2、5，这样我们就无法预先创建一个合适长度的列表

- 因此，我们可以先存储二元组（时间点，金额）的形式，等用户输入完毕后，再根据时间点将其转换为列表形式

    - 例如，用户输入了 (0, -1000)、(2, 400)、(4, 1200)，三笔现金流
    - 我们就可以先存储为一个列表 `[(0, -1000), (2, 400), (4, 1200)]`
    - 然后再转换为现金流列表 `[-1000, 0, 400, 0, 1200]`
    - 根据时间点的最大值，这个例子中是4，我们就能创建一个合适长度的现金流列表，然后把对应位置的金额填上即可

按照这个思路，我们来实现 `get_cash_flow_list()` 函数：

```python
# src/function_cash_flow.py
def get_cash_flow_list():

    # 获取用户输入的现金流
    cash_flows_tuples = []
    print("-" * 40)
    
    while True:
        # 获取现金流时间点
        cf_time = input("请输入现金流时间点（非负整数）：").strip()
        try:
            cf_time_int = int(cf_time)
            if cf_time_int < 0:
                print("时间点必须是非负整数，请重新输入！")
                continue
        except Exception:
            print("时间点格式错误，请输入非负整数！")
            continue
        # 获取现金流金额
        cf_value = input("请输入现金流金额：").strip()
        try:
            cf_value_float = float(cf_value)
        except Exception:
            print("现金流金额格式错误，请输入数字！")
            continue
        # 添加现金流到列表
        cash_flows_tuples.append((cf_time_int, cf_value_float))
        print("现金流已添加：时间点 =", cf_time_int, "金额 =", cf_value_float)
        print("-" * 40)
        # 询问是否继续添加现金流
        if input("是否继续添加现金流？(y/n)：").strip().lower() != "y":
            break
    
    # 按时间点排序现金流
    cash_flows_tuples.sort(key=lambda x: x[0])
    cash_flow_time_max = cash_flows_tuples[-1][0]

    # 构建完整的现金流列表
    cash_flows = [0.0] * (cash_flow_time_max + 1)
    for t, v in cash_flows_tuples:
        cash_flows[t] = v
    
    print("-" * 40)
    print("完整现金流列表已生成：", cash_flows)

    return cash_flows
```

我们来尝试运行一下这个函数，看看效果：

```text
----------------------------------------
请输入现金流时间点（非负整数）：0
请输入现金流金额：-100
现金流已添加：时间点 = 0 金额 = -100.0
----------------------------------------
是否继续添加现金流？(y/n)：y
请输入现金流时间点（非负整数）：2
请输入现金流金额：400
现金流已添加：时间点 = 2 金额 = 400.0
----------------------------------------
是否继续添加现金流？(y/n)：y
请输入现金流时间点（非负整数）：4
请输入现金流金额：1200
现金流已添加：时间点 = 4 金额 = 1200.0
----------------------------------------
是否继续添加现金流？(y/n)：n
----------------------------------------
完整现金流列表已生成： [-100.0, 0.0, 400.0, 0.0, 1200.0]
```

看到这个结果，我们就成功实现了获取现金流列表的功能。

## 3. 计算净现值（NPV）

NPV 和 IRR 的计算对比，还是 NPV 要简单一些，我们先来实现计算净现值的函数 `calculate_npv(cash_flows, discount_rate)`。

NPV 的计算公式是：

$$NPV = \sum_{t=0}^{n} \frac{CF_t}{(1 + r)^t}$$

我们之前其实在练习题目中实现过一个 NPV 的计算函数，当时的思路是：

```python
# src/function_cash_flow.py
def calculate_npv(cash_flows, discount_rate):
    npv_list = []
    for t in range(len(cash_flows)):
        cf_t = cash_flows[t]
        npv_t = cf_t / ((1 + discount_rate) ** t)
        npv_list.append(npv_t)
    npv = sum(npv_list)
    return npv
```

当时，我们还没学 `enumerate()` 函数，所以用了 `for t in range(len(cash_flows))` 的形式来遍历现金流列表。

现在我们可以用 `enumerate()` 来简化这个代码，同时我们也可以直接累加 NPV 的值，而不需要先存储到一个列表中，最后再求和。改进后的代码如下：

```python
# src/function_cash_flow.py
def calculate_npv(cash_flows, discount_rate):
    npv = 0.0
    for t, cf_t in enumerate(cash_flows):
        npv_t = cf_t / ((1 + discount_rate) ** t)
        npv += npv_t
    return npv
```

## 4. 计算内部收益率（IRR）

计算内部收益率（IRR）相对来说要复杂一些，因为 IRR 是使得净现值（NPV）等于零的折现率，这个需要使用解方程的方法来实现。

IRR 的计算公式是：

$$\sum_{t=0}^{n} \frac{CF_t}{(1 + IRR)^t} = 0$$

- 我们在金融课上学过，首先，这个公式想要用解方程的方法来求解 IRR 是比较困难的
- 其次，这个公式可能有多个解，或者没有解，因此，计算 IRR 通常是通过数值方法来实现的

由于求解 IRR 是很困难的，因此，我们这里直接使用“他山之石”：

- 不论是互联网上，还是 AI 工具，或者是现有的 Python 库，都有很多现成的 IRR 计算方法
- 我们可以直接借鉴这些方法，来实现我们的 `calculate_irr(cash_flows)` 函数

这里呢，我直接使用 `numpy_financial` 库中的 `irr()` 函数来计算 IRR，大家没有安装的话，需要先安装：


```python
import numpy_financial as npf

cf1 = [-1000, 300, 400, 500, 600]
print(npf.irr(cf1))

cf2 = [-1000, 300, 400, -500, 600]
print(npf.irr(cf2))
```

    0.2488833566240709
    -0.08200378307661349


但是，这个方法在 IRR 没有解的时候，会返回 NaN，这个是 `numpy` 里的空值，我们给它换成 Python 自带的 `None`。


```python
import numpy_financial as npf
import numpy as np

def calculate_irr(cash_flows):
    try:
        irr = npf.irr(cash_flows)
        if irr is np.nan:
            return [None]
        else:
            return [irr]
    except:
        return [None]

cf1 = [-1000, 300, 400, 500, 600]
print(calculate_irr(cf1))

cf2 = [-1000, 300, 400, -500, 600]
print(calculate_irr(cf2))

cf3 = [-1000, 1000]
print(calculate_irr(cf3))

cf4 = [100, 200, 300]  # IRR 无解
print(calculate_irr(cf4))
```

    [0.2488833566240709]
    [-0.08200378307661349]
    [0.0]
    [None]


其实，我们这里的 IRR 计算，实现的比较简单：

- 大家可以根据需要，选择更复杂的实现方法，例如支持多解的返回，多个解返回为一个列表
- 这里大家可以体会到函数接口的重要性，我们只要保证函数接口不变，就可以随时更换实现方法
- 也就是说，我们可以定义一个更复杂的 IRR 函数，只要这个函数接收一个列表的现金流作为输入，返回一个列表的 IRR 结果即可，中间的计算我们可以随时更换实现方法

这里，我们使用了第三方库 `numpy_financial` 和 `numpy`

- 所以我们在 `requirements.txt` 文件中添加第三方库依赖
- 不强调版本号则表示安装最新版本即可

```text
numpy-financial 
numpy
```

## 5. 现金流功能的测试

计算 IRR 和 NPV 的函数实现后，使用一个框架同时测试这两个函数：

- 测试 IRR 基于的逻辑是：

    - 在 IRR 有解的情况下：

        - IRR 代入到 NPV 公式中，计算出来的 NPV 应该等于 0
        - 就算我们有多个 IRR 结果，我们也可以逐个代入 NPV 公式进行验证

    - 在 IRR 无解的情况下：

        - 我们就检查 IRR 无解的情况是否满足
        - 现金流列表中，如果都是正数，或者都是负数，那么 IRR 就无解

- 测试 NPV，则直接在金融计算器里（我用的计算器是 TI BA II Plus）计算几个现金流的 NPV，然后和程序计算结果对比一下

按照这个思路，我们在 `test/test_function_cash_flow.py` 实现测试代码如下：

```python
# tests/test_function_cash_flow.py
from config_test import *
from function_cash_flow import calculate_npv, calculate_irr

# 测试净现值计算功能的正确性
def test_calculate_irr_npv():

    def test_irr(cash_flows):
        
        irr_list = calculate_irr(cash_flows)
        irr_valid_list = [False for irr in irr_list]
        
        if irr_list == [None]:
            # 直接在这里判断现金流是否发生过变号（忽略 0）
            signs = [cf > 0 for cf in cash_flows if cf != 0]

            # 若列表非空且存在相邻符号不同，则说明发生变号
            if signs and any(sign != signs[0] for sign in signs):
                return [False] # 有变号（理论上可能有IRR）
            else:
                return [True]  # 无变号（理论上无IRR）

        else:
            for idx, irr in enumerate(irr_list):
                npv = calculate_npv(cash_flows, irr)
                if abs(npv) < 0.01:
                    irr_valid_list[idx] = True
                else:
                    irr_valid_list[idx] = False
        
        if all(irr_valid_list):
            return True
        else:
            return False

    def test_npv(cash_flows, discount_rate, npv_expected):
        npv_calculated = calculate_npv(cash_flows, discount_rate)
        if abs(npv_calculated - npv_expected) < 0.01:
            return True
        else:
            return False


    # 测试用例：格式为：(现金流列表, 折现率, NPV)
    test_cases = [
        ([-1000, 200, 300, 400, 500, 600], 0.08, 535.7846),
        ([-5000, -2000, 3000, 4000, 5000, 6000], 0.10, 5807.0114),
        ([-10000, 0, 0, 0, 0, 25000], 0.12, 4185.6714),
        ([-8000, -2000, 4000, 5000, 6000, 7000], 0.09, 6192.8460),
        ([-3000, 800, 800, 800, 800, 800], 0.06, 369.8910),
        ([-10000, 5000, -2000, 7000, 3000, 4000], 0.11, 2349.5975),
        ([10000, -3000, -3000, -3000, -3000], 0.07, -161.6338),
        ([-2000, 600, 600, 600, 600], 0.05, 127.5703),
        ([-15000, -5000, 4000, 6000, 8000, 10000], 0.13, -1799.7419),
        ([-5000, -1000, -500, 0, 8000, 9000], 0.15, 2800.9795),
    ]

    for cash_flows, discount_rate, expected_npv in test_cases:
        assert test_irr(cash_flows)
        assert test_npv(cash_flows, discount_rate, expected_npv)

    print("所有 IRR 和 NPV 测试通过！")

if __name__ == "__main__":
    test_calculate_irr_npv()
```

我们尝试运行一下测试代码，看看效果：

```text
所有 IRR 和 NPV 测试通过！
```

## 6. 将所有功能整合到主函数

到目前为止，我们已经实现了现金流计算功能的各个部分，现在我们只需要将它们整合到主函数 `function_cash_flow_main()` 中即可：

```python
# src/function_cash_flow.py
from ui import show_instructions
from logger import log_write
import numpy_financial as npf
import numpy as np

def get_cash_flow_list():

    # 获取用户输入的现金流
    cash_flows_tuples = []
    print("-" * 40)
    
    while True:
        # 获取现金流时间点
        cf_time = input("请输入现金流时间点（非负整数）：").strip()
        try:
            cf_time_int = int(cf_time)
            if cf_time_int < 0:
                print("时间点必须是非负整数，请重新输入！")
                continue
        except Exception:
            print("时间点格式错误，请输入非负整数！")
            continue
        # 获取现金流金额
        cf_value = input("请输入现金流金额：").strip()
        try:
            cf_value_float = float(cf_value)
        except Exception:
            print("现金流金额格式错误，请输入数字！")
            continue
        # 添加现金流到列表
        cash_flows_tuples.append((cf_time_int, cf_value_float))
        print("现金流已添加：时间点 =", cf_time_int, "金额 =", cf_value_float)
        print("-" * 40)
        # 询问是否继续添加现金流
        if input("是否继续添加现金流？(y/n)：").strip().lower() != "y":
            break
    
    # 按时间点排序现金流
    cash_flows_tuples.sort(key=lambda x: x[0])
    cash_flow_time_max = cash_flows_tuples[-1][0]

    # 构建完整的现金流列表
    cash_flows = [0.0] * (cash_flow_time_max + 1)
    for t, v in cash_flows_tuples:
        cash_flows[t] = v
    
    print("-" * 40)
    print("完整现金流列表已生成：", cash_flows)

    return cash_flows


def calculate_irr(cash_flows):
    try:
        irr = npf.irr(cash_flows)
        if irr is np.nan:
            return [None]
        else:
            return [irr]
    except:
        return [None]

def calculate_npv(cash_flows, discount_rate):
    npv = 0.0
    for t, cf_t in enumerate(cash_flows):
        npv_t = cf_t / ((1 + discount_rate) ** t)
        npv += npv_t
    return npv

def get_discount_rate():
    while True:
        discount_rate_input = input("请输入折现率（小数形式，如 0.05 表示 5%）：").strip()
        try:
            discount_rate = float(discount_rate_input)
            return discount_rate
        except Exception:
            print("折现率格式错误，请输入数字！")

def function_cash_flow_main():
    
    while True:

        # 展示功能菜单
        print("-" * 40)
        print("现金流计算功能：")
        print("0. 使用说明")
        print("1. 输入现金流并进行运算")
        print("q. 返回主菜单")
        print("-" * 40)

        # 获取用户选择
        choice = input("请选择功能（0/1/q）：")
        print("-" * 40)

        # 0. 查看功能说明
        if choice == "0":
            show_instructions(function_key="2")
            print("-" * 40)
        
        # 1. 现金流计算
        elif choice == "1":
            
            while True:
                
                # 获取用户输入的现金流
                cash_flow_list = get_cash_flow_list()
                
                try:
                    # 计算IRR
                    irr = calculate_irr(cash_flow_list)
                    print("该现金流的内部收益率（IRR）为：", irr)  # 由于 IRR 被我们改成了列表，这里取消 round

                    # 计算NPV
                    discount_rate = get_discount_rate()
                    npv = calculate_npv(cash_flow_list, discount_rate=discount_rate)

                    # 输出计算结果
                    print("该现金流的净现值（NPV）为：", round(npv, 4))
                    
                    # 记录计算历史日志
                    log_write("计算历史", {
                        "功能": "现金流计算",
                        "现金流列表": cash_flow_list,
                        "IRR": irr,  # 由于 IRR 被我们改成了列表，这里取消 round
                        "折现率": discount_rate,
                        "NPV": round(npv, 4)
                    })
                    
                    # 询问是否继续计算
                    print("-" * 40)
                    choice_continue = input("是否继续计算？(y/n)：").strip().lower()
                    print("-" * 40)
                    if choice_continue != "y":
                        break
                
                # 计算过程中出现错误
                except Exception as err:
                    print("计算过程中出现错误：", err)
                    print("请重新输入现金流进行计算。")
                    log_write("计算历史", {
                        "功能": "现金流计算",
                        "现金流列表": cash_flow_list,
                        "结果": "程序错误：" + str(err)
                    })
                    print("-" * 40)
            
        # q. 返回主菜单
        elif choice == "q":
            break
        
        # 其他. 无效输入
        else:
            print("无效输入，请重新选择。")

if __name__ == "__main__":
    function_cash_flow_main()
```


运行主函数的结果如下：

```text
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：0
----------------------------------------
现金流计算NPV与IRR功能使用说明：
请按照提示输入一系列的现金流数据，程序将计算出净现值（NPV）和内部收益率（IRR）。
输入任意内容返回上级菜单：
----------------------------------------
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
----------------------------------------
请输入现金流时间点（非负整数）：0
请输入现金流金额：-1000
现金流已添加：时间点 = 0 金额 = -1000.0
----------------------------------------
是否继续添加现金流？(y/n)：y
请输入现金流时间点（非负整数）：1
请输入现金流金额：400
现金流已添加：时间点 = 1 金额 = 400.0
----------------------------------------
是否继续添加现金流？(y/n)：y
请输入现金流时间点（非负整数）：2
请输入现金流金额：900
现金流已添加：时间点 = 2 金额 = 900.0
----------------------------------------
是否继续添加现金流？(y/n)：n
----------------------------------------
完整现金流列表已生成： [-1000.0, 400.0, 900.0]
该现金流的内部收益率（IRR）为： [0.16953597148326582]
请输入折现率（小数形式，如 0.05 表示 5%）：0.06
该现金流的净现值（NPV）为： 178.3553
----------------------------------------
是否继续计算？(y/n)：n
----------------------------------------
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：q
----------------------------------------
```

到此为止，我们的现金流计算功能就实现完成了

- 可以发现，我们这一个功能没有怎么使用测试框架，
- 主要是因为计算 IRR 和 NPV 的函数实现比较简单直接，大家可以根据需要自行添加测试代码
- 之后我们如果扩展 IRR 计算，可以考虑添加更多的测试内容

最后，我么来丰富一下这一功能的说明文档，在 `data/instructiions/instructions_cash_flow.txt` 中编写以下内容：

```text
现金流计算NPV与IRR功能使用说明：
请按照提示输入一系列的现金流数据，在输入每一笔现金流时，需要输入该现金流的时间点（非负整数）和金额。
现金流输入完毕后，程序将自动计算出 IRR。
之后请根据提示输入折现率，程序将计算出 NPV。
```
