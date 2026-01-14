# Topic 14.4 - 金钱时间价值功能实现

本章我们就来实现金钱的时间价值计算功能：

- 在该功能下，用户将输入以下5个 input 的其中4个，程序来求解剩下的那个：

    - 现值（PV）
    - 终值（FV）
    - 支付（PMT）
    - 利率（R）
    - 期数（N）

- 该功能基于的公式逻辑是 NPV 为0：

$$NPV = 0 = PV \times (1 + R)^N + PMT \times \frac{(1 + R)^N - 1}{R} + FV$$

- 于是，根据这个公式，我们可以通过推导公式法，来求解大部分的变量

    - 求解 PV：

    $$PV = -\,\frac{PMT \cdot \frac{(1 + R)^N - 1}{R} + FV}{(1 + R)^N}$$

    - 求解 FV：

    $$FV = -\,PV \times (1 + R)^N - PMT \times \frac{(1 + R)^N - 1}{R}$$
    - 求解 PMT：

    $$PMT = -\,R \cdot \frac{PV(1 + R)^N + FV}{(1 + R)^N - 1}$$

    - 求解 N：

    $$N = \frac{\ln\!\left(\dfrac{PMT - R \cdot FV}{PMT + R \cdot PV}\right)}{\ln(1 + R)}$$

    - 求解 R：只能通过数值解法来求解，其实就是挨个试

- 公式写成这个版本的好处是，PV、FV、PMT这三个量，都是正数为收入，负数为支出，更符合金融学上的习惯

## 1. 金钱时间价值功能的主函数

仿照表达式和现金流的主函数，我们可以编写金钱时间价值功能的主函数 `function_time_value_main`，代码如下所示：

- 这里的 `get_time_value_inputs` 和 `calculate_time_value` 函数我们先占位，后续进行详细实现
- 占位之后，这个代码块是可以直接运行的

```python
# src/function_time_value.py
from ui import show_instructions
from logger import log_write

def get_time_value_inputs():
    return (-1000.0, None, 100.0, 0.05, 10)

def calculate_time_value(tv_inputs):
    return (-1000.0, 2886.68, 100.0, 0.05, 10)

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
            tv_inputs = get_time_value_inputs()
            tv_result = calculate_time_value(tv_inputs)

            print("参数输入为：")
            print("PV：", tv_inputs[0])
            print("FV：", tv_inputs[1])
            print("PMT：", tv_inputs[2])
            print("R：", tv_inputs[3])
            print("N：", tv_inputs[4])
            print("*" * 40)

            print("计算结果为：")
            print("PV：", tv_result[0])
            print("FV：", tv_result[1])
            print("PMT：", tv_result[2])
            print("R：", tv_result[3])
            print("N：", tv_result[4])
            print("*" * 40)

            input("输入任意内容返回主菜单：")

            log_write("计算历史", {
                "功能": "时间价值计算",
                "输入参数": tv_inputs,
                "结果": tv_result
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

目前虽然占位函数没有实现具体功能，但是这个主函数已经可以运行了，效果如下所示：

```text
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：0
----------------------------------------
金钱的时间价值计算功能使用说明：
请按照提示输入现值（PV）、终值（FV）、利率（R）、每期支付金额（PMT）与期数（n）中的几个值，程序将计算出您想要的目标值。
输入任意内容返回上级菜单：
----------------------------------------
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
参数输入为：
PV： -1000.0
FV： None
PMT： 100.0
R： 0.05
N： 10
****************************************
计算结果为：
PV： -1000.0
FV： 2886.68
PMT： 100.0
R： 0.05
N： 10
****************************************
输入任意内容返回主菜单：
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

## 2. 获取金钱时间价值计算输入参数的函数

接下来，我们先来实现获取金钱时间价值计算输入参数的函数 `get_time_value_inputs`：

- 其实这个函数无非也就是使用 `input` 函数来获取用户输入而已，只不过这里要获取的内容比较多，而且我们想加一些新的需求，所以代码会稍微复杂一些

