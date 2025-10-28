# Topic 11.3 - 认识其他的文件类型（补充）

## 1. JSON 文件

JSON（JavaScript Object Notation）以 `.json` 作为文件扩展名，也是一种文本文件格式，当中存储的结构化数据类似于 Python 中列表套字典的数据格式。

我们本节使用一个名为 `data.json` 的 JSON 文件作为例子，文件内容如下：

```json
[
    {
        "name": "Alice",
        "age": 30,
        "is_student": false,
        "courses": ["Math", "Science", "Art"],
        "address": {
            "street": "123 A St",
            "city": "City A"
        }
    },
    {
        "name": "Bob",
        "age": 25,
        "is_student": true,
        "courses": ["History", "Literature"],
        "address": {
            "street": "456 B St",
            "city": "City B"
        }
    }
]
```

Python 提供了内置的 `json` 模块来处理 JSON 文件的读写操作，其中最重要的两个函数是：

- `json.load()`：用于从文件中读取 JSON 数据并将其转换为 Python 对象
- `json.dump()`：用于将 Python 对象转换为 JSON 格式并写入文件

### (1) 读取 JSON 文件

我们先来看一个读取 JSON 文件的例子：

```python
import json

# 读取 JSON 文件
with open("Topic11/Topic11_03/data.json", "r") as file:
    content = file.read()

# 读取文件内容
print("读取的文件内容:")
print(content)
print(type(content))

# 将 JSON 字符串转换为 Python 对象
print("\n转换为 Python 对象:")
data = json.loads(content)
print(data)
print(type(data))  
print(type(data[0])) 
print(data[0]["name"])
```

```text
[
    {
        "name": "Alice",
        "age": 30,
        "is_student": false,
        "courses": ["Math", "Science", "Art"],
        "address": {
            "street": "123 A St",
            "city": "City A"
        }
    },
    {
        "name": "Bob",
        "age": 25,
        "is_student": true,
        "courses": ["History", "Literature"],
        "address": {
            "street": "456 B St",
            "city": "City B"
        }
    }
]
<class 'str'>

转换为 Python 对象:
[{'name': 'Alice', 'age': 30, 'is_student': False, 'courses': ['Math', 'Science', 'Art'], 'address': {'street': '123 A St', 'city': 'City A'}}, {'name': 'Bob', 'age': 25, 'is_student': True, 'courses': ['History', 'Literature'], 'address': {'street': '456 B St', 'city': 'City B'}}]
<class 'list'>
<class 'dict'>
Alice
```

通过上段代码可以看到：

- JSON 文件刚读取出来的内容是一个字符串
- 使用 `json.loads()` 函数可以将 JSON 字符串转换为 Python 对象：转换后的 Python 对象是一个列表，列表中的每个元素是一个字典
- 之后我们就可以通过列表和字典的操作方法来访问和操作这些数据了

注意：

- JSON 文件中的布尔值是 `true` 和 `false`，而在 Python 中对应的是 `True` 和 `False`
- 而且，JSON 文件中的 `null` 对应的是 Python 中的 `None`
- 但是大家不用担心，`json` 模块会自动帮我们处理这些差异

### (2) 写入 JSON 文件

同样的道理，如果我们在 Python 中有一个列表套字典的结构，也是可以保存为 JSON 文件的，我们再来看一个写入 JSON 文件的例子：

```python
import json

# 定义一个列表套字典的结构
data = [
    {
        "name": "Charlie",
        "age": 28,
        "is_student": False,
        "courses": ["Physics", "Chemistry"],
        "address": {
            "street": "789 C St",
            "city": "City C"
        }
    },
    {
        "name": "Diana",
        "age": 22,
        "is_student": True,
        "courses": ["Biology", "Geography"],
        "address": {
            "street": "101 D St",
            "city": "City D"
        }
    }
]

# 将 Python 对象转换为 JSON 字符串
print("转换为 JSON 字符串:")
json_data = json.dumps(data, indent=4, ensure_ascii=False)
print(json_data)
print(type(json_data))

# 将 JSON 字符串写入文件
with open("Topic11/Topic11_03/data1.json", "w") as file:
    file.write(json_data)

```

```text
转换为 JSON 字符串:
[
    {
        "name": "Charlie",
        "age": 28,
        "is_student": false,
        "courses": [
            "Physics",
            "Chemistry"
        ],
        "address": {
            "street": "789 C St",
            "city": "City C"
        }
    },
    {
        "name": "Diana",
        "age": 22,
        "is_student": true,
        "courses": [
            "Biology",
            "Geography"
        ],
        "address": {
            "street": "101 D St",
            "city": "City D"
        }
    }
]
<class 'str'>
```

之后我们可以打开 `data1.json` 文件查看写入的内容，内容如下：

```json
[
    {
        "name": "Charlie",
        "age": 28,
        "is_student": false,
        "courses": [
            "Physics",
            "Chemistry"
        ],
        "address": {
            "street": "789 C St",
            "city": "City C"
        }
    },
    {
        "name": "Diana",
        "age": 22,
        "is_student": true,
        "courses": [
            "Biology",
            "Geography"
        ],
        "address": {
            "street": "101 D St",
            "city": "City D"
        }
    }
]

```

