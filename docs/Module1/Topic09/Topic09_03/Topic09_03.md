# Topic 9.3 - 函数的高级用法（补充）

## 1. 函数的嵌套

### (1) 在函数内部定义函数

在 Python 中，我们可以在函数内部定义另一个函数，我们来看一个简单的例子：

```python
def calculate(a, b):

    def add(x, y):
        sum_result = x + y
        return sum_result

    def subtract(x, y):
        diff_result = x - y
        return diff_result

    sum_result = add(a, b)
    diff_result = subtract(a, b)
    
    return sum_result, diff_result

a = 10
b = 5
result = calculate(a, b)
print(f"{a}与{b}的和与差分别是:", result)
```

```text
10与5的和与差分别是: (15, 5)
```

在这个例子中，`calculate` 函数内部定义了两个函数 `add` 和 `subtract`，和局部变量一样，这两个函数只能在 `calculate` 函数内部使用，外部无法访问：

```python
print(add(3, 4))  # 这会报错，因为 add 函数是局部函数
```

```text
NameError: name 'add' is not defined
```

注意，在函数内部定义函数，其实是不推荐的：

- 一是因为，函数不像变量那样只是一个临时储存数据的容器，而是一个可以重复使用的工具，最好是可以让所有函数之间共享使用，好东西最好是大家一起分享
- 二是因为，函数嵌套会导致变量作用域变得复杂，我们马上会讲到

### (2) 使用 `nonlocal` 关键字

在函数内部定义函数的概念相信大家比较好理解，但是如果我们定义了多层函数嵌套，这时候变量的作用域就会变得比较复杂。

比方说我们定义了一个两层嵌套的函数，那么此时函数的作用域就有三层：

- 全局作用域
- 外层函数的局部作用域
- 内层函数的局部作用域

在 Python 中，在两层嵌套函数的情境下：

- 外层函数访问全局变量要使用 `global` 关键字
- 内层函数访问外层函数变量要使用 `nonlocal` 关键字

我们先来看一个内层函数访问外层函数变量的例子：

```python
def outer_function_v1():

    outer_var = 10  # 外层函数的局部变量
    print("外层函数变量原始值:", outer_var)

    def inner_function_v1():
        nonlocal outer_var  # 声明 outer_var 是外层函数的变量
        outer_var = 20  # 修改外层函数的变量
        print("内层函数访问并修改的外层变量:", outer_var)

    inner_function_v1()
    print("外层函数再次访问外层变量:", outer_var)

outer_function_v1()
```

```text
外层函数变量原始值: 10
内层函数访问并修改的外层变量: 20
外层函数再次访问外层变量: 20
```

我们再来看一个内层函数访问全局变量的例子：

```python
global_var = 100
print("全局变量初始值:", global_var)

def outer_function_v2():

    def inner_function_v2():
        global global_var  # 声明 global_var 是全局变量
        global_var = 200
        print("内层函数访问并修改后的全局变量:", global_var)

    inner_function_v2()
    print("外层函数访问全局变量:", global_var)

outer_function_v2()
print("函数外部访问全局变量:", global_var)
```

```text
全局变量初始值: 100
内层函数访问并修改后的全局变量: 200
外层函数访问全局变量: 200
函数外部访问全局变量: 200
```

我们再来看一个全局变量先由外层函数修改，然后由内层函数修改的例子：

```python
global_var = 100
print("全局变量初始值:", global_var)

def outer_function_v3():
    global global_var  # 声明 global_var 是全局变量
    global_var = 200
    print("外层函数修改后的全局变量:", global_var)

    def inner_function_v3():
        global global_var  # 声明 global_var 是全局变量
        global_var = 300
        print("内层函数修改后的全局变量:", global_var)

    inner_function_v3()
    print("外层函数再次访问全局变量:", global_var)

outer_function_v3()
print("函数外部访问全局变量:", global_var)
```

```text
全局变量初始值: 100
外层函数修改后的全局变量: 200
内层函数修改后的全局变量: 300
外层函数再次访问全局变量: 300
函数外部访问全局变量: 300
```

