# Topic 14.7 - 金融计算器程序升级 - 版本 v3

本章我们准备对金融计算器进行一个大改，升级到 v3 版本，我们先把 `financial_calculator_v2` 文件夹拷贝一份，并将其重命名为 `financial_calculator_v3`：

- 我们本章主要在 `financial_calculator_v3` 文件夹中进行改进
- 并且大家记着将 `config.py` 与 `config_test.py` 中的路径前缀也进行相应的修改

其实我们想加的需求特别简单，但是实现起来要花不少功夫：就是允许用户设置小数点位数，与金额符号（¥或者$）：

- 首先，我们可以想到，这两个设置应该都存在变量里，然后进行运算时，传递到各个计算模块里：

    - 问题就是，这两个变量要放在哪个模块里呢，有同学可能会觉得放在 `config.py` 里比较合适，因为这两个量算是配置参数
    - 但是事实上，放在 `config.py` 里有个大问题，那就是 `config.py` 里的变量是无法在外部被修改的，只能被 `config.py` 内部的代码修改
    - 所以，我们把这两个变量放在一个新模块 `user_settings.py` 里，这个模块专门用来存储可以被外部修改的变量

- 其次，我们还需要一个用户界面，允许用户修改这两个变量：

    - 我们需要在 `main.py` 里添加一个新的菜单选项，进入设置界面
    - 和其他功能一样，我们需要把修改参数这一功能及其函数，放在 `function.py` 里的 `function_info` 字典里
    - 主要的界面展示和修改参数的代码都放在 `user_settings.py` 里，专门用于修改用户可以设置的变量

- 最后，我们还需要修改各个计算模块的代码，让它们在输出结果时，使用用户设置的小数点位数和金额符号：

    - 表达式计算中，只设置小数点位数
    - 现金流和金钱时间价值中，要设置小数点位数，如果是金额的数值还要在输出时加上金额符号

大家平时用的金融计算器还可以设置现金流的时间点是起初还是期末

- 这个功能要实现起来，我们的现金流和金钱时间价值模块都要大改
- 所以我们就暂时不做这个功能，同学们如果有兴趣，课后可以自己尝试实现一下

## 1. 设计用户设置的交互界面

### (1) 设计用户设置模块

首先，我们新建一个 `user_settings.py` 模块，里面既要放入用户设置的变量，也要放入修改这些变量的函数：

- 设置用户界面大家已经比较熟悉了，就是将用户的选择通过 `input()` 函数获取，然后根据选择调用不同的函数，同时整个过程放在一个循环里，直到用户选择退出
- 这段代码的关键点在于，两个变量 `decimal_places` 和 `currency_symbol`，在函数中修改的话，需要使用 `global` 关键字声明为全局变量

根据以上思路，我们可以编写如下代码：

```python
# src/user_settings.py
decimal_places = 4
money_symbol = "¥"

def set_decimal_places():
    global decimal_places
    print("设置小数点位数：")
    print(f"当前小数点位数设置为：{decimal_places}")
    while True:
        try:
            decimal_places_new = int(input("请输入新的小数点位数（0-10之间的整数）："))
            if 0 <= decimal_places_new <= 10:
                decimal_places = decimal_places_new
                print(f"小数点位数已更新为：{decimal_places}")
                break
            else:
                print("输入有误，请输入0到10之间的整数。")
        except Exception:
            print("输入有误，请输入有效的整数。")

def set_money_symbol():
    global money_symbol
    money_symbol_valid_list = ['¥', '$', '€', '£']
    print("设置金额符号：")
    print(f"当前金额符号设置为：{money_symbol}")
    while True:
        try:
            money_symbol_new = input(f"请输入新的金额符号（{'、'.join(money_symbol_valid_list)}）：").strip()
            if money_symbol_new in money_symbol_valid_list:
                money_symbol = money_symbol_new
                print(f"金额符号已更新为：{money_symbol}")
                break
            else:
                print("输入有误，请输入有效的金额符号。")
        except Exception:
            print("输入有误，请输入有效的金额符号。")

def get_user_settings():
    while True:
        print("-" * 40)
        print("用户设置：")
        print("1. 设置小数点位数")
        print("2. 设置金额符号")
        print("q. 返回主菜单")
        print("-" * 40)
        choice = input("请输入您的选择：")
        print("-" * 40)
        if choice == '1':
            set_decimal_places()
        elif choice == '2':
            set_money_symbol()
        elif choice == 'q':
            break
        else:
            print("输入有误，请重新输入。")

# 提供获取当前小数点位数的函数
def get_decimal_places():
    return decimal_places

# 提供获取当前金额符号的函数
def get_money_symbol():
    return money_symbol

if __name__ == "__main__":
    get_user_settings()
```


