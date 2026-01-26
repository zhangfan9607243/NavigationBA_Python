# Topic 1.3 - 使用命令行管理 Conda 环境（补充）

在前面的章节中，我们介绍了如何通过 Anaconda Navigator 来创建和管理 Conda 环境，并在其中安装所需的包：

- 事实上，Conda 还提供了强大的命令行工具，允许我们通过终端来创建、管理环境以及安装包
- 之前我们讲过，如果是 Python 环境，我们可以通过 `pip` 命令来进行包的安装和管理
- 而对于 Conda 环境，我们可以使用 `conda` 命令来进行类似的操作

## 1. 环境的创建与激活

### (1) 创建 Conda 环境

如果想创建一个新的 Conda 环境，我们之前是使用 Anaconda Navigator 的图形界面来操作的：

- 先在 Anaconda Navigator 中点击 "Environments" 标签
- 然后点击 "Create" 按钮，输入环境名称和选择 Python 版本，最后点击 "Create" 即可

同样的操作使用命令行也可以完成：

```bash
conda create --name 环境名 python=版本号
```

例如，我们创建一个名为 `pydata1` 的 Conda 环境，并指定 Python 版本为 3.9：

```bash
conda create --name pydata1 python=3.9
```

### (2) 激活 Conda 环境

创建好环境后，我们需要激活它才能在该环境中安装包和运行代码：

```bash
conda activate 环境名
```

例如，激活我们刚创建的 `pydata1` 环境：

```bash
conda activate pydata1
```

注意，激活环境后，才能进行我们后续讲的包安装和管理的操作。

### (3) 退出 Conda 环境

当我们不再使用某个 Conda 环境时，可以通过以下命令退出该环境，返回到基础环境：

```bash 
conda deactivate
```

### (4) 删除 Conda 环境

如果某个 Conda 环境不再需要，可以通过以下命令将其删除：

```bash
conda remove --name 环境名 --all
```


## 2. 包的安装与管理

### (1) 安装包

在 Conda 环境中安装包同样可以使用命令行来完成，这里我们使用的命令是 `conda install`：

```bash
conda install 包名1 包名2 ...
```

例如，我们想安装 `numpy` 和 `pandas` 这两个常用的数据分析包，可以使用以下命令：

```bash
conda install numpy pandas
```

并且，在安装的时候我们还可以指定包的版本号：

```bash
conda install 包名1=版本号 包名2=版本号 ...
```

例如，我们安装指定版本的 `matplotlib` 与 `seaborn`：

```bash
conda install matplotlib=3.4.3 seaborn=0.11.2
```

### (2) 升级包

如果想要升级某个包，使用的命令是 `conda update`：

```bash
conda update 包名1 包名2 ...
```

例如，我们想升级 `pandas` 与 `numpy`：

```bash
conda update pandas numpy
```

并且，升级也是支持指定版本号的：

```bash
conda update 包名1=版本号 包名2=版本号 ...
```

例如，我们升级 `scipy` 到指定版本：

```bash
conda update scipy=1.7.1
```

### (3) 删除包

如果想要删除某个包，使用的命令是 `conda remove`：

```bash
conda remove 包名1 包名2 ...
```

例如，我们想删除 `matplotlib` 与 `seaborn`：

```bash
conda remove matplotlib seaborn
```
