# Topic 2.5 - Python 程序的输出

## 1. `print()` 函数拓展功能

在前面我们已经用过 `print()` 来输出信息。实际上，`print()` 函数还有很多拓展功能，可以帮助我们控制输出的格式。  

### (1) `print()` 中函数不加任何内容：空行

`print()` 函数在不加任何的参数的时候，效果是空一行


```python
print("Hello World!")
print()
print("Hello Python!")
```

    Hello World!
    
    Hello Python!


### (2) 输出多个内容
`print()` 可以一次输出多个变量或值，使用逗号 `,` 分隔，Python 默认会在逗号分隔的内容之间加一个空格：  


```python
name = "小明"
age = 18
print("姓名：", name, "年龄：", age)
```

    姓名： 小明 年龄： 18


### (3) `end` 参数： 控制行尾

默认情况下，print() 在输出内容后会自动换行（相当于在结尾加了一个换行符 `\n`）。

- 我们可以通过设置 `end` 参数，改变行尾的输出内容。


```python
print("Hello", end=" ")
print("Python")
```

    Hello Python


- 如果将 `end` 中填入空字符串：`end=""`，就会把前后输出内容连在一起：


```python
print("Hello", end="")
print("Python")
```

    HelloPython


- 思考题：如何使用 `end` 参数输出 `Hello Python!` 呢？


```python
print("Hello", end=" ")
print("Python", end="")
print("!")
```

    Hello Python!


### (4) `sep` 参数：控制分隔符

在使用 `print()` 函数进行多个内容输出时，多个输出的内容之间默认用一个空格分隔：

- 我们可以通过 `sep` 参数修改分隔符：


```python
print("2025", "01", "01", sep="-")
```

    2025-01-01


- 或者把分隔符改成 `/` 试一下：


```python
print("2025", "12", "31", sep="/")
```

    2025/12/31


- 注意，`sep` 函数只是规定了输出内容两两之间的分隔符，并没有像 `end` 参数那样，将结尾也换成分隔符

- 接下来我们看一个 `sep` 与 `end` 二合一的综合应用：


```python
print("2025", "12", "31", sep="-", end=" ")
print("22", "45", "30", sep=":")
```

    2025-12-31 22:45:30


## 2. Jupyter Notebook 中的输出

### (1) Jupyter Notebook 自动输出最后一行内容

在 Jupyter Notebook 中，除了使用 `print()` 函数输出内容外，还可以直接在单元格的最后一行写上想要输出的变量或表达式，Jupyter Notebook 会自动将其输出


```python
text1 = "Hello World!"
text1
```




    'Hello World!'




```python
number = 100
number
```




    100



### (2) 使用 `display()` 函数输出多个内容

如果想让 Jupyter Notebook 单元格输出多个内容，可以使用 `display()` 函数：


```python
text2 =  "Hello Python!"
display(text2)

text3 = "Hello Jupyter!"
display(text3)
```


    'Hello Python!'



    'Hello Jupyter!'


`display()` 函数可以接收多个参数，并将它们逐一输出：


```python
display(text1, text2, text3)
```


    'Hello World!'



    'Hello Python!'



    'Hello Jupyter!'


### (3) `display()` 与 `print()` 的区别

`display()` 与 `print()` 的区别在于：

- `print()` 函数会将输出的对象以字符串（Python 中的文字）的形式展示出来
- `display()` 函数则会根据对象的类型，选择最合适的方式进行展示，比方说我们后续会接触到表格、图像、交互式控件等复杂对象时，`display()` 就会更实用些
- 这里大家简单了解一个通用规律即可：字符串适合用 `print()` 输出，其它对象适合用 `display()` 输出