我们尝试运行 `user_settings.py` 模块，看看效果是否符合预期：

```text
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：1
----------------------------------------
设置小数点位数：
当前小数点位数设置为：4
请输入新的小数点位数（0-10之间的整数）：6
小数点位数已更新为：6
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：2
----------------------------------------
设置金额符号：
当前金额符号设置为：¥
请输入新的金额符号（¥、$、€、£）：$
金额符号已更新为：$
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：q
----------------------------------------
```

### (2) 将用户设置模块集成到主程序

接下来，我们将用户设置模块集成到主程序 `main.py` 里（但是大家先记得在 `input_handler.py` 和 `ui.py` 里，做相应的修改，这里我们就先不展示了）：

```python
# src/main.py
from input_handler import get_user_input
from ui import display_menu, show_instructions
from logger import log_write, log_read
from function_cash_flow import function_cash_flow_main
from function_expression import function_expression_main
from function_time_value import function_time_value_main
from user_settings import get_user_settings

def main():
    while True:
        
        # 显示标题与菜单
        display_menu()
        print("-" * 40)
        # 获取用户输入
        user_input = get_user_input()
        print("-" * 40)

        # 处理用户输入
        if user_input == 'q':
            break
        elif user_input == '0':
            show_instructions("0")
        elif user_input == '1':
            function_expression_main()
        elif user_input == '2':
            function_cash_flow_main()
        elif user_input == '3':
            function_time_value_main()
        elif user_input == 'l':
            log_read()
        elif user_input == 's':
            get_user_settings()

if __name__ == "__main__":
    main()
```

之后，我们直接运行主程序 `main.py`，看看用户设置功能是否成功集成：

```text
========================================
                金融计算器
========================================
欢迎使用金融计算器！请选择以下功能：
0. 使用说明
1. 算式计算
2. 现金流量计算
3. 时间价值计算
l. 查看计算历史
s. 用户设置
q. 退出
----------------------------------------
请输入你的选择: s
----------------------------------------
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：1
----------------------------------------
设置小数点位数：
当前小数点位数设置为：4
请输入新的小数点位数（0-10之间的整数）：5
小数点位数已更新为：5
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：2
----------------------------------------
设置金额符号：
当前金额符号设置为：¥
请输入新的金额符号（¥、$、€、£）：$
金额符号已更新为：$
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：q
----------------------------------------
========================================
                金融计算器
========================================
欢迎使用金融计算器！请选择以下功能：
0. 使用说明
1. 算式计算
2. 现金流量计算
3. 时间价值计算
l. 查看计算历史
s. 用户设置
q. 退出
----------------------------------------
请输入你的选择: q
----------------------------------------
感谢使用，程序已退出！
```

## 2. 修改各计算模块以应用用户设置

### (1) 修改表达式计算模块

表达式计算模块比较简单，我们只需要在输出结果时，使用用户设置的小数点位数，所以改这一行代码即可：

```python
# src/function_expression.py
from user_settings import get_decimal_places

def function_expression_main():
    ...
    result = round(calculate_expression(expression_checked), get_decimal_places())
    ...
```

这里我们要注意一个关键的问题：

- 我们导入的是 `get_decimal_places` 函数，而不是直接导入 `decimal_places` 变量，并且在调用时也要使用这个函数获取当前的小数点位数
- 这是因为 `decimal_places` 变量是在 `user_settings.py` 模块中定义的全局变量，而我们在其他模块中导入它时，实际上导入的是定义时的值，而不是动态变化后的值
- 所以我们必须通过函数调用的方式，才能获取到最新的用户设置值

### (2) 修改现金流量计算模块

在显示现金流列表和计算结果时，我们都需要使用用户设置的小数点位数和金额符号：