注意，在全局变量先传进外层函数，再传进内层函数的情境下，两层函数使用的都是 `global` 关键字

- 有些同学会误以为，全局变量先传进外层函数用 `global`，之后全局变量就会变成外层函数的局部变量，之后再传进内层函数就应该用 `nonlocal`
- 其实不然，使用 `global` 还是 `nonlocal`，取决于变量最初定义的位置，而不是变量传递的位置

在上面那个例子中，如果内层函数错误地使用了 `nonlocal` 关键字，Python 就会报 `no binding` 错误：

```python
global_var = 100
print("全局变量初始值:", global_var)

def outer_function_v3():

    global global_var  # 声明 global_var 是全局变量
    global_var = 200
    print("外层函数修改后的全局变量:", global_var)

    def inner_function_v3():
        nonlocal global_var  # 声明 global_var 是外层函数的变量
        global_var = 300
        print("内层函数修改后的全局变量:", global_var)

    inner_function_v3()
    print("外层函数再次访问全局变量:", global_var)

outer_function_v3()
print("函数外部访问全局变量:", global_var)
```

```text
SyntaxError: no binding for nonlocal 'global_var' found
```

讲到这里，估计有些同学已经头大了：

- 如果你听懂了，那很棒，那说明你理解能力很强
- 如果你没听懂，也很棒，因为你已经意识到这个概念比较复杂，以后就**少用函数嵌套**😏


## 2. 可变参数类型与不可变参数类型

注意⚠️：

- 我们这里讨论的参数类型，和作用域（全局变量和局部变量）是不同的概念
- 我们在这一节设定的情景是，在函数外部定义一个变量，再将这个变量传到函数内部作为**参数**使用。

在 Python 中，参数类型可以分为可变类型和不可变类型

- 不可变类型：整数（`int`）、浮点数（`float`）、字符串（`str`）、元组（`tuple`）
- 可变类型：列表（`list`）、字典（`dict`）、集合（`set`）

当我们将不可变类型作为参数传递给函数时，函数内部对参数的修改不会影响到外部的变量

```python
def modify_immutable(x):
    x = x + 10
    print("函数内部修改后的值:", x)

x = 5
modify_immutable(x)
print("函数外部的值:", x)
```

```text
函数内部修改后的值: 15
函数外部的值: 5
```

当我们将可变类型作为参数传递给函数时，函数内部对参数的修改会影响到外部的变量

```python
def modify_mutable(lst):
    lst.append(4)
    print("函数内部修改后的列表:", lst)

my_list = [1, 2, 3]
modify_mutable(my_list)
print("函数外部的列表:", my_list)
```

```text
函数内部修改后的列表: [1, 2, 3, 4]
函数外部的列表: [1, 2, 3, 4]
```

## 3. 多值参数

我们之前接触过几个 Python 内置函数，比如说 `print()`、`max()`、`min()` 等等，这些参数都有一个特点，我们以 `max()` 函数为例：

```python

print(max(3, 5))
print(max(3, 5, 2, 8, 1))
print(max(3, 5, 2, 8, 1, 10, 4))
```

```text
5
8
10
```

我们会发现 `max()` 函数可以接受任意数量的参数，这种参数我们称之为**多值参数**。

我们在自定义函数中能不能也实现类似的功能呢？答案是肯定的，我们可以在定义函数的时候使用多值参数。

### (1) 多值元组参数

多值元组参数的语法格式如下：

```python
def 函数名(*参数名):
    函数体
```

在这里，参数名前的 `*` 表示这个参数可以接受任意数量的值，这些值会被打包成一个元组（`tuple`）传递给函数

- 通常我们给这个参数起名为 `*args`，这个是一个约定俗成的名字
- 但是，要知道，这个名字并不是必须的，你可以使用任何合法的变量名，只要前面有 `*` 就行

例如，我们定义一个函数来计算任意数量数字的和：

