# Topic 5.3 - 组合数据类型之集合

## 1. 集合的基本概念

### (1) 集合的定义

集合（set）是 Python 中的另一种组合数据类型，和列表、元组不同的是，集合中的元素是**无序的**，并且**不允许重复**。

集合的概念，和大家在数学上学到的集合是一样的，因此这里大家理解起来会比较容易。

集合的定义格式是使用大括号 `{}`，并且用逗号 `,` 分隔各个元素：


```python
set1 = {1, 2, 3, 4, 5}
print(set1)
print(type(set1))
```

    {1, 2, 3, 4, 5}
    <class 'set'>


注意，如果我们定义一个空集合，不能使用 `{}`，因为 `{}` 定义的是一个空字典，而不是空集合。 定义空集合的格式是 `set()`：


```python
set2 = set()
print(set2)
print(type(set2))
```

    set()
    <class 'set'>


### (2) 集合的特点

首先，和大家在数学上学到的集合一样，集合中的元素是不可重复的

- 因此如果我们定义一个集合时，包含了重复的元素，Python 会自动帮我们去重
- 其实**去重**就是集合的一个重要应用场景


```python
set3 = {1, 2, 2, 3, 4, 4, 5}
print(set3)
```

    {1, 2, 3, 4, 5}


其次，集合中的元素是无序的

- 因此集合不支持索引与切片操作
- 并且，如果大家打印一个集合，发现每次打印的顺序都不一样，这也是正常现象，是集合无序的一个体现


```python
set4 = {1, 2, 3, 4, 5}
print(set4)
```

    {1, 2, 3, 4, 5}



```python
# 以下代码会引发 TypeError 错误
# print(set4[0])
```

## 2. 集合的常用操作



### (1) 集合成分员运算符

集合和列表、元组、字符串一样，支持成员运算符 `in` 和 `not in`，用于判断某个元素是否在集合中：


```python
set_fruits = {"apple", "banana", "cherry"}

print("banana" in set_fruits)
print("strawberry" not in set_fruits)
```

    True
    True


### (2) 集合的添加与删除元素

集合是可变的，因此可以对集合进行添加或删除元素的操作：

- `集合.add(元素)`：向集合中添加一个元素
- `集合.update(元素1, 元素2, ...)`：向集合中添加多个元素（只能是列表、元组、字符串等可迭代对象）
- `集合.remove(元素)`：删除集合中的某个元素，如果元素不存在会报错
- `集合.discard(元素)`：删除集合中的某个元素，如果元素不存在不会报错
- `集合.pop()`：随机删除并返回集合中的一个元素，如果集合为空会报错
- `集合.clear()`：清空集合


```python
set_new = {1, 2, 3}
set_new.add(4)
set_new.update([5, 6], (7, 8))
print(set_new)
```

    {1, 2, 3, 4, 5, 6, 7, 8}



```python
set_new.remove(2) 
set_new.discard(10)
print(set_new)
```

    {1, 3, 4, 5, 6, 7, 8}



```python
removed_element = set_new.pop()
print("Removed element:", removed_element)
print(set_new)
```

    Removed element: 1
    {3, 4, 5, 6, 7, 8}



```python
set_new.clear()
print(set_new)
```

    set()


### (3) 集合的常用函数

集合的常用函数有：

- `len(集合)`：返回集合中元素的个数
- `max(集合)`：返回集合中的最大值（集合元素需全部为数字类型）
- `min(集合)`：返回集合中的最小值（集合元素需全部为数字类型）
- `sum(集合)`：返回集合中所有元素的和（集合元素需全部为数字类型）
- `sorted(集合)`：返回一个排序后的新**列表**，原集合不变


```python
set_num = {3, 1, 4, 1, 5, 9, 2, 6, 5}

print(set_num)
print(len(set_num))
print(max(set_num))
print(min(set_num))
print(sum(set_num))
print(sorted(set_num))
```

    {1, 2, 3, 4, 5, 6, 9}
    7
    9
    1
    30
    [1, 2, 3, 4, 5, 6, 9]


### (4) 集合的运算

集合支持数学上的一些常见运算：

- 并集：`集合1 | 集合2` 或 `集合1.union(集合2)`，返回一个包含两个集合中所有元素的新集合
- 交集：`集合1 & 集合2` 或 `集合1.intersection(集合2)`，返回一个包含两个集合中共同元素的新集合
- 差集：`集合1 - 集合2` 或 `集合1.difference(集合2)`，返回一个包含在集合1中但不在集合2中的元素的新集合
- 对称差集：`集合1 ^ 集合2` 或 `集合1.symmetric_difference(集合2)`，返回一个包含在集合1或集合2中但不在两者交集中的元素的新集合


```python
set_a = {1, 2, 3, 4, 5}
set_b = {4, 5, 6, 7, 8}

print("Set A:", set_a)
print("Set B:", set_b)
print("Union:", set_a | set_b)
print("Intersection:", set_a & set_b)
print("Difference (A - B):", set_a - set_b)
print("Difference (B - A):", set_b - set_a)
print("Symmetric Difference:", set_a ^ set_b)
```

    Set A: {1, 2, 3, 4, 5}
    Set B: {4, 5, 6, 7, 8}
    Union: {1, 2, 3, 4, 5, 6, 7, 8}
    Intersection: {4, 5}
    Difference (A - B): {1, 2, 3}
    Difference (B - A): {8, 6, 7}
    Symmetric Difference: {1, 2, 3, 6, 7, 8}

