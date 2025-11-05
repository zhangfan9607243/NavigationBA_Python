# Topic 4.3 字符串的常见操作

我们说字符串其实就是计算机中的文字，我们本章讲的字符串常见操作其实就是如何用编程的方式来处理文字。

在许多复杂的 NLP（自然语言处理）任务中，也需要用到这些字符串的常见操作，可以说，大家今天学的内容，和训练 ChatGPT 的 AI 工程师做的部分工作是类似的。

## 1. 字符串的常见运算符

### (1) 拼接与重复

字符串是支持 `+` 与 `*` 两个算数运算符的：

- 一个字符串 `+` 另一个字符串，结果就是将这两个字符串拼接起来，返回新字符串
- 一个字符串 `*` 一个正整数，结果就是将这个字符串重复正整数这么多次，返回新字符串


```python
print("Hello" + "Python")
print("Hello" * 3)
```

    HelloPython
    HelloHelloHello


### (2) 判断字符串中是否包含某字符或某子串

字符串可以使用关键字 `in` 与 `not in` 来判断其中是否包括某个字符或某个子串，返回值为布尔型



```python
s = "Hello Python!"

print("e" in s)
print("Hello" in s)
print("Pandas" in s)
print("Java" not in s)
```

    True
    True
    False
    True


### (3) 字符串的比较

字符串之间可以用比较运算符进行比较，

- `==` 与 `!=` 的逻辑比较简单，就是判断两个字符串是否相等
- `<` `<=` `>` `>=` 这样的比大小操作，其实就是将两个字符串按字典序比较，也就是 Unicode 编码值逐个比较
- 注意，字符串的比较是区分大小写的，**大写字母的 Unicode 编码值都小于小写字母**



```python
print("apple" == "apple")
print("apple" != "orange")
print("apple" < "banana")
print("Zebra" < "apple")
```

    True
    True
    True
    True


## 2. 字符串函数

### (1) 计算字符串长度

计算一个字符串的长度使用的是 `len()` 函数，其实就是数字符串中有几个字符：



```python
s = "Hello Python!"
print(len(s))
```

    13


### (2) 字符串与其他类型之间的转换

将字符串转为其他数据类型的规则

- 转为整数：`int()` 函数：只有"整数模样"的字符串才能转为整数（纯数字不带小数点，可以是负数）
- 转为浮点数：`float()` 函数：只有"浮点数模样"的字符串才能转为浮点数（纯数字带小数点，可以是负数）
- 转为布尔型： `bool()` 函数：只有空字符串是 `False`，其他字符串都对应 `True`



```python
print(int("123"))
print(int("-45"))
print(float("3.14"))
print(float("-2.0"))
print(bool(""))
print(bool("abc"))
```

    123
    -45
    3.14
    -2.0
    False
    True


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

    ['H', 'e', 'l', 'l', 'o', ' ', 'P', 'y', 't', 'h', 'o', 'n', '!']
    ('H', 'e', 'l', 'l', 'o', ' ', 'P', 'y', 't', 'h', 'o', 'n', '!')
    {'n', 't', 'y', 'o', '!', 'e', 'h', ' ', 'l', 'H', 'P'}


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

    python
    HELLO
    Hello world
    Hello world
    Hello world
    Hello World
    Hello World
    Hello World
    Python


### (2) 判断系列

#### (a) 判断成分

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
# 判断是否为字母和数字
print("abc123".isalnum())
print("abc".isalnum())
print("123".isalnum())
```

    True
    True
    True



```python
# 判断是否为字母
print("abc".isalpha())
print("ABCdef".isalpha())
print("abc123".isalpha())
print("abc!".isalpha())
```

    True
    True
    False
    False



```python
# 判断是否为数字
print("123".isdecimal())
print("②".isdecimal())
print("一百".isdecimal())

print("123".isdigit())
print("②".isdigit())
print("一百".isdigit())

