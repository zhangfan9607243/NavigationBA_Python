# Topic 1.4 - 其他运行 Python 的方式（补充）

除了在 PyCharm 中运行 Python 程序外，我们还可以通过多种方式来体验和使用 Python：

## 1. Python 命令运行 Python 文件：
- 在编写好 Python 文件后，可以在终端命令行中输入 `python + 文件名.py` 的命令来运行该文件
- 这种方法是Python程序运行的最基本方法，简单直接，执行时会从头到尾运行整个文件，但是不便于调试



## 2. Python 交互式命令行：  
- 安装 Python 后，可以在终端命令行中输入 `python` 进入交互式环境，运行结束后使用 `quit()` 退出
- 这种方法简单直接，适合快速测试语句或函数，但不适合编写较长程序



## 3. IPython  
- IPython 是对标准 Python 交互式环境的增强版
- IPython 需要提前安装，安装命令是 `pip install ipython`
- 之后在终端命令行中输入 `ipython` 进入 IPython 的交互式环境，运行结束后使用 `quit()` 退出



## 4. PyCharm

PyCharm 由 JetBrains 开发，是目前最流行的 Python 集成开发环境（IDE）之一，提供了强大的代码编辑、调试、测试和版本控制等功能，适合专业的 Python 开发者使用

- PyCharm 是专门为 Python 设计的 IDE，其界面布局和 VS Code 差不多，有代码编辑区、文件浏览区、运行区等
- PyCharm 只能运行 Python 程序，基本不支持其他编程语言，如果只写 Python 的话，PyCharm 是一个不错的选择
- PyCharm 的代码运行结果会显示在下方的“运行”窗口中，方便查看、调试、与互动，这个其实是比 VS Code 那样只在终端显示结果要方便一些，很开发者比较看重这一点，所以选择 PyCharm
- PyCharm 有免费版（Community Edition）和付费版（Professional Edition），免费版制只支持运行 `.py` 格式的文件，要想运行 `.ipynb` 文件，还需要使用付费版，但是大家可以上传学生证或在校证明免费申请专业版的使用权限

## 5. Anaconda - Spyder
首先，Anaconda 是一个集成了 Python 解释器和众多数据科学相关库的工具包

- 大家可以将 Anaconda 理解为是一个，将所有写 Python 代码所需的工具都打包在一起的“大礼包”
- "Anaconda" 这个词是蟒蛇的意思，"Python" 也是蟒蛇的意思，所以 Anaconda 开发者的初衷，就是为了和 Python 配套的
- 当然，Anaconda 最强大的功能其实是它可以比价方便地创建新的虚拟环境，我们会在后续的课程中介绍这一点

Anaconda 的官网地址是：[https://www.anaconda.com/](https://www.anaconda.com/)

- 注意，很多网站都叫 Anaconda，例如墨尔本一家卖野炊用品的连锁店也叫 Anaconda，大家如果 Google 的话，不要点错了😂
- 大家可以下载 Anaconda 的安装包，安装 Anaconda Navigator
- 下载完成之后，打开 Anaconda Navigator，可以看到其中集成了多个常用的开发工具，其中就包括 Spyder

Spyder 打开之后，可以发现比较类似于 PyCharm 的界面，有代码编辑区、运行结果输出区、终端等功能模块

- Spyder 最大的一个特点就是它集成了 IPython 控制台，支持选定一段代码运行，方便调试和测试代码片段
- 这个功能就有点像 RStudio 中的“运行选中代码”功能，有些同学比较喜欢这一点，所以会选择 Spyder 来写 Python 代码

## 6. Anaconda - Jupyter Notebook 与 Jupyter Lab

Anaconda 中的 Jupyter Notebook 是基于网页的交互式开发环境，是运行 `.ipynb` 文件的一种原始的方式

- 大家打开 Anaconda Navigator，可以看到其中集成了 Jupyter Notebook
- 点开 Jupyter Notebook 之后，会在本地计算机的浏览器上开启一个网页，所有代码编辑和运行都是在网页里进行的
- 注意，这个网页并不是联网的网页，只是通过浏览器来显示本地内容而已，代码在这里运行也是在本地计算机上运行的，耗费自己的计算资源

除此之外还有个 Jupyter Lab，是 Jupyter Notebook 的升级版，也是通过网页来编写运行 `.ipynb` 文件的

- Jupyter Lab 比 Jupyter Notebook 多了很多功能，界面也更现代化一些
- Jupyter Lab 最大的改进在于它支持编写和运行 `.py` 文件，有时如果写大规模的项目，需要 `.py` 文件与 `.ipynb` 文件混搭使用，这样 Jupyter Lab 会更方便一些
- 在 VS Code 流行起来之前，Jupyter Lab 是很多数据科学家的首选工具

目前呢，这两种运行 `.ipynb` 文件的方式都不如 VS Code 方便，建议大家优先使用 VS Code 来运行和编辑 Jupyter Notebook 文件
