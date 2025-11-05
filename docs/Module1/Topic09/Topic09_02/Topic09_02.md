# Topic 9.2 - 函数的进阶用法

## 1. 参数的默认值

### (1) 设置参数的默认值

在定义函数时，我们可以为参数设置默认值，这样在调用函数时，如果没有传入该参数的值，就会使用默认值。

设置参数默认值的语法格式如下：

```python
def 函数名(参数1=默认值1, 参数2=默认值2, ...):
    函数体
```

例如，我们定义一个函数来展示欢迎信息，没有传入姓名，就打印“某某”：


```python
def show_welcome_message(name="某某"):
    print(f"欢迎，{name}！")

# 调用函数，传入参数
show_welcome_message("张三")
# 调用函数，不传入参数，使用默认值
show_welcome_message()
```

    欢迎，张三！
    欢迎，某某！


### (2) 带默认值的参数与不带默认值的参数

在定义函数时，所有带默认值的参数，必须放在所有不带默认值的参数后面，否则会导致语法错误。



```python
# 正确的定义方式
def test_func_v1(a, b, c=1, d=2): 
    return a + b + c + d


```


```python
# 错误的定义方式，以下代码会报 SyntaxError
# def test_func_v2(a, b=1, c): 
#     return a + b + c
```

如果一个函数中，既有带默认值的参数，又有不带默认值的参数，那么在调用函数时一定要搞清楚参数的顺序：

- 一个推荐的做法是，**调用时都传入参数名**，这样就不会因为参数顺序搞错而出错
- 我们来看以下例子：


```python
# 定义函数
def test_func_v3(a, b, c=1, d=2):
    return a + b + c + d

# 按顺序传入参数
result1 = test_func_v3(3, 4)       # a=3, b=4, c 使用默认值, d 使用默认值
result2 = test_func_v3(3, 4, 5)    # a=3, b=4, c=5, d 使用默认值
result3 = test_func_v3(3, 4, 5, 6) # a=3, b=4, c=5, d=6
```


```python
# 传入参数，使用参数名，可以不按顺序传入
result4 = test_func_v3(b=4, a=3)
result5 = test_func_v3(d=6, a=3, b=4)
```


```python
# 如果带参数名和不带参数名混用，规则就会比较混乱，以下代码都不会报错，只是可读性很差：
result6 = test_func_v3(3, b=4, d=6)
result7 = test_func_v3(3, 4, d=6)
result8 = test_func_v3(3, 4, c=5)
result9 = test_func_v3(3, 4, c=5, d=6)
result10 = test_func_v3(c=5, d=6, b=4, a=3) 
```

## 2. 函数的作用域

### (1) 全局变量与局部变量

在 Python 中，如果我们在函数内部定义一个变量，这个变量就是局部变量，只能在函数内部使用，除非使用 `return` 语句将其返回，否则在函数外部无法访问这个变量。



```python
def my_function_v1():
    local_var = 10  # 这是一个局部变量
    print("函数内部的局部变量:", local_var)

# 调用函数，由函数内部访问局部变量
my_function_v1()
```

    函数内部的局部变量: 10



```python
# 这会报 NameError，因为 local_var 是局部变量
# print("函数外部访问局部变量:")
# print(local_var)  
```

如果我们在函数外部定义一个变量，这个变量就是全局变量，可以在整个程序中使用。


```python
global_var = 20  # 这是一个全局变量

def my_function_v2():
    print("函数内部访问全局变量:", global_var)

my_function_v2()
print("函数外部访问全局变量:", global_var)
```

    函数内部访问全局变量: 20
    函数外部访问全局变量: 20


### (2) 使用 `global` 关键字

事实上，在函数内部访问全局变量时，我们推荐使用 `global` 关键字来声明变量是全局变量，这样可以避免一些潜在的问题

- 有些人的编程习惯是，当在函数内部需要修改全局变量时，或者内部变量与外部变量同名时，才使用 `global` 关键字声明该变量是全局变量
- 但是我们推荐的做法是，只要是在函数内部访问全局变量，不论应用情景，都使用 `global` 关键字声明该变量是全局变量


