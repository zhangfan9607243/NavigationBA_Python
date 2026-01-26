# Topic 1.2 - Anaconda 中的其他功能（补充）

在 Anaconda Navigator 的首页中，大家可以看到 Anaconda 集成了很多常用的数据科学工具：

- 这些工具其实和 VS Code 类似，大家可以笼统地理解为运行 Python 代码的不同 IDE（集成开发环境）
- 只不过这些 IDE 各有各的特点，而有些开发者正是看中了这些特点，才选择使用它们来进行 Python 开发工作的
- 并且大家在有些课程中，老师可能制定这些工具作为课程的指定开发工具
- 本节我们来简单介绍一下 Anaconda 中集成的这些常用工具

## 1. Jupyter Notebook

Jupyter Notebook 是一个早期非常流行的 Python 交互式编程环境，是运行 `.ipynb` 文件的主要工具：

- Jupyter Notebook 以网页的形式运行，用户可以在网页中编写和运行代码，并且可以将代码、文本、图像等内容混合在一个文档中
- 我们在 VS Code 中运行 `.ipynb` 文件时，实际上也是调用的 Jupyter Notebook 的内核来执行代码的
- 只不过原装的 Jupyter Notebook 功能相对简单，界面也不如 VS Code 美观和易用，因此现在更多人选择在 VS Code 中使用 Jupyter Notebook 的功能

我们在 Anaconda Navigator 中点击 Jupyter Notebook 图标，就可以启动 Jupyter Notebook：

- 启动时先会打开一个终端窗口，然后在默认浏览器中打开 Jupyter Notebook 的主页，注意这个终端窗口不能关闭

<div align="center">
    <img src="../截屏2026-01-26 18.09.34.png" width="800"/>
</div>

- 在 Jupyter Notebook 中，我们可以浏览和管理计算机中的文件，并且可以新建或打开已有的 Jupyter Notebook 文件进行编辑和运行

<div align="center">
    <img src="../截屏2026-01-26 18.18.05.png" width="800"/>
</div>

<div align="center">
    <img src="../截屏2026-01-26 18.18.38.png" width="800"/>
</div>

- 注意，虽然是在浏览器中打开的，但是 Jupyter Notebook 并不是一个在线工具，所有的文件和代码都是在本地计算机上运行和存储的，浏览器只是作为一个界面来使用而已
- 大家可以看到，Jupyter Notebook 中的功能其实和我们在 VS Code 中运行 `.ipynb` 文件时的功能是类似的
- 如果要想关闭 Jupyter Notebook，只需要关闭浏览器窗口，然后关闭终端窗口即可

事实上，大家应该也体会到了，要想在 Jupyter Notebook 中运行代码是有些费劲的：

- 因此，许多 IDE（包括 VS Code）都集成了 Jupyter Notebook 的功能，而且做得更好用一些
- 这也就是为什么现在越来越少人直接使用 Jupyter Notebook，而是选择在 VS Code 中使用 `.ipynb` 文件的原因了

## 2. Jupyter Lab

Jupyter Lab 是 Jupyter Notebook 的升级版，我们可以直接在 Anaconda Navigator 中点击 Jupyter Lab 图标来启动 Jupyter Lab：

<div align="center">
    <img src="../截屏2026-01-26 18.27.17.png" width="800"/>
</div>

<div align="center">
    <img src="../截屏2026-01-26 18.27.50.png" width="800"/>
</div>

- 大家会发现，启动 Jupyter Lab 时并不需要打开终端窗口，直接在浏览器中打开 Jupyter Lab 的主页即可
- 同样地，Jupyter Lab 也是一个本地运行的工具，浏览器只是作为一个界面来使用而已

Jupyter Lab 相比 Jupyter Notebook 有很多改进和增强的功能：

- Jupyter Lab 提供了更灵活的布局和界面，用户可以同时打开多个文件和面板，并且可以自由调整它们的位置和大小
- Jupyter Lab 支持更多类型的文件和内容，例如文本文件、Markdown 文件、Python 脚本等
- Jupyter Lab 支持终端和代码控制台，用户可以直接在 Jupyter Lab 中运行命令行操作和交互式代码

大家可以发现这个界面和当前主流的 IDE 界面很像了，但是距离功能强大的主流 IDE 还有一定差距，因此目前也很少人直接使用 Jupyter Lab 进行开发工作。

## 3. Spyder

Spyder 是一个运行 Python 代码的集成开发环境（IDE），目前只支持 `.py` 文件，并不支持运行 `.ipynb` 文件。

我们可以直接在 Anaconda Navigator 中点击 Spyder 图标来启动 Spyder：

<div align="center">
    <img src="../截屏2026-01-26 17.20.24.png" width="800"/>
</div>

- Spyder 的界面和功能其实比较独特，大家如果使用过 RStudio，应该会觉得 Spyder 和 RStudio 有些类似：左边是代码编辑区，右上角是变量，右下角是控制台和输出区
- Spyder 最重要的功能特点就是支持选中一部分代码进行运行，而不是像大多数 IDE 那样只能运行整个文件，这个也跟 RStudio 运行 R 代码的方式是类似的
- 所以，严格来讲，这种功能进行代码调试其实是比 `.ipynb` 文件更方便一些的，因此现在依然有不少人使用 Spyder 进行 Python 开发工作


