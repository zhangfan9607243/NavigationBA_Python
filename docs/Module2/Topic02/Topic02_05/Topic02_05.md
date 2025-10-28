# Topic 2.5 - `print()` 函数拓展功能

在前面我们已经用过 `print()` 来输出信息。实际上，`print()` 函数还有很多拓展功能，可以帮助我们控制输出的格式。  

## 1. `print()` 中函数不加任何内容：空行

`print()` 函数在不加任何的参数的时候，效果是空一行

- 示例：我们新建一个 `t02_06_print_01.py`，并且运行以下代码：

```python
print("Hello World!")
print()
print("Hello Python!")
```

- 输出：

```text
Hello World!

Hello Python!
```

## 2. 输出多个内容
`print()` 可以一次输出多个变量或值，使用逗号 `,` 分隔：  

- 示例：我们在 `t02_06_print_01.py` 中运行以下代码：

```python
name = "小明"
age = 18
print("姓名：", name, "年龄：", age)
```

- 输出：

```text
姓名： 小明 年龄： 18
```

- 可以看到，Python 默认会在逗号分隔的内容之间加一个空格

## 3. `end` 参数： 控制行尾

默认情况下，print() 在输出内容后会自动换行（相当于在结尾加了一个换行符 `\n`）。

- 我们可以通过设置 `end` 参数，改变行尾的输出内容。

- 示例：我们新建一个 `t02_06_print_02.py`，并且运行以下代码：

```python
print("Hello", end=" ")
print("Python")
```

- 输出为：

```text
Hello Python
```

- 如果将 `end` 中填入空字符串：`end=""`，就会把前后输出内容连在一起：

```python
print("Hello", end="")
print("Python")
```

- 输出：

```text
HelloPython
```

思考题：如何使用 `end` 参数输出 `Hello Python!` 呢？

- 答案：

```python
print("Hello", end=" ")
print("Python", end="")
print("!")
```

- 输出：

```text
Hello Python!
```

## 4. `sep` 参数：控制分隔符

在使用 `print()` 函数进行多个内容输出时，多个输出的内容之间默认用一个空格分隔：

- 我们可以通过 `sep` 参数修改分隔符：
- 示例：我们新建一个 `t02_06_print_03.py`，并且运行以下代码：

```python
print("2025", "01", "01", sep="-")
```

- 输出：

```text
2025-01-01
```

- 或者把分隔符改成 `\` 试一下：

```python
print("2025", "12", "31", sep="/")
```

- 输出：

```text
2025/12/31
```

- 注意，`sep` 函数只是规定了输出内容两两之间的分隔符，并没有像 `end` 参数那样，将结尾也换成分隔符

- 接下来我们看一个 `sep` 与 `end` 二合一的综合应用：

```python
print("2025", "12", "31", sep="-", end=" ")
print("22", "45", "30", sep=":")
```

- 结果为：

```text
2025-12-31 22:45:30
```