- 首先，我们想要实现的一个新需求就是，用户依次输入PV、FV、PMT、R、N这5个参数，如果输入有误，只需重新输入当前参数，而不是全部重新输入：

    - 要想实现这个需求，我们就要把每个参数的输入都套在一个无限循环里
    - 如果输入是正确的，则跳出当前循环，进入下一个参数的输入，需要使用到 `break` 语句
    - 如果输入不正确，则提示用户重新输入当前参数，需要使用到 `continue` 语句

- 其次，我们还想实现的一个需求是，用户只能输入4个参数，必须有且仅有1个参数是留空的，用于程序计算

    - 如果用户输入不满足这个要求，则提示用户重新输入所有参数
    - 这就需要整个参数输入过程套在一个更外层的无限循环里

- 结合上面的两个需求，我们整个代码的逻辑应该是，最外层是一个无限循环，里面依次是5个参数的输入循环

- 将这个需求梳理清楚之后，我们就可以编写代码了，代码如下所示：

```python
# src/function_time_value.py
def get_time_value_inputs():
    # 外层循环，确保用户输入正确
    while True:
        # PV
        print("*" * 40)
        print("请输入以下金钱时间价值计算所需的参数：")
        while True:
            try:
                pv_input = input("请输入PV（输入None表示要求现值）：").strip()
                if pv_input.lower() == "none":
                    pv = None
                else:
                    pv = float(pv_input)
                break
            except Exception:
                print("PV格式错误，请输入数字或None。")
        print("PV输入完成：", pv)
        # FV
        print("*" * 40)
        while True:
            try:
                fv_input = input("请输入FV（输入None表示要求终值）：").strip()
                if fv_input.lower() == "none":
                    fv = None
                else:
                    fv = float(fv_input)
                break
            except Exception:
                print("FV格式错误，请输入数字或None。")
        print("FV输入完成：", fv)
        # PMT
        print("*" * 40)
        while True:
            try:
                pmt_input = input("请输入PMT（输入None表示要求每期支付金额）：").strip()
                if pmt_input.lower() == "none":
                    pmt = None
                else:
                    pmt = float(pmt_input)
                break
            except Exception:
                print("PMT格式错误，请输入数字或None。")
        print("PMT输入完成：", pmt)
        # R
        print("*" * 40)
        while True:
            try:
                r_input = input("请输入R（输入None表示要求利率）：").strip()
                if r_input.lower() == "none":
                    r = None
                else:
                    r = float(r_input)
                if r is not None and r <= -1:
                    print("R不能小于或等于 -1，请重新输入。")
                    continue
                break
            except Exception:
                print("R格式错误，请输入数字或None。")
        print("R输入完成：", r)
        # N
        print("*" * 40)
        while True:
            try:
                n_input = input("请输入N（输入None表示要求期数）：").strip()
                if n_input.lower() == "none":
                    n = None
                else:
                    n = int(n_input)
                if n is not None and n < 0:
                    print("N不能为负数，请重新输入。")
                    continue
                break
            except Exception:
                print("N格式错误，请输入整数或None。")
        print("N输入完成：", n)
        # 汇总结果
        print("*" * 40)
        tv_inputs = (pv, fv, pmt, r, n)
        if tv_inputs.count(None) != 1:
            print("输入错误：必须且只能有一个参数为None，请重新输入所有参数。")
            print("*" * 40)
            continue
        else:
            print("所有参数输入完成。")
            print("*" * 40)
            break
    # 返回结果  
    return tv_inputs
```



我们尝试运行这个函数，看看效果如何：

- 我们先运行一个所有参数都正确输入的例子：