print("123".isnumeric())
print("②".isnumeric())
print("一百".isnumeric())
```

    True
    False
    False
    True
    True
    False
    True
    True
    True



```python
# 是否只包含空白字符
print("  \n \t".isspace())
```

    True



```python
# 是否只包含 ASCII
print("abc123,.?! \n\t".isascii())
print("你好，世界！".isascii())
print("Hello, 世界!".isascii())
```

    True
    False
    False


#### (b) 判断格式

| 方法           | 功能                                       |
| ------------- | ----------------------------------------- |
| `islower()`   | 是否至少有一个字母，且字母部分全部是小写         |
| `isupper()`   | 是否至少有一个字母，且字母部分全部是大写          | 
| `istitle()`   | 是否至少有一个字母，且字母部分每个单词首字母大写其余小写                | 



```python
# 判断是否为小写字母
print("abc".islower())
print("abc123".islower())
print("Abc123".islower())
```

    True
    True
    False



```python
# 判断是否为大写字母
print("ABC".isupper())
print("ABC123".isupper())
print("Abc123".isupper())
```

    True
    True
    False



```python
print("Hello Python".istitle())
print("Hello Python!@#".istitle())
print("Hello python".istitle())
```

    True
    True
    False


#### (c) 判断开头或结尾

| 方法           | 功能                        |
| ------------- | ----------------------------|
| `startswith(子串)` | 判断字符串是否以某个子串开头（区分大小写） |
| `endswith(子串)`   | 判断字符串是否以某个子串结尾（区分大小写）|

这两个方法都支持以元组的形式传入多个子串，多个子串中只要有一个对，就会返回 `True`，否则返回 `False`


```python
# 判断开头
print("Hello Python".startswith("H"))
print("Hello Python".startswith("He"))
print("Hello Python".startswith("Hello"))
print("Hello Python".startswith("he"))
```

    True
    True
    True
    False



```python
# 判断结尾
print("Hello Python".endswith("on"))
print("Hello Python".endswith("hon"))
print("Hello Python".endswith("Python"))
```

    True
    True
    True



```python
# 以元组形式传入多个参数
print("Hello Python".startswith(("He", "Hel", "Ha")))
print("Hello Python".startswith(("Ha", "Hb", "Hc")))
```

    True
    False


### (3) 查找替换系列

| 方法 | 功能 | 
| ------------------| ----------- |
| `find(子串)` | 从左往右查找子串位置，返回发现的第一个子串的索引，找不到返回 **-1** | 
| `rfind(子串)` | 从右往左查找子串位置，返回发现的第一个子串的索引，找不到返回 **-1** | 
| `index(子串)` | 从左往右查找子串位置，找不到会报错 ValueError | 
| `rindex(子串)` | 从右往左查找子串位置，找不到会报错 ValueError | 
| `replace(旧子串, 新字串, 替换次数)` | 替换子串，可以限制替换次数，如果不限制替换次数则全部替换 | 



```python
# find 方法
print("hello".find("l"))
print("hello".find("el"))
print("hello".find("a"))
```

    2
    1
    -1



```python
# rfind 方法
print("hello".rfind("l"))
print("hello".rfind("el"))
print("hello".rfind("a"))
```

    3
    1
    -1



```python
# index 方法
print("hello".index("l"))
print("hello".index("lo"))
```

    2
    3



```python
# rindex 方法
print("hello".rindex("l"))
print("hello".rindex("lo"))
```

    3
    3



```python
# replace 方法
print("hello".replace("l", "X"))
print("hello".replace("l", "X", 1))
```

    heXXo
    heXlo


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
# 去除开头或结尾的空白字符
print(" Hello ".strip())
print(" Hello ".rstrip())
print(" Hello ".lstrip())
```

    Hello
     Hello
    Hello 



```python
# 去除开头或结尾的指定字符
print("-Hello-".strip("-"))
print("-Hello-".rstrip("-"))
print("-Hello-".lstrip("-"))
```

    Hello
    -Hello
    Hello-



```python
# 字符串对齐（填充空白字符）
print("hi".center(6))
print("hi".ljust(6))
print("hi".rjust(6))
```

      hi  
    hi    
        hi



```python
# 字符串对齐（填充指定字符）
print("hi".center(6, "-"))
print("hi".ljust(6, "-"))
print("hi".rjust(6, "-"))
```

    --hi--
    hi----
    ----hi



```python
# 数字型字符串前面补零
print("54".zfill(4))
```

    0054


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
# 拆分字符串为列表
print("a b c".split())
print("a,b,c".split(","))
print("a,b,c".split(",", 1))
```

    ['a', 'b', 'c']
    ['a', 'b', 'c']
    ['a', 'b,c']



```python
# 拆分字符串为列表（从右侧开始）
print("a b c".rsplit())
print("a,b,c".rsplit(","))
print("a,b,c".rsplit(",", 1))
```

    ['a', 'b', 'c']
    ['a', 'b', 'c']
    ['a,b', 'c']



```python
# 按行拆分字符串为列表
s = """
line1
line2
line3
"""
print(s.splitlines())
```

    ['', 'line1', 'line2', 'line3']



```python
# 拆分字符串为三元组
print("a-b-c".partition("-"))
print("a-b-c".rpartition("-"))
```

    ('a', '-', 'b-c')
    ('a-b', '-', 'c')



```python
# 拼接列表为字符串
print("".join(["a", "b", "c"]))
print("-".join(["a", "b", "c"]))
```

    abc
    a-b-c


## 4. 字符串操作综合练习

### (1) 手机号遮挡

- 要求：

    - 给定一个11位的手机号，我们将手机号的中间4位换成 *
    - 默认用户输入的手机号格式正确

- 参考代码：


```python
phone_number = "13812345678"
phone_number_masked = phone_number[:3] + "****" + phone_number[-4:]
print("保护后的手机号：", phone_number_masked)
```

    保护后的手机号： 138****5678


### (2) 购物小票排版

- 要求：

    - 用户输入商品的名称，数量，价格，我们将这些信息打印出来
    - 要求居中对齐，保证整齐美观

- 参考代码：


```python
item = "冰淇淋"
price = 5
number = 2

s = (item + str(number) + "件 x " + str(price) + "元" + " = " + str(float(number) * float(price)) + "元")

s_output = s.center(30, "-")

print(s_output)
```

    ------冰淇淋2件 x 5元 = 10.0元------


### (3) 名字格式化

- 要求：

    - 给定一位外国友人的名音译和姓音译
    - 将名和姓连接起来，用点 `·` 分隔
    - 考虑不同的完成方式

- 参考代码


```python
first_name = "唐纳德"
last_name = "川普"

print(first_name + "·" + last_name)
print("·".join([first_name, last_name]))
```

    唐纳德·川普
    唐纳德·川普