- 小数点位数好说，我们直接用 `round()` 函数就可以了
- 金额符号稍微复杂一点，因为如果是正数，我们需要在前面加上符号，比方说 `¥200`，如果是负数，我们需要在负号后面加上符号，比方说 `-¥200`，所以我们需要写一个格式化函数：

```python
# src/utils.py
def format_money(money_symbol, decimal_places, amount):
    if amount >= 0:
        return f"{money_symbol}{amount:.{decimal_places}f}"
    else:
        return f"-{money_symbol}{abs(amount):.{decimal_places}f}"
```

- 这个函数，是 `function_cash_flow.py` 和 `function_time_value.py` 两个模块都需要用到的，所以我们可以把它放在一个新的模块 `utils.py` 里，然后在两个计算模块里都导入使用

在现金流量计算模块里，我们需要修改以下几个地方：

- 显示现金流列表的时候，需要保留小数点位数并加上金额符号，我们让 `get_cash_flow_list()` 函数返回两个列表，一个是原始数值列表，一个是格式化后的字符串列表
- 计算 IRR 的时候，只需修改输出的小数点位数，我们让 `calculate_irr()` 函数返回两个列表，一个是原始数值列表，一个是保留小数点位数的列表
- 计算 NPV 的时候，需要保留小数点位数并加上金额符号，我们让 `calculate_npv()` 函数返回两个值，一个是原始数值，一个是格式化后的字符串

修改后的代码如下所示：

```python
# src/function_cash_flow.py
from ui import show_instructions
from logger import log_write
import numpy_financial as npf
import numpy as np
from user_settings import get_decimal_places, get_money_symbol
from utils import format_money

def get_cash_flow_list():
    while True:
        print("-" * 40)
        print("请输入现金流列表（以逗号分隔的数字，例如 -1000, 300, 400）：")
        cash_flow_str = input("请输入现金流列表：")
        try:
            cash_flow_list = [float(cash.strip()) for cash in cash_flow_str.split(',')]
            cash_flow_list_formatted = [format_money(get_money_symbol(), get_decimal_places(), cf) for cf in cash_flow_list]
            print("现金流列表输入成功：", cash_flow_list_formatted)
            print("-" * 40)
            # 返回原值和格式化后的值
            return cash_flow_list, cash_flow_list_formatted
        except ValueError:
            print("输入格式错误，请重新输入合法的现金流列表。")

def calculate_npv(cash_flows, discount_rate):
    npv = 0.0
    for t, cf_t in enumerate(cash_flows):
        npv_t = cf_t / ((1 + discount_rate) ** t)
        npv += npv_t
    # 返回原值和格式化后的值
    return round(npv, get_decimal_places()), format_money(get_money_symbol(), get_decimal_places(), npv)

def calculate_irr(cashflows):
    # 求所有根（x=1+r）
    roots = np.roots(cashflows)
    # 只保留实数根的实部
    roots_filtered = [r.real for r in roots if abs(r.imag) < 1e-8]
    # 转换为 irr，且只保留大于 -1 的解
    irr_values = [r - 1 for r in roots_filtered if r - 1 > -1]
    # 如果没有实数根，返回 None
    if not irr_values:
        irr_list = [None]
    # 如果有实数根，则按从小到大排序返回
    else:
        irr_list = sorted(irr_values)
    # 格式化输出小数点位数
    irr_formatted = [round(float(r), get_decimal_places()) if r is not None else None for r in irr_list]
    # 返回原值和格式化后的值
    return irr_list, irr_formatted

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
                cash_flow_list, cash_flow_list_formatted = get_cash_flow_list()
                
                try:
                    # 计算IRR
                    irr_list, irr_formatted = calculate_irr(cash_flow_list)
                    print("该现金流的内部收益率（IRR）为：", irr_formatted)  

                    # 计算NPV
                    discount_rate = get_discount_rate()
                    npv, npv_formatted = calculate_npv(cash_flow_list, discount_rate=discount_rate)

                    # 输出计算结果
                    print("该现金流的净现值（NPV）为：" + npv_formatted)
                    
                    # 记录计算历史日志
                    log_write("计算历史", {
                        "功能": "现金流计算",
                        "现金流列表": cash_flow_list_formatted,
                        "IRR": irr_formatted, 
                        "折现率": discount_rate,
                        "NPV": npv_formatted
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
                        "现金流列表": cash_flow_list_formatted,
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

我们运行一下，可以看出，设置了小数点位数和金额符号之后，现金流计算模块的输出结果会更标准规范一些：

```text
----------------------------------------
现金流计算功能：
0. 使用说明
1. 输入现金流并进行运算
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
----------------------------------------
请输入现金流列表（以逗号分隔的数字，例如 -1000, 300, 400）：
请输入现金流列表：-1000, 300, 400, 500, 600
现金流列表输入成功： ['-¥1000.0000', '¥300.0000', '¥400.0000', '¥500.0000', '¥600.0000']
----------------------------------------
该现金流的内部收益率（IRR）为： [0.2489]
请输入折现率（小数形式，如 0.05 表示 5%）：0.06
该现金流的净现值（NPV）为：¥534.0833
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