通过上段代码可以看到：

- 我们先定义了一个 Python 中的列表套字典的结构，
- 之后使用 `json.dumps()` 函数可以将这个 Python 对象转换为 JSON 字符串
- 最终写入到 JSON 文件中的是这个 JSON 字符串

再次注意：

- JSON 文件中的布尔值是 `true` 和 `false`，而在 Python 中对应的是 `True` 和 `False`
- JSON 文件中的 `null` 对应的是 Python 中的 `None`
- 大家在 Python 中还是要使用 `True`、`False` 和 `None`，之后 `json` 模块会自动帮我们处理这些差异

## 2. CSV 文件

CSV（Comma-Separated Values）以 `.csv` 作为文件扩展名，是一种以逗号分隔值的文本文件格式，通常用于存储表格数据。

CSV 文件大家应该都不陌生，Excel 就可以直接打开 CSV 文件

- 但是 Excel 打开 CSV 文件时，已经自动帮我们把 CSV 文件转换为表格形式了
- 大家要知道 CSV 文件其实是一个纯文本文件
- 我们这节使用一个 `student.csv` 的文件，打开我们就可以看到 CSV 文件本来的形式：

```csv
name,age,is_student,courses,address_street,address_city
Alice,30,False,"Math;Science;Art","123 A St","City A"
Bob,25,True,"History;Literature","456 B St","City B"
```

Python 提供了内置的 `csv` 模块来处理 CSV 文件的读写操作，其中最重要的两个是：

- `csv.reader`：用于读取 CSV 文件
- `csv.writer`：用于写入 CSV 文件

CSV 文件的读取与处理通常使用比较强大的第三方库 `pandas` 来完成，我们在后续的 Python 数据分析课程中还会详细介绍，这里我们先简单介绍一下 Python 内置`csv` 模块的使用。


### (1) 读取 CSV 文件

我们先来看一个读取 CSV 文件的例子：

```python
import csv

with open("Topic11/Topic11_03/student.csv", "r") as file:
    reader = csv.reader(file)
    header = next(reader)
    print(header)
    for row in reader:
        print(row)
```

```text
['name', 'age', 'is_student', 'courses', 'address_street', 'address_city']
['Alice', '30', 'False', 'Math;Science;Art', '123 A St', 'City A']
['Bob', '25', 'True', 'History;Literature', '456 B St', 'City B']
```

通过上段代码可以看到：

- 使用 `csv.reader` 可以读取 CSV 文件，返回一个可迭代的 `reader` 对象
- 如果 CSV 文件第一行是表头，我们使用 `next(reader)` 可以读取 CSV 文件的表头，返回的是一个列表，当中的元素是字符串形式
- 之后可以通过遍历 `reader` 对象来逐行读取 CSV 文件的内容，每一行的数据也是以列表的形式返回，当中的元素也是字符串形式

可以看到，`csv.reader` 其实用起来并不太智能：

- 首先，我们读取 CSV 文件时，所有的数据都是字符串形式的，如果需要其他数据类型，需要我们手动转换
- 其次，这个 CSV 文件中，`courses` 列的数据是以分号 `;` 分隔的多个课程，如果需要把这些课程转换为列表，也需要我们手动处理
- 还有就是每行要单独读取，如果想把每行的数据综合到一个列表中，也需要我们手动处理

以下是一个改进版的读取 CSV 文件的例子：

```python
import csv

data_list = []

with open("Topic11/Topic11_03/student.csv", "r") as file:
    reader = csv.reader(file)
    header = next(reader)
    for row in reader:
        dt_name = row[0]
        dt_age = int(row[1])
        dt_is_student = True if row[2] == "True" else False
        dt_courses = row[3].split(";")
        dt_address = {"street": row[4], "city": row[5]}
        dt_result = {
            "name": dt_name,
            "age": dt_age,
            "is_student": dt_is_student,
            "courses": dt_courses,
            "address": dt_address
        }
        data_list.append(dt_result)

print(data_list)
```

```text
[{'name': 'Alice', 'age': 30, 'is_student': False, 'courses': ['Math', 'Science', 'Art'], 'address': {'street': '123 A St', 'city': 'City A'}}, {'name': 'Bob', 'age': 25, 'is_student': True, 'courses': ['History', 'Literature'], 'address': {'street': '456 B St', 'city': 'City B'}}]
```

### (2) 写入 CSV 文件

同样，`csv.writer` 也不是特别智能，这个函数会接受一个列表，作为写入文件的一行，而且只支持一次写入一行：

我们来看一个写入 CSV 文件的例子：

