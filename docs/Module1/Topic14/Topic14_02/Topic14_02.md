# Topic 14.2 - 表达式计算功能实现

这一节，我们将实现金融计算器的第一个功能 - 表达式计算功能。所有相关代码都在 `function_expression.py` 文件中。

首先我们来回顾一下表达式计算功能的需求：

- 用户输入一个数学表达式字符串，例如 "2 + 3 * 4"，我们需要计算出其结果并返回给用户
- 除了基本的加减乘除计算外，我们希望支持一些计算函数，例如平方根、指数、对数等

## 1. Python 中的 `eval()` 函数

### (1) `eval()` 函数简介

在实现表达式功能之前，需要解决的一个重要问题就是，用户的输入是一个字符串形式，我们如何将其转换为可以计算的表达式呢？

其实，Python 内置了一个非常强大的函数 `eval()`，它可以将字符串形式的表达式转换为 Python 表达式，并进行计算

- 例如，`eval("2 + 3 * 4")` 会返回结果 `14`


```python
expr1 = "2 + 3 * 4"
print(eval(expr1))
```

    14


- 如果要用到一些拓展的数学函数，例如平方根、对数等，我们可以先导入 `math` 模块，然后在 `eval()` 中使用这些函数


```python
import math
expr2 = "math.sqrt(16) + math.log(100, 10)"
print(eval(expr2))
```

    6.0


- 如果自己自定义了一些函数，例如 `square(x)` 用于计算平方，我们也可以在 `eval()` 中使用这些自定义函数


```python
def square(x):
    return x * x

expr3 = "square(5) + 10"
print(eval(expr3))
```

    35


一句话总结 `eval()` 函数：

- `eval()` 中的内容可以简单理解为也是你的 Python 代码的一部分，只不过它是以字符串的形式存在的而已
- 我们需要 `eval()` 来将其转换为实际的代码并执行

### (2) `eval()` 函数的注意事项

使用 `eval()` 函数时必须注意一个关键点：

- 由于 `eval()` 会执行字符串中的代码，不论字符串中的代码是什么，它都会被执行
- 那么万一用户输入了一些恶意代码怎么办？例如 `__import__('os').system('rm -rf /')` 这样的代码，这个代码会删除系统中的所有文件（大家千万不要自己尝试）！
- 因此，在实际应用中，必须对用户的输入进行严格的验证和过滤，确保其只包含合法的数学表达式

目前，我们还没有设计完成表达式计算功能，我们在整个功能实现后，会回过头来完善输入验证和错误处理的部分。

## 2. 表达式计算功能的主函数

首先，我们来实现表达式计算这个功能的主函数：

- 函数名称：`function_expression_main()`
- 当中使用 `input()` 函数获取用户输入的表达式字符串，
- 之后判断用户输入是否合法，如果合法，则使用 `eval()` 函数计算表达式的结果并返回给用户，如果不合法，则提示用户输入错误，重新输入
- 该函数也是个循环函数，用户可以多次输入表达式进行计算，直到用户输入 "exit" 退出

根据这个逻辑，我们可以把它的代码实现如下：

