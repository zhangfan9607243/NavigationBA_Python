# Topic 12.4 - 常用的第三方模块与包（补充）

在 Python 的生态系统中，除了内置模块和包之外，还有大量的第三方模块和包可供使用

- 这些第三方模块和包由全世界的开发者创建和维护，并且自愿开源分享
- 目前流行的 Python 第三方模块涵盖各种功能和应用场景，丰富了 Python 的使用体验

本章我们来介绍一些常用的第三方模块和包，涉及到数据分析的包：如 `numpy`、`pandas`、`matplotlib` 等，我们会在后续的数据分析模块中进行详细介绍，这里先不多说。

## 1. 第三方包的安装与使用

### (1) 安装第三方包

Python 内置模块和包，与第三方模块和包，最大的区别在于，第三方模块和包需要通过包管理工具（如 `pip`）进行安装，之后才能在代码中使用。

安装第三方包的命令需要在**终端中运行**，不是 Python 中运行：

- 安装一个包的终端命令格式为：

    ```bash
    pip install package_name
    ```

- 安装多个包的终端命令格式为：

    ```bash
    pip install package_name1 package_name2 package_name3
    ```

- 例如，我们安装这一节要介绍的几个包：

    ```bash
    pip install joblib tqdm
    ```

安装完成后，就可以在代码中使用 `import` 语句导入这些包了：

```python
import joblib
import tqdm
```

- 安装的命令只需要运行一次，安装完成后就可以在任何 Python 代码中使用这些包了
- 如果没有安装，或者安装失败，在运行 `import` 代码时会报错 `ModuleNotFoundError`

终端命令的运行有多种方式：

- 最直接的就是在 VS Code 中新建一个终端窗口
- 其实在 Jupyter Notebook 中也可以运行终端命令，只需要在命令前加上 `!` 符号即可，这是 Jupyter Notebook 的魔法命令，例如：

    ```python
    !pip install package_name
    ```

- 注意，这种方式只能在 `.ipynb` 文件中使用，在 `.py` 文件中不能使用

### (2) 升级第三方包

第三方包由开发者们持续维护和更新，可能会发布新版本以修复 bug 或添加新功能。

- 升级一个包的终端命令格式为：

    ```bash
    pip install --upgrade package_name
    ```

- 升级多个包的终端命令格式为：

    ```bash
    pip install --upgrade package_name1 package_name2 package_name3
    ```

- 例如，我们升级刚才安装的几个包：

    ```bash
    pip install --upgrade joblib tqdm
    ```

### (3) 卸载第三方包
如果不再需要某个第三方包，可以通过卸载命令将其移除。

- 卸载一个包的终端命令格式为：

    ```bash
    pip uninstall package_name
    ```

- 卸载多个包的终端命令格式为：

    ```bash
    pip uninstall package_name1 package_name2 package_name3
    ```

但是，由于 Python 卸载后如果需要再次使用还需要重新安装，所以一般不建议频繁卸载包。

## 2. `joblib` 模块

`joblib` 模块主要用于高效地进行大规模数据运算，最常用的功能就是并行计算了。

### (1) Python 程序的单线程执行

我们目前为止接触到的 Python 代码，都是在**单线程**下顺序运行的：

比方说我们有以下列表，我们想将列表中的每个数字都进行平方计算，然后将平方后的数字求和：



```python
data = range(1, 101)

def compute_square(x):
    return x * x

data_squared = []

for num in data:
    result = compute_square(num)
    data_squared.append(result)

total = sum(data_squared)
print("平方和：", total)
```

    平方和： 338350


在上面的代码中，我们计算平方的过程是**顺序执行**的：

- 先计算 `1` 的平方，然后计算 `2` 的平方，依次类推，直到计算完所有数字的平方

- 但是，我们仔细分析发现，计算每个数字的平方其实是**相互独立**的操作，计算 `1` 的平方并不依赖于计算 `2` 的平方

- 因此，如果能够同时计算多个数字的平方，就能大大提升计算效率

### (2) 使用 `joblib` 实现并行计算

`joblib` 模块提供了非常方便的并行计算功能，我们可以利用它来同时计算多个数字的平方：


```python
from joblib import Parallel, delayed

data = range(1, 101)

def compute_square(x):
    return x * x

data_squared = Parallel(n_jobs=-1)(delayed(compute_square)(num) for num in data)

total = sum(data_squared)
print("平方和：", total)
```

    平方和： 338350


在上面的代码中，

- `Parallel()` 函数用于创建一个并行计算的环境
- `n_jobs` 指定可用的 CPU 核心数，指定为 `-1` 表示使用所有可用的核心
- `delayed()` 函数用于将需要并行执行的函数进行包装，使其可以被 `Parallel()` 调用

通过这种方式，`joblib` 会自动将计算任务分配到多个 CPU 核心上同时执行，从而大大提升计算效率

## 3. `tqdm` 模块

`tqdm` 模块用于在 Python 程序中显示进度条，特别适合用于长时间运行的循环或任务，让用户可以直观地看到任务的进展情况

### (1) 在循环中使用 `tqdm`

`tqdm` 在执行循环时，须要将可迭代对象（如 `range()`）包裹在 `tqdm` 函数中，这样就能在循环开始时显示一个进度条。

我们可以很方便地在循环中使用 `tqdm` 来显示进度条：



```python
from tqdm import tqdm
import time

for i in tqdm(range(100)):
    # 模拟一些耗时操作
    time.sleep(0.1)
```

    100%|██████████| 100/100 [00:10<00:00,  9.47it/s]


在上面的代码中:

- `tqdm(range(100))` 会在循环开始时显示一个进度条
- 随着循环的进行，进度条会动态更新，显示当前的进度百分比、已用时间和预计剩余时间


### (2) 在 `joblib` 并行计算中使用 `tqdm`

`tqdm` 还可以与 `joblib` 结合使用，在并行计算时显示进度条，只需将 `tqdm` 包裹在可迭代对象外层即可：

例如，我们将前面的并行计算平方和的例子，加入进度条显示：


```python
from joblib import Parallel, delayed
from tqdm import tqdm
import time

data = range(1, 101)

def compute_square(x):
    time.sleep(0.1)  # 模拟耗时操作
    return x * x

data_squared = Parallel(n_jobs=-1)(delayed(compute_square)(num) for num in tqdm(data))
total = sum(data_squared)
print("平方和：", total)
```

    100%|██████████| 100/100 [00:01<00:00, 96.54it/s]


    平方和： 338350