```text
****************************************
请输入以下金钱时间价值计算所需的参数：
请输入PV（输入None表示要求现值）：-1000
PV输入完成： 1000.0
****************************************
请输入FV（输入None表示要求终值）：None
FV输入完成： None
****************************************
请输入PMT（输入None表示要求每期支付金额）：100
PMT输入完成： 100.0
****************************************
请输入R（输入None表示要求利率）：0.06
R输入完成： 0.06
****************************************
请输入N（输入None表示要求期数）：10
N输入完成： 10
****************************************
所有参数输入完成。
****************************************
```

- 我们再运行一个参数输入错误，但是满足只有一个参数为None的例子：

```text
****************************************
请输入以下金钱时间价值计算所需的参数：
请输入PV（输入None表示要求现值）：None
PV输入完成： None
****************************************
请输入FV（输入None表示要求终值）：w
FV格式错误，请输入数字或None。
请输入FV（输入None表示要求终值）：3000
FV输入完成： 3000.0
****************************************
请输入PMT（输入None表示要求每期支付金额）：100
PMT输入完成： 100.0
****************************************
请输入R（输入None表示要求利率）：-9
R不能小于或等于 -1，请重新输入。
请输入R（输入None表示要求利率）：0.06
R输入完成： 0.06
****************************************
请输入N（输入None表示要求期数）：-10
N不能为负数，请重新输入。
请输入N（输入None表示要求期数）：20
N输入完成： 20
****************************************
所有参数输入完成。
****************************************
```

- 最后，我们运行一个不满足只有一个参数为None的例子：

```text
****************************************
请输入以下金钱时间价值计算所需的参数：
请输入PV（输入None表示要求现值）：None
PV输入完成： None
****************************************
请输入FV（输入None表示要求终值）：1000
FV输入完成： 1000.0
****************************************
请输入PMT（输入None表示要求每期支付金额）：100
PMT输入完成： 100.0
****************************************
请输入R（输入None表示要求利率）：None
R输入完成： None
****************************************
请输入N（输入None表示要求期数）：10
N输入完成： 10
****************************************
输入错误：必须且只能有一个参数为None，请重新输入所有参数。
****************************************
****************************************
请输入以下金钱时间价值计算所需的参数：
请输入PV（输入None表示要求现值）：-1000
PV输入完成： -1000.0
****************************************
请输入FV（输入None表示要求终值）：2000
FV输入完成： 2000.0
****************************************
请输入PMT（输入None表示要求每期支付金额）：100
PMT输入完成： 100.0
****************************************
请输入R（输入None表示要求利率）：None
R输入完成： None
****************************************
请输入N（输入None表示要求期数）：10
N输入完成： 10
****************************************
所有参数输入完成。
****************************************
```

## 3. 金钱时间价值计算函数

### (1) 金钱时间价值函数实现

接下来，我们就要实现最重要的的金钱时间价值计算函数 `calculate_time_value` 了：

- 该函数的输入是上一个函数 `get_time_value_inputs` 返回的5个参数的元组
- 该函数的输出是一个包含5个参数的元组，和输入参数格式一致，只不过将None替换成了计算结果
- 所以基本的实现思路是，根据输入参数中哪个是None，来选择计算对应的变量：

    - 其中求解 PV、FV、PMT、N 很简单，直接使用推导公式代入算即可
    - 求解 R 则需要使用数值解法，也就是挨个试，但是我们可以像上一章求解 IRR 那样，寻找一些其他包中已经实现的函数来帮我们完成
    - 其实 `numpy_financial` 包中就有现成的函数 `npf.rate` 可以使用，也是接收 N、PMT、PV、FV 这4个参数，来求解 R 的


根据这个函数的需求分析，我们可以写出这部分代码：

```python
# src/function_time_value.py
import math
import numpy_financial as npf

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
        n = math.log((pmt - r * fv) / (pmt + r * pv)) / math.log(1 + r)
    
    # 求解 R
    else:
        # 直接调用 numpy_financial 包中的 rate 函数
        r = npf.rate(n, pmt, pv, fv)

    return (pv, fv, pmt, r, n)
```

### (2) 金钱时间价值函数测试

这个函数的测试也比较简单直白：