同时，大家记得要修改现金流模块的测试代码 `test_function_cash_flow.py`，让测试代码也能适应新的返回值，我们这里就不展示完整代码了。

### (3) 修改金钱时间价值计算模块

金钱的时间价值模块中的修改思路和现金流量计算模块类似：

- PV、FV、PMT 的输出结果需要保留小数点位数并加上金额符号，我们使用 `format_money()` 函数进行格式化
- R 与 N 只需保留小数点位数，用 `round()` 函数进行处理

我们主要修改参数获取函数与计算函数，也是让它们返回两个值，一个是原始数值，一个是格式化后的字符串：

```python
# src/function_time_value.py
from ui import show_instructions
from logger import log_write
import math
import numpy_financial as npf
from user_settings import get_decimal_places, get_money_symbol
from utils import format_money

def get_time_value_inputs():
    while True:
        print("-" * 40)
        print("请输入金钱时间价值的参数：")
        print("格式为：PV, FV, PMT, R, N，需要求的参数请输入 None")
        print("例如：-1000, None, -60, 0.05, 12")
        params_str = input("请输入参数：")
        try:
            params_list = []
            for param in params_str.split(','):
                param = param.strip()
                if param == 'None':
                    params_list.append(None)
                else:
                    params_list.append(float(param))
            if len(params_list) != 5:
                print("输入参数数量错误，请输入5个参数。")
                continue
            if params_list.count(None) != 1:
                print("请输入且仅输入一个参数为 None。")
                continue
            if params_list[3] is not None and not (params_list[3] > -1):
                print("折现率 R 必须大于-1。")
                continue
            if params_list[4] is not None and not (params_list[4] > 0):
                print("期数 N 必须是正数。")
                continue
            param_list_formatted = params_list.copy()
            param_list_formatted[0] = format_money(get_money_symbol(), get_decimal_places(), params_list[0]) if params_list[0] is not None else None
            param_list_formatted[1] = format_money(get_money_symbol(), get_decimal_places(), params_list[1]) if params_list[1] is not None else None
            param_list_formatted[2] = format_money(get_money_symbol(), get_decimal_places(), params_list[2]) if params_list[2] is not None else None
            param_list_formatted[3] = round(params_list[3], get_decimal_places()) if params_list[3] is not None else None
            param_list_formatted[4] = round(params_list[4], get_decimal_places()) if params_list[4] is not None else None
            print("金钱时间价值参数输入成功：", param_list_formatted)
            print("-" * 40)
            return tuple(params_list), tuple(param_list_formatted)
        except ValueError:
            print("输入格式错误，请重新输入合法的参数列表。")


def calculate_time_value(tv_inputs):
    pv, fv, pmt, r, n = tv_inputs

    # 求解 PV
    if pv is None:
        pv = - (pmt * ((1 + r) ** n - 1) / r + fv) / (1 + r) ** n
    
    # 求解 FV
    elif fv is None:
        fv = - pv * (1 + r) ** n - pmt * ((1 + r) ** n - 1) / r
    
    # 求解 PMT
    elif pmt is None:
        pmt = - r * (pv * (1 + r) ** n + fv) / ((1 + r) ** n - 1)
    
    # 求解 N
    elif n is None:
        # n = npf.nper(pv=pv, fv=fv, pmt=pmt, rate=r)
        n = math.log((pmt - r * fv) / (pmt + r * pv)) / math.log(1 + r)
    
    # 求解 R
    else:
        # 直接调用 numpy_financial 包中的 rate 函数
        r = npf.rate(pv=pv, fv=fv, pmt=pmt, nper=n)

    # 格式化输出结果
    result_tuple = (pv, fv, pmt, r, n)
    result_tuple_formatted = (
        format_money(get_money_symbol(), get_decimal_places(), pv),
        format_money(get_money_symbol(), get_decimal_places(), fv),
        format_money(get_money_symbol(), get_decimal_places(), pmt),
        round(r, get_decimal_places()),
        round(n, get_decimal_places())
    )
    return result_tuple, result_tuple_formatted

# 金钱时间价值计算的函数
def function_time_value_main():
    
    while True:

        # 展示功能菜单
        print("-" * 40)
        print("金钱时间价值计算功能：")
        print("0. 查看功能说明")
        print("1. 计算金钱时间价值")
        print("q. 返回主菜单")
        print("-" * 40)
        
        # 获取用户选择
        choice = input("请选择功能（0/1/q）：")
        print("-" * 40)
        
        # 0. 查看功能说明
        if choice == "0":
            show_instructions(function_key="3")
            print("-" * 40)
        
        # 1. 计算金钱时间价值
        elif choice == "1":
            tv_inputs, tv_inputs_formatted = get_time_value_inputs()
            tv_result, tv_result_formatted = calculate_time_value(tv_inputs)

            print("参数输入为：")
            print("PV：", tv_inputs_formatted[0])
            print("FV：", tv_inputs_formatted[1])
            print("PMT：", tv_inputs_formatted[2])
            print("R：", tv_inputs_formatted[3])
            print("N：", tv_inputs_formatted[4])
            print("*" * 40)

            print("计算结果为：")
            print("PV：", tv_result_formatted[0])
            print("FV：", tv_result_formatted[1])
            print("PMT：", tv_result_formatted[2])
            print("R：", tv_result_formatted[3])
            print("N：", tv_result_formatted[4])
            print("*" * 40)

            input("输入任意内容返回主菜单：")

            log_write("计算历史", {
                "功能": "时间价值计算",
                "输入参数": tv_inputs_formatted,
                "结果": tv_result_formatted
                }
            )

            print("-" * 40)
        
        # q. 返回主菜单
        elif choice.lower() == "q":
            break
        
        # 非法输入处理
        else:
            print("输入不合法，请重新选择！")
            print("-" * 40) 

if __name__ == "__main__":
    function_time_value_main()
```

