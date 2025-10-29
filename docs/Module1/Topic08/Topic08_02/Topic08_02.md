# Topic 8.2 - `for` 循环的进阶用法

## 1. `for` 循环中的 `break`、`continue` 和 `else` 语句

在 Python 中，和 `while` 循环一样，`for` 循环可以与 `break`、`continue` 和 `else` 语句结合使用，以实现更复杂的控制流

- `break` 语句：用于退出整个循环
- `continue` 语句：用于跳过当前循环，继续下一次循环
- `else` 语句：当循环正常结束（没有被 `break` 中断）时执行的代码块

我们先来看一个例子，演示 `break` 和 `else` 的用法：

- 以下代码中，当遇到名字 '李四' 时，循环会被 `break` 语句中断，因此不会执行 `else` 语句块

```python
names = ['张三', '李四', '王五']
for name in names:
    if name == '李四':
        break
    print(name)
else:
    print("循环正常结束")
```

```text
张三 
```

- 如果将判断条件改为 `if name == '赵六':`，则不会触发 `break`，循环会正常结束，`else` 语句块会被执行

```python
names = ['张三', '李四', '王五']
for name in names:
    if name == '赵六':
        break
    print(name)
else:
    print("循环正常结束")
```

```text
张三
李四
王五
循环正常结束
```

我们再来看一个例子，演示 `continue` 的用法：

- 以下代码中，当遇到名字 '李四' 时，`continue` 语句会跳过当前循环，继续下一次循环

```python
names = ['张三', '李四', '王五']
for name in names:
    if name == '李四':
        continue
    print(name)
```

```text
张三
王五
```

- 当然，`continue` 也可以与 `else` 结合使用，如果循环中触发了 `continue`，则 `else` 语句块仍然会被执行，因为循环并没有被 `break` 中断

```python
names = ['张三', '李四', '王五']
for name in names:
    if name == '李四':
        continue
    print(name)
else:
    print("循环正常结束")
```

```text
张三
王五
循环正常结束
```

## 2. `for` 循环嵌套

`for` 循环嵌套和 `while` 循环嵌套的原理是一样的：

- 我们可以在 `for` 循环内部再嵌套一个 `for` 循环
- 内圈循环全部结束后，才会进行下一圈的外圈循环

```python
for i in range(3):  
    print(f"外圈第{i+1}圈开始")
    for j in range(2): 
        print(f"  内圈第{j+1}圈")
    print(f"外圈第{i+1}圈结束")
```

```text
外圈第1圈开始
  内圈第1圈
  内圈第2圈
外圈第1圈结束
外圈第2圈开始
  内圈第1圈
  内圈第2圈
外圈第2圈结束
外圈第3圈开始
  内圈第1圈
  内圈第2圈
外圈第3圈结束
```

在这个例子中：外圈循环使用变量 `i` 跑3圈，内圈循环使用变量 `j` 跑2圈：

- 第1圈外圈循环（`i=0`）：

    - 输出 "外圈第1圈开始"
    - 进入内圈循环：

        - 第1圈内圈循环（`j=0`）：输出 "  内圈第1圈"
        - 第2圈内圈循环（`j=1`）：输出 "  内圈第2圈"

    - 内圈循环结束，输出 "外圈第1圈结束"

- 第2圈外圈循环（`i=1`）：
    - 输出 "外圈第2圈开始"
    - 进入内圈循环：

        - 第1圈内圈循环（`j=0`）：输出 "  内圈第1圈"
        - 第2圈内圈循环（`j=1`）：输出 "  内圈第2圈"

    - 内圈循环结束，输出 "外圈第2圈结束"

- 第3圈外圈循环（`i=2`）：
    - 输出 "外圈第3圈开始"
    - 进入内圈循环：

        - 第1圈内圈循环（`j=0`）：输出 "  内圈第1圈"
        - 第2圈内圈循环（`j=1`）：输出 "  内圈第2圈"

    - 内圈循环结束，输出 "外圈第3圈结束"

## 3. `for` 循环综合练习

### (1) 打印九九乘法表

- 要求：

    - 之前我们用 `while` 循环打印过九九乘法表，这次我们使用 `for` 循环来实现同样的功能
    - 使用嵌套的 `for` 循环来打印九九乘法表会简单许多

- 以下代码是我们将 `while` 循环实现的逻辑改为 `for` 循环：

```python
for row in range(1, 10):
    for col in range(1,10):
        if col <= row:  
            print(f"{col} * {row} = {row*col}", end="\t")
    print()
```

```text
1 * 1 = 1
1 * 2 = 2       2 * 2 = 4
1 * 3 = 3       2 * 3 = 6       3 * 3 = 9
1 * 4 = 4       2 * 4 = 8       3 * 4 = 12      4 * 4 = 16
1 * 5 = 5       2 * 5 = 10      3 * 5 = 15      4 * 5 = 20      5 * 5 = 25
1 * 6 = 6       2 * 6 = 12      3 * 6 = 18      4 * 6 = 24      5 * 6 = 30      6 * 6 = 36
1 * 7 = 7       2 * 7 = 14      3 * 7 = 21      4 * 7 = 28      5 * 7 = 35      6 * 7 = 42      7 * 7 = 49
1 * 8 = 8       2 * 8 = 16      3 * 8 = 24      4 * 8 = 32      5 * 8 = 40      6 * 8 = 48      7 * 8 = 56      8 * 8 = 64
1 * 9 = 9       2 * 9 = 18      3 * 9 = 27      4 * 9 = 36      5 * 9 = 45      6 * 9 = 54      7 * 9 = 63      8 * 9 = 72      9 * 9 = 81
```

