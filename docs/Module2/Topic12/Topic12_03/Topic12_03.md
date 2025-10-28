# Topic 12.3 - 常用的内置模块与包（补充）

在之前的学习中，我们已经了解了一些 Python 的内置模块与包，包括：

- `math` 模块：提供数学相关的函数和常量
- `random` 模块：用于生成随机数
- `copy` 模块：用于对象的浅拷贝和深拷贝
- `json` 模块：用于处理 JSON 数据
- `csv` 模块：用于处理 CSV 文件

除此之外，Python 还提供了许多其他有用的内置模块和包，我们本章来介绍一些常用的。

这章介绍到的模块和包只作简单了解即可，当我们以后有具体需求时，再查阅相关文档进行深入学习。


## 1. `time` 模块

`time` 模块提供了与时间相关的各种函数，可以用于获取当前时间、暂停程序执行等：

### (1) 获取时间戳

`time` 模块中常见的功能就是获取时间**时间戳**，使用的函数是 `time()`：

- 时间戳是一个浮点数，表示**自1970年1月1日以来过了多少秒**，整数部分表示秒，小数部分表示微秒
- 大家有的时候在电脑上或手机上，看到有些文件的创建时间会奇怪地显示为 `1970年1月1日`，那是因为这些文件的时间戳被错误地设置为了 `0`

```python
import time
print(time.time())
print(type(time.time()))
```

```text
1760674553.948184
<class 'float'>
```

时间戳最常用的场景是计算程序运行时间：

```python
import time

# 记录开始时间
start_time = time.time()

# 执行一个程序
for i in range(1000000):
    pass

# 记录结束时间
end_time = time.time()

# 计算并打印程序运行时间
print(f"程序运行时间：{end_time - start_time} 秒")
```

```text
程序运行时间：0.06046271324157715 秒
```

### (2) 获取时间

当然，时间戳来表示时间太过于抽象了，以下函数常用于获取意义明确的**年月日时分秒形式的时间**：

- `localtime()`：返回当前时间的本地时间表示，返回一个时间元组
- `gmtime()`：返回当前时间的格林威治时间表示，返回一个时间元组
- `strftime(格式, 时间元组)`：将时间格式转化为字符串

```python
import time

local_time = time.localtime()
print(local_time)
print(type(local_time))
print(time.strftime("%Y-%m-%d %H:%M:%S", local_time))

gmt_time = time.gmtime()
print(gmt_time)
print(type(gmt_time))
print(time.strftime("%Y-%m-%d %H:%M:%S", gmt_time))
```

```text
time.struct_time(tm_year=2025, tm_mon=10, tm_mday=17, tm_hour=15, tm_min=16, tm_sec=41, tm_wday=4, tm_yday=290, tm_isdst=1)
<class 'time.struct_time'>
2025-10-17 15:16:41
time.struct_time(tm_year=2025, tm_mon=10, tm_mday=17, tm_hour=4, tm_min=16, tm_sec=41, tm_wday=4, tm_yday=290, tm_isdst=0)
<class 'time.struct_time'>
2025-10-17 04:16:41
```

### (3) 暂停程序执行

`time` 模块还提供了一个非常实用的功能：`sleep(秒数)`：可以让我们在程序中暂停执行一段时间：

```python
import time

for i in range(5):
    print(f"第 {i+1} 次打印")
    time.sleep(1)  # 暂停1秒
```

```text
第 1 次打印
第 2 次打印
第 3 次打印
第 4 次打印
第 5 次打印
```

大家在日常使用电脑或手机程序时，很多场景都会用到这个功能，比如：

- 在打开 APP 时，会有3秒钟的广告页，3秒钟后自动跳转到 APP 的首页
- 在游戏中，技能会有冷却时间，技能释放后需要等待一段时间才能再次使用

在实际的开发过程中，`sleep()` 函数也是非常使用的，例如：

- 在一些需要等待的程序中，我们会每隔一段时间检查一次某个条件是否满足
- 下面的代码演示了每隔30秒检查一次某个条件是否满足，如果满足则执行后续操作并退出循环，否则继续等待

```python
import time

count = 0

while True:
    检查某个条件是否满足
    if 条件满足:
        print("条件满足，执行后续操作")
        break
    else:
        print("条件不满足，继续等待")
        count += 1
        if count >= 24:  # 最多等待24次
            print("等待时间过长，退出程序")
            break
    time.sleep(300)
```


## 2. `datetime` 模块

`datetime` 模块也是一个与时间相关的模块，提供了更高级的时间处理功能