```python
global_var = 20  # 这是一个全局变量

def my_function_v3():
    global global_var 
    print("函数内部访问全局变量:", global_var)

my_function_v3()
print("函数外部访问全局变量:", global_var)
```

    函数内部访问全局变量: 20
    函数外部访问全局变量: 20


使用 `global` 关键字后，函数内部就可以直接访问和修改全局变量。


```python
global_var = 20
def my_function_v4():
    global global_var 
    global_var = 30  # 修改全局变量
    print("函数内部修改后的全局变量:", global_var)

my_function_v4()
print("函数外部访问修改后的全局变量:", global_var)
```

    函数内部修改后的全局变量: 30
    函数外部访问修改后的全局变量: 30


我们尝试以下不使用 `global` 关键字，就去修改全局变量的例子：


```python
global_var = 20
def my_function_v5():
    global_var = 30  # 这实际上是定义了一个新的局部变量
    print("函数内部的局部变量:", global_var)

my_function_v5()
print("函数外部访问全局变量:", global_var)
```

    函数内部的局部变量: 30
    函数外部访问全局变量: 20


在这个例子中，函数外部和函数内部的 `global_var` 其实是两个不同的变量

- 函数外部的 `global_var` 是全局变量，值为 20
- 函数内部的 `global_var` 是一个新的局部变量，函数内部对 `global_var` 的赋值只是在函数内部生效，并没有修改外部的全局变量

### (3) 使用函数修改外部变量的方法对比

其实在实际开发过程中，如果要修改函数外部的全局变量，我们推荐的做法是：

- 尽量少用 `global` 关键字来修改全局变量，这样会增加代码的复杂度和维护难度
- 如果需要在函数内部修改外部变量，推荐使用函数的参数和返回值来实现

我们来看以下例子，以下代码使用 `global` 关键字来修改全局变量，我们**不推荐使用这种方式**：


```python
x = 10

def my_new_func_v1():
    global x  # 这里使用 global 关键字
    x = x + 5

my_new_func_v1()
print(x) 
```

    15


我们再来看以下代码，以下代码使用函数参数和返回值来修改外部变量，函数返回的新值覆盖了外部变量的旧值，我们**推荐使用这种方式**：


```python
x = 10

def my_new_func_v2(x):
    x = x + 5
    return x

x = my_new_func_v2(x)
print(x)
```

    15


## 3. 函数的注释

### (1) 函数的功能注释

在 Python 中，添加函数的注释是一个良好的编程习惯。 这样可以帮助我们和其他人更好地理解函数的用途和使用方法。

- 一个约定俗成的函数注释方式是放在函数定义的下一行，使用三重引号 `"""` 或者 `'''` 来包裹注释内容，并包括函数的**功能**描述、**参数**说明、以及**返回值**说明
- 但是函数的注释格式或具体程度等，并没有约定俗成的标准，可以根据实际情况和个人习惯来决定
- 例如：


```python
def add(a, b):
    """
    函数功能: 
        计算两个数的和。
    参数:
        a: 第一个加数，类型可以是整数或浮点数
        b: 第二个加数，类型可以是整数或浮点数
    返回值:
        两个数的和，类型是整数或浮点数
    """
    sum_result = a + b
    return sum_result
```

### (2) 函数参数与返回值的类型注释

在 Python 中，函数的**参数和返回值默认是没有类型限制的**，可以传入任何类型的参数，返回任何类型的值：

- 我们来看一个简单的例子：



```python
# 定义函数
def multiply(a, b):
    return a * b

# 调用函数，计算两个整数的乘积
print(multiply(3, 5))

# 调用函数，重复字符串
print(multiply("*", 10))
```

    15
    **********


- 在这个函数中：

    - 也许我们的本意是想让 `a` 和 `b` 都是数字类型，返回也是数字类型
    - 但是实际上我们传入了一个字符串，函数依然可以正常工作

