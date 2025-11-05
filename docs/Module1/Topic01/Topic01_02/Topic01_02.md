# Topic 1.2 - Python 与 PyCharm 安装

## 1. Python 解释器安装

Python 是一门解释型语言，运行程序需要依赖**解释器** - 我们常说的安装 Python，实际上就是在安装 Python 的解释器：

- Python 解释器就好比是一个字典，计算机的出厂设置是只听得懂机器语言（0 和 1），要想听懂其他的编程语言，如 Python、C、Java 等，就必须依赖解释器来将编程语言翻译成机器语言
- 解释器的作用就是在 Python 语言和计算机语言之间做实时翻译：当你写下一行 Python 代码时，解释器会把它一句一句翻译成机器能理解的指令，然后交给计算机执行
- 因此，没有解释器，计算机是无法直接运行 Python 程序的

Python 解释器官方下载地址：[https://www.python.org](https://www.python.org)

- 建议安装 Python 3.12 之后的任意的 Python 3.x 版本，避免使用老旧的 Python 2.x 版本
- 要选择与自己操作系统相匹配的安装器
- Python 解释器安装到电脑上之后，就是以一个应用程序的形式存在的

## 2. VS Code 集成开发环境安装
### (1) VS Code 介绍
安装完 Python 解释器之后，我们还需要使用集成开发环境（IDE）来提高编程效率：

- Python 解释器就像一本厚重的字典，可以让计算机逐条理解 Python 语言，但仅靠查阅字典往往既慢又不方便
- 而 IDE 则更像是一款智能翻译软件，不仅能帮电脑快速翻译，还提供了许多便捷的编程功能，大大提升了开发体验和效率

VS Code (Visual Studio Code) 是目前最流行的免费开源集成开发环境之一，由微软开发，支持多种编程语言：

- 界面简洁，功能强大，从初学者到专业开发者都能轻松上手
- 拥有资源管理、代码编写、运行调试、版本控制等多种实用功能，基本不需要额外配置即可使用
- 拥有丰富的插件生态，可以根据需要扩展功能

### (2) VS Code 安装与配置
VS Code 官方下载地址：[https://code.visualstudio.com/](https://code.visualstudio.com/)

- 同样，选择与自己操作系统相匹配的安装器进行安装
- 注意不要安装成 VS (Visual Studio)，这两个是不同的软件

VS Code 安装完成后，如果要进行 Python 开发，还需要安装以下插件：

- Python 插件：提供语法高亮、代码补全、调试等功能
- Pylance 插件：提供更智能的代码分析和类型检查功能
- PythonDebugger 插件：提供更强大的调试功能
- Jupyter 插件4合1：支持在 VS Code 中直接运行和编辑 Jupyter Notebook 文件
- Jupyter PowerToys 插件：提供额外的 Jupyter Notebook 功能，如变量查看器、数据表格预览等

### (3) 创建工作空间并运行 Python 程序
在安装好 VS Code 之后，我们在桌面建立一个文件夹，作为我们后续编写 Python 代码的工作空间（Workspace），然后用 VS Code 打开该文件夹即可开始开发：

- 建立一个新建文件夹，命名为 `Topic01`，再在该文件夹下建立一个子文件夹 `Topic01_02`
- 建立一个新的文件，命名为 `hello.py`，并输入以下代码：

```python
print("Hello World!")
```

- 在该文件的右下角，选择 Python 解释器，这个解释器就是我们之前安装的 Python 解释器
- 点击右上角的运行按钮，即可在终端看到程序输出 `Hello World!`
- 到此大家就已经成功运行了第一个 Python 程序😄

运行 Python 的程序有很多方法，大家都是 BA 专业的学生，更常用的是 Jupyter Notebook：

- 接下来我们新建一个 Jupyter Notebook 文件 `Topic01_02.ipynb`
- 打开文件后，新建一个代码单元，输入以下代码：

```python
print("Hello World!")
```

- 点击右上角，选择 Kernel 为 刚刚下载的 Python 解释器
- 然后点击运行按钮，这时候可能提示需要安装 ipykernel，选择安装即可
- 程序运行后，同样可以在下方看到输出 `Hello World!`

Python 文件 `.py` 和 Jupyter Notebook 文件 `.ipynb` 是两种不同的运行 Python 程序的方式：

- `.py` 文件适合编写和运行完整的 Python 程序，在运行时会从头到尾执行所有代码，不便于分步调试，但是用户交互效果比较好
- `.ipynb` 文件则适合分步运行代码单元，方便调试和展示结果，但是用户交互效果较差
