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

## 4. Anaconda - Spyder

## 5. Anaconda - Jupyter Notebook 与 Jupyter Lab
- Jupyter Notebook 是基于网页的交互式开发环境，可以将代码、运行结果、图表、文字说明融合在一个文档中
- 它最大的特点是支持分步运行，适合数据分析与可视化，支持边写代码边记录思路，并且可导出为 HTML、PDF 等格式，方便分享
- Jupyter Notebook 中运行 Python 的并不是 `.py` 格式的文件，而是 `.ipynb` 格式的文件
- Jupyter Notebook 的安装需要在终端中输入 `pip install notebook` 命令，安装好之后需要使用 `jupyter notebook` 命令运行，运行之后会在本地计算机的浏览器上开启一个网页，所有代码编辑和运行都是在网页里进行的