- 我们直接拿金融计算器，算出10组正确的 `(pv, fv, pmt, r, n)` 输入输出对
- 然后将其中一个参数设为 `None`，作为输入传给 `calculate_time_value` 函数
- 看看输出结果和我们计算器算出的结果是否一致即可

我们在 `test/test_time_value.py` 文件中编写测试代码，代码如下所示：

```python
# tests/test_function_time_value.py
from config_test import *
from function_time_value import calculate_time_value

# 测试净现值计算功能的正确性
def test_calculate_time_value():

    test_cases = [
        # (1) 单笔现值按期复利增长
        (-1000.0, 1628.894627, 0.0, 0.05, 10),

        # (2) 期末等额存入（年金），初始 PV = 0
        (0.0, 12577.892536, -1000.0, 0.05, 10),

        # (3) 贷款：求得 PMT 使 FV = 0
        (10000.0, 0.0, -2637.974808, 0.10, 5),

        # (4) 零息：-950 投入 5 期变 1000
        (-950.0, 1000.0, 0.0, 0.010311, 5),

        # (5) 退休储蓄：期末缴款至目标 FV
        (0.0, 1500000.0, -15879.605267, 0.07, 30),

        # (6) 抵押贷款：月利 0.5%，10 年（120 期）摊还至 0
        (500000.0, 0.0, -5551.025097, 0.005, 120),

        # (7) 定期存款：单笔 -5000，2% 利率 10 期
        (-5000.0, 6094.972100, 0.0, 0.02, 10),

        # (8) 分期融资：6 期、每期 8%，摊还至 0
        (20000.0, 0.0, -4326.307725, 0.08, 6),

        # (9) 年金现值：给定 PMT 与 r、n，使 FV = 0
        (7721.734929, 0.0, -1000.0, 0.05, 10),

        # (10) 教育基金：期末缴款至目标 FV
        (0.0, 200000.0, -3645.343642, 0.06, 25),
    ]

    inputs_idx = ["PV", "FV", "PMT", "R", "N"]

    for idx, case in enumerate(test_cases):
        print("测试:", idx+1)
        case_list = list(case)

        for i in range(5):
            inputs = case_list.copy()
            inputs[i] = None  # 将第i个参数设为None，表示要求解该参数

            result = calculate_time_value(tuple(inputs))
            expected = case_list[i]

            # 使用近似比较，允许一定的误差范围
            assert abs(result[i] - expected) < 0.1, f"    求解参数{inputs_idx[i]}失败：期望{round(expected, 4)} & 得到{round(result[i], 4)}"
            print(f"    求解参数{inputs_idx[i]}成功：期望{round(expected, 4)} & 得到{round(result[i], 4)}")

    print("所有测试通过。")

if __name__ == "__main__":
    test_calculate_time_value()
```


运行这段测试代码，我们得到以下输出：

