# Topic 3.3 - 数字类型之空值

## 1. 空值类型基本介绍

空值（`None`）是 Python 中的一个特殊值，表示什么都没有。

- `None` 既不是 0，也不是空字符串 `""`，更不是 `False`，而是一个独立的值
- 我们来查看一下 `None` 值的类型：


```python
x = None
print(x)
print(type(x))
```

    None
    <class 'NoneType'>


- `None` 值为什么会产生，原因其实有很多，我们会在后面的课程里探讨

## 2. None 的判断

判断一个变量是否为 `None`，Python 推荐：

- 使用 `is` 判断是 `None`，不使用 `==`
- 使用 `is not` 判断不是 `None`，不使用 `!=`




```python
y = None
print(y is None)
print(y is not None)
```

    True
    False


## 3. None 的计算

如果对 None 值进行加减乘除运算，或者比较运算，会直接报错：


```python
# 以下代码都会报 TypeError 错误
# print(None + 1)
# print(None > 0)
# print(max(1,2,3,None))
```

如果将 None 值进行逻辑运算，倒是不会报错，但是情况会比较复杂：

- 直接将 `None` 转为布尔型，得到的结果是 `False`
- 在 `or` 逻辑中，`None` 的值会被当做 `False` 来看待
- 在 `and` 逻辑中， `None` 的运算结果都是 `None` 


```python
print(bool(None))
print(None or True)
print(None or False)
print(None and True)
print(None and False)
```

    False
    True
    False
    None
    None