我们尝试运行一下，可以看出结果会更加规范：

```text
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
----------------------------------------
请输入金钱时间价值的参数：
格式为：PV, FV, PMT, R, N，需要求的参数请输入 None
例如：-1000, None, -60, 0.05, 12
请输入参数：-1000, None, -60, 0.05, 12
金钱时间价值参数输入成功： ['-¥1000.0000', None, '-¥60.0000', 0.05, 12.0]
----------------------------------------
参数输入为：
PV： -¥1000.0000
FV： None
PMT： -¥60.0000
R： 0.05
N： 12.0
****************************************
计算结果为：
PV： -¥1000.0000
FV： ¥2750.8839
PMT： -¥60.0000
R： 0.05
N： 12.0
****************************************
输入任意内容返回主菜单：q
----------------------------------------
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：q
----------------------------------------
```

## 3. 综合测试用户设置功能

### (1) 在主函数中测试用户设置功能

最后，我们对用户设置功能进行综合测试，最重要的就是看一看修改了小数点位数和金额符号之后，各计算模块的输出结果是否都符合预期。

我们运行主程序 `main.py`，先进入用户设置界面，修改小数点位数为 3，金额符号为 $：

- 我们先运行一下主函数
- 接着运行一次金钱的时间价值计算模块，这时我们的小数点位数为4，金额符号为¥，都是默认值
- 然后我们进入用户设置界面，修改小数点位数为6，金额符号为$，最后再运行一次金钱的时间价值计算模块，看看结果是否符合预期：

