# Topic 4.3 字符串的常见操作

## 1. 字符串的常见运算符

### (1) 拼接与重复

字符串是支持 `+` 与 `*` 两个算数运算符的：

- 一个字符串 `+` 另一个字符串，结果就是将这两个字符串拼接起来，返回新字符串
- 一个字符串 `*` 一个正整数，结果就是将这个字符串重复正整数这么多次，返回新字符串

```python
print("Hello" + "Python")
print("Hello" * 3)
```

```text
HelloPython
HelloHelloHello
```

### (2) 判断字符串中是否包含某字符或某子串

字符串可以使用关键字 `in` 与 `not in` 来判断其中是否包括某个字符或某个字串，返回值为布尔型

```python
s = "Hello Python!"

print("e" in s)
print("Hello" in s)
print("Pandas" in s)
print("Java" not in s)
```

```text
True
True
False
True
```

### (3) 字符串的比较

字符串之间可以用比较运算符进行比较，

- `==` 与 `!=` 的逻辑比较简单，就是判断两个字符串是否相等
- `<` `<=` `>` `>=` 这样的比大小操作，其实就是将两个字符串按字典序比较，也就是 Unicode 编码值逐个比较
- 注意，字符串的比较是区分大小写的，大写字母的 Unicode 编码值都小于小写字母

```python
print("apple" == "apple")
print("apple" != "orange")
print("apple" < "banana")
print("Zebra" < "apple")
```

```text
True
True
True
True
```

## 2. 字符串函数

### (1) 计算字符串长度

计算一个字符串的长度使用的是 len() 函数，其实就是数字符串中有几个字符：

```python
s = "Hello Python!"
print(len(s))
```

```text
13
```

### (2) 字符串与其他类型之间的转换

将字符串转为其他数据类型的规则

- 转为整数：`int()` 函数：只有"整数模样"的字符串才能转为整数（纯数字不带小数点，可以是负数）
- 转为浮点数：`float()` 函数：只有"浮点数模样"的字符串才能转为浮点数（纯数字带小数点，可以是负数）
- 转为布尔型： `bool()` 函数：只有空字符串是 `False`，其他字符串都对应 `True`

```python
int("123") 
int("-45") 
float("3.14") 
float("-2.0") 
bool("") 
bool("abc") 
```

```text
123
-45
3.14
-2.0
False
True
```

除此之外，字符串还可以转为组合数据类型，如列表、元组、集合等，效果其实就是将字符串打散成子字符，组合数据类型我们会在后面详细介绍

- 转为列表：`list()` 函数
- 转为元组：`tuple()` 函数
- 转为集合：`set()` 函数

```python
s = "Hello Python!"
print(list(s))
print(tuple(s))
print(set(s))
```

```text
['H', 'e', 'l', 'l', 'o', ' ', 'P', 'y', 't', 'h', 'o', 'n', '!']
('H', 'e', 'l', 'l', 'o', ' ', 'P', 'y', 't', 'h', 'o', 'n', '!')
{'!', 't', 'e', 'H', 'l', 'o', 'h', 'y', 'P', 'n', ' '}
```

## 3. 字符串方法

字符串除了函数之外，还有很多内置方法

这里我们简单介绍一下函数和方法的区别：

- 函数的调用是 `函数名(对象, 其他参数)` - 函数与对象是相互独立存在的
- 方法的调用是 `对象.方法名(其他参数)` - 方法是依赖于对象而存在的

字符串的内置方法有很多，我们这里不可能全部介绍，以下我们介绍一些常用的方法

### (1) 大小写转换系列

| 方法            | 功能                                  | 
| -------------- | -------------------------------------- | 
| `lower()`      | 全部转小写（Unicode）                   | 
| `upper()`      | 全部转大写（Unicode）                   | 
| `capitalize()` | 整串首字符大写，其余小写                  | 
| `title()`      | 每个单词首字母大写，其余小写（按分隔符划分） | 
| `swapcase()`   | 大小写互换                             | 

```python
print("PyThon".lower())
print("Hello".upper())

print("hello world".capitalize())
print("hello WORLD".capitalize())
print("hELlo wORlD".capitalize())

print("hello world".title())
print("hello WORLD".title())
print("hELlo wORlD".title())

print("PyThon".title())
```

```text
python
HELLO
Hello world
Hello world
Hello world
Hello World
Hello World
Hello World
Python
```

### (2) 判断系列

**判断成分：**

