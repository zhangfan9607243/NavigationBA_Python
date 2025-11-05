# Topic 9.1 - 函数的基本用法

## 1. 自定义函数的定义与调用

我们目前已经学习了 Python 中的很多函数，比如 `print()`、`input()`、`len()` 等等。 这些函数都是 Python 内置的函数，直接可以使用。

但是有时候我们需要自己定义一些函数来完成特定的任务。 这时候就需要用到自定义函数。

自定义函数的语法格式如下：

```python
def 函数名():
    函数体
```

其中：

- `def` 是定义函数的关键字
- `函数名` 是你给函数起的名字，Python 推荐使用小写字母和下划线来命名函数
- `()` 用来表示这是一个函数
- `:` 表示函数体的开始
- `函数体` 是函数执行的代码块，要缩进4个空格或者1个制表符

函数在定义之后，可以通过函数名加括号来调用执行：`函数名()`，注意，函数必须先定义，后调用，并且可以多次调用。


```python
# 定义函数
def show_welcome():
    print("欢迎使用 Python 编程！")

# 调用函数
show_welcome()

# 再次调用函数
show_welcome()
```

    欢迎使用 Python 编程！
    欢迎使用 Python 编程！


## 2. 函数的参数

### (1) 函数参数的概念

有时候我们希望函数能够接受一些输入，这样函数就可以根据不同的输入执行不同的操作，这时候我们可以给函数添加参数。

函数参数的语法格式如下：

```python
def 函数名(参数1, 参数2, ...):
    函数体
```

例如，我们定义一个打招呼的函数，接受一个名字作为参数：


```python
# 定义函数，带有一个参数 name
def greet(name):
    print(f"你好，{name}！")

# 调用函数，传入参数
greet(name="小明")
greet(name="小红")
```

    你好，小明！
    你好，小红！


在这段代码中，在定义函数是，我们加入了一个参数 `name`

- 在函数体中，`name` 就可以当做一个变量来使用
- 在定义的时候，我们并不知道 `name` 会是什么值，我们是以一种占位符的形式来定义它的，也可以说“假设我们知道这个参数的值”
- 在调用函数时，我们传入了具体的值 `"小明"` 和 `"小红"`，这些值会被赋给参数 `name`，然后函数体内就带着这个值去执行

在函数调用时，可以不加入参数名，直接传入参数值，Python 会按照参数的顺序依次赋值给参数：


```python
greet("小明")
greet("小红")
```

    你好，小明！
    你好，小红！


我们再来看一个多参数的例子：


```python
# 定义函数，带有两个参数 a 和 b
def add_numbers(a, b):
    summation = a + b
    print(f"{a} 与 {b} 的和是 {summation}。")

# 调用函数，传入两个参数
add_numbers(a=3, b=5)
add_numbers(a=10, b=20)
```

    3 与 5 的和是 8。
    10 与 20 的和是 30。


在这个例子中，函数 `add_numbers` 有两个参数 `a` 和 `b`

- 在函数定义的时候，`a` 和 `b` 都是占位形式的参数
- 在函数调用的时候，我们传入了具体的数值赋给 `a` 和 `b`，然后函数体内就可以使用这两个值来执行函数体内的代码

在这个例子中，如果我们不使用参数名，直接传入参数值，效果是一样的，注意 Python 会按顺序匹配参数：


```python
add_numbers(3, 5)
add_numbers(10, 20)
```

    3 与 5 的和是 8。
    10 与 20 的和是 30。


在多个参数的情况下，有以下几点需要注意的

- 如果使用参数名，那么我们可以在传入参数的时候，打乱参数的顺序，但是不使用参数名的话就必须按照定义时的顺序传入参数
- 如果混用参数名和不使用参数名的方式传入参数，那么不使用参数名的参数必须放在前面，使用参数名的参数必须放在后面


```python
add_numbers(b=5, a=3)  # 使用参数名，可以打乱顺序
add_numbers(10, 20)    # 不使用参数名，必须按顺序
```

    3 与 5 的和是 8。
    10 与 20 的和是 30。



```python
# 混用，必须先传入不使用参数名的参数
add_numbers(3, b=5)
# 混用的错误示范，必须先传入不使用参数名的参数，以下代码会报 SyntaxError
# add_numbers(b=5, 3)     
```

    3 与 5 的和是 8。


