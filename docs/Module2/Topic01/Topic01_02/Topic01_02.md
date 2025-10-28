# Topic 1.2 - Python 与 PyCharm 安装

## 1. Python解释器安装

Python是一门解释型语言，运行程序需要依赖**解释器** - 我们常说的安装 Python，实际上就是在安装 Python 的解释器：

- Python 解释器就好比是一个字典，计算机的出厂设置是只听得懂机器语言（0 和 1），要想听懂其他的编程语言，如 Python、C、Java 等，就必须依赖解释器来将编程语言翻译成机器语言
- 解释器的作用就是在 Python 语言和计算机语言之间做实时翻译：当你写下一行 Python 代码时，解释器会把它一句一句翻译成机器能理解的指令，然后交给计算机执行
- 因此，没有解释器，计算机是无法直接运行 Python 程序的

Python 解释器官方下载地址：[https://www.python.org](https://www.python.org)

- 建议安装 Python 3.12 之后的任意的 Python 3.x 版本，避免使用老旧的 Python 2.x 版本
- 要选择与自己操作系统相匹配的安装器
- Python 解释器安装到电脑上之后，就是以一个应用程序的形式存在的，并且它所在的路径（文件夹）很重要
- Python 解释器安装完毕后，可以在终端运行以下命令检查是否安装成功：

```bash
python --version
```

## 2. PyCharm集成开发环境安装
安装完 Python 解释器之后，我们还需要使用集成开发环境（IDE）来提高编程效率：

- Python 解释器就像一本厚重的字典，可以让计算机逐条理解 Python 语言，但仅靠查阅字典往往既慢又不方便
- 而 IDE 则更像是一款智能翻译软件，不仅能帮电脑快速翻译，还提供了许多便捷的编程功能，大大提升了开发体验和效率

PyCharm 是目前应用最广泛的 Python IDE之一：

- 虽然许多人在学习后期可能会转向更为通用和强大的开发工具，如 VSCode，但 VSCode 面向所有编程语言，功能丰富的同时也增加了上手难度
- 相比之下，PyCharm 专为 Python 开发而设计，界面简洁、功能集中，更适合初学者快速入门
- 掌握 PyCharm 后，再过渡到 VSCode 等更高级的 IDE 会更加顺利

PyCharm 官方下载地址：[https://www.jetbrains.com/pycharm](https://www.jetbrains.com/pycharm)

- PyCharm 分为社区版（免费）和专业版（收费）
- 社区版就已经可以满足学习和日常使用需求
- 专业版虽然收费，但是在校学生在官网获得教育认证后就可以免费使用

PyCharm 安装完成后，首次启动我们做以下设置：
- 配置 Python 解释器路径
- 新建或导入项目与文件
- 运行一个简单的程序来测试配置，这里我们运行一个 `print("Hello World!")`：在控制台打印"Hello World!"