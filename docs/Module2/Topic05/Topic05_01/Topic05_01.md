# Topic 5.1 - 组合数据类型之列表

## 1. 列表的基本概念

### (1) 列表的定义

列表 (list) 是 Python 中的一种**有序的**并且**可变的**组合数据类型，可以用来存储一组相关的数据。

- 列表的定义是用一对方括号 `[]` 把数据括起来，数据之间用逗号 `,` 分隔:

```python
fruits = ["apple", "banana", "cherry"]
print(fruits)
print(type(fruits))
``` 

```text
['apple', 'banana', 'cherry']
<class 'list'>
```

- 如果想要定义一个空列表，可以直接使用一对空的方括号 `[]`，或者使用 `list()` 函数:

```python
empty_list1 = []
empty_list2 = list()
print(empty_list1)
print(empty_list2)
print(type(empty_list1))
print(type(empty_list2))
``` 

```text
[]
[]
<class 'list'>
<class 'list'>
```

注意，如果将列表转为布尔值，空列表会被视为 `False`，所有非空列表都会被视为 `True`。

```python
print(bool(fruits))
print(bool(empty_list1))
print(bool(empty_list2))
``` 

```text
True
False
False
```

### (2) 列表的元素

列表中的每个数据项称为元素 (element):

- 列表中的元素可以是任意Python中的数据类型，包括数字、字符串、布尔值，甚至其他组合数据类型
- 列表中的元素在定义时还可以放入之前定义过的变量

```python
a = 10
mixed_list = [a, 1, "apple", 3.14, True, None, [1, 2, 3], (4, 5)]
print(mixed_list)
``` 

```text
[10, 1, 'apple', 3.14, True, None, [1, 2, 3], (4, 5)]
``` 

### (3) 列表的索引与切片

列表的元素是有序排列的，因此可以进行索引与切片操作，并且列表的切片与字符串的切片操作是类似的：

- 索引格式为 `列表[索引]`，其中正数索引从 0 开始，负数索引从 -1 开始
- 切片格式为 `列表[开始索引:结束索引:步长]`

```python
name = ["张三", "李四", "王五", "赵六", "牛七", "马八", "陈九"]
print(name[0]) 
print(name[-1])
print(name[1:4])
print(name[::2])
print(name[::-1])
``` 

```text
张三
陈九
['李四', '王五', '赵六']
['张三', '王五', '牛七', '陈九']
['陈九', '马八', '牛七', '赵六', '王五', '李四', '张三']
```

### (4) 列表中元素的修改与删除 

列表是可变的，因此可以对列表中的元素进行修改与删除操作，我们可以使用索引来对列表中特定的元素进行操作：

- 要想修改列表中某个位置的元素，格式为 `列表[索引] = 新值`

- 要想删除列表中某个位置的元素，可以使用 `del` 语句，格式为 `del 列表[索引]`

```python
name1 = ["张三", "李四", "王五", "赵六", "牛七", "马八", "陈九"]
# 修改
name1[0] = "张三丰"
# 删除
del name1[-1]
print(name1)
```

```text
['张三丰', '李四', '王五', '赵六', '牛七', '马八']
```

除此之外，还可以使用切片的方式，来修改或删除列表中的一段元素：

- 使用切片批量修改列表中元素的格式为 `列表[开始索引:结束索引:步长] = [新值1, 新值2, ...]`
- 使用切片批量删除列表中元素的格式为 `del 列表[开始索引:结束索引:步长]`

```python
name2 = ["张三", "李四", "王五", "赵六", "牛七", "马八", "陈九"]
# 批量修改
name2[0:4] = ["张三丰", "李四丰", "王五丰", "赵六丰"]
# 批量删除
del name2[4:]
print(name2)
```

```text
['张三丰', '李四丰', '王五丰', '赵六丰']
```

## 2. 列表的常用操作

### (1) 列表的拼接与重复

列表的拼接与重复操作与字符串类似，使用 `+` 和 `*` 运算符：

- 两个列表之间可以使用 `+` 进行拼接
- 一个列表可以 `*` 另一个整数进行重复

```python
list1 = [1, 2, 3]
list2 = ["a", "b", "c"]
print(list1 + list2)
print(list1 * 2)
```

```text
[1, 2, 3, 'a', 'b', 'c']
[1, 2, 3, 1, 2, 3]
```

### (2) 列表的成分判断

列表的成分判断与字符串类似，使用 `in` 和 `not in` 运算符：

- 使用 `in` 判断某个元素是否在列表中
- 使用 `not in` 判断某个元素是否不在列表中

```python
list3 = [1, 2, 3, "a", "b", "c"]
print(2 in list3)
print("d" not in list3)
```

```text
True
True
```

### (3) 列表的常用函数

列表的常有函数有：

- `len(列表)`：返回列表的长度（元素个数）
- `max(列表)`：返回列表中的最大值（列表元素需全部为数字类型）
- `min(列表)`：返回列表中的最小值（列表元素需全部为数字类型）
- `sum(列表)`：返回列表中所有元素的和（列表元素需全部为数字类型）
- `sorted(列表)`：返回一个排序后的新列表，原列表不变

