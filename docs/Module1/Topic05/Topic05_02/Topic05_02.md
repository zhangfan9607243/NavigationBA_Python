# Topic 5.2 - 组合数据类型之元组

## 1. 元组的基本概念

### (1) 元组的定义

元组 (tuple) 是 Python 中的一种**有序的**但**不可变的**组合数据类型，可以用来存储一组相关的数据。

- 元组的定义是用一对圆括号 `()` 把数据括起来，数据之间用逗号 `,` 分隔:


```python
fruits = ("apple", "banana", "cherry")
print(fruits)
print(type(fruits))
```

    ('apple', 'banana', 'cherry')
    <class 'tuple'>


- 如果想要定义一个空元组，可以直接使用一对空的圆括号 `()`，或者使用 `tuple()` 函数:



```python
empty_tuple1 = ()
empty_tuple2 = tuple()
print(empty_tuple1)
print(empty_tuple2)
print(type(empty_tuple1))
print(type(empty_tuple2))
```

    ()
    ()
    <class 'tuple'>
    <class 'tuple'>


- 如果想要定义一个只有一个元素的元组，需要在元素后面加上逗号 `,`，否则 Python 会把它当作普通的括号表达式:


```python
single_element_tuple1 = (42,)
single_element_tuple2 = (42)
print(single_element_tuple1)
print(single_element_tuple2)
print(type(single_element_tuple1))
print(type(single_element_tuple2))
```

    (42,)
    42
    <class 'tuple'>
    <class 'int'>


注意，如果将元组转为布尔值，空元组会被视为 `False`，所有非空元组都会被视为 `True`。


```python
print(bool(fruits))
print(bool(empty_tuple1))
print(bool(empty_tuple2))
```

    True
    False
    False


注意，由于元组是不可变的，因此所有修改元组的操作，包括添加、删除或修改元素，都是不支持的，这些操作会引发 `TypeError` 错误

- 唯一修改元组的方法，就是重新定义这个元组


```python
fruits = ("apple", "banana", "cherry")
# fruits[0] = "orange"  # 这行代码会引发 TypeError 错误
print(fruits)

fruits = ("orange", "banana", "cherry")  # 重新定义元组
print(fruits)
```

    ('apple', 'banana', 'cherry')
    ('orange', 'banana', 'cherry')


- 因此，元组这里的知识点比较简单，只包括索引与切片，以及简单统计等操作

### (2) 元组的常见操作

由于元组是有序的，所以支持索引与切片，元组的索引与切片操作与列表字符串完全类似，这里我们就不再赘述了



```python
fruits = ("apple", "banana", "cherry", "date", "elderberry")

print(fruits[0]) 
print(fruits[-1]) 
print(fruits[1:4]) 
print(fruits[:3]) 
print(fruits[2:]) 
```

    apple
    elderberry
    ('banana', 'cherry', 'date')
    ('apple', 'banana', 'cherry')
    ('cherry', 'date', 'elderberry')


元组也是支持判断成员运算符 `in` 和 `not in` 的，使用方法与列表字符串类似：


```python
fruits = ("apple", "banana", "cherry", "date", "elderberry")

print("banana" in fruits)
print("strawberry" not in fruits)
```

    True
    True


由于不可变，元组只有一些简单的统计操作：

- `len(元组)`：返回元组中元素的个数
- `元组.count(元素)`：返回指定元素在元组中出现的次数
- `元组.index(元素)`：返回指定元素在元组中第一次出现的索引位置，如果元素不存在则会引发 `ValueError` 错误



```python
tuple_new = ("a", "b", "c", "d", "c", "b", "a")
print(len(tuple_new))
print(tuple_new.count("b"))
print(tuple_new.index("c"))
```

    7
    2
    2


## 2. 元组的应用场景

元组这个数据类型在 Python 中使用非常广泛，有的时候并不是以存储数据的形式出现，而是作为一种语法结构来使用，在以后的 Python 学习中会经常看到。

我们在这里列举几个常见的应用场景：

### (1) 多变量赋值

元组可以用来实现多变量赋值，即一次性给多个变量赋值：


```python
x, y, z = 1, 2, 3

print(x)
print(y)
print(z)
```

    1
    2
    3


- 在这个例子中，等号右边的 `1, 2, 3` 实际上是一个元组，等同于 `(1, 2, 3)`
- 这个元组通过**解包**的方式把元组中的值依次赋给左边的变量 `x`, `y`, `z`
- 而等式左边的 `x, y, z` 实际上也是一个元组，分别接受右边元组中的值

我们还可以这样写这段代码：


```python
combined_numbers = x, y, z = 1, 2, 3
print(combined_numbers)
print(type(combined_numbers))
print(x)
print(y)
print(z)
```

    (1, 2, 3)
    <class 'tuple'>
    1
    2
    3


- 这里我们把右边的元组赋值给了一个变量 `combined_numbers`，这个变量就存储了这个元组
- 同时，`x`, `y`, `z` 也分别接受了元组中的值
- 可以看到，`combined_numbers` 的值是一个元组 `(1, 2, 3)`，类型是 `tuple`

### (2) 交换变量的值

元组也可以用来交换两个变量的值，而不需要使用临时变量（程序员面试题）：


```python
a = 5
b = 10
a, b = b, a
print(a)
print(b)
```

    10
    5


如果使用传统的方法，需要使用一个临时变量：


```python
a = 5
b = 10
temp = a
a = b
b = temp
print(a)
print(b)
```

    10
    5