```python
# src/function_expression.py
from ui import show_instructions
from logger import log_write

# 计算表达式的函数
def calculate_expression(expression):
    try:
        result = eval(expression)
        return result
    except Exception as e:
        print("Error:", e)
        return None

# 表达式合法性检查函数
def expression_check(expression):
    # 这里可以添加对表达式的合法性检查代码
    # 目前先简单返回原表达式
    return expression

# 表达式计算功能主函数
def function_expression_main():

    while True:

        # 展示功能菜单
        print("表达式计算功能：")
        print("0. 查看功能说明")
        print("1. 计算表达式")
        print("q. 返回主菜单")
        # 获取用户选择
        choice = input("请选择功能（0/1/q）：")
        
        # 0. 查看功能说明
        if choice == "0":
            show_instructions(function_key="1")
        
        # 1. 计算表达式
        elif choice == "1":

            while True:
                
                # 获取用户输入的表达式
                expression = input("请输入数学表达式（输入 'exit' 退出）：").strip()
                
                # 退出
                if expression == "exit":
                    break
                
                # 计算表达式
                try:
                    # 检查并计算表达式
                    expression_checked = expression_check(expression)
                    result = calculate_expression(expression_checked)
                    print("计算结果：", result)
                    # 记录计算历史日志
                    log_write("计算历史", {
                        "功能": "算式计算",
                        "输入": expression_checked,
                        "结果": result
                    })
                    # 询问是否继续计算
                    choice_continue = input("是否继续计算？(y/n)：").strip().lower()
                    if choice_continue != "y":
                        break
                
                # 处理计算错误
                except Exception as e:
                    print("输入错误，请重新输入。")
        
        # q. 返回主菜单
        elif choice == "q":
            break
        
        # 其他. 无效输入
        else:
            print("无效输入，请重新选择。")

if __name__ == "__main__":
    function_expression_main()
```


我们尝试运行这个函数，看看效果如何：

```text
表达式计算功能：
0. 查看功能说明
1. 计算表达式
q. 返回主菜单
请选择功能（0/1/q）：0
简单算式计算功能使用说明：
请输入一个算式，例如：2 + 3 * 4
程序将计算出结果并返回。
输入任意内容返回上级菜单：
表达式计算功能：
0. 查看功能说明
1. 计算表达式
q. 返回主菜单
请选择功能（0/1/q）：1
请输入数学表达式（输入 'exit' 退出）：2 + 3 * 4
计算结果： 14
是否继续计算？(y/n)：y
请输入数学表达式（输入 'exit' 退出）：100 * 99 / 88 + 77 - 66       
计算结果： 123.5
是否继续计算？(y/n)：n
表达式计算功能：
0. 查看功能说明
1. 计算表达式
q. 返回主菜单
请选择功能（0/1/q）：q
```

那么到此，我们实现了表达式计算功能的基本框架，接下来我们要完善的功能有：

- 丰富表达式计算功能，例如添加对数学函数的支持
- 完善表达式合法性检查，防止恶意代码执行
- 增加错误处理的机制

下面我们就来逐步完善这些功能。

## 3. 丰富表达式计算功能

### (1) 支持的计算功能

我们希望支持的计算功能包括（这里我是参照我手头的金融计算器上面的功能列举的）：

- 基本的加减乘除运算：

    - `+`：加法
    - `-`：减法
    - `*`：乘法
    - `/`：除法
    - `//`：整除
    - `%`：取余
    - `**`：幂运算

- 正负号：

    - `+`：正号
    - `-`：负号

- 数学常数：

    - `pi`：圆周率，约等于 3.14159
    - `e`：自然对数的底数，约等于 2.71828

- 括号：支持括号 `()` 来改变运算优先级

- 数学函数：

    - `square(x)`：平方函数，等价于 `x ** 2`
    - `pow(x, y)`：x 的 y 次幂，等价于 `x ** y`
    - `exp(x)`：指数函数
    - `sqrt(x)`：平方根
    - `root(x, y)`：x 的 y 次根，等价于 `x ** (1/y)`
    - `reciprocal(x)`：取倒数，相当于 `1/x`
    - `ln(x)`：自然对数，等价于 `log(x)`
    - `log2(x)`：以 2 为底，x 的对数
    - `log10(x)`：以 10 为底，x 的对数
    - `log(x, y)`：以 y 为底，x 的对数
    - `sin(x)`：正弦函数
    - `cos(x)`：余弦函数
    - `tan(x)`：正切函数
    - `factorial(x)`：阶乘函数
    - `abs(x)`：绝对值函数
    - `C(n, k)`：组合数函数，计算从 n 个元素中取 k 个元素的组合数
    - `P(n, k)`：排列数函数，计算从 n 个元素中取 k 个元素的排列数

这当中：

