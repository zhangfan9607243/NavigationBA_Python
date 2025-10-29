# Topic 3.2 - 数字类型之布尔型

## 1. 布尔型基本介绍

布尔型（bool 或 boolean）就是 Python 中用来判断对错的类型（Yes or No），只有两个值：`True` 与 `False`

```python
a = True
b = False

print(a)
print(b)

print(type(a))
print(type(b))
```

```text
True
False
<class 'bool'>
<class 'bool'>
```

布尔型和数字类型之间是有对应关系的：`True` 的数值就是 1，`False` 的数值就是 0

- 因此，布尔型是支持基本运算的，包括加减乘除和其他运算函数
- 同时，我们也可以使用 `int()` 函数将布尔型转为整数，或使用 `float()` 函数将布尔型转为浮点数

```python
print(int(True))
print(int(False))
print(float(True))
print(float(False))
print(True + True)
print(True + False)
print(True * 10)
```

```text
1
0
1.0
0.0
2
1
10
```

同样的道理，数字类型也可以转为布尔型，使用的函数是 `bool()`：

- 只有 0 与 0.0 对应的布尔型为 `False`
- 其他数字对应的布尔型都是 `True`

```python
print(bool(1))
print(bool(1.0))
print(bool(-2))
print(bool(100))
print(bool(0))
print(bool(0.0))
```

```text
True
True
True
True
False
False
```

## 2. 比较运算符

布尔值通常由**比较运算符**得到：

| 运算符  | 含义   | 示例 (`a=5, b=3`) | 结果    |
| ---- | ---- | --------------- | ----- |
| `==` | 等于   | `a == b`        | False |
| `!=` | 不等于  | `a != b`        | True  |
| `>`  | 大于   | `a > b`         | True  |
| `<`  | 小于   | `a < b`         | False |
| `>=` | 大于等于 | `a >= b`        | True  |
| `<=` | 小于等于 | `a <= b`        | False |

```python
a = 5
b = 3

print(a == b)
print(a != b)
print(a > b)
print(a < b)
print(a >= b)
print(a <= b)
```

```text
False
True
True
False
True
False
```

在 Python 中，比较运算是支持**链式比较**的，也就是说可以将多个比较运算符连接在一起进行比较：

```python
x = 10

print(0 < x < 20)
print(10 >= x > 5)
print(15 < x < 20)
print(5 < x > 6)  # 这种写法大家在数学上可能不太习惯，但在 Python 中是允许的
```

```text
True
True
False
True
```

## 3. 逻辑运算符

多个布尔型数据可以通过**逻辑运算符**链接：

| 运算符   | 含义  | 示例               | 结果    |
| ----- | --- | ---------------- | ----- |
| `and` | 逻辑与：两边都为真，结果才是真，否则为假 | `True and False` | False |
| `or`  | 逻辑或：两边只要有一个真，结果就是真，两边都为假时结果才是假 | `True or False`  | True  |
| `not` | 逻辑非：取反 | `not True`       | False |

```python
print(True and True)
print(True and False)
print(False and False)
print(True or True)
print(True or False)
print(False or False)
print(not False)
print(not True)
```

```text
True
False
False
True
True
False
True
False
```

## 4. 逻辑运算与比较运算的顺序

比较运算符与逻辑运算符也是讲究运算顺序的：

- 1. 算术运算（+, -, *, /, **, //, %）

- 2. 比较运算（==, !=, >, <, >=, <=）

- 3. 逻辑运算

    - (1) 括号
    - (2) not
    - (3) and
    - (4) or

综合运用算数运算与逻辑运算，我们来看以下几个例子：

```python
print(3 + 2 > 4)   
print(3 + 2 > 4 and 10 / 2 == 5)
print(not 3 > 2 or 4 < 1)
print(True or False and False)
print((3 + 2 > 4 or 1 > 2) and not (2 * 2 < 5))
```

```text
True
True
False
True
False
```

## 5. 布尔类型综合练习
### (1) 成绩判断
- 要求：
    
    - 小明的数学成绩为85分，语文成绩为95，如果两门成绩都在90分以上，就奖励他一台 Switch
    - 判断小明是否能获得 Switch

- 参考代码：

```python
score_mt = 85
score_cn = 95

is_get_switch = score_mt > 90 and score_cn > 90

print("小明能否获得Switch：", is_get_switch)
```

```text
小明能否获得Switch： False
```

### (2) 随机生成的点是否落入圆内

- 要求：
    
    - 在横纵坐标都为 [-1, 1] 的范围内随机生成一个点，判断这个点是否在单位圆内
    - 判断公式为：$x^2 + y^2 <= 1$

- 参考代码：

```python
import random

x = random.uniform(-1, 1)
y = random.uniform(-1, 1)

is_inside_circle = x**2 + y**2 <= 1

print("随机点: (", round(x, 2), ",", round(y, 2), ")")
print("是否在单位圆内:", is_inside_circle)
```

```text
随机点: ( -0.04 , 0.22 )
是否在单位圆内: True
```
