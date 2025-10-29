# Topic 2.1 - 一些简单的 Python 程序

## 1. 单行 Python 程序

首先我们来复习一下上一章的打印 `Hello World!` 的简单程序：

```python
print("Hello World!")
```

```text
Hello World!
```

## 2. 多行 Python 程序

接着我们来写一个含有多行代码的程序：

```python
print("Hello World!")
print("Hello Python!")
print("欢迎来到编程世界")
```

```text
Hello World!
Hello Python!
欢迎来到编程世界
```

在 Python 中，代码是按行执行的，并且遵循严格的代码规范：

- 不可以将两句代码写在一行用空格连接
- 可以有空白行
- 除非严格的缩进关系，否则每行代码前面不可以空格
- 如果一句代码太长，可以使用 `\` 连接两行，但是 Python 官方不推荐这样做，因为写出来的代码比较难看

通过这个简单的多行代码程序，我们可以简单地看出 Python 程序的运行顺序：

- Python 程序执行时，会将整个文件中的所有代码全部运行，不会跳过任何一行代码，严格按照文件中从上到下的顺序依次运行
- 如果中途某一行出现错误（Bug），Bug 之后的代码将不会继续运行
- 如果想让 Python 分步运行，就要用到 PyCharm 中的 debug + 断点运行功能，我们这次不点击运行，而是点击 debug 试试效果
- 可以看出 debug 这种分步运行方式并不好用，之后我们会介绍在 Python 数据分析中使用一种更好用的分步运行方式 - Jupyter Notebook

## 3. 多文件 Python 程序

在 PyCharm 中，只需右键选择要运行的文件，即可分别运行不同的程序：

- 如果想让 PyCharm 总是默认运行当前文件，可以在右上角 `configuration` 那里固定到 `current file`

- 要注意在 Python 程序开发中，往往我们会指定一个 Python 主文件用来运行，其他文件都是辅助，我们在后续课程中会慢慢体会这个过程