- 我们可以对这个代码进行一个小升级：

    - 我们在内循环内加入 `if col <= row` 这个条件，其实是为了控制列号小于等于行号
    - 其实，我们也可以直接把内循环的范围改为 `range(1, row+1)`，这个逻辑是内循环中列号的最大值是行号
    - 这样就不需要 `if` 条件判断了
    - 改进后的代码如下：

```python
for row in range(1, 10):
    for col in range(1,row+1):
        print(f"{col} * {row} = {row*col}", end="\t")
    print()
```

```text
1 * 1 = 1
1 * 2 = 2       2 * 2 = 4
1 * 3 = 3       2 * 3 = 6       3 * 3 = 9
1 * 4 = 4       2 * 4 = 8       3 * 4 = 12      4 * 4 = 16
1 * 5 = 5       2 * 5 = 10      3 * 5 = 15      4 * 5 = 20      5 * 5 = 25
1 * 6 = 6       2 * 6 = 12      3 * 6 = 18      4 * 6 = 24      5 * 6 = 30      6 * 6 = 36
1 * 7 = 7       2 * 7 = 14      3 * 7 = 21      4 * 7 = 28      5 * 7 = 35      6 * 7 = 42      7 * 7 = 49
1 * 8 = 8       2 * 8 = 16      3 * 8 = 24      4 * 8 = 32      5 * 8 = 40      6 * 8 = 48      7 * 8 = 56      8 * 8 = 64
1 * 9 = 9       2 * 9 = 18      3 * 9 = 27      4 * 9 = 36      5 * 9 = 45      6 * 9 = 54      7 * 9 = 63      8 * 9 = 72      9 * 9 = 81
```

### (2) 学生信息管理 (计算机学院 Python 课真题类型)

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

- 需求分析：

    - 首先我们肯定要定义一个空列表 `students = []`，之后用循环将一个个的学生信息添加到这个列表中
    - 我们可以使用 `for` 循环，但是这里有四个列表，我们知道 `for` 循环一次只能遍历一个列表，我们如何做到同时遍历四个列表呢？
    - 这里我们可以使用 `range(3)` 函数来生成一个整数序列，这个序列的范围是列表的索引范围：
        
        - 当取到 `range(3)` 的第1个数字0时，我们就可以用0这个索引去访问四个列表的第1个元素
        - 当取到 `range(3)` 的第2个数字1时，我们就可以用1这个索引去访问四个列表的第2个元素
        - 当取到 `range(3)` 的第3个数字2时，我们就可以用2这个索引去访问四个列表的第3个元素
    
    - 这样我们就可以通过一个 `for` 循环来同时遍历四个列表了

- 代码实现：

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

### (3) 现金流折现

- 要求：

    - 我们设计一个现金流折现的程序，计算未来现金流的现值（NPV，Net Present Value）
    - 公式如下：

    \[NPV = \sum_{t=0}^{n} \frac{CF_t}{(1 + r)^t}\]
    
    - 其中：
        - \(CF_t\) 是第 \(t\) 年的现金流
        - \(r\) 是折现率（年利率）
        - \(n\) 是现金流的总年数
    - 我们假设有以下现金流数据，注意这里的现金流是从第0年开始的：

```python
cash_flows = [-2000, 1000, 1500, 2000, 2500, 3000]
r = 0.05
```

- 需求分析：

    - 我们需要使用 `for` 循环来遍历现金流列表 `cash_flows`
    - 如果我们直接遍历这个列表的话，我们只能拿到每一年的现金流 \(CF_t\)，我们无法知道这是第几年 \(t\)
    - 所以我们可以使用 `range(len(cash_flows))` 来生成一个从0到5的整数序列，作为年份 \(t\)
    - 在每一圈循环中，我们可以通过 `cash_flows[t]` 来获取对应年份的现金流 \(CF_t\)
    - 然后我们可以创建一个空列表 `npv_list = []`，在每一圈循环中计算出每一年的现值，并将其添加到 `npv_list` 列表中
    - 最后我们使用 `sum()` 函数对 `npv_list` 列表中的所有现值进行求和，得到最终的 NPV

- 代码实现：

```python
cash_flows = [-2000, 1000, 1500, 2000, 2500, 3000]
r = 0.05

npv_list = []

for t in range(len(cash_flows)):
    cf_t = cash_flows[t]
    npv_t = cf_t / ((1 + r) ** t)
    npv_list.append(npv_t)

npv = sum(npv_list)
print(f"现金流的现值（NPV）为：{npv}")
```

```text
现金流的现值（NPV）为：6447.93505351606
```
