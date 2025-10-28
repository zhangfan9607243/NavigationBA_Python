# Topic 8.3 - `for` 循环的高级用法（补充）

## 1. `for` 循环推导式

Python 提供了一种简洁的语法来创建列表、集合和字典，称为推导式（comprehension），推导式可以让我们用更少的代码实现同样的功能。

### (1) 列表推导式

列表推导式的语法格式如下：

```python
[表达式 for 变量 in 可迭代对象]
```

- 我们先来看一个例子，假设我们有一个包含数字的列表，我们想要创建一个新的列表，包含这些数字的平方：

```python
numbers = [2, 5, 7, 9, 11]
numbers_squares = [x**2 for x in numbers]
print(numbers_squares)
```

```text
[4, 25, 49, 81, 121]
```

- 如果使用传统的 `for` 循环来实现同样的功能，代码会显得冗长一些：

```python
numbers = [2, 5, 7, 9, 11]
numbers_squares = []
for x in numbers:
    numbers_squares.append(x**2)
print(numbers_squares)
```

```text
[4, 25, 49, 81, 121]
```

- 可以看到，列表推导式十分简洁明了地就完成了一个 `for` 循环的功能

在推导式中，我们还可以添加条件语句来过滤元素，语法格式如下：

```python
[表达式 for 变量 in 可迭代对象 if 条件]
```

- 例如，我们想要创建一个包含平方数的列表，但是我们只想要偶数的平方，可以这样写：

```python
numbers = [2, 5, 7, 9, 11]
number_squares = [x**2 for x in numbers if x % 2 == 0]
print(number_squares)
```

```text
[4]
```

- 传统的 `for` 循环实现同样功能的代码如下：

```python
numbers = [2, 5, 7, 9, 11]
number_squares = []
for x in numbers:
    if x % 2 == 0:
        number_squares.append(x**2)
print(number_squares)
```

```text
[4]
```

### (2) 集合推导式

除了列表推导式以外，Python 还支持集合推导式来创建集合，语法格式如下：

```python
{表达式 for 变量 in 可迭代对象 if 条件}
```

- 例如，我们想要创建一个包含数字平方的集合，并且只包含偶数的平方：

```python
numbers = [2, 5, 7, 9, 11]
number_squares_set = {x**2 for x in numbers if x % 2 == 0}
print(number_squares_set)
```

```text
{4}
```

### (3) 字典推导式

字典同样支持推导式的形式来创建，但是语法格式要稍微复杂一些：

```python
{键表达式: 值表达式 for 变量 in 可迭代对象 if 条件}
```

- 例如，我们想要创建一个字典，键是数字，值是数字的平方：

```python
numbers = [2, 5, 7, 9, 11]
number_squares_dict = {x: x**2 for x in numbers}
print(number_squares_dict)
```

```text
{2: 4, 5: 25, 7: 49, 9: 81, 11: 121}
```

- 再来看一个例子，我们想根据两个列表创建一个字典，键是名字，值是对应的年龄：

```python
names = ['张三', '李四', '王五']
ages = [18, 20, 22]
name_age_dict = {names[i]: ages[i] for i in range(len(names))}
print(name_age_dict)
```

```text
{'张三': 18, '李四': 20, '王五': 22}
```

### (4) 嵌套推导式

推导式还可以嵌套使用，其基于的逻辑就是 `for` 循环的嵌套：

- 嵌套推导式常常用于处理更复杂的数据结构，例如二维列表：

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
flattened = [num for row in matrix for num in row]
print(flattened)
```

```text
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```

- 它的等价传统 `for` 循环写法如下：

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
flattened = []
for row in matrix:
    for num in row:
        flattened.append(num)
print(flattened)
```

```text
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```

当然，嵌套的推导式形式就比较复杂了，大家在以后的学习中其实还是比较少见这种复杂的用法的。

## 2. `enumerate()` 函数

`enumerate()` 函数是 Python 内置的一个非常有用的函数，它经常用于 `for` 循环中，可以同时获取元素的索引和值。

我们来看一个例子：

```python
names = ['张三', '李四', '王五']
for index, name in enumerate(names):
    print(f"索引: {index}, 名字: {name}")
```

```text
索引: 0, 名字: 张三
索引: 1, 名字: 李四
索引: 2, 名字: 王五
```

从这段代码中，我们可以看到，`enumerate()` 函数返回了一个包含索引和值的二元组，我们可以通过解包的方式同时获取索引和值

- 第1圈循环时，`enumerate(names)` 给到了 `(0, '张三')`，我们分别用 `index` 和 `name` 来接收这两个值，此时 `index` 是 0，`name` 是 '张三'

- 第2圈循环时，`enumerate(names)` 给到了 `(1, '李四')`，我们分别用 `index` 和 `name` 来接收这两个值，此时 `index` 是 1，`name` 是 '李四'

