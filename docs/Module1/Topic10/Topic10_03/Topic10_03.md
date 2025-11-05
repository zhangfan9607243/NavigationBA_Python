# Topic 10.3 - 异常处理拓展（补充）


## 1. `assert` 语句

在 Python 中，还有一种更直接的抛出异常的方式，那就是使用 `assert` 语句，它的基本语法如下：

```python
assert 条件, "异常的描述信息"
```

`assert` 语句抛出的异常类型统一是 `AssertionError`。

我们来看一个例子：

```python
# 请给x赋值一个整数
x = 123.456
print(x)
assert isinstance(x, int), "您的输入的赋值的不是整数！"
```

```text
123.456
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
Cell In[1], line 4
      2 x = 123.456
      3 print(x)
----> 4 assert isinstance(x, int), "您的输入的赋值的不是整数！"

AssertionError: 您的输入的赋值的不是整数！
```

## 2. 异常类型之间的继承关系

Python 中的异常类型之间存在继承关系，比方说：

- `ZeroDivisionError` 其实是 `ArithmeticError` 的子类，犯了 `ZeroDivisionError` 错误，实际上也是犯了 `ArithmeticError` 错误
- `IndexError` 其实是 `LookupError` 的子类，犯了 `IndexError` 错误，实际上也是犯了 `LookupError` 错误

我们来看以下代码：


```python
try:
    x = 10 / 0
except ArithmeticError as e:
    print(f"捕获到异常：{e}")
```

    捕获到异常：division by zero


完整的异常继承关系（Python 3.10+）如下，许多异常其实不常见，稍作了解即可：

```text
BaseException
├── SystemExit                # sys.exit() 触发，用于安全退出程序
├── KeyboardInterrupt         # 用户中断（Ctrl + C）
├── GeneratorExit             # 生成器/协程被关闭时触发
└── Exception                 # 所有常规错误的基类
    ├── ArithmeticError       # 数学运算相关错误的基类
    │   ├── FloatingPointError
    │   ├── OverflowError
    │   └── ZeroDivisionError
    │
    ├── AssertionError        # assert 语句失败
    ├── AttributeError        # 对象属性访问失败
    ├── BufferError
    ├── EOFError              # input() 读取到文件结尾
    │
    ├── ImportError           # 导入模块失败
    │   └── ModuleNotFoundError
    │
    ├── LookupError           # 查找错误（索引/键）
    │   ├── IndexError
    │   └── KeyError
    │
    ├── MemoryError
    ├── NameError             # 使用未定义的变量
    │   └── UnboundLocalError # 局部变量未赋值
    │
    ├── OSError               # 操作系统相关错误（IO/文件）
    │   ├── BlockingIOError
    │   ├── ChildProcessError
    │   ├── ConnectionError
    │   │   ├── BrokenPipeError
    │   │   ├── ConnectionAbortedError
    │   │   ├── ConnectionRefusedError
    │   │   └── ConnectionResetError
    │   ├── FileExistsError
    │   ├── FileNotFoundError
    │   ├── InterruptedError
    │   ├── IsADirectoryError
    │   ├── NotADirectoryError
    │   ├── PermissionError
    │   ├── ProcessLookupError
    │   └── TimeoutError
    │
    ├── ReferenceError        # 弱引用访问的对象已被销毁
    ├── RuntimeError          # 运行时错误的通用基类
    │   ├── NotImplementedError
    │   ├── RecursionError
    │   └── FutureWarning
    │
    ├── StopIteration         # 迭代器无元素（内部使用）
    ├── StopAsyncIteration    # 异步迭代器无元素
    ├── SyntaxError           # 语法错误
    │   └── IndentationError
    │       └── TabError
    │
    ├── SystemError           # 解释器内部错误
    ├── TypeError             # 操作或函数应用于错误类型
    ├── ValueError            # 参数类型正确但值不合适
    ├── UnicodeError          # Unicode 编码/解码错误
    │   ├── UnicodeDecodeError
    │   ├── UnicodeEncodeError
    │   └── UnicodeTranslateError
    │
    ├── Warning               # 警告类基类
    │   ├── DeprecationWarning
    │   ├── PendingDeprecationWarning
    │   ├── RuntimeWarning
    │   ├── SyntaxWarning
    │   ├── UserWarning
    │   ├── FutureWarning
    │   ├── ImportWarning
    │   ├── UnicodeWarning
    │   └── ResourceWarning
    │
    └── EnvironmentError      # Python 3 中已并入 OSError（旧版本遗留）
```