这时，我们可以通过**类型注解**来给函数的参数和返回值添加类型提示，语法格式如下：

```python
def 函数名(参数1: 类型1, 参数2: 类型2 = 默认值2, 参数3: (类型3_1 | 类型3_2)) -> 返回值类型:
    函数体
```

- 如果参数有默认值，要先写类型，再写等号和默认值
- 如果参数可以接受多种类型，可以使用 `|` 符号来表示联合类型

例如，我们给上面的 `multiply` 函数添加类型注解：



```python
# 定义乘积函数，添加类型注解
def multiply(a: (int | float), b: (int | float)) -> (int | float):
    return a * b

# 调用函数，计算两个整数的乘积
print(multiply(3, 5))

# 定义重复字符串函数，添加类型注解
def repeat_string(s: str, n: int) -> str:
    return s * n

# 调用函数，重复字符串
print(repeat_string("*", 10))
```

    15
    **********


需要注意的是，Python 的类型注解只是一个提示，并**不会强制执行类型检查**，所以传入错误类型的参数仍然会被接受并执行：


```python
# 定义乘积函数，添加类型注解
def multiply(a: (int | float), b: (int | float)) -> (int | float):
    return a * b

# 调用函数，传入错误类型的参数
print(multiply("*", 5))
```

    *****


## 4. 函数的综合练习 - 凯撒密码

凯撒密码是一种简单的加密算法，通过将字母表中的字母向后移动固定的位数来实现加密。

- 例如，使用位移 3 的凯撒密码：

|凯撒密码|||||||||||||||||||||||||||
|-------|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
|原始字母   |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|
|加密后字母 |D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|A|B|C|

- 比方说：

    - 原始消息 "Hello World" 使用位移 3 的凯撒密码加密后变成 "Khoor Zruog"
    - 原始信息 "Python" 使用位移 5 的凯撒密码加密后变成 "Udymts"

我们就来编写一个函数 `caesar_cipher`，实现凯撒密码的加密功能：

- 给定一个字符串 `message` 和一个整数 `shift`，返回加密后的字符串
- 要分开处理大写字母和小写字母，非字母字符保持不变
- 这个函数最好既能加密，也能解密：

首先，我们来分析一下实现的思路：

- 当 `message` 传入字符串后，我们肯定需要遍历字符串的每个字符
- 对于每个字符，我们需要用 `if` 判断它是大写字母、小写字母，还是非字母字符：大写转为对应的大写，小写转为对应的小写，非字母字符保持不变
- 最关键的就是字母如何转换呢，这里我们先用一个直接的方法：
    
    - 我们可以建立一个字母表，可以是列表类型，也可以是字符串类型，然后通过查找字母在字母表中的索引位置，来计算转换后的字母
    - 主要的问题是，我们如何做到索引循环呢，我们想做到的效果是：0->3, 1->4, 2->5, ..., 22->25, 23->0, 24->1, 25->2
    - 这里我们可以利用取余数的方式：(索引 + 3) % 26 来实现索引的循环，我们来看看取余数的效果：

|取余计算||||||||||||
|-------|-|-|-|-|-|-|-|-|-|-|-|
|原始索引|0|1|2|3|4|5|...|21|22|23|24|25|
|取余计算|(0+3)%26|(1+3)%26|(2+3)%26|(3+3)%26|(4+3)%26|(5+3)%26|...|(21+3)%26|(22+3)%26|(23+3)%26|(24+3)%26|(25+3)%26|
|结果索引|3|4|5|6|7|8|...|24|25|0|1|2|

- 还有一个问题就是，我们如何处理解密呢？其实比较简单，只要将 `shift` 变成负数即可

我们来看一个完整的实现代码：


