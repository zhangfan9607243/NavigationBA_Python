# Topic 5.4 - 组合数据类型之字典

## 1. 字典的基本概念

### (1) 字典的定义

字典 (dictionary) 是 Python 中的另一种**可变的**组合数据类型，用来存储一组**键值对** (key-value pairs)

- 字典的定义格式是使用大括号 `{}`，并且用冒号 `:` 分隔键和值，逗号分隔 `,` 每对键值对，键必须是唯一的，且**键的类型只能是数字、字符串、元组**：

```python
dict1 = {"name": "Alice", "age": 30, "city": "New York"}
print(dict1)
print(type(dict1))
```

```text
{'name': 'Alice', 'age': 30, 'city': 'New York'}
<class 'dict'>
```

- 如果我们定义一个空字典，可以使用 `{}`，也可以使用 `dict()`：

```python
dict2 = {}
print(dict2)
print(type(dict2))

dict3 = dict()
print(dict3)
print(type(dict3))
```

```text
{}
<class 'dict'>
{}
<class 'dict'>
```

### (2) 字典的特点

Python 中的字典，和大家在现实生活中使用的字典是类似的，现实的字典当中，每个单词都是一个键 (key)，而单词的解释就是这个键对应的值 (value)

现实中的字典有两个重要特点，这两个特点在 Python 中是类似的：

- 一是，字典中的**键是唯一不可重复的**，例如，字典中不可能有两个 "banana" 这个单词，因为 "banana" 所有的意思都会在同一个条目下面进行解释
- 二是，字典中的**键值对是无序的**，例如，我们不能说 "abondon" 这个单词是字典中的第1个单词，因为如果哪天字典中新增了一个比 "abondon" 还靠前的单词，那么 "abondon" 的位置就变了

## 2. 字典的基本操作

### (1) 访问字典中的值

访问字典中的值，是通过键 (key) 来实现的，格式是 `字典[键]`：

```python
dict1 = {"name": "Alice", "age": 30, "city": "New York"}
print(dict1["name"])
print(dict1["age"])
print(dict1["city"])
```

```text
Alice
30
New York
```

```python
print(dict1["gender"])  # 访问不存在的键会报错
```

```text
KeyError: 'gender'
```

由于字典是无序的，因此不支持数字索引，也不支持切片操作

### (2) 修改字典中的值

修改字典中的值，也可以通过键 (key) 来实现，格式是 `字典[键] = 新值`：

```python
dict1 = {"name": "Alice", "age": 30, "city": "New York"}
print(dict1)
dict1["age"] = 31
print(dict1)
```

```text
{'name': 'Alice', 'age': 31, 'city': 'New York'}
``` 

### (3) 字典的常用函数

Python 中适用与字典的内置函数，常用的只有 `len(字典)`，用来返回字典中键值对的数量：

```python
dict1 = {"name": "Alice", "age": 30, "city": "New York"}
print(len(dict1))
```

```text
3
```

### (4) 字典的常用方法

Python 中字典的内置方法，常用的有以下几个：

#### (a) 键值对提取类

- `字典.keys()`：返回字典中所有的键，类型是 `dict_keys`，可以使用 `list()` 函数把它转换成列表
- `字典.values()`：返回字典中所有的值，类型是 `dict_values`，可以使用 `list()` 函数把它转换成列表
- `字典.items()`：返回字典中所有的键值对，类型是 `dict_items`，可以使用 `list()` 函数把它转换成列表

```python
dict2 = {"name": "Bob", "age": 25, "city": "Los Angeles"}

dict2_keys = dict2.keys()
dict2_values = dict2.values()
dict2_items = dict2.items()

print(dict2_keys)
print(dict2_values)
print(dict2_items)

print(type(dict2_keys))
print(type(dict2_values))
print(type(dict2_items))

dict2_keys_list = list(dict2_keys)
dict2_values_list = list(dict2_values)
dict2_items_list = list(dict2_items)

print(dict2_keys_list)
print(dict2_values_list)
print(dict2_items_list)

print(type(dict2_keys_list))
print(type(dict2_values_list))
print(type(dict2_items_list))

print(dict2_items_list[0])
print(type(dict2_items_list[0]))
```

```text
dict_keys(['name', 'age', 'city'])
dict_values(['Bob', 25, 'Los Angeles'])
dict_items([('name', 'Bob'), ('age', 25), ('city', 'Los Angeles')])
<class 'dict_keys'>
<class 'dict_values'>
<class 'dict_items'>
['name', 'age', 'city']
['Bob', 25, 'Los Angeles']
[('name', 'Bob'), ('age', 25), ('city', 'Los Angeles')]
<class 'list'>
<class 'list'>
<class 'list'>
('name', 'Bob')
<class 'tuple'>
```

#### (b) 增删改查类

- `字典.get(键, 默认值)`：返回指定键对应的值，如果键不存在则返回默认值
- `字典.pop(键, 默认值)`：删除指定键对应的键值对，并返回对应的值，如果键不存在则返回默认值
- `字典.update(另一个字典)`：使用另一个字典中的键值对来更新当前字典，如果键已存在则更新其值，否则添加新的键值
- `字典.clear()`：清空字典  