### (2) 参数与变量的区别

我们先来看一下以下代码：


```python
# 定义函数
def show_welcome_info(name):
    print(f"您好，{name}，欢迎来到 Python 课程！")

# 调用函数
name = "小明"
show_welcome_info(name)
```

    您好，小明，欢迎来到 Python 课程！


在这段代码中，我们观察到一个现象：

- 在定义函数 `show_welcome_info` 时，参数是 `name`，在调用函数时，我们传入的也是 `name` 这个变量，但是这两个 `name` 并不是同一个东西
- 在函数定义时，`name` 是一个占位符，是函数的参数，它的值是由调用函数时传入的值决定的
- 在函数调用时，`name` 是一个变量，它的值是 `"小明"`
- 当我们调用 `show_welcome_info(name)` 时，实际上是将变量 `name` 的值 `"小明"` 传递给了函数的参数 `name`
- 由于它们两个本质上是不同的东西，所以我们给他们起相同的名字也是可以的，因为 Python 是可以自动识别它们各自的角色的

## 3. 函数的返回值

### (1) 函数返回值的概念

有时候我们希望函数在执行完毕后，能够返回一个结果，这个结果可以被一个变量接收，这时候我们可以使用 `return` 语句来实现。

函数返回值的语法格式如下：

```python
def 函数名(参数1, 参数2, ...):
    函数体
    return 返回值
```

例如，我们定义一个计算两个数乘积的函数，并返回结果：


```python
# 定义函数，带有两个参数 a 和 b，返回它们的乘积
def multiply_numbers(a, b):
    product = a * b
    return product

# 调用函数，并接收返回值
result = multiply_numbers(4, 5)
print(f"4 与 5 的乘积是 {result}。")
```

    4 与 5 的乘积是 20。


在这个例子中，函数 `multiply_numbers` 将计算好的一个结果通过 `return` 语句返回

- 在函数调用时，我们将返回值赋给了变量 `result`
- 然后我们可以使用这个变量 `result` 来打印结果

事实上，`return` 表示的是一个函数的结束，效果有点类似于循环里的 `break`

- 函数一旦执行到 `return` 语句，函数就会立即结束，并将 `return` 后面的值返回给调用者
- 如果只写一个 `return`，不指定返回值，或者函数体内没有 `return` 语句，函数默认会返回 `None`，表示什么也没有返回
- 如果 `return` 下方还有代码，这些代码是不会被执行的，可以看到编辑器会把这些代码变成灰色，提醒程序员这些代码不会被执行

我们来看以下例子：


```python
# 定义三个函数，分别展示不同的返回值情况
def test_function_v1():
    print("Hello World!")

def test_function_v2():
    print("Hello World!")
    return

def test_function_v3():
    print("Hello World!")
    return 8888
    print("Hello Python!")

# 调用函数，并接收返回值
result1 = test_function_v1()
print(f"test_function_v1 的返回值是 {result1}")

result2 = test_function_v2()
print(f"test_function_v2 的返回值是 {result2}")

result3 = test_function_v3()
print(f"test_function_v3 的返回值是 {result3}")
```

    Hello World!
    test_function_v1 的返回值是 None
    Hello World!
    test_function_v2 的返回值是 None
    Hello World!
    test_function_v3 的返回值是 8888


在这段代码中：

- 在调用 `test_function_v1` 时，函数体内只有一个 `print()` 语句，没有 `return` 语句，所以函数执行完毕后，默认返回 `None`
- 在调用 `test_function_v2` 时，函数体内有一个 `return` 语句，但是没有指定返回值，所以函数执行完毕后，返回的也是 `None`
- 在调用 `test_function_v3` 时，函数体内有一个 `return 8888` 语句，所以函数执行完毕后，返回的就是 `8888`，注意，`return` 语句后面的 `print("Hello Python!")` 不会被执行

### (2) 区分函数返回与 `print()`

很多同学在学习函数时，容易混淆 `return` 和 `print()` 的区别。这里我们再来详细解释一下：

- `return` 是用来将函数的结果返回给调用者的，可以将函数的结果赋值给一个变量，供后续使用
- `print()` 是用来在控制台输出信息的，它不会将结果返回给调用者，只是单纯地显示信息

