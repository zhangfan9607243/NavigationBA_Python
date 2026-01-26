# Topic 1.1 - 下载 Anaconda 并创建 Conda 环境

## 1. 下载并安装 Anaconda

Anaconda 是一个开源的 Python 发行版，集成了大量用于数据科学和机器学习的库和工具。它包含了 Python 解释器、包管理器 Conda 以及 Jupyter Notebook 等常用工具：

- 其中最重要的功能就是 Conda 包管理器，它可以帮助我们轻松地安装、更新和管理 Python 包和环境
- 我们知道，Python 是免费开源的，因此第三方库的资源是十分丰富庞大的，这就带来一个问题就是库的版本管理：

    - 我们之前学到过，想要使用哪个第三方库，直接使用 `pip` 工具就可以安装到当前 Python 解释器中
    - 但是，我们能不能直接把所有需要的第三方库都安装到同一个 Python 解释器中呢？答案是不可以的
    - 因为 Python 第三方库其实是相互依赖的，也就是说，第三方库的编写者在开发库的时候，也会使用其他的第三方库
    - 比方说项目一需要用到 A 库，而 A 库依赖于 Pandas 库的 1.0 版本，项目二需要用到 B 库，而 B 库依赖于 Pandas 库的 2.0 版本
    - 这就需要我们维护两个不同的 Python 解释器环境，分别安装不同版本的 Pandas 库

- Conda 就是用来帮助我们管理不同 Python 解释器环境的工具

我们可以从 Anaconda 的官方网站下载 Anaconda 安装包：https://www.anaconda.org

- 网站往下滑有一个 "Download Anaconda" 按钮，点击进入下载页面，之后点击 "Get Started" 按钮
- 之后网站可能会让你注册一个账号，这里直接用自己的邮箱注册一个账号就可以了，完全免费的
- 注册完成之后，进入新的页面，会提示你是下载 "Anaconda Distribution" 还是 "Miniconda"，这里我们选择 "Anaconda Distribution" 的 "Graphical Installer"
- 之后选择对应的操作系统版本（Windows、macOS、Linux）进行下载即可

下载完成后，安装包就会出现在你的电脑上，接下来我们就可以进行安装了：

- 安装过程中全程选择默认选项即可
- 安装完成后，可以打开 "Anaconda Navigator" 这个应用程序，看到以下页面，就说明安装成功了：

<div align="center">
    <img src="../截屏2026-01-26 15.07.25.png" width="800"/>
</div>

- 这里我们可以点击右上角的 "Connect" 按钮，连接 Anaconda Cloud 账号，当然也可以跳过这一步，不连接也没关系

## 2. 创建新的 Conda 环境

这里我们创建一个新的 Conda 环境，用于我们本模块的学习。

首先，我们在 Anaconda Navigator 中，点击左侧的 "Environments" 选项：

- 进入的页面就是 Conda 环境管理页面，这里会列出当前电脑上所有的 Conda 环境，我们可以看到 Anaconda 已经帮我们创建了一个名为 "base (root)" 的默认环境

<div align="center">
    <img src="../截屏2026-01-26 15.15.07.png" width="800"/>
</div>

- 接着，我们点击页面底部的 "Create" 按钮，创建一个新的 Conda 环境
- 在弹出的对话框中，输入新环境的名称（这里我们命名为 "pydata"），并选择 Python 版本，这里我们就选择一个 Python 3.11.x 的版本，点击 "Create" 按钮即可，R 语言环境我们暂时不需要
- 创建完成后，我们就可以在环境列表中看到新创建的 "pydata" 环境了

Anaconda 提供了一种界面式的操作方式来管理 Python 包：

- 我们可以点击上方的 "Installed" 下拉菜单，选择 "Not installed" 选项，可以看到 Anaconda 列出了 pydata 环境中右一万多个未安装的包
- 之后，我们在右上角的搜索框中，输入我们需要安装的包名，比如 "jupyter"，Anaconda 会自动帮我们过滤出符合条件的包
- 选中 "jupyter" 包后，点击右下角的 "Apply" 按钮，Anaconda 就会帮我们自动安装该包及其依赖包
- 同理，我们可以安装本模块需要用到的其他包，比如 "pandas"、"numpy"、"seaborn"、"matplotlib" 等等

在安装完所需的包之后，我们就可以关闭 Anaconda Navigator 了，这个环境其实就存在于我们的电脑上了，之后不打开 Anaconda Navigator 也可以使用这个环境。

## 3. 在 VSCode 中使用 Conda 环境 

在 VSCode 中，只要打开任意一个 Jupyter Notebook （.ipynb）文件，VSCode 编辑器的右上角就会有一个内核选择器（Select Kernel）：

- 点击该选择器，会弹出一个内核选择菜单
- 在菜单中，我们选择 "Select Another Kernel" 选项，再选择 "Python Environment" 选项
- 之后就可以看到我们刚刚创建的 "pydata" 环境，选择该环境即可

此时，pydata 环境就相当于是我们当前 Jupyter Notebook 的 Python 解释器了：

- 我们在这个 Notebook 中运行的所有代码，都会在 pydata 环境中执行
- 比方说，我们运行一下以下代码：


```python
print("Hello World!")
```

    Hello World!


- 我们还可以运行刚刚安装的包中的代码，比如 Numpy 包中的代码：


```python
import numpy as np
print(np.ones((3,4)))
```

    [[1. 1. 1. 1.]
     [1. 1. 1. 1.]
     [1. 1. 1. 1.]]


到此，我们就准备好了进行 Python 数据分析的学习环境：

- 之后如果有其他需要安装的包，我们直接安装到目前的 pydata 环境中即可
- 并且这些安装操作是不会影响我们上两个模块学习所使用的 Python 环境的，因为我们是使用的不同的 Python 环境

## 4. Conda 环境与 Python 环境的区别

到此为止，我们总共见过两种 Python 解释器：

- 一种是我们在前两个模块中使用的 Python 解释器，它是我们从网上下载，然后安装到电脑上的
- 一种是我们通过 Anaconda 创建的 Conda 环境中的 Python 解释器，它是只要安装了 Anaconda，就可以创建很多个不同的 Conda 环境，每个环境中都有一个独立的 Python 解释器

那这两种 Python 解释器有什么区别呢？这里我们简单理解就好：

- 第一种 Python 解释器是“实实在在存在的“：

    - 它是我们直接安装到电脑上的 Python 解释器
    - 对安装包的管理是直接通过 Python 的 `pip` 工具来进行的

- 第二种 Conda 环境中的 Python 解释器是“虚拟的“：

    - 它是依赖于 Anaconda 这个工具创建出来的，并且只能在 Anaconda 创建的环境中使用
    - 对安装包的管理是通过 Conda 工具来进行的：要么通过 Anaconda Navigator 这个图形界面工具来管理，要么通过 Conda 命令行工具来管理（命令行我们后面会补充介绍）