```python
# 凯撒密码实现 - 版本1
def caesar_cipher_v1(message: str, shift: int = 3) -> str:
    
    # 预定义字母表
    uppercase_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    lowercase_letters = "abcdefghijklmnopqrstuvwxyz"
    
    # 初始化加密后的消息为一个空字符串
    encrypted_message = ""

    # 遍历消息中的每个字符
    for char in message:
        
        # 处理大写字母
        if char in uppercase_letters:
            index = uppercase_letters.index(char)  # 查找字母索引
            new_index = (index + shift) % 26  # 计算新的索引位置
            new_char = uppercase_letters[new_index]
            encrypted_message += new_char  # 添加加密后的字母到结果字符串

        # 处理小写字母
        elif char in lowercase_letters:
            index = lowercase_letters.index(char)  # 查找字母索引
            new_index = (index + shift) % 26  # 计算新的索引位置
            new_char = lowercase_letters[new_index]  # 获取加密后的字母
            encrypted_message += new_char  # 添加加密后的字母到结果字符串
        
        # 非字母字符保持不变
        else:
            encrypted_message += char
            
    return encrypted_message
```


```python
# 测试加密
decrypted_message1 = "Hello World!"
encrypted_message1 = caesar_cipher_v1(decrypted_message1, shift=3)
print("加密前:", decrypted_message1)
print("加密后:", encrypted_message1)
```

    加密前: Hello World!
    加密后: Khoor Zruog!



```python
# 测试解密
encrypted_message2 = "Ohduqlqj Sbwkrq lv ixqqb!"
decrypted_message2 = caesar_cipher_v1(encrypted_message2, shift=-3)
print("解密前:", encrypted_message2)
print("解密后:", decrypted_message2)
```

    解密前: Ohduqlqj Sbwkrq lv ixqqb!
    解密后: Learning Python is funny!


接着我们对代码进行一些优化：

- 我们之前在字符串那章和大家介绍过，字符串有有两个对应的函数：

    - `ord(字符)` 函数，可以获取字符的 Unicode 编码值
    - `chr(编码)` 函数，可以将 Unicode 编码值转换为对应的字符

- 其实，Python 中的 Unicode 编码值，字母 A-Z 是连续的，字母 a-z 也是连续的，例如：

    - A的编码是65，B的编码是66，C的编码是67，以此类推
    - a的编码是97，b的编码是98，c的编码是99，以此类推

- 也就是说，Python 其实已经帮我们把大写字母和小写字母排好序了，我们不需要再单独创建列表去查找索引位置了
- 代码可以改成这样：


```python
def caesar_cipher_v2(message: str, shift: int = 3) -> str:
    
    # 初始化加密后的消息为一个空字符串
    encrypted_message = ""

    # 遍历消息中的每个字符
    for char in message:
        
        # 处理大写字母
        if 'A' <= char <= 'Z':
            index = ord(char) - ord('A')  # 计算字母在字母表中的索引位置
            new_index = (index + shift) % 26  # 计算新的索引位置
            new_char = chr(new_index + ord('A'))  # 获取加密后的字母
            encrypted_message += new_char  # 添加加密后的字母到结果字符串

        # 处理小写字母
        elif 'a' <= char <= 'z':
            index = ord(char) - ord('a')  # 计算字母在字母表中的索引位置
            new_index = (index + shift) % 26  # 计算新的索引位置
            new_char = chr(new_index + ord('a'))  # 获取加密后的字母
            encrypted_message += new_char  # 添加加密后的字母到结果字符串
        
        # 非字母字符保持不变
        else:
            encrypted_message += char
            
    return encrypted_message
```


```python
# 测试加密
decrypted_message1 = "Hello World!"
encrypted_message1 = caesar_cipher_v2(decrypted_message1, shift=3)
print("加密前:", decrypted_message1)
print("加密后:", encrypted_message1)
```

    加密前: Hello World!
    加密后: Khoor Zruog!



```python
# 测试解密
encrypted_message2 = "Ohduqlqj Sbwkrq lv ixqqb!"
decrypted_message2 = caesar_cipher_v2(encrypted_message2, shift=-3)
print("解密前:", encrypted_message2)
print("解密后:", decrypted_message2)
```

    解密前: Ohduqlqj Sbwkrq lv ixqqb!
    解密后: Learning Python is funny!