例如，我们来看一个例子：


```python
def add_v1(a, b):
    print(a + b)

def add_v2(a, b):
    return a + b

def add_v3(a, b):
    print(a + b)
    return a + b

# 调用 add_v1
result1 = add_v1(2, 3)
print(f"add_v1 的结果是 {result1}")

# 调用 add_v2
result2 = add_v2(2, 3)
print(f"add_v2 的结果是 {result2}")

# 调用 add_v3
result3 = add_v3(2, 3)
print(f"add_v3 的结果是 {result3}")
```

    5
    add_v1 的结果是 None
    add_v2 的结果是 5
    5
    add_v3 的结果是 5


这段代码的结果有些复杂，我们来分析一下：

- 首先，我们在定义三个函数 `add_v1`、`add_v2` 和 `add_v3` 的时候，不会有任何的输出，因为函数代码只有在调用的时候执行，在定义时不会执行

- 当我们运行 `result1 = add_v1(2, 3)` 时：

    - 函数 `add_v1` 会执行 `print(a + b)`，所以会在控制台输出 `5`
    - 但是 `add_v1` 没有返回值，所以 `result1` 的值是 `None`，就代表这个函数什么也没有返回，变量也什么也没有接收到
    - 所以接着运行 `print(f"add_v1 的结果是 {result1}")` 时，输出的是 `add_v1 的结果是 None`

- 当我们运行 `result2 = add_v2(2, 3)` 时：

    - 函数 `add_v2` 会执行 `return a + b`，所以会将 `5` 返回给调用者
    - 变量 `result2` 就接收到这个返回值 `5`
    - 所以接着运行 `print(f"add_v2 的结果是 {result2}")` 时，输出的是 `add_v2 的结果是 5`

- 当我们运行 `result3 = add_v3(2, 3)` 时：

    - 函数 `add_v3` 会先执行 `print(a + b)`，所以会在控制台输出 `5`
    - 然后执行 `return a + b`，将 `5` 返回给调用者
    - 变量 `result3` 就接收到这个返回值 `5`
    - 所以接着运行 `print(f"add_v3 的结果是 {result3}")` 时，输出的是 `add_v3 的结果是 5`

所以，我们简单总结一下：

- `print()`：Python 解释器只要看到了 `print()` 语句，就会在控制台输出信息
- `return`：只有函数执行完毕后，使用 `return` 返回结果，调用者才能接收到这个结果


### (3) 函数返回值作为其他函数的参数

函数的参数其实可以是任何的表达式类型，可以直接传入数据，可以是变量，也可以是其他函数的返回值：


```python
# 定义函数
def add_numbers(a, b):
    return a + b
```


```python
# 直接传入数据
sum1 = add_numbers(10, 20)
print(sum1)
```

    30



```python
# 使用变量
x = 30
y = 40
sum2 = add_numbers(x, y)
print(sum2)
```

    70



```python
# 使用其他函数的返回值
def multiply_numbers(x, y):
    return x * y

sum3 = add_numbers(multiply_numbers(5, 6), 10)
print(sum3)
```

    40


### (4) 函数返回多个值

在 Python 中，函数可以返回多个值，这些值会被打包成一个元组返回。语法格式如下：

```python
def 函数名(参数1, 参数2, ...):
    函数体
    return 返回值1, 返回值2, ...
```

例如，我们定义一个函数，计算两个数的和与差，并返回这两个结果：


```python
# 定义函数，带有两个参数 a 和 b，返回它们的和与差
def calculate_v1(a, b):
    summation = a + b
    difference = a - b
    return summation, difference

# 调用函数，并接收返回值
sum_result, diff_result = calculate_v1(10, 5)
print(f"10 与 5 的和是 {sum_result}，差是 {diff_result}。")
```

    10 与 5 的和是 15，差是 5。


在这个例子中：

- 函数 `calculate_v1` 返回了两个值 `summation` 和 `difference`，这两个值会以一个元组的形式返回
- 函数在调用的时候，两个返回值分别赋值给 `sum_result` 和 `diff_result` 变量，这个过程叫做“拆包”

我们可以通过以下方式来验证返回值的类型：