- 基本的加减乘除运算、正负号、括号这些是 Python 本身就支持的，我们不需要额外处理
- 数学常数和函数我们需要来定义 - 可以定义在 `calculate_expression()` 函数中，或者定义在全局作用域中，根据大家的习惯来定即可
- 但是要注意，这两种计算方式，对应的测试代码也要做相应的调整

### (2) 添加数学常数和函数

我们可以在 `calculate_expression()` 函数中，先导入 `math` 模块，然后定义我们需要的数学常数和函数，最后再调用 `eval()` 来计算表达式。

```python
# src/function_expression.py
# 计算表达式的函数
def calculate_expression(expression):

    # 定义数学常数和函数
    import math
    # pi
    pi = math.pi
    # e
    e = math.e
    # square(x)：平方函数
    def square(x):
        return x * x
    # pow(x, y)：x 的 y 次幂
    def pow(x, y):
        return x ** y
    # exp(x)：指数函数
    def exp(x):
        return math.e ** x
    # sqrt(x)：平方根
    def sqrt(x):
        return x ** 0.5
    # root(x, y)：x 的 y 次根
    def root(x, y):
        return x ** (1 / y)
    # reciprocal(x)：取倒数
    def reciprocal(x):
        return 1 / x
    # ln(x)：自然对数
    def ln(x):
        return math.log(x, math.e)
    # log2(x)：以 2 为底，x 的对数
    def log2(x):
        return math.log(x, 2)
    # log10(x)：以 10 为底，x 的对数
    def log10(x):
        return math.log(x, 10)
    # log(x, y)：以 y 为底，x 的对数
    def log(x, y):
        return math.log(x, y)
    # sin(x)：正弦函数
    def sin(x):
        return math.sin(x)
    # cos(x)：余弦函数
    def cos(x):
        return math.cos(x)
    # tan(x)：正切函数
    def tan(x):
        return math.tan(x)
    # factorial(x)：阶乘函数
    def factorial(x):
        return math.factorial(x)
    # abs(x)：绝对值函数
    def abs(x):
        return math.fabs(x)
    # C(n, k)：组合数函数，计算从 n 个元素中取 k 个元素的组合数
    def C(n, k):
        return math.comb(n, k)
    # P(n, k)：排列数函数，计算从 n 个元素中取 k 个元素的排列数
    def P(n, k):
        return math.perm(n, k)

    # 使用 eval 计算表达式
    result = eval(expression)
    return result
```

### (3) 在测试模块中测试表达式计算的正确性

在完成了表达式计算功能后，我们还需要在测试模块 `test_function_expression.py` 中，添加对表达式计算功能的测试代码，确保其计算结果的正确性。

这里，我们的测试代码就要比之前动物园程序的测试代码复杂一些，正式一些了，我们需要搭一个测试框架，来系统地测试各种表达式的计算结果是否正确：

