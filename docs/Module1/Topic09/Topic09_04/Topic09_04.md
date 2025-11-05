# Topic 9.4 - 函数拓展（补充）

## 1. `lambda` 函数

### (1) 定义 `lambda` 函数

在前面的章节中，我们学习了如何使用 `def` 关键字来定义函数，其实 Python 还提供了一种更简洁的方式来创建小型函数，这就是 `lambda` 函数。

`lambda` 函数的语法如下：

- 如果将函数命名：

```python
函数名 = lambda 参数1, 参数2, ... : 表达式
```

- 如果不将函数命名（匿名函数）：

```python
lambda 参数1, 参数2, ... : 表达式
```

我们来看一个简单的例子，对比一下 `def` 函数和 `lambda` 函数的定义方式：


```python
# 使用 def 定义函数
def add_a(x, y):
    return x + y

def square_a(x):
    return x ** 2

print(add_a(2, 3))
print(square_a(4))
```

    5
    16



```python
# 使用 lambda 定义函数
add_b = lambda x, y: x + y
square_b = lambda x: x ** 2

print(add_b(2, 3))
print(square_b(4))
```

    5
    16


### (2) `lambda` 函数的应用场景

通过上一节的例子，我们可以体会到 `lambda` 函数的以下特点：

- 语法简洁，可以快速定义一个函数，不用写完整的缩进语法块
- 只能包含一个表达式，适合用于简单的计算或操作

因此，`lambda` 函数通常用于**临时定义一个简单的公式**，具体来说有以下几个常见的应用场景。

#### (a) `map()` 函数

`map()` 函数用于将一个函数应用到一个可迭代对象（如列表）中的每个元素上，返回一个新的可迭代对象。

- `map()` 函数的第一个参数是一个函数，表示要应用的操作
- 这个函数通常使用 `lambda` 函数来定义

我们来看以下例子：


```python
numbers = [1, 2, 3, 4, 5]
squared_numbers = list(map(lambda x: x ** 2, numbers))
print(squared_numbers)
```

    [1, 4, 9, 16, 25]


如果使用 `def` 函数来实现同样的功能，代码会显得冗长一些：


```python
def square(x):
    return x ** 2
numbers = [1, 2, 3, 4, 5]
squared_numbers = list(map(square, numbers))
print(squared_numbers)
```

    [1, 4, 9, 16, 25]


这段代码的效果等同于我们之前学的列表推导式：


```python
numbers = [1, 2, 3, 4, 5]
squared_numbers = [x ** 2 for x in numbers]
print(squared_numbers)
```

    [1, 4, 9, 16, 25]


#### (b) `filter()` 函数

`filter()` 函数用于过滤可迭代对象中的元素，返回符合条件的元素组成的新可迭代对象。

- `filter()` 函数的第一个参数是一个函数，该函数返回布尔值，用于判断元素是否符合条件
- 这个函数通常使用 `lambda` 函数来定义

我们来看以下例子：


```python
numbers = [1, 2, 3, 4, 5, 6]
even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
print(even_numbers)
```

    [2, 4, 6]


如果使用 `def` 函数来实现同样的功能，代码会显得冗长一些：


```python
def is_even(x):
    return x % 2 == 0

numbers = [1, 2, 3, 4, 5, 6]
even_numbers = list(filter(is_even, numbers))
print(even_numbers)
```

    [2, 4, 6]


这段代码的效果等同于带条件的列表推导式：


```python
numbers = [1, 2, 3, 4, 5, 6]
even_numbers = [x for x in numbers if x % 2 == 0]
print(even_numbers)
```

    [2, 4, 6]


#### (c) `sorted()` 函数

`sorted()` 函数用于对组合类型的可迭代对象进行排序，如列表套列表、列表套元组等。

- `sorted()` 函数的 `key` 参数接受一个函数，该函数用于提取排序依据
- 这个参数通常使用 `lambda` 函数来定义

我们来看以下例子：


```python
pairs = [('Alice', 85), ('Bob', 95), ('Charlie', 80)]
sorted_pairs = sorted(pairs, key=lambda x: x[1])
print(sorted_pairs)
```

    [('Charlie', 80), ('Alice', 85), ('Bob', 95)]


如果使用 `def` 函数来实现同样的功能，代码会显得冗长一些：