```text
测试: 1
    求解参数PV成功：期望-1000.0 & 得到-1000.0
    求解参数FV成功：期望1628.8946 & 得到1628.8946
    求解参数PMT成功：期望0.0 & 得到-0.0
    求解参数R成功：期望0.05 & 得到0.05
    求解参数N成功：期望10 & 得到10.0
测试: 2
    求解参数PV成功：期望0.0 & 得到-0.0
    求解参数FV成功：期望12577.8925 & 得到12577.8925
    求解参数PMT成功：期望-1000.0 & 得到-1000.0
    求解参数R成功：期望0.05 & 得到0.05
    求解参数N成功：期望10 & 得到10.0
测试: 3
    求解参数PV成功：期望10000.0 & 得到10000.0
    求解参数FV成功：期望0.0 & 得到0.0
    求解参数PMT成功：期望-2637.9748 & 得到-2637.9748
    求解参数R成功：期望0.1 & 得到0.1
    求解参数N成功：期望5 & 得到5.0
测试: 4
    求解参数PV成功：期望-950.0 & 得到-950.0022
    求解参数FV成功：期望1000.0 & 得到999.9977
    求解参数PMT成功：期望0.0 & 得到-0.0004
    求解参数R成功：期望0.0103 & 得到0.0103
    求解参数N成功：期望5 & 得到5.0002
测试: 5
    求解参数PV成功：期望0.0 & 得到0.0
    求解参数FV成功：期望1500000.0 & 得到1500000.0
    求解参数PMT成功：期望-15879.6053 & 得到-15879.6053
    求解参数R成功：期望0.07 & 得到0.07
    求解参数N成功：期望30 & 得到30.0
测试: 6
    求解参数PV成功：期望500000.0 & 得到500000.0
    求解参数FV成功：期望0.0 & 得到-0.0
    求解参数PMT成功：期望-5551.0251 & 得到-5551.0251
    求解参数R成功：期望0.005 & 得到0.005
    求解参数N成功：期望120 & 得到120.0
测试: 7
    求解参数PV成功：期望-5000.0 & 得到-5000.0
    求解参数FV成功：期望6094.9721 & 得到6094.9721
    求解参数PMT成功：期望0.0 & 得到-0.0
    求解参数R成功：期望0.02 & 得到0.02
    求解参数N成功：期望10 & 得到10.0
测试: 8
    求解参数PV成功：期望20000.0 & 得到20000.0
    求解参数FV成功：期望0.0 & 得到0.0
    求解参数PMT成功：期望-4326.3077 & 得到-4326.3077
    求解参数R成功：期望0.08 & 得到0.08
    求解参数N成功：期望6 & 得到6.0
测试: 9
    求解参数PV成功：期望7721.7349 & 得到7721.7349
    求解参数FV成功：期望0.0 & 得到0.0
    求解参数PMT成功：期望-1000.0 & 得到-1000.0
    求解参数R成功：期望0.05 & 得到0.05
    求解参数N成功：期望10 & 得到10.0
测试: 10
    求解参数PV成功：期望0.0 & 得到-0.0
    求解参数FV成功：期望200000.0 & 得到200000.0
    求解参数PMT成功：期望-3645.3436 & 得到-3645.3436
    求解参数R成功：期望0.06 & 得到0.06
    求解参数N成功：期望25 & 得到25.0
所有测试通过。
```

## 4. 将所有功能集成到主程序中

最后，我们将输入函数与时间价值计算函数集成到主函数 `function_time_value_main` 中：