```python
list_num = [3, 1, 4, 1, 5, 9, 2, 6, 5]
print(len(list_num))
print(max(list_num))
print(min(list_num))
print(sum(list_num))
print(sorted(list_num))
```

```text
9
9
1
36
[1, 1, 2, 3, 4, 5, 5, 6, 9]
``` 

### (4) 列表的常用方法

列表的常用方法有：

#### (a) 增加类

- `列表.append(元素)`：在列表末尾添加一个元素
- `列表.insert(索引, 元素)`：在指定索引位置插入
- `列表.extend(可迭代对象)`：在列表末尾一次性追加另一个可迭代对象中的多个元素

```python
list_new1 = [1, 2, 3]
list_new1.append(4)
list_new1.insert(0, 0)
list_new1.extend([5, 6, 7])
print(list_new1)
```

```text
[0, 1, 2, 3, 4, 5, 6, 7]
```

#### (b) 删除类

- `列表.remove(元素)`：删除列表中第一个匹配的指定元素
- `列表.pop(索引)`：删除并返回指定索引位置的元素，如果不指定索引，默认删除并返回最后一个元素
- `列表.clear()`：清空列表

```python
list_new2 = [0, 1, 2, 3, 4, 5, 6, 7]
list_new2.remove(3)
list_new2.pop()
list_new2.pop(0)
print(list_new2)

list_new3 = [0, 1, 2, 3, 4, 5, 6, 7]
list_new3.clear()
print(list_new3)
```

```text
[1, 2, 4, 5, 6]
[]
```

#### (c) 查找类

- `列表.index(元素, 开始索引, 结束索引)`：返回列表中第一个匹配的指定元素的索引位置，可以指定搜索的开始与结束位置，可以只指定开始不指定结束（默认为列表的末尾），如果元素不存在则会引发 `ValueError` 错误
- `列表.count(元素)`：返回列表中指定元素的出现次数 

```python
list_new4 = ["a", "b", "c", "d", "c", "b", "a"]
print(list_new4.index("c"))
print(list_new4.index("c", 4))
print(list_new4.count("b"))
``` 

```text
2
4
2
```

#### (d) 排序类

- `列表.sort(reverse=False)`：对列表进行原地排序，`reverse` 参数指定是否降序
- `列表.reverse()`：将列表中的元素反转

```python
list_new5 = [3, 1, 4, 1, 5, 9, 2, 6, 5]
list_new5.sort()
print(list_new5)
list_new5.sort(reverse=True)
print(list_new5)
list_new5.reverse()
print(list_new5)
```

```text
[1, 1, 2, 3, 4, 5, 5, 6, 9]
[9, 6, 5, 5, 4, 3, 2, 1, 1]
[1, 1, 2, 3, 4, 5, 5, 6, 9]
```

#### (e) 重要：列表方法的返回值

我们来对比以下两种不同的操作：

```python
list_a = [3, 1, 4, 1, 5, 9, 2, 6, 5]
list_b = list_a.sort()
print(list_a)
print(list_b)
```

```text
[1, 1, 2, 3, 4, 5, 5, 6, 9]
None
```

这里我们看到 `list_a` 被排序了，但是 `list_b` 的值却是 `None`

- 这是因为 `sort()` 方法是原地排序，不会返回新的列表，而是直接对原列表进行修改，因此它的返回值是 `None`， 就是什么也不返回

- 因此，使用一个变量来接受 `sort()` 方法的返回值是没有意义的

- 这就是 Python 中函数与方法的 **返回值** 的概念，后面我们会反复看到，有些操作会返回一个新的值，而有些操作则是在原值上修改不会返回任何值（返回 `None`）

## 3. 列表的嵌套

刚才我们介绍过，列表中的元素可以是任意数据类型，包括其他的组合数据类型，因此列表中也可以嵌套其他的列表，这就是列表的嵌套 (nested list)。

```python
nested_list = [[1, 2, 3], ["a", "b", "c"], [True, False]]
print(nested_list)
print(nested_list[0])
print(nested_list[1][2])
```

```text
[[1, 2, 3], ['a', 'b', 'c'], [True, False]]
[1, 2, 3]
c
```

列表的嵌套最常用的就是二维列表 (2D list)，也就是每个元素都是一个列表，这样就形成了一个表格结构

```python
table = [
    ["姓名", "语文", "数学", "英语"],
    ["张三", 90, 85, 88],
    ["李四", 92, 80, 86],
    ["王五", 85, 87, 90]
] 

print(table)
print(table[0])        # 第0个子列表 - 第0行
print(table[1][0])     # 第1个子列表的第0个元素 - 第1行的第0列
print(table[2][2])     # 第2个子列表的第2个元素 - 第2行的第2列
print(table[1][1:])    # 第1个子列表的第1个元素到最后一个元素 - 第1行的第1列到最后1列
```

## 4. 列表复制

### (1) 浅拷贝