```python
# tests/test_function_expression.py
from config_test import *
from function_expression import calculate_expression

# 测试表达式计算功能的正确性
def test_calculate_expression():

    import math

    # 检查表达式计算结果是否正确的辅助函数
    def check_expression(expression, value):
        if math.fabs(calculate_expression(expression) - value) < 1e-10:
            return True
        else:
            return False

    # 测试基本的加减乘除运算、括号、正负号
    assert check_expression("2 + 3 * 4 - 5 / 2", 2 + 3 * 4 - 5 / 2)
    assert check_expression("((2 + 3) * 4) / 5", ((2 + 3) * 4) / 5)
    assert check_expression("(1 + 2) * (3 + 4)", (1 + 2) * (3 + 4))
    assert check_expression("-(1 + 2) * +(3 + 4)", -(1 + 2) * +(3 + 4))

    # 测试包含数学常数和函数的表达式
    # square(x)：平方函数
    assert check_expression("square(5)", 25)
    # pow(x, y)：x 的 y 次幂
    assert check_expression("pow(2, 3)", 8)
    # exp(x)：指数函数
    assert check_expression("exp(1)", math.e)
    # sqrt(x)：平方根
    assert check_expression("sqrt(16)", 4)
    # root(x, y)：x 的 y 次根
    assert check_expression("root(27, 3)", 3)
    # reciprocal(x)：取倒数
    assert check_expression("reciprocal(4)", 0.25)
    # ln(x)：自然对数
    assert check_expression("ln(e)", 1)
    # log2(x)：以 2 为底，x 的对数
    assert check_expression("log2(8)", 3)
    # log10(x)：以 10 为底，x 的对数
    assert check_expression("log10(100)", 2)
    # log(x, y)：以 y 为底，x 的对数
    assert check_expression("log(100, 10)", 2)
    # sin(x)：正弦函数
    assert check_expression("sin(0)", 0)
    assert check_expression("sin(pi/2)", 1)
    # cos(x)：余弦函数
    assert check_expression("cos(0)", 1)
    assert check_expression("cos(pi)", -1)
    # tan(x)：正切函数
    assert check_expression("tan(0)", 0)
    assert check_expression("tan(pi/4)", 1)
    # factorial(x)：阶乘函数
    assert check_expression("factorial(5)", 120)
    # abs(x)：绝对值函数
    assert check_expression("abs(-5)", 5)
    # C(n, k)：组合数函数，计算从 n 个元素中取 k 个元素的组合数
    assert check_expression("C(5, 2)", 10)
    # P(n, k)：排列数函数，计算从 n 个元素中取 k 个元素的排列数
    assert check_expression("P(5, 2)", 20)

    print("所有表达式计算测试通过！")

if __name__ == "__main__":
    test_calculate_expression()
```

这里我们用到两个关键的技术点：

- 在检查表达式计算结果与预期值的差异时，我们与一个很小的阈值（`1e-10`）进行比较：

    - 这样做是为了避免浮点数计算中的精度问题，确保结果在允许的误差范围内是正确的
    - 例如 `tan(pi/4)` 的结果理论上应该是 `1`，但实际计算结果可能是 `0.9999999999999999`，通过与一个小阈值比较，我们可以认为它是正确的

- 使用 `assert` 语句来断言表达式计算的结果是否正确，如果不正确，程序会抛出异常并停止执行

我们运行测试代码，看到以下结果，表示我们的表达式计算功能已经通过了所有测试：

```text
所有表达式计算测试通过！
```

## 4. 检查表达式合法性

### (1) 检查表达式的函数实现

接下来，我们需要完善表达式合法性检查功能，防止恶意代码执行。

这里的思路其实比较简单：

- 我们支持的计算功能已经列举出来了，那么我们只需要检查用户输入的表达式字符串中，是否只包含这些合法的字符和函数即可
- 这里涉及到的知识点，其实就是字符串的处理了

我们来看下具体的实现，例如我们有这样一个表达式字符串：`"2 - 3 + log(100, 10) * sin(pi/2)"`

- 首先，我们先将字符串中的括号和运算符换成空格，例如将 `(`、`)`、`+`、`-`、`*`、`/`、`,` 都替换为空格，得到一个新的字符串：`"2   3   log 100  10    sin pi  2 "`
- 之后，我们将这个字符串按空格拆分成一个个的“单词”，得到一个列表：`["2", "3", "log", "100", "10", "sin", "pi", "2"]`
- 最后，我们检查这个列表中的每个单词，如果出现了不是数字的，或者不是我们支持的函数和常数的单词，那么就说明这个表达式是不合法的
- 这里，我们默认括号和运算符的使用是合法的，这个其实是没有问题的，因为仅仅使用括号和运算符基本没有什么安全风险

我们可以在 `expression_check()` 函数中，添加对表达式合法性的检查代码：