我们先简单区分一下 `time` 模块和 `datetime` 模块的区别：

- `time` 模块主要用于**获取时间**和**暂停程序执行**，主要作用是**让 Python 感知到时间**
- `datetime` 模块提供了更丰富的**日期时间处理**功能，主要作用是**日期时间的处理与计算**

`datetime` 常用的两个类为：

- `datetime` 类（**时间点**）：表示日期和时间的组合，包含年、月、日、时、分、秒等信息（这个类的名字和模块名字是一样的，需要注意区分）
- `timedelta` 类（**时间段**）：表示两个日期时间之间的差值，可以用于日期时间的加减运算

### (1) 修改创建日期时间对象

`datetime` 模块中表示时间的数据格式就是 `datetime` 对象，常见的创建方式有：

- `datetime.now()`：获取当前的日期时间，对象为日期时间对象

```python
from datetime import datetime

current_datetime = datetime.now()
print(current_datetime)
print(type(current_datetime))
```

```text
2025-10-17 15:52:08.278775
<class 'datetime.datetime'>
```

- `datetime(年, 月, 日, 时, 分, 秒)`：通过指定年月日时分秒来创建日期时间对象

```python
from datetime import datetime

dt1 = datetime(2025, 12, 25, 10, 30, 0)  # 具体到时分秒
print(dt1)
print(type(dt1))

dt2 = datetime(2023, 1, 1)  # 只指定到年月日，时分秒默认为0
print(dt2)
print(type(dt2))
```

```text
2025-12-25 10:30:00
<class 'datetime.datetime'>
2023-01-01 00:00:00
<class 'datetime.datetime'>
```

### (2) 日期时间的格式化解析

`datetime` 模块中表示时间的对象是 `datetime` 对象，但有时在特定需求下，我们也需要字符串格式的日期时间，这二者可以相互转换：

- `datetime.strftime(格式)`：将日期时间对象转换为字符串格式

```python
from datetime import datetime

# 获取当前日期时间对象
current_datetime = datetime.now()

# 将日期时间对象格式化为字符串
formatted_datetime1 = current_datetime.strftime("%Y-%m-%d %H:%M:%S")  # 推荐的标准格式
print(formatted_datetime1)
print(type(formatted_datetime1))

formatted_datetime2 = current_datetime.strftime("%d/%m/%Y %I:%M %p")
print(formatted_datetime2)
print(type(formatted_datetime2))

formatted_datetime3 = current_datetime.strftime("%A, %B %d, %Y")
print(formatted_datetime3)
print(type(formatted_datetime3))
```

```text
2025-10-17 15:52:08
<class 'str'>
17/10/2025 03:52 PM
<class 'str'>
Friday, October 17, 2025
<class 'str'>
```

- `datetime.strptime(字符串, 格式)`：将字符串格式的日期时间转换为日期时间对象

```python
datetime_str = "2025-10-17 15:52:08"

datetime_obj = datetime.strptime(datetime_str, "%Y-%m-%d %H:%M:%S")
print(datetime_obj)
print(type(datetime_obj))
```

```text
2025-10-17 15:52:08
<class 'datetime.datetime'>
```

这当中，时间的格式化符号（以 `%` 开头）用于指定日期时间的格式，常见的有：

- 日期部分：

| 符号          | 含义                 | 示例        |
| ----------- | ------------------ | --------- |
| `%Y`        | 四位数的年份             | `2025`    |
| `%y`        | 两位数的年份（00-99）      | `25`      |
| `%m`        | 两位数的月份（01-12）      | `10`      |
| `%B`        | 完整月份名称（英文）         | `October` |
| `%b` / `%h` | 缩写月份名称（英文）         | `Oct`     |
| `%d`        | 月份中的日期（01-31）      | `19`      |
| `%e`        | 月份中的日期，不补零（部分系统支持） | ` 9`      |
| `%j`        | 一年中的第几天（001-366）   | `293`     |

- 时间部分：

| 符号   | 含义                | 示例       |
| ---- | ----------------- | -------- |
| `%H` | 24小时制的小时（00-23）   | `14`     |
| `%I` | 12小时制的小时（01-12）   | `02`     |
| `%p` | 上/下午标识（AM/PM）     | `PM`     |
| `%M` | 分钟（00-59）         | `30`     |
| `%S` | 秒（00-59）          | `45`     |
| `%f` | 微秒（000000-999999） | `123456` |

- 星期与周部分：