- 第3圈循环时，`enumerate(names)` 给到了 `(2, '王五')`，我们分别用 `index` 和 `name` 来接收这两个值，此时 `index` 是 2，`name` 是 '王五'

`enumerate()` 函数还可以接受一个可选的参数 `start`，用于指定索引的起始值，默认是 0：

```python
names = ['张三', '李四', '王五']
for index, name in enumerate(names, start=1):
    print(f"索引: {index}, 名字: {name}")
```

```text
索引: 1, 名字: 张三
索引: 2, 名字: 李四
索引: 3, 名字: 王五

在指定了 `start=1` 后，索引就不再是 0,1,2，而是 1,2,3 了
```

## 3. `zip()` 函数

在上一节，我们做了一道练习题：

- 要求：

    - 以下是几个学生信息的列表：

```python
names = ["Alice Smith", "Bob Johnson", "Charlie Lee"]
ages = [20, 20, 21]
genders = ["Female", "Male", "Male"]
citys = ["New York", "Los Angeles", "Chicago"]
```

    - 将所有学生信息整理到一个列表套字典的数据格式当中，形式如下：

```python
[
    {"First Name": "Alice", "Last Name": "Smith", "age": 20, "gender": "Female", "city": "New York"},
    {"First Name": "Bob", "Last Name": "Johnson", "age": 20, "gender": "Male", "city": "Los Angeles"},
    {"First Name": "Charlie", "Last Name": "Lee", "age": 21, "gender": "Male", "city": "Chicago"}
]
```

- 我们当时的解法是使用索引遍历的方式来做的：

```python
names = ["Alice Smith", "Bob Johnson", "Charlie Lee"]
ages = [20, 20, 21]
genders = ["Female", "Male", "Male"]
citys = ["New York", "Los Angeles", "Chicago"]

students = []

for i in range(3):
    
    full_name = names[i]
    full_name_list = full_name.split()
    first_name = full_name_list[0]
    last_name = full_name_list[1]

    age = ages[i]
    gender = genders[i]
    city = citys[i]

    student_id = f"Student {i+1}"

    student_sub_dict = {
        "First Name": first_name,
        "Last Name": last_name,
        "age": age,
        "gender": gender,
        "city": city
    }

    students.append(student_sub_dict)

print(students)
```

```text
[
    {'First Name': 'Alice', 'Last Name': 'Smith', 'age': 20, 'gender': 'Female', 'city': 'New York'},
    {'First Name': 'Bob', 'Last Name': 'Johnson', 'age': 20, 'gender': 'Male', 'city': 'Los Angeles'},
    {'First Name': 'Charlie', 'Last Name': 'Lee', 'age': 21, 'gender': 'Male', 'city': 'Chicago'}
]
```

- 我们当时在做这个练习题的时候和大家说，这道题要使用遍历索引的方式来做，因为一次的 `for` 循环无法遍历4个列表

但其实，Python 提供了一个内置函数 `zip()`，可以将多个可迭代对象“压缩”在一起，形成一个个元组，从而可以在一个 `for` 循环中同时遍历多个列表

- 如果使用 `zip()` 函数来重写上面的代码，可以如下实现：

```python
names = ["Alice Smith", "Bob Johnson", "Charlie Lee"]
ages = [20, 20, 21]
genders = ["Female", "Male", "Male"]
citys = ["New York", "Los Angeles", "Chicago"]
students = []

for name, age, gender, city in zip(names, ages, genders, citys):

    full_name_list = name.split()
    first_name = full_name_list[0]
    last_name = full_name_list[1]

    student_sub_dict = {
        "First Name": first_name,
        "Last Name": last_name,
        "age": age,
        "gender": gender,
        "city": city
    }

    students.append(student_sub_dict)

print(students)
```

```text
[
    {'First Name': 'Alice', 'Last Name': 'Smith', 'age': 20, 'gender': 'Female, 'city': 'New York'},
    {'First Name': 'Bob', 'Last Name': 'Johnson', 'age': 20, 'gender: 'Male, 'city': 'Los Angeles'},
    {'First Name': 'Charlie', 'Last Name': 'Lee', 'age': 21, 'gender': 'Male, 'city': 'Chicago'}
]
```

- 在这个例子中，`zip()` 函数将多个列表“压缩”在一起，使得我们可以在一个 `for` 循环中同时遍历多个列表:

    - `name` 变量依次获取 `names` 列表中的元素
    - `age` 变量依次获取 `ages` 列表中的元素
    - `gender` 变量依次获取 `genders` 列表中的元素
    - `city` 变量依次获取 `citys` 列表中的元素

`zip()` 函数中，如果传入的可迭代对象长度不一致，则会以最短的可迭代对象为准，超出部分会被忽略，这里就不给大家演示了，大家可以自行尝试一下。