```python
# src/function_expression.py
# 定义表达式非法类
class InvalidExpressionError(Exception):
    pass

# 表达式合法性检查函数
def expression_check(expression):

    # 定义允许的函数和常数列表
    valid_funcs = [
        "pi", "e",
        "square", "pow", "exp", "sqrt", "root", "reciprocal",
        "ln", "log2", "log10", "log", "sin", "cos", "tan",
        "factorial", "abs", "C", "P"]
    
    # 分割表达式，提取出所有的标识符
    expression_list = (expression.replace('(', ' ').
                                  replace(')', ' ').
                                  replace('+', ' ').
                                  replace('-', ' ').
                                  replace('*', ' ').
                                  replace('/', ' ').
                                  replace('%', ' ').
                                  replace('.', ' ').
                                  replace(',', ' ').
                                  split())

    # 检查表达式合法性
    is_valid = True
    for item in expression_list:
        if not item.isnumeric() and item not in valid_funcs:
            is_valid = False
    
    # 如果不合法，抛出异常，否则返回表达式
    if not is_valid:
        raise InvalidExpressionError("表达式包含不合法的标识符！")
    else:
        return expression
```

### (2) 测试表达式检查函数

之后，我们在测试模块中，编写一下这个函数的测试框架，注意这里需要把 `InvalidExpressionError` 也导入进来：

```python
# tests/test_function_expression.py
from config_test import *
from function_expression import calculate_expression, expression_check, InvalidExpressionError

def test_expression_check():

    # 检查表达式是否合法的辅助函数
    def check_expression(expression):
        try:
            expression_check(expression)
            return True
        except InvalidExpressionError:
            return False
    
    # 合法表达式
    assert check_expression("2 + 3 * 4 - 5 / 2") == True
    assert check_expression("square(5) + pow(2, 3)") == True
    assert check_expression("1 * 9 + -sin(pi / 2) + cos(0)") == True
    assert check_expression("C(5, 2) / P(5, 2)") == True
    assert check_expression("ln(e) + log10(100) - sqrt(16)") == True

    # 非法表达式
    assert check_expression("import os; os.system('rm -rf /')") == False
    assert check_expression("__import__('os').system('ls')") == False
    assert check_expression("open('file.txt', 'w')") == False
    assert check_expression("exec('print(123)')") == False
    assert check_expression("lambda x: x + 1") == False

    print("所有表达式合法性检查测试通过！")


if __name__ == "__main__":
    test_expression_check()
```

如果我们运行测试代码，看到以下结果，表示我们的表达式合法性检查功能已经通过了所有测试：

```text
所有表达式合法性检查测试通过！
```

## 5. 将计算表达式与检查表达式整合

最后，我们需要将表达式计算与表达式合法性检查整合起来：

- 在 `function_expression_main()` 函数中调用 `expression_check()` 来检查用户输入的表达式是否合法
- 如果合法再调用 `calculate_expression()` 来计算结果
- 同时，我们再加上一些错误处理的机制，再加一些打印横线让输出美观一些

```python
# src/function_expression.py
# 表达式计算功能主函数
def function_expression_main():

    while True:

        # 展示功能菜单
        print("-" * 40)
        print("表达式计算功能：")
        print("0. 查看功能说明")
        print("1. 计算表达式")
        print("q. 返回主菜单")
        print("-" * 40)
        
        # 获取用户选择
        choice = input("请选择功能（0/1/q）：")
        print("-" * 40)
        
        # 0. 查看功能说明
        if choice == "0":
            show_instructions(function_key="1")
            print("-" * 40)
        
        # 1. 计算表达式
        elif choice == "1":

            while True:
                
                # 获取用户输入的表达式
                expression = input("请输入数学表达式（输入 'exit' 退出）：").strip()
                
                # 退出
                if expression == "exit":
                    break
                
                # 计算表达式
                try:
                    # 检查并计算表达式
                    expression_checked = expression_check(expression)
                    result = round(calculate_expression(expression_checked), 4)
                    # 输出计算结果
                    print("计算结果：", result)
                    # 记录计算历史日志
                    log_write("计算历史", {
                        "功能": "算式计算",
                        "输入": expression_checked,
                        "结果": result
                    })
                    # 询问是否继续计算
                    print("-" * 40)
                    choice_continue = input("是否继续计算？(y/n)：").strip().lower()
                    print("-" * 40)
                    if choice_continue != "y":
                        break
                
                # 处理计算错误
                except InvalidExpressionError as e1:
                    print("表达式非法：", e1, "请检查后重新输入表达式。")
                    log_write("计算历史", {
                        "功能": "算式计算",
                        "输入": expression,
                        "结果": "程序错误：" + str(e1)
                    })
                    print("-" * 40)
                except Exception as e2:
                    print("表达式错误：", e2, "请检查后重新输入表达式。")
                    log_write("计算历史", {
                        "功能": "算式计算",
                        "输入": expression,
                        "结果": "程序错误：" + str(e2)
                    })
                    print("-" * 40)
        
        # q. 返回主菜单
        elif choice == "q":
            break
        
        # 其他. 无效输入
        else:
            print("无效输入，请重新选择。")
```