列表，以及很多种的组合数据类型，都有一个特点，我们先来看以下列子：

```python
list_a = [1, 2, 3]
list_b = list_a
list_b.append(4)
print(list_a)
print(list_b)
```

```text
[1, 2, 3, 4]
[1, 2, 3, 4]
```

这里我们看到，我们明明只对 `list_b` 进行了修改，但是 `list_a` 也跟着变了

- 这是因为 `list_b = list_a` 这个操作，并不是将 `list_a` 的值复制给 `list_b`，而是给 `list_a` 起了一个别名，叫做 `list_b`
- 因此，`list_a` 和 `list_b` 实际上是同一个列表的两个名字，对其中一个进行修改，另一个也会跟着变

要想克服这一问题，我们可以使用列表的 `copy()` 方法，来创建一个新的列表，这个操作叫做浅拷贝 (shallow copy)

```python
list_a_new = [1, 2, 3]
list_b_new = list_a_new.copy()
list_b_new.append(4)
print(list_a_new)
print(list_b_new)
```

```text
[1, 2, 3]
[1, 2, 3, 4]
```

### (2) 深拷贝

但是，浅拷贝也有一个问题，我们来看以下例子：

```python
list_c = [[1, 2], [3, 4]]
list_d = list_c.copy()
list_d[0].append(5)
print(list_c)
print(list_d)
```

```text
[[1, 2, 5], [3, 4]]
[[1, 2, 5], [3, 4]]
```

这里我们看到，在列表嵌套的情境下，就算是使用了 `copy()` 方法，我们对 `list_d` 中的子列表进行了修改，`list_c` 中的子列表还是跟着变了

- 这是因为 `copy()` 方法只会复制最外层的列表，内部的子列表仍然是引用同一个对象，因此对其中一个子列表的修改会影响到另一个

- 这种情况下，我们需要使用 `copy` 模块中的 `deepcopy()` 函数，来进行深拷贝 (deep copy)

```python
import copy

list_c_new = [[1, 2], [3, 4]]
list_d_new = copy.deepcopy(list_c_new)
list_d_new[0].append(5)
print(list_c_new)
print(list_d_new)
```

```text
[[1, 2], [3, 4]]
[[1, 2, 5], [3, 4]]
```
- 这里我们看到，使用 `deepcopy()` 函数后，`list_c_new` 和 `list_d_new` 就完全独立了，互不影响

### (3) 浅拷贝与深拷贝的注意事项

我们这里用列表来举例浅拷贝与深拷贝

- 其实，浅拷贝与深拷贝的概念，适用于所有的组合数据类型
- 甚至之后数据分析里会学的 Pandas 库与 NumPy 库中的数据结构，也都适用浅拷贝与深拷贝的概念
- 大家在使用这些数据类型时，都要注意浅拷贝与深拷贝的问题，我们就不在每个数据类型下面都重复介绍了

## 5. 列表的综合练习

### (1) 颜色

- 要求

    - 定义一个列表 `colors`，包含以下颜色名称：`"red"`, `"green"`, `"blue"`，然后完成以下操作：
    - (1) 在列表末尾添加颜色 `"yellow"`
    - (2) 在索引位置 1 插入颜色 `"orange"`
    - (3) 删除颜色 `"green"`
    - (4) 使用切片获取索引位置 1 到 3 的颜色，并将结果存储在变量 `sliced_colors` 中
    - (5) 打印修改后的 `colors` 列表和 `sliced_colors` 

- 参考代码

```python
colors = ["red", "green", "blue"] 
colors.append("yellow")               
colors.insert(1, "orange")            
colors.remove("green")                 
sliced_colors = colors[1:4]           
print(colors)
print(sliced_colors)
```

```text
['red', 'orange', 'blue', 'yellow']
['orange', 'blue', 'yellow']
```

### (2) 学生成绩
- 要求

    - 定义一个二维列表 `grades`，如下所示，然后完成以下操作：

```python
grades = [
    ["姓名", "语文", "数学", "英语"],
    ["张三", 90, 85, 88],
    ["李四", 92, 80, 86],
    ["王五", 85, 87, 90]
]
```

    - (1) 计算张三的三科总成绩
    - (2) 计算全班的语文平均成绩
    - (3) 计算全班数学的最高分

- 参考代码

```python
grades = [
    ["张三", 90, 85, 88],
    ["李四", 92, 80, 86],
    ["王五", 85, 87, 90]
]

# (1) 计算张三的三科总成绩
total_zhangsan = sum(grades[0][1:])
print("张三的总成绩:", total_zhangsan)

# (2) 计算全班的语文平均成绩
total_chinese = sum([grades[0][1], grades[1][1], grades[2][1]])
average_chinese = total_chinese / len(grades)
print("全班语文平均成绩:", average_chinese)

# (3) 计算全班数学的最高分
max_math = max([grades[0][2], grades[1][2], grades[2][2]])
print("全班数学最高分:", max_math)
```

```text
张三的总成绩: 263
全班语文平均成绩: 89.0
全班数学最高分: 87
```