```python
import csv

data_list = [
    {
        "name": "Charlie",
        "age": 28,
        "is_student": False,
        "courses": ["Physics", "Chemistry"],
        "address": {
            "street": "789 C St",
            "city": "City C"
        }
    },
    {
        "name": "Diana",
        "age": 22,
        "is_student": True,
        "courses": ["Biology", "Geography"],
        "address": {
            "street": "101 D St",
            "city": "City D"
        }
    }
]

with open("Topic11/Topic11_03/student1.csv", "w", newline="") as file:
    
    # 创建 CSV 写入对象
    writer = csv.writer(file)
    
    # 写入表头
    header = ["name", "age", "is_student", "courses", "address_street", "address_city"]
    writer.writerow(header)

    # 写入数据
    for student in data_list:
        dt_list = [
            student["name"],
            student["age"],
            student["is_student"],
            ";".join(student["courses"]),
            student["address"]["street"],
            student["address"]["city"]
        ]
        writer.writerow(dt_list)
```

之后我们可以打开 `student1.csv` 文件查看写入的内容，内容如下：

```csv
name,age,is_student,courses,address_street,address_city
Charlie,28,False,"Physics;Chemistry","789 C St","City C"
Diana,22,True,"Biology;Geography","101 D St","City D"
```

## 3. 文本文件的本质

我们目前在 Python 中学习了三种文件的读写操作：`txt`、`json` 和 `csv` 文件：

- 这些文件都是文本文件，本质上它们都是用来存储文本数据的，在计算机眼里它们没有什么区别
- 但是为什么它们的拓展名要做出区分呢？这主要是因为强调了拓展名后可以方便我们区分文件的类型，也可以让编辑器使用合适的格式来打开这些文件

我们来看以下例子，我创建一个叫做 `example.txt` 的文本文件，内容如下：

```text
[
    {
        "name": "eve",
        "age": 29,
        "is_student": false,
        "courses": ["Philosophy", "Economics"],
        "address": {
            "street": "202 E St",
            "city": "City E"
        }
    },
    {
        "name": "Frank",
        "age": 24,
        "is_student": true,
        "courses": ["Sociology", "Psychology"],
        "address": {
            "street": "303 F St",
            "city": "City F"
        }
    }
]
```

这个文件的拓展名是 `.txt`，但是内容其实是一个 JSON 格式的数据，我们来试一试 `json` 模块能否读取这个文件：

```python
import json
with open("Topic11/Topic11_03/example.txt", "r") as file:
    content = file.read()
data = json.loads(content)
print(data)
```

```text
[{'name': 'eve', 'age': 29, 'is_student': False, 'courses': ['Philosophy', 'Economics'], 'address': {'street': '202 E St', 'city': 'City E'}}, {'name': 'Frank', 'age': 24, 'is_student': True, 'courses': ['Sociology', 'Psychology'], 'address': {'street': '303 F St', 'city': 'City F'}}]
```

我们发现：

- `json` 模块依然可以正确读取这个文件的内容，并将其转换为 Python 对象
- 说明计算机在处理文本文件时，并不关心文件的拓展名是什么，拓展名只是为了方便我们区分文件的类型而已

根据这个本质，我们可以在编辑器中创建一些奇奇怪怪的文件，它们的本质其实都是文本文件：

- `zhangsan.log`: `.log` 文件只是一个文本文件而已，常用来存储日志信息

```text
今天是个好日子，我去春熙路看了爬墙熊猫！
```

- `lisi.info`: 并没有 `.info` 这种文件格式，所以只是一个文本文件而已

```text
{
    "name": "lisi",
    "dob": "1990-05-15",
    "email": "lisi@example.com"
}
```

- `wangwu_diary`: 这个文件连拓展名都没有，所以也是一个文本文件而已

```text
今天我学习了Python的文件操作，那个老师讲的不咋地，但是长得挺帅
```

但是注意：

- 我们这里只演示文本文件的本质而已，大家以后看见别人写的奇奇怪怪的文件名时，或者你的老师老板要求你创建奇奇怪怪的文件名时，要知道它们的本质都是文本文件
- 大家还是要按照文件的实际内容来选择合适的拓展名，不然以后你的文件会变得乱七八糟，同学同事们看不懂，自己再看到也会觉得莫名其妙

## 4. 其他类型的文件

我们上面讲的文本文件的本质只针对文本文件而言，计算机中还有很多其他类型的文件，比如：

- 图片：常见的有 `.jpg`、`.png`、`.gif` 等格式，存储的是**像素矩阵**，每个像素点由 RGB 三个颜色通道的值组成
- 音频：常见的有 `.mp3`、`.wav` 等格式，存储的是**声音波形数据**，通过采样率和位深度来表示声音的细节
- 视频：常见的有 `.mp4`、`.avi` 等格式，存储的是**连续的图像帧**和**音频数据**，通过帧率来表示视频的流畅度
- Word、Excel、PowerPoint：本质上是一个包含了**文本、表格、样式、图像等多种数据的复合文件**，使用特定的二进制格式或XML格式来存储
- PDF：全称为 Portable Document Format，由文本部分（使用指令描述文字位置和字体）与图像部分（嵌入JPEG或其他格式的图像）组成

这些文件是无论如何也无法用文本文件的方式来处理的，因为它们的本质并不是文本文件。