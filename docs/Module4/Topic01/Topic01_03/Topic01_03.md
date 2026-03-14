# Topic 1.3 - 本模块使用的数据库 - Chinook

## 1. Chinook 数据库简介

我们后续章节使用的数据库是 Chinook 数据库：

- Chinook 是一个模拟的数字音乐商店数据库，包含了关于艺术家、专辑、曲目、客户和订单等信息
- 我们将使用 Chinook 数据库来练习 SQL 查询和数据分析技能

- 连接这个数据库的方式是 VS Code 中的 SQL Server 插件，连接配置如下：


- Chinook 数据库的 ERD 如下所示：

<div style="text-align: center;">
    <img src="../Chinook ERD.png" style="width: 900px; height: auto;">
</div>

## 2. 连接 Chinook 数据库

首先，我们来安装连接数据库所使用的插件：

- 我们在 VS Code 中下载并安装 SQL Server (mssql) 插件，可以直接从插件市场搜索 "SQL Server (mssql)" 来安装。

- 安装完成后，我们在 VS Code 的左侧活动栏中会看到一个新的 SQL Server 图标，长得像一个冰箱，点击它进入 SQL Server 插件的界面

<div style="text-align: center;">
    <img src="../安装1.png" style="width: 800px; height: auto;">
</div>

- 在 SQL Server 插件界面中，我们点击左上角的加号 "New Connection" 来创建一个新的数据库连接

<div style="text-align: center;">
    <img src="../安装2.png" style="width: 800px; height: auto;">
</div>

<div style="text-align: center;">
    <img src="../安装3.png" style="width: 800px; height: auto;">
</div>

- 在弹出的连接配置界面中，我们按照之前提供的连接信息填写相关字段：

```text
Profile Name: Chinook (注意这个其实是你自己给这个连接起的名字，可以随意命名，我们就起和数据库同名的名字，方便查找)
Connection Group: <Default>
Input Type: Parameters
Server Name: 1.13.142.106,1433
Trust Server Certificate: Yes
Authentication Type: SQL Login
User Name: student
Password: Navigation666!
Save Password: Yes
Database Name: Chinook
Encrypt: Mandatory
```

- 填写完成后，我们点击 "Connect" 来连接数据库，如果连接成功，你会在 SQL Server 插件的左侧看到一个新的连接项，显示为 "Chinook"（或者你之前设置的 Profile Name）

<div style="text-align: center;">
    <img src="../安装4.png" style="width: 800px; height: auto;">
</div>

## 3. 测试连接是否成功

连接成功后，我们可以测试一下是否能够正常查询数据库：

- 我们退回到文件浏览器，在任意位置新建一个 SQL 文件，命名为 test.sql（文件名可以随意，只要后缀是 .sql 就行）

- 之后，我们点击右上角的 "Connect" 按钮，选择我们之前创建的 "Chinook" 连接，这样就把这个 SQL 文件和 Chinook 数据库连接起来了

<div style="text-align: center;">
    <img src="../安装5.png" style="width: 800px; height: auto;">
</div>

<div style="text-align: center;">
    <img src="../安装6.png" style="width: 800px; height: auto;">
</div>

- 之后，我们在 test.sql 文件中输入以下 SQL 查询语句（注意，SQL 文件中每一条 SQL 语句都需要以分号（`;`）结尾）：

```sql
SELECT TOP 10 * 
FROM Artist;
```

- 要想运行这一段 SQL 代码，我们需要选中这段代码，然后点击右上角的 "Run Query" 按钮，运行成功后，你会在下方的结果窗口看到 Artist 表中的前 10 条记录，这就说明我们已经成功连接并查询了 Chinook 数据库

<div style="text-align: center;">
    <img src="../安装7.png" style="width: 800px; height: auto;">
</div>

在之后的课程中，我们将使用这个数据库来练习各种 SQL 技能，大家之后的课程中，一定要确保**数据库在线**：

- 刚打开 VS Code 的时候，先检查一下 SQL Server 插件中 "Chinook" 连接的状态
- 如果为红色，则说明数据库连接断开了，需要重新连接，重新连接只需要点击一下这个数据库即可
- 连接成功后，状态会变成绿色，这时候就可以正常使用了