| 方法            | 功能                                     | 
| ------------- | ----------------------------------------- | 
| `isalnum()`   | 是否只包含字母和数字                          | 
| `isalpha()`   | 是否只包含字母（不含数字）                     | 
| `isdecimal()` | 是否只包含数字（0-9阿拉伯数字）                 | 
| `isdigit()`   | 是否只包含数字字符（还能判断字符数字）          | 
| `isnumeric()` | 是否只包含数字字符（含中文数字“一百”）           |
| `isspace()`   | 是否只包含空白字符（空格、`\t`、`\n` 等）       | 
| `isascii()`   | 是否全部是 ASCII 字符（数字、字母、常见标点等）   | 

```python
print("(1) 判断是否为字符串和数字：")
print("abc123".isalnum())
print("abc".isalnum())
print("123".isalnum())

print("(2) 判断是否为数字：")
print("123".isdecimal())
print("②".isdecimal())
print("一百".isdecimal())
print("123".isdigit())
print("②".isdigit())
print("一百".isdigit())
print("123".isnumeric())
print("②".isnumeric())
print("一百".isnumeric())

print("(3) 是否只包含空白字符：")
print("  \n \t".isspace())

print("(4) 是否只包含 ASCII：")
print("abc123,.?! \n\t".isascii())
```

```text
(1) 判断是否为字符串和数字：
True
True
True
(2) 判断是否为数字：
True
False
False
True
True
False
True
True
True
(3) 是否只包含空白字符：
True
(4) 是否只包含 ASCII：
True
```

**判断格式：**

| 方法           | 功能                                       |
| ------------- | ----------------------------------------- |
| `islower()`   | 是否至少有一个字母，且字母部分全部是小写         |
| `isupper()`   | 是否至少有一个字母，且字母部分全部是大写                | 
| `istitle()`   | 是否至少有一个字母，且字母部分每个单词首字母大写其余小写                | 

```python
print("(5) 判断格式：")
print("abc".islower())
print("abc123".islower())
print("Abc123".islower())

print("ABC".isupper())
print("ABC123".isupper())
print("Abc123".isupper())

print("Hello Python".istitle())
print("Hello Python!@#".istitle())
print("Hello python".istitle())
```

```text
(5) 判断格式：
True
True
False
True
True
False
True
True
False
```

**判断开头或结尾**

| 方法           | 功能                        |
| ------------- | ----------------------------|
| `startswith(子串)` | 判断字符串是否以某个子串开头（区分大小写） |
| `endswith(子串)`   | 判断字符串是否以某个子串结尾（区分大小写）|

这两个方法都支持以元组的形式传入多个子串，多个子串中只要有一个对，就会返回 `True`，否则返回 `False`

```python
print("Hello Python".startswith("H"))
print("Hello Python".startswith("He"))
print("Hello Python".startswith("Hello"))

print("Hello Python".endswith("on"))
print("Hello Python".endswith("hon"))
print("Hello Python".endswith("Python"))

print("Hello Python".startswith("he"))

print("Hello Python".startswith(("He", "Hel", "Ha")))
print("Hello Python".startswith(("Ha", "Hb", "Hc")))
```

```text
True
True
True
True
True
True
False
True
False
```

### (3) 查找替换系列

| 方法 | 功能 | 
| ------------------| ----------- |
| `find(子串)` | 从左往右查找子串位置，返回发现的第一个子串的索引，找不到返回 **-1** | 
| `rfind(子串)` | 从右往左查找子串位置，返回发现的第一个子串的索引，找不到返回 **-1** | 
| `index(子串)` | 从左往右查找子串位置，找不到会报错 ValueError | 
| `rindex(子串)` | 从右往左查找子串位置，找不到会报错 ValueError | 
| `replace(旧子串, 新字串, 替换次数)` | 替换子串，可以限制替换次数，如果不限制替换次数则全部替换 | 

```python
print("hello".find("l"))
print("hello".find("el"))
print("hello".find("a"))
print("hello".rfind("l"))
print("hello".rfind("el"))
print("hello".rfind("a"))

print("hello".index("l"))
print("hello".index("lo"))

print("hello".replace("l", "X"))
print("hello".replace("l", "X",1))
```

```text
2
1
-1
3
1
-1
2
3
heXXo
heXlo
```

### (4) 文本处理系列

