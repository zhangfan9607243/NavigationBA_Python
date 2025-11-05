# Topic 3.4 - 数字类型之复数（补充）


## 1. 复数的基本概念

Python 中是支持复数运算的，这个复数和大家在数学上学的复数是一个概念，由实部与虚部构成：


```python
a = 3 + 4j
print(a)
print(type(a))
```

    (3+4j)
    <class 'complex'>


Python 中的复数支持以下操作：

- `复数.real`：获取实部
- `复数.imag`：获取虚部
- `复数.conjugate()`：计算共轭复数


```python
a = 3 + 4j
print(a.real) 
print(a.imag) 
print(a.conjugate())
```

    3.0
    4.0
    (3-4j)


Python 中的复数是支持加减乘除基本运算的，也支持使用 `abs` 算复数的模：

- 这里我们就不介绍复数的运算细节了，这是和大家说一下 Python 中有这些复数的运算操作
- 大家如果以后接触到复数运算，可以直接使用 Python 来进行计算


```python
z1 = 3 + 4j
z2 = 1 - 2j

print(z1 + z2) 
print(z1 - z2) 
print(z1 * z2) 
print(z1 / z2) 
print(abs(z1))
print(abs(z2))
```

    (4+2j)
    (2+6j)
    (11-2j)
    (-1+2j)
    5.0
    2.23606797749979


## 2. 复数运算的 `cmath` 模块

我们之前接触过的 `math` 模块是不支持复数运算的，用来做复数运算的模块叫 `cmath`，常见操作有：

- `cmath.sqrt(z)`：复数开方
- `cmath.exp(z)`：复数指数
- `cmath.log(z)`：复数对数
- `cmath.phase(z)`：复数幅角

同样，这里我们就不介绍这些运算的细节了，大家如果以后接触到复数运算，再来查找对应的 Python 方法来进行计算即可


```python
import cmath

z = 1 + 1j
print(cmath.sqrt(z)) 
print(cmath.exp(z)) 
print(cmath.log(z))
print(cmath.phase(z))
```

    (1.09868411346781+0.45508986056222733j)
    (1.4686939399158851+2.2873552871788423j)
    (0.34657359027997264+0.7853981633974483j)
    0.7853981633974483