```python
def sum_numbers(*numbers):
    total = 0
    for num in numbers:
        total += num
    return total

print(sum_numbers(1, 2, 3))
print(sum_numbers(10, 20, 30, 40, 50))
print(sum_numbers(5, 15))
```

```text
6
150
20
```

在这个代码中，`*numbers` 就是一个多值元组参数

- 在函数内部，`numbers` 就是一个元组，包含了所有传入的参数值
- 我们可以使用 `for` 循环来遍历这个元组，计算它们的和


### (2) 多值字典参数

除了多值元组参数，我们还可以定义多值字典参数，语法格式如下：

```python
def 函数名(**参数名):
    函数体
```

在这里，参数名前的 `**` 表示这个参数可以接受任意数量的键值对，这些键值对会被打包成一个字典（`dict`）传递给函数

- 在这个字典中，参数名就是键（参数名会转换为字符串），参数值就是值
- 通常我们给这个参数起名为 `**kwargs`，这个是一个约定俗成的名字
- 同样，这个名字并不是必须的，你可以使用任何合法的变量名，只要前面有 `**` 就行

例如，我们定义一个函数来展示个人信息：

```python
def print_person_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_person_info(name="张三", age=30, gender="男")
print_person_info(name="李四", married=False, city="北京")
```

```text
name: 张三
age: 30
gender: 男
name: 李四
married: False
city: 北京
```

在这个代码中，`**kwargs` 就是一个多值字典参数

- 在函数内部，`kwargs` 就是一个字典，包含了所有传入的键值对（键是参数名转为的字符串，值是参数值）
- 我们可以使用 `for` 循环来遍历这个字典，打印每个键值对

### (3) 同时使用多值元组参数和多值字典参数

我们可以在一个函数中同时使用普通参数、多值元组参数、以及多值字典参数，语法格式如下：

```python
def 函数名(普通参数, *多值元组参数, **多值字典参数):
    函数体
```

例如，我们定义一个函数来展示学生信息：

```python
def print_student_info_v1(name, age, *scores, **info):
    
    print(f"姓名: {name}")
    print(f"年龄: {age}")
    
    print(f"总成绩: {sum(scores)}")

    for key, value in info.items():
        print(f"{key}: {value}")

print_student_info_v1("小明", 18, 90, 85, 88, city="北京", major="管理学")
```

```text
姓名: 小明
年龄: 18
总成绩: 263
城市: 北京
专业: 管理学
```

这里我们可以看到，函数在调用的时候，Python 会按顺序对应参数

- 第一个接收到的参数是 `"小明"`，就对应到 `name`
- 第二个接收到的参数是 `18`，就对应到 `age`
- 接下来所有没有参数名的参数 `90, 85, 88`，就会被打包成一个元组，传递给 `*scores`
- 最后所有带参数名的参数 `city="北京", major="管理学"`，就会被打包成一个字典，传递给 `**info`

因此，我们在普通参数与多值参数混用时，不推荐给普通参数设置默认值，因为这会导致一些混乱的情况，我们来看以下例子：

```python
def print_student_info_v2(name, age=18, *scores, **info):
    
    print(f"姓名: {name}")
    print(f"年龄: {age}")
    
    print(f"总成绩: {sum(scores)}")

    for key, value in info.items():
        print(f"{key}: {value}")

print_student_info_v2("小明", 90, 85, 88, city="北京", major="管理学")
```

```text
姓名: 小明
年龄: 90
总成绩: 173
城市: 北京
专业: 管理学
```

在这个例子中，我们的本意是想让 `age` 使用默认值 `18`

- 但是函数在调用的时候，Python 分不清楚 `90` 是传递给 `age` 还是传递给 `*scores`，于是默认选择将 `90` 传递给 `age`

- 这样就导致 `age` 的值变成了 `90`，而不是我们想要的默认值 `18`，与我们的预期不符

- 因此，为了避免这种混乱的情况，我们推荐在使用多值参数时，最好不要给普通参数设置默认值