| 方法                          | 功能                   |
| --------------------------- | -------------------- | 
| `strip(字符(可选))`            | 去掉首尾指定字符，默认去掉空白字符（空格、换行符、制表符等）|
| `lstrip(字符(可选))`           | 去掉左边指定字符，默认去掉空白字符（空格、换行符、制表符等）| 
| `rstrip(字符(可选))`           | 去掉右边*指定字符，默认去掉空白字符（空格、换行符、制表符等）| 
| `center(宽度, 字符(可选))` | 居中对齐，用填充字符补足宽度，默认用空格填充 |
| `ljust(宽度, 字符(可选))`  | 左对齐，用填充字符补足宽度，默认用空格填充 | 
| `rjust(宽度, 字符(可选))`  | 右对齐，用填充字符补足宽度，默认用空格填充 | 
| `zfill(宽度)`              | 数字字符串左侧补零，补充至指定宽度 | 

```python
print(" Hello ".strip())
print(" Hello ".rstrip())
print(" Hello ".lstrip())

print("-Hello-".strip("-"))
print("-Hello-".rstrip("-"))
print("-Hello-".lstrip("-"))

print("hi".center(6))
print("hi".ljust(6))
print("hi".rjust(6))

print("hi".center(6, "-"))
print("hi".ljust(6, "-"))
print("hi".rjust(6, "-"))

print("54".zfill(4))
```

```text
Hello
 Hello
Hello 
Hello
-Hello
Hello-
  hi  
hi    
    hi
--hi--
hi----
----hi
0054
```

### (5) 拆分合并系列

| 方法 | 功能 | 
| ------------------------------- | ------------------------------------ | 
| `split(分隔符,最多分隔次数)`  | 从左向右按分隔符拆分字符串为列表形式，可以指定最多分隔次数 | 
| `rsplit(分隔符,最多分隔次数)` | 从右向左按分隔符拆分字符串为列表形式，可以指定最多分隔次数 | 
| `splitlines()`    | 按行拆分字符串为列表形式，本质是按照换行符拆分              | 
| `partition(分隔符)`                | 按从左往右出现的第一个分隔符拆分，返回三元组 `(分隔符之前, 分隔符, 分隔符之后)`  |
| `rpartition(分隔符)`               | 按从右往左出现的第一个分隔符拆分，返回三元组 `(分隔符之前, 分隔符, 分隔符之后)` | 
| `"字符".join(全部为字符串的列表或元组)`            | 用指定字符作为分隔符拼接序列，返回字符串                     | 


```python
print("a b c".split())
print("a,b,c".split(","))
print("a,b,c".split(",", 1))

print("a b c".rsplit())
print("a,b,c".rsplit(","))
print("a,b,c".rsplit(",", 1))

s = """
line1
line2
line3
"""
print(s.splitlines())

print("a-b-c".partition("-"))
print("a-b-c".rpartition("-"))

print("".join(["a", "b", "c"]))
print("-".join(["a", "b", "c"]))
```

```text
['a', 'b', 'c']
['a', 'b', 'c']
['a', 'b,c']
['a', 'b', 'c']
['a', 'b', 'c']
['a,b', 'c']
['', 'line1', 'line2', 'line3']
('a', '-', 'b-c')
('a-b', '-', 'c')
abc
a-b-c
```

## 4. 字符串操作综合练习

### (1) 手机号遮挡

- 要求：

    - 用户输入一个11位的手机号，我们将手机号的中间4位换成 *
    - 默认用户输入的手机号格式正确

- 参考代码：

```python
phone_number = input("请输入你的手机号：")
phone_number_masked = phone_number[:3] + "****" + phone_number[-4:]
print("保护后的手机号：", phone_number_masked)
```

```text
请输入你的手机号：13811223344
保护后的手机号： 138****3344
```

### (2) 购物小票排版

- 要求：

    - 用户输入商品的名称，数量，价格，我们将这些信息打印出来
    - 要求居中对齐，保证整齐美观

- 参考代码：

```python
item = input("请输入商品名称：")
price = input("请输入商品价格：")
number = input("请输入商品数量：")

s = (item + number + "件 x " + price + "元" + " = " + str(float(number) * float(price)) + "元")

s_output = s.center(30, "-")

print(s_output)
```

```text
请输入商品名称：苹果
请输入商品价格：5
请输入商品数量：2
------苹果2件 x 5元 = 10.0元-------
```

### (3) 名字格式化

- 要求：

    - 用户分别输入一位外国友人的名音译和姓音译
    - 将名和姓连接起来，用点 `·` 分隔
    - 考虑不同的完成方式

- 参考代码

```python
first_name = input("请输入名：")
last_name = input("请输入姓：")

print(first_name + "·" + last_name)
print("·".join([first_name, last_name]))
```

```text
请输入名：唐纳德
请输入姓：川普
唐纳德·川普
唐纳德·川普
```