```python
# src/function_time_value.py
from ui import show_instructions
from logger import log_write
import math
import numpy_financial as npf

def get_time_value_inputs():
    # 外层循环，确保用户输入正确
    while True:
        # PV
        print("*" * 40)
        print("请输入以下金钱时间价值计算所需的参数：")
        while True:
            try:
                pv_input = input("请输入PV（输入None表示要求现值）：").strip()
                if pv_input.lower() == "none":
                    pv = None
                else:
                    pv = float(pv_input)
                break
            except Exception:
                print("PV格式错误，请输入数字或None。")
        print("PV输入完成：", pv)
        # FV
        print("*" * 40)
        while True:
            try:
                fv_input = input("请输入FV（输入None表示要求终值）：").strip()
                if fv_input.lower() == "none":
                    fv = None
                else:
                    fv = float(fv_input)
                break
            except Exception:
                print("FV格式错误，请输入数字或None。")
        print("FV输入完成：", fv)
        # PMT
        print("*" * 40)
        while True:
            try:
                pmt_input = input("请输入PMT（输入None表示要求每期支付金额）：").strip()
                if pmt_input.lower() == "none":
                    pmt = None
                else:
                    pmt = float(pmt_input)
                break
            except Exception:
                print("PMT格式错误，请输入数字或None。")
        print("PMT输入完成：", pmt)
        # R
        print("*" * 40)
        while True:
            try:
                r_input = input("请输入R（输入None表示要求利率）：").strip()
                if r_input.lower() == "none":
                    r = None
                else:
                    r = float(r_input)
                if r is not None and r <= -1:
                    print("R不能小于或等于 -1，请重新输入。")
                    continue
                break
            except Exception:
                print("R格式错误，请输入数字或None。")
        print("R输入完成：", r)
        # N
        print("*" * 40)
        while True:
            try:
                n_input = input("请输入N（输入None表示要求期数）：").strip()
                if n_input.lower() == "none":
                    n = None
                else:
                    n = int(n_input)
                if n is not None and n < 0:
                    print("N不能为负数，请重新输入。")
                    continue
                break
            except Exception:
                print("N格式错误，请输入整数或None。")
        print("N输入完成：", n)
        # 汇总结果
        print("*" * 40)
        tv_inputs = (pv, fv, pmt, r, n)
        if tv_inputs.count(None) != 1:
            print("输入错误：必须且只能有一个参数为None，请重新输入所有参数。")
            print("*" * 40)
            continue
        else:
            print("所有参数输入完成。")
            print("*" * 40)
            break
    # 返回结果  
    return tv_inputs


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

    return (pv, fv, pmt, r, n)

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
            tv_inputs = get_time_value_inputs()
            tv_result = calculate_time_value(tv_inputs)

            print("参数输入为：")
            print("PV：", tv_inputs[0])
            print("FV：", tv_inputs[1])
            print("PMT：", tv_inputs[2])
            print("R：", tv_inputs[3])
            print("N：", tv_inputs[4])
            print("*" * 40)

            print("计算结果为：")
            print("PV：", tv_result[0])
            print("FV：", tv_result[1])
            print("PMT：", tv_result[2])
            print("R：", tv_result[3])
            print("N：", tv_result[4])
            print("*" * 40)

            input("输入任意内容返回主菜单：")

            log_write("计算历史", {
                "功能": "时间价值计算",
                "输入参数": tv_inputs,
                "结果": tv_result
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

我们尝试运行这个主程序，看看效果如何：

```text
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：0
----------------------------------------
金钱的时间价值计算功能使用说明：
请按照提示输入现值（PV）、终值（FV）、利率（R）、每期支付金额（PMT）与期数（n）中的几个值，程序将计算出您想要的目标值。
输入任意内容返回上级菜单：
----------------------------------------
----------------------------------------
金钱时间价值计算功能：
0. 查看功能说明
1. 计算金钱时间价值
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
****************************************
请输入以下金钱时间价值计算所需的参数：
请输入PV（输入None表示要求现值）：-1000
PV输入完成： -1000.0
****************************************
请输入FV（输入None表示要求终值）：None
FV输入完成： None
****************************************
请输入PMT（输入None表示要求每期支付金额）：-100
PMT输入完成： -100.0
****************************************
请输入R（输入None表示要求利率）：0.03
R输入完成： 0.03
****************************************
请输入N（输入None表示要求期数）：10
N输入完成： 10
****************************************
所有参数输入完成。
****************************************
参数输入为：
PV： -1000.0
FV： None
PMT： -100.0
R： 0.03
N： 10
****************************************
计算结果为：
PV： -1000.0
FV： 2490.3043104911967
PMT： -100.0
R： 0.03
N： 10
****************************************
输入任意内容返回主菜单：
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

最后，我们完善一下该功能的说明文档 `data/instructions/instructions_time_value.txt`，添加如下内容：

```text
金钱的时间价值计算功能使用说明：
本功能用于计算金钱的时间价值。
用户可以输入现值（PV）、终值（FV）、每期支付金额（PMT）、利率（R）与期数（N）中的4个参数，并将要求的参数留空（输入None）。
用户输入完成之后，程序将根据输入的参数计算出要求的参数值。
请注意输入的格式：
- PV、FV、PMT均为正数表示收入，负数表示支出
- R为小数形式表示利率（例如5%表示为0.05）
- N为小数形式表示期数（例如10期表示为10）
```
