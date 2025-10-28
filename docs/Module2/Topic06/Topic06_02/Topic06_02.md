# Topic 6.2 -  条件语句的高级用法

## 1. 三元表达式

### (1) 三元表达式基本概念

在给变量赋值的时候，有的时候我们希望根据不同的条件来赋不同的值，这时可以使用 `if` 三元表达式，语法格式是：

```python
变量 = 条件为真时的值 if 条件 else 条件为假时的值
```

它其实等同于以下普通的 if 语句：

```python
if 条件:
    变量 = 条件为真时的值
else:
    变量 = 条件为假时的值
```

我们来看以下例子：

```python
average = 85
grade_level = "及格" if average >= 60 else "不及格"
print("成绩等级:", grade_level)
```

```text
成绩等级: 及格
```

这段代码等同于：

```python
average = 85
if average >= 60:
    grade_level = "及格"
else:
    grade_level = "不及格"
print("成绩等级:", grade_level)
```

```text
成绩等级: 及格
```

### (2) 三元表达式的嵌套用法

三元表达式也是可以嵌套使用的，但是不建议过度嵌套，以免影响代码的可读性。

```python
average = 75
grade_level = "优秀" if average >= 90 else "良好" if average >= 80 else "及格" if average >= 60 else "不及格"
print("成绩等级:", grade_level)
```

```text
成绩等级: 及格
```

这个例子中，给 `grade_level` 变量赋值的代码就很长很复杂，如果写成等同的普通 `if` 语句会更清晰：

```python
average = 75
if average >= 90:
    grade_level = "优秀"
elif 80 <= average < 90:
    grade_level = "良好"
elif 60 <= average < 80:
    grade_level = "及格"
else:
    grade_level = "不及格"
print("成绩等级:", grade_level)
```

```text
成绩等级: 及格
```

## 2. Python 中判断变量类型

### (1) `isinstance()` 函数的基本用法

目前我们已经学习了许多的变量类型，包括基础数据类型与组合数据类型。

那么 Python 中可不可以判断一个变量的类型呢？可以的，使用的是 `isinstance(变量, 类型)` 函数，它会返回一个布尔值

这当中，类型这个参数填入的是类型名称，而不是字符串：

- 数字类型，`int`、`float`
- 布尔类型，`bool`
- 字符串类型，`str`
- 列表类型，`list`
- 元组类型，`tuple`
- 集合类型，`set`
- 字典类型，`dict`

我们来看以下例子：

```python
a = 100
b = 3.14
c = "Hello"
d = True
e = [1, 2, 3]
f = (4, 5, 6)
g = {7, 8, 9}
h = {"name": "Alice", "age": 30}

print(isinstance(a, int))        
print(isinstance(b, float))      
print(isinstance(c, str))        
print(isinstance(d, bool))       
print(isinstance(e, list))       
print(isinstance(f, tuple))      
print(isinstance(g, set))       
print(isinstance(h, dict))      
```

```text
True
True
True
True
True
True
True
True
True
```

这当中注意一个特例，就是空值类型，Python 中并没有给空值类型单独命名一个类型名称，因此判断的时候只能使用 `type(None)` 来代表空值类型：

```python
x = None
print(isinstance(x, type(None)))
```

```text
True
```

### (2) 使用 `isinstance()` 函数的进阶用法

`isinstance(变量, 类型)` 函数的第二个参数还可以是一个类型元组，表示可以判断多个类型，只要变量是其中任意一个类型，就会返回 `True`，否则返回 `False`。

```python
x = 100
y = 3.14
z = "Hello"

print(isinstance(x, (int, float))) 
print(isinstance(y, (int, float))) 
print(isinstance(z, (int, float))) 
```

```text
True
True
False
```

