# Topic 10.2 - 抛出异常

## 1. 抛出异常

### (1) 抛出异常的基本语法

到目前为止，我们见到的异常都是 Python 解释器自动抛出的：

- 这些异常都比较基础
- 如果出现这些异常，意味着程序的基本运行逻辑是不满足的。

在实际开发中，我们还可以“自定义”异常：

- 这些异常通常不是程序运行的基础逻辑错误，而是业务逻辑上的错误
- 这就要用到**抛出异常**的机制

抛出异常的基本语法如下：

```python
raise 异常类型("异常的描述信息")
```

但是，通常，我们不会在程序主流程中平白无故就抛出异常，我们通常是程序在满足某个条件时，才抛出异常：

```python
if 某个条件满足:
    raise 异常类型("异常的描述信息")
```

我们来看以下例子：

```python
# 请给x赋值一个整数
x = 123.456
print(x)
if not isinstance(x, int):
    raise ValueError("您的输入的赋值的不是整数！")
```

```text
123.456
ValueError: 您的输入的赋值的不是整数！
```

### (2) 捕获自定义的异常

通常我们会在 `try` 块中，判断如果某个条件满足，就使用 `raise` 抛出异常，并且我们还可以在 `except` 块中捕获这个异常：

```python
try:
    # 请给x赋值一个整数
    x = 123.456
    print(x)
    if not isinstance(x, int):
        raise ValueError("您的赋值的不是整数！")
except ValueError as e:
    print(f"捕获到异常：{e}")
```

```text
123.456
捕获到异常：您的赋值的不是整数！
```

## 2. 自定义异常类型

通过以上两个例子我们发现，我们自己定义的异常，只能属于 Python 内置的异常类型之一

- 在上面两个例子中，我们让我们自定义的异常属于 `ValueError` 类型，是因为我们认为，想要整数但是得到了其他类型，听上去像是一个“值错误”
- 那么我们能不能让它属于其他类型呢？答案是可以的，比方说，我们让它属于 `TypeError` 类型：

```python
try:
    # 请给x赋值一个整数
    x = 123.456
    print(x)
    if not isinstance(x, int):
        raise TypeError("您的赋值的不是整数！")
except TypeError as e:
    print(f"捕获到异常：{e}")
```

```
123.456
捕获到异常：您的赋值的不是整数！
```

那么，有时候我们觉得，我自定义的这个错误类型，用 Python 哪种内置的异常类型都不合适

- 这时候，我们就可以**自定义异常类型**，具体语法如下：

- 注意，这种写法是面向对象编程的语法，我们这里不深探讨，我们会在后续的面向对象编程模块中详细介绍

```python
class 自定义异常类型名(继承的内置异常类型):
    pass
```

- 自定义的异常类型名要符合大驼峰命名法：例如 `NotIntegerError`、`InvalidAgeError`、`PermissionDeniedError`

- 大多数情况下，我们会让自定义异常类型继承自 `Exception` 这个内置异常类型：

```python
class 自定义异常类型名(Exception):
    pass
```

我们来看一个例子：

```python
class NotIntegerError(Exception):
    pass

try:
    # 请给x赋值一个整数
    x = 123.456
    print(x)
    if not isinstance(x, int):
        raise NotIntegerError("您的赋值的不是整数！")
except NotIntegerError as e:
    print(f"捕获到异常：{e}")
```

```
123.456
捕获到异常：您的赋值的不是整数！
```

在这段代码中，我们就把错误类型，自定义成了 `NotIntegerError`，这个名字更符合我们想表达的意思