```python
dict3 = {"name": "Charlie", "age": 28, "city": "Chicago"}

print(dict3)
print(dict3.get("age"))
print(dict3.get("gender", "Not Specified"))

removed_value1 = dict3.pop("city")
removed_value2 = dict3.pop("country", "Not Specified")

print(removed_value1)
print(removed_value2)
print(dict3)

dict3.update({"age": 29, "country": "USA"})
dict3.update({"name": "Charlie Smith"})
print(dict3)

dict3.clear()
print(dict3)
```

```text
{'name': 'Charlie', 'age': 28, 'city': 'Chicago'}
28
Not Specified
Chicago
Not Specified
{'name': 'Charlie', 'age': 28}
{'name': 'Charlie Smith', 'age': 29, 'country': 'USA'}
{}
```

这里我们发现，使用 `字典.update()` 方法也可以更新指定的键值对，这里我们就总结一下更新特定键值对的2种方式：

- 直接通过 `字典[键] = 新值` 的方式更新
-  使用 `字典.update({键: 新值})` 的方式更新

```python
dict4 = {"name": "David", "age": 35, "city": "San Francisco"}
print(dict4)
dict4["age"] = 36
print(dict4)
dict4.update({"name": "David Johnson"})
print(dict4)
```

```text
{'name': 'David', 'age': 35, 'city': 'San Francisco'}
{'name': 'David', 'age': 36, 'city': 'San Francisco'}
{'name': 'David Johnson', 'age': 36, 'city': 'San Francisco'}
```

## 3. 字典的二维数据类型

类似与列表的嵌套，字典也常常用来存储二维数据，常见的形式有以下几种：

- 字典嵌套字典：字典的值是另一个字典
- 字典嵌套列表：字典的值是一个列表
- 列表嵌套字典：列表的元素是字典

```python
# 字典嵌套字典
scores1 = {
    "Alice": {"Math": 90, "English": 85, "Science": 88},
    "Bob": {"Math": 78, "English": 82, "Science": 80},
    "Charlie": {"Math": 85, "English": 87, "Science": 90}
}

# 字典嵌套列表
scores2 = {
    "Alice": [90, 85, 88],
    "Bob": [78, 82, 80],
    "Charlie": [85, 87, 90]
}

# 列表嵌套字典
scores3 = [
    {"name": "Alice", "Math": 90, "English": 85, "Science": 88},
    {"name": "Bob", "Math": 78, "English": 82, "Science": 80},
    {"name": "Charlie", "Math": 85, "English": 87, "Science": 90}
]
```

## 4. 字典综合练习

### (1) 学生信息管理

- 要求：

    - 定义一个字典套字典的数据格式，存储3个学生的姓名、年龄和城市信息：

```python
students = {
    "student1": {"name": "Alice", "age": 18, "city": "New York"},
    "student2": {"name": "Bob", "age": 19, "city": "Los Angeles"},
    "student3": {"name": "Charlie", "age": 20, "city": "Chicago"}
}
```

    - 完成以下操作：
    - (1) 访问并打印第2个学生的姓名
    - (2) 修改第1个学生的年龄为20岁
    - (3) 删除第3个学生的城市信息

- 参考代码

```python
students = {
    "student1": {"name": "Alice", "age": 18, "city": "New York"},
    "student2": {"name": "Bob", "age": 19, "city": "Los Angeles"},
    "student3": {"name": "Charlie", "age": 20, "city": "Chicago"}
}
# (1) 访问并打印第2个学生的姓名
print(students["student2"]["name"])
# (2) 修改第1个学生的年龄为20岁
students["student1"]["age"] = 20
print(students["student1"])
# (3) 删除第3个学生的城市信息
students["student3"].pop("city")
print(students["student3"])
```

```text
Bob
{'name': 'Alice', 'age': 20, 'city': 'New York'}
{'name': 'Charlie', 'age': 20}
```

### (2) 学生成绩管理

- 要求：

    - 定义一个字典套列表的数据格式，存储3个学生的姓名和他们的语文、数学、英语成绩：

```python

scores = {
    "Alice": [90, 85, 88],
    "Bob": [78, 82, 80],
    "Charlie": [85, 87, 90]
}
```

    - 完成以下操作：
    - (1) 访问并打印 Bob 的英语成绩
    - (2) 修改 Alice 的数学成绩为95分
    - (3) 计算Bob的平均成绩并打印
    - (4) 计算所有学生的平均语文成绩并打印

- 参考代码

```python
scores = {
    "Alice": [90, 85, 88],
    "Bob": [78, 82, 80],
    "Charlie": [85, 87, 90]
}
# (1) 访问并打印 Bob 的英语成绩
print(scores["Bob"][2])
# (2) 修改 Alice 的数学成绩为95分
scores["Alice"][1] = 95
print(scores["Alice"])
# (3) 计算Bob的平均成绩并打印
average_bob = sum(scores["Bob"]) / len(scores["Bob"])
print("Bob的平均成绩:", average_bob)
# (4) 计算所有学生的平均语文成绩并打印
average_chinese = (scores["Alice"][0] + scores["Bob"][0] + scores["Charlie"][0]) / len(scores)
print("全班的语文平均成绩:", average_chinese)
```

```text
80
[90, 95, 88]
Bob的平均成绩: 80.0
全班的语文平均成绩: 84.33333333333333
```