```python
def get_score(pair):
    return pair[1]

pairs = [('Alice', 85), ('Bob', 95), ('Charlie', 80)]
sorted_pairs = sorted(pairs, key=get_score)
print(sorted_pairs)
```

    [('Charlie', 80), ('Alice', 85), ('Bob', 95)]


## 2. 函数作为 Python 中的对象

Python 的一个编程理念就是“万物皆对象”，函数也是如此，这意味着函数可以像其他对象（如变量）一样被传递和操作。

这么说有点抽象，这一节我们通过几个例子来体会一下函数作为对象的用法。

### (1) 函数作为列表中的元素

我们可以将函数作为对象存储在列表中：

- 储存时只需将函数名放入列表中，不加括号
- 因为加括号会调用函数并将其返回值存储在列表中，而不是函数本身

我们来看一个例子：


```python
def func1(x):
    return x ** 2

def func2(x):
    return x ** 3

def func3(x):
    return x ** 4

func_list = [func1, func2, func3]
```


```python
# 调用第一个函数
print(func_list[0](2))
```

    4



```python
# 调用所有函数
for func in func_list:
    print(func(2))
```

    4
    8
    16


在上面的例子中：

- 我们先定义了三个函数 `func1`、`func2` 和 `func3`，并将它们存储在列表 `func_list` 中
- 如果我们想调用列表里的第一个函数，只需使用 `func_list[0]` 来定位到 `func1`，因此 `func_list[0](2)` 就相当于 `func1(2)`，并返回结果
- 我们还可以通过循环遍历列表，依次调用每个函数

    - 第1圈，`func` 指向 `func1`，调用 `func(2)` 就是调用 `func1(2)`，返回 4
    - 第2圈，`func` 指向 `func2`，调用 `func(2)` 就是调用 `func2(2)`，返回 8
    - 第3圈，`func` 指向 `func3`，调用 `func(2)` 就是调用 `func3(2)`，返回 16

### (2) 函数作为另一个函数的参数

函数还可以作为另一个函数的参数传递，传进去的函数可以在被调用的函数内部使用

- 注意，我们这里不是调用传进去的函数，而是将其作为对象传递
- 函数在传进去的时候，只需使用函数名，不加括号，表示传递函数本身，而不是调用结果

我们来看以下例子：


```python
def func_new(x):
    return x + 10

def apply_function(func, value):
    return func(value) * 2

result = apply_function(func_new, 5)
print(result)
```

    30


在这个例子中：

- 我们将 `func_new` 函数作为参数传递给 `apply_function` 函数
- 在 `apply_function` 函数内部，我们调用传入的函数 `func`，并将 `value` 作为参数传递给它：

    - `apply_function` 调用时传入了 `func_new` 和 5
    - 在 `apply_function` 中调用 `func_new(5)` * 2
    - `func_new(5)` 返回 15，然后乘以 2，最终 `apply_function` 返回 30

### (3) 函数作为另一个函数的返回值

函数还可以作为另一个函数的返回值返回，这样做的本质是**用函数创造函数**。

我们来看一个例子：


```python
def outer_func(factor):

    def inner_func(x):
        return x * factor
    
    return inner_func

func_a = outer_func(2)  # 创建一个将输入乘以 2 的函数
func_b = outer_func(3)  # 创建一个将输入乘以 3 的函数

print(func_a(5))
print(func_b(5))
```

    10
    15


在这个例子中：

- `outer_func` 就是一个用来创建函数的函数
- `outer_func` 接受一个参数 `factor`，并定义了一个内部函数 `inner_func`，该函数将输入 `x` 乘以 `factor`
- 当我们调用 `outer_func(2)` 时

    - 返回一个新的函数 `inner_func(x)`，内部代码是 `return x * 2`，这个函数会将输入乘以 2
    - 我们给新函数命名为 `func_a`，并调用 `func_a(5)`，返回 10

- 当我们调用 `outer_func(3)` 时

    - 返回一个新的函数 `inner_func(x)`，内部代码是 `return x * 3`，这个函数会将输入乘以 3
    - 我们给新函数命名为 `func_b`，并调用 `func_b(5)`，返回 15


### (4) 小结

通过以上几个例子，我们可以体会到，函数作为 Python 中的对象，使用起来可以像其他对象一样灵活多变。

- 但是在实际开发中，以上这些操作会增加代码的复杂度，建议大家根据实际需求谨慎使用。

- 同样，讲这节的主要目的是让大家可以看懂别人写的类似代码。