```text
========================================
                金融计算器
========================================
欢迎使用金融计算器！请选择以下功能：
0. 使用说明
1. 算式计算
2. 现金流量计算
3. 时间价值计算
l. 查看计算历史
s. 用户设置
q. 退出
----------------------------------------
请输入你的选择: s
----------------------------------------
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：1
----------------------------------------
设置小数点位数：
当前小数点位数设置为：4
请输入新的小数点位数（0-10之间的整数）：6
小数点位数已更新为：6
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：2
----------------------------------------
设置金额符号：
当前金额符号设置为：¥
请输入新的金额符号（¥、$、€、£）：$
金额符号已更新为：$
----------------------------------------
用户设置：
1. 设置小数点位数
2. 设置金额符号
q. 返回主菜单
----------------------------------------
请输入您的选择：q
----------------------------------------
========================================
                金融计算器
========================================
欢迎使用金融计算器！请选择以下功能：
0. 使用说明
1. 算式计算
2. 现金流量计算
3. 时间价值计算
l. 查看计算历史
s. 用户设置
q. 退出
----------------------------------------
请输入你的选择: 3
----------------------------------------
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
----------------------------------------
请输入金钱时间价值的参数：
格式为：PV, FV, PMT, R, N，需要求的参数请输入 None
例如：-1000, None, -60, 0.05, 12
请输入参数：-1000, None, -60, 0.05, 12
金钱时间价值参数输入成功： ['-$1000.000000', None, '-$60.000000', 0.05, 12.0]
----------------------------------------
参数输入为：
PV： -$1000.000000
FV： None
PMT： -$60.000000
R： 0.05
N： 12.0
****************************************
计算结果为：
PV： -$1000.000000
FV： $2750.883917
PMT： -$60.000000
R： 0.05
N： 12.0
****************************************
输入任意内容返回主菜单：q
----------------------------------------
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：q
----------------------------------------
========================================
                金融计算器
========================================
欢迎使用金融计算器！请选择以下功能：
0. 使用说明
1. 算式计算
2. 现金流量计算
3. 时间价值计算
l. 查看计算历史
s. 用户设置
q. 退出
----------------------------------------
请输入你的选择: q
----------------------------------------
感谢使用，程序已退出！
```

可以看到，修改了小数点位数和金额符号之后，输出结果更规范更美观了。

### (2) 查看新的计算历史日志

最后，我们查看一下计算历史日志，看看新的输出结果是否也符合预期：

```text
========================================
                金融计算器
========================================
欢迎使用金融计算器！请选择以下功能：
0. 使用说明
1. 算式计算
2. 现金流量计算
3. 时间价值计算
l. 查看计算历史
s. 用户设置
q. 退出
----------------------------------------
请输入你的选择: l
----------------------------------------
========================================
第 1 页，共 1 页
----------------------------------------
{
    "时间": "2025-11-14 10:48:44",
    "类型": "计算历史",
    "内容": {
        "功能": "时间价值计算",
        "输入参数": [
            "-¥1000.0000",
            null,
            "-¥60.0000",
            0.05,
            12.0
        ],
        "结果": [
            "-¥1000.0000",
            "¥2750.8839",
            "-¥60.0000",
            0.05,
            12.0
        ]
    }
}
----------------------------------------
{
    "时间": "2025-11-14 11:03:23",
    "类型": "计算历史",
    "内容": {
        "功能": "时间价值计算",
        "输入参数": [
            "-$1000.000000",
            null,
            "-$60.000000",
            0.05,
            12.0
        ],
        "结果": [
            "-$1000.000000",
            "$2750.883917",
            "-$60.000000",
            0.05,
            12.0
        ]
    }
}
----------------------------------------
已显示所有日志记录，退出查看日志
========================================
========================================
                金融计算器
========================================
欢迎使用金融计算器！请选择以下功能：
0. 使用说明
1. 算式计算
2. 现金流量计算
3. 时间价值计算
l. 查看计算历史
s. 用户设置
q. 退出
----------------------------------------
请输入你的选择: q
----------------------------------------
感谢使用，程序已退出！
```

可以看到，日志中记录的计算历史也跟着用户设置变化了，这个结果是符合预期的。

主程序与日志中，都正确反映了用户设置的小数点位数和金额符号，说明我们本次的升级工作是成功的。