我们运行一下，看看最终的效果如何：

```text
----------------------------------------
表达式计算功能：
0. 查看功能说明
1. 计算表达式
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：www
----------------------------------------
无效输入，请重新选择。
----------------------------------------
表达式计算功能：
0. 查看功能说明
1. 计算表达式
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：0
----------------------------------------
简单算式计算功能使用说明：
请输入一个算式，例如：2 + 3 * 4
程序将计算出结果并返回。
输入任意内容返回上级菜单：
----------------------------------------
----------------------------------------
表达式计算功能：
0. 查看功能说明
1. 计算表达式
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：1
----------------------------------------
请输入数学表达式（输入 'exit' 退出）：1+1
计算结果： 2
----------------------------------------
是否继续计算？(y/n)：y
----------------------------------------
请输入数学表达式（输入 'exit' 退出）：log(8,2) * sqrt(100) + -2
计算结果： 28.0
----------------------------------------
是否继续计算？(y/n)：y
----------------------------------------
请输入数学表达式（输入 'exit' 退出）：print(678)
表达式非法： 表达式包含不合法的标识符！ 请检查后重新输入表达式。
----------------------------------------
请输入数学表达式（输入 'exit' 退出）：exit
----------------------------------------
表达式计算功能：
0. 查看功能说明
1. 计算表达式
q. 返回主菜单
----------------------------------------
请选择功能（0/1/q）：q
----------------------------------------
```

那么到此为止，我们就完成了表达式计算功能的实现：

- 实现了表达式计算功能的主函数 `function_expression_main()`
- 实现了表达式计算函数 `calculate_expression()` 并在测试模块中进行了测试
- 实现了表达式合法性检查函数 `expression_check()` 并在测试模块中进行了测试

最后，我们将这个功能的使用说明文档重新丰富一下，放在 `data/instructions/instruction_expression.txt` 文件中，内容如下：

```text
简单算式计算功能使用说明：

请输入一个算式，程序会计算出结果并返回。

支持的表达式要素包括：
- 数字：整数和浮点数
- 括号
- 基本运算符
    - +：加法
    - -：减法
    - *：乘法
    - /：除法
    - //：整除
    - %：取余
    - **：幂运算
- 正负号
    - +：正号
    - -：负号
- 数学常数
    - pi：圆周率
    - e：自然对数的底数
- 数学函数
    - square(x)：平方函数
    - pow(x, y)：x 的 y 次幂
    - exp(x)：指数函数
    - sqrt(x)：平方根
    - root(x, y)：x 的 y 次根
    - reciprocal(x)：取倒数
    - ln(x)：自然对数
    - log2(x)：以 2 为底，x 的对数
    - log10(x)：以 10 为底，x 的对数
    - log(x, y)：以 y 为底，x 的对数
    - sin(x)：正弦函数
    - cos(x)：余弦函数
    - tan(x)：正切函数
    - factorial(x)：阶乘函数
    - abs(x)：绝对值函数
    - C(n, k)：组合数函数
    - P(n, k)：排列数函数

表达式示例：
- 示例 1
    输入：2 + 3 * 4
    输出：14
- 示例 2
    输入：sqrt(16) + log10(100)
    输出：6.0
- 示例 3
    输入：C(5, 2) + P(5, 2)
    输出：30

请不要输入任何非法表达式，否则程序会提示错误并要求重新输入。
```