| 符号   | 含义                   | 示例       |
| ---- | -------------------- | -------- |
| `%A` | 完整星期名（英文）            | `Sunday` |
| `%a` | 缩写星期名（英文）            | `Sun`    |
| `%w` | 星期数字（0=星期日，6=星期六）    | `0`      |
| `%u` | ISO星期数字（1=星期一，7=星期日） | `7`      |
| `%U` | 一年中的周数（星期日为一周的第一天）    | `41`   |
| `%W` | 一年中的周数（星期一为一周的第一天）    | `42`   |
| `%V` | ISO 8601 格式的周数（01-53） | `42`   |
| `%G` | ISO 8601 周的年份（4位）     | `2025` |
| `%g` | ISO 8601 周的年份（2位）     | `25`   |

- 其他符号：

| 符号   | 含义             | 示例                         |
| ---- | -------------- | -------------------------- |
| `%z` | UTC 偏移量（±HHMM） | `+0800`                    |
| `%Z` | 时区名称           | `CST`（China Standard Time） |
| 符号   | 含义          | 示例                         |
| ---- | ----------- | -------------------------- |
| `%c` | 本地日期与时间表示   | `Sun Oct 19 14:30:45 2025` |
| `%x` | 本地日期表示      | `10/19/25`                 |
| `%X` | 本地时间表示      | `14:30:45`                 |
| `%%` | 字面上的百分号 `%` | `%`                        |


### (3) 日期时间的对比运算

`datetime` 模块还提供了最基本的时间对比功能，可以直接使用**比较运算符**对日期时间对象进行比较：

```python
from datetime import datetime

dt1 = datetime(2025, 10, 17, 15, 0, 0)
dt2 = datetime(2025, 10, 18, 15, 0, 0)

if dt1 < dt2:
    print("dt1早于dt2")
elif dt1 > dt2:
    print("dt1晚于dt2")
else:
    print("dt1和dt2相等")
```

```text
dt1早于dt2
```

### (4) 日期时间的加减运算

`datetime` 模块还提供了 `timedelta` 类，可以用于日期时间的加减运算

- 如果说 `datetime` 对象表示一个具体的时间点，那么 `timedelta` 对象表示的是一个时间段
- 我们在进行时间运算时，肯定是时间点+时间段这样的操作，例如 `2025-01-01 + 5天` 得到 `2025-01-06`
- 时间运算不可能出现时间点+时间点这样的操作，例如 `2025-01-01 + 2025-01-05` 这样的操作是意义不明的

具体来说，`timedelta` 对象可以通过以下参数来创建（以下参数均可正可负）：

- `weeks`：周数
- `days`：天数
- `seconds`：秒数
- `microseconds`：微秒数
- `milliseconds`：毫秒数
- `minutes`：分钟数
- `hours`：小时数

```python
from datetime import datetime, timedelta

dt = datetime(2025, 10, 17, 15, 0, 0)
print("原始日期时间：", dt)

# 加5天
dt1 = dt + timedelta(days=5)
print("加5天后的日期时间：", dt1)

# 减3小时
dt2 = dt - timedelta(hours=3)
print("减3小时后的日期时间：", dt2)

# 加2天10分钟
dt3 = dt + timedelta(days=2, minutes=10)
print("加2天10分钟后的日期时间：", dt3)
```

```text
原始日期时间： 2025-10-17 15:00:00
加5天后的日期时间： 2025-10-22 15:00:00
减3小时后的日期时间： 2025-10-17 12:00:00
加2天10分钟后的日期时间： 2025-10-19 15:10:00
```

当然，`timedelta` 对象之间也可以进行加减运算，得到一个新的 `timedelta` 对象，基本逻辑也很简单，例如：

- `1 天 5 小时 + 2 天 3 小时 = 3 天 8 小时`
- `3 分 10 秒 - 1 分 20 秒 = 1 分 50 秒`

```python
from datetime import timedelta

td1 = timedelta(days=5, hours=3)
td2 = timedelta(days=2, hours=1)

# 加法运算
td3 = td1 + td2
print("加法运算结果：", td3)

# 减法运算
td4 = td1 - td2
print("减法运算结果：", td4)
```

```text
加法运算结果： 7 days, 4:00:00
减法运算结果： 3 days, 2:00:00
```

此外，`timedelta` 对象之间也可以进行比较运算，基本逻辑就是时间长的大于时间短的：

```python
from datetime import timedelta

td1 = timedelta(days=5, hours=3)
td2 = timedelta(days=2, hours=1)

# 比较运算
if td1 > td2:
    print("td1大于td2")
elif td1 < td2:
    print("td1小于td2")
else:
    print("td1和td2相等")
```

```text
td1大于td2
```