```python
# 定义函数，带有两个参数 a 和 b，返回它们的和与差
def calculate_v2(a, b):
    summation = a + b
    difference = a - b
    return summation, difference

# 调用函数，并打印返回值的类型
results = calculate_v2(10, 5)
print(results)  
print(type(results))

print("函数返回的第一个值是：", results[0])
print("函数返回的第二个值是：", results[1])
```

    (15, 5)
    <class 'tuple'>
    函数返回的第一个值是： 15
    函数返回的第二个值是： 5


## 4. 自定义函数综合练习

### (1) 计算BMI指数

- 要求：

    - 定义一个函数 `calculate_bmi(weight, height)`，接受两个参数：体重（公斤）和身高（米）
    - 函数功能是计算并返回BMI指数，计算公式是：BMI = 体重 / (身高 * 身高)
    - 调用函数并打印结果

- 参考代码：



```python
# 定义函数
def calculate_bmi(weight, height):
    bmi = weight / (height * height)
    return bmi

# 调用函数
weight = 70
height = 1.75
bmi_value = calculate_bmi(weight, height)
print(f"一个体重为 {weight} 公斤，身高为 {height} 米的人，BMI 指数是: {round(bmi_value, 2)}")
```

    一个体重为 70 公斤，身高为 1.75 米的人，BMI 指数是: 22.86


### (2) 打印小星星

- 要求：

    - 定义一个函数 `show_stars(n)`，接受一个整数参数 `n`
    - 函数功能是打印 `n` 行小星星，每行打印的星星数量等于行号，我们之前练习过类似的代码
    - 如果 `n` 大于30，打印 "太多了，打印不完！" 并结束函数

- 参考代码：



```python
# 定义函数
def show_stars(n):
    if n > 30:
        print("太多了，打印不完！")
        return
    for i in range(1, n + 1):
        print('*' * i)
    
# 调用函数
show_stars(5)
```

    *
    **
    ***
    ****
    *****



```python
# 调用函数
show_stars(100)
```

    太多了，打印不完！


### (3) 学生信息管理

- 要求

    - 我们之前联系过一个学生信息管理的题目，假设我们有以下几个学生信息的列表：

    ```python
    names = ["Alice Smith", "Bob Johnson", "Charlie Lee"]
    ages = [20, 20, 21]
    genders = ["Female", "Male", "Male"]
    citys = ["New York", "Los Angeles", "Chicago"]
    ```

    - 我们想将所有学生信息整理到一个列表套字典的数据格式当中，形式如下：

    ```python
    [
        {"First Name": "Alice", "Last Name": "Smith", "age": 20, "gender": "Female", "city": "New York"},
        {"First Name": "Bob", "Last Name": "Johnson", "age": 20, "gender": "Male", "city": "Los Angeles"},
        {"First Name": "Charlie", "Last Name": "Lee", "age": 21, "gender": "Male", "city": "Chicago"}
    ]
    ```

    - 这次我们定义一个函数 `create_student_records(names, ages, genders, citys)`，返回一个列表套字典的数据格式，其实就是将我们之前的代码封装到函数里就行：

- 参考代码：


```python
# 定义函数
def create_student_records(names, ages, genders, citys):

    students = []

    for i in range(len(names)):
        
        full_name = names[i]
        full_name_list = full_name.split()
        first_name = full_name_list[0]
        last_name = full_name_list[1]

        age = ages[i]
        gender = genders[i]
        city = citys[i]

        student_sub_dict = {
            "First Name": first_name,
            "Last Name": last_name,
            "age": age,
            "gender": gender,
            "city": city
        }

        students.append(student_sub_dict)

    return students


# 学生信息列表
names = ["Alice Smith", "Bob Johnson", "Charlie Lee"]
ages = [20, 20, 21]
genders = ["Female", "Male", "Male"]
citys = ["New York", "Los Angeles", "Chicago"]

# 调用函数
student_records = create_student_records(names, ages, genders, citys)
print(student_records)
```

    [{'First Name': 'Alice', 'Last Name': 'Smith', 'age': 20, 'gender': 'Female', 'city': 'New York'}, {'First Name': 'Bob', 'Last Name': 'Johnson', 'age': 20, 'gender': 'Male', 'city': 'Los Angeles'}, {'First Name': 'Charlie', 'Last Name': 'Lee', 'age': 21, 'gender': 'Male', 'city': 'Chicago'}]

