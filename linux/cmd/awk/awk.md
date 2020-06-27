# **awk**
awk是一种编程语言，非常强大，支持数组函数，if 等关键字，awk以行为最小处理单位，也就是一行行读取文本作为awk命令的输入.

# 题目预置
> 如何取得/etc/hosts 文件的权限对应的数字内容，如-rw-r--r--  为 644，要求使用命令取得644 这样的数字

```bash
stat /etc/hosts
File: '/etc/hosts'
Size: 283       	Blocks: 8          IO Block: 4096   regular file
Device: 10302h/66306d	Inode: 4981234     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-06-27 15:16:10.611845438 +0800
Modify: 2020-05-17 17:35:39.796341225 +0800
Change: 2020-05-17 17:35:39.796341225 +0800
 Birth: -
```
需要把Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root) 中的0644截取出来:
```bash
stat /etc/hosts|awk 'match($0, /^Access:\ \(([0-9]+)/, arry) {print arry[1]}'
0644
```

> 日志统计分析, test.log文件内容如下：
```bash
2020-06-30 10:00:00
uri:www.zybang.com cost[30ms]
2020-06-30 10:00:00
uri:www.zybang.com cost[40ms]
2020-06-30 10:00:00
uri:www.zybang.com cost[50ms]
2020-06-30 10:00:00
uri:www.baidu.com cost[30ms]
2020-06-30 10:00:00
uri:www.baidu.com cost[40ms]
2020-06-30 10:00:00
uri:www.xiaomi.com cost[10ms]
2020-06-30 10:00:00
uri:www.alipay.com cost[32ms]
2020-06-30 10:00:00
uri:www.alipay.com cost[48ms]
```
1. www.zybang.com 域名的平均访问耗时
2. 日志中不同域名的平均访问耗时
```bash
awk 'match($0, /uri:(.+)\ cost\[([0-9]+)ms\]/, array) {uri_cost[array[1]]+=array[2];uri_cnt[array[1]] += 1;}END{for (uri in uri_cost) {print uri, uri_cost[uri] / uri_cnt[uri] "ms"}}' ./test.log

www.xiaomi.com 10ms
www.baidu.com 35ms
www.alipay.com 40ms
www.zybang.com 40ms
```
```bash
awk -f ./log_parse.awk ./uri_test.log
```

# 命令格式和选项

### 语法形式
> awk [options] 'script' var=value file(s)  
awk [options] -f scriptfile var=value file(s)
### 常用命令选项
* -F fs  fs指定输入分隔符，fs可以是字符串或正则表达式，如-F:
* -v var=value   赋值一个用户定义变量，将外部变量传递给awk
* -f scripfile  从脚本文件中读取awk命令

# 模式和操作
awk的脚本是由模式和操作组成的.
### 模式
模式可以是下列中的任意一个:
* /正则表达式/：使用通配符的扩展集。
* 关系表达式：使用运算符进行操作，可以是字符串或数字的比较测试。
* 模式匹配表达式：用运算符~（匹配）和~!（不匹配）。
* BEGIN语句块、pattern语句块、END语句块：参见[awk的工作原理](#工作原理)
### 操作
操作由一个或多个命令、函数、表达式组成，之间由换行符或分号隔开，并位于大括号内，主要部分是：
- [变量](#内置变量)或[数组](#数组)赋值
- 输出命令
- [内置函数](#内置函数)
- [控制流语句](#流程控制语句)

# 基本结构
> awk 'BEGIN{ print "start" } pattern{ commands } END{ print "end" }' file  

一个awk脚本通常由：BEGIN语句块、能够使用模式匹配的通用语句块、END语句块3部分组成，这三个部分是可选的。任意一个部分都可以不出现在脚本中，脚本通常是被**单引号**或**双引号中**，例如:
```bash
awk 'BEGIN{ i=0 } { i++ } END{ print i }' filename
awk "BEGIN{ i=0 } { i++ } END{ print i }" filename
```
### 工作原理
> awk 'BEGIN{ commands } pattern{ commands } END{ commands }'  
* 第一步：执行BEGIN{ commands }语句块中的语句；
* 第二步：从文件或标准输入(stdin)读取一行，然后执行pattern{ commands }语句块，它逐行扫描文件，从第一行到最后一行重复这个过程，直到文件全部被读取完毕。
* 第三步：当读至输入流末尾时，执行END{ commands }语句块。  

**BEGIN**语句块在awk开始从输入流中读取行之前被执行，这是一个可选的语句块，比如变量初始化、打印输出表格的表头等语句通常可以写在BEGIN语句块中;  

**END**语句块在awk从输入流中读取完所有的行之后即被执行，比如打印所有行的分析结果这类信息汇总都是在END语句块中完成，它也是一个可选语句块;  

**pattern**语句块中的通用命令是最重要的部分，它也是可选的。如果没有提供pattern语句块，则默认执行{ print }，即打印每一个读取到的行，awk读取的每一行都会执行该语句块.

**示例**  

```bash
echo -e "A line 1nA line 2" | awk 'BEGIN{ print "Start" } { print } END{ print "End" }'
Start
A line 1
A line 2
End
```

当使用不带参数的print时，它就打印当前行，当print的参数是以逗号进行分隔时，打印时则以空格作为定界符。在awk的print语句块中双引号是被当作拼接符使用，例如：
```bash
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1,var2,var3; }' 
v1 v2 v3
```

双引号拼接使用：
```bash
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1"="var2"="var3; }'
v1=v2=v3
```
{ }类似一个循环体，会对文件中的每一行进行迭代，通常变量初始化语句（如：i=0）以及打印文件头部的语句放入BEGIN语句块中，将打印的结果等语句放在END语句块中。

# 内置变量

```bash
$n        当前记录的第n个字段，比如n为1表示第一个字段，n为2表示第二个字段;
$0        这个变量包含执行过程中当前行的文本内容;  
$FILENAME 当前输入文件的名;
$FS       字段分隔符（默认是任何空格);
$NF       表示字段数，在执行过程中对应于当前的字段数;
$NR       表示记录数，在执行过程中对应于当前的行号;
$OFMT     数字的输出格式（默认值是%.6g）;
$OFS      输出字段分隔符（默认值是一个空格）;
$ORS      输出记录分隔符（默认值是一个换行符）;
$RS       记录分隔符（默认是一个换行符).
```
**示例:**
```bash
seq 5 | awk 'BEGIN{ sum=0; print "总和：" } { print $1"+"; sum+=$1 } END{ print "等于"; print sum }' 
总和：
1+
2+
3+
4+
5+
等于
15
```

# 将外部变量值传递给awk
借助```-v```选项，可以将外部值（并非来自stdin）传递给awk:
```bash
VAR=10000
echo | awk -v VARIABLE=$VAR '{ print VARIABLE }'
```
另一种传递外部变量方法：
``` bash
var1="aaa"
var2="bbb"
echo | awk '{ print v1,v2 }' v1=$var1 v2=$var2
```
当输入来自于文件时使用：
```bash
awk '{ print v1,v2 }' v1=$var1 v2=$var2 filename
```
以上方法中，变量之间用空格分隔作为awk的命令行参数跟随在BEGIN、{}和END语句块之后。

# 运算和判断
作为一种程序设计语言所应具有的特点之一，awk支持多种运算，这些运算与C语言提供的基本相同。awk还提供了一系列内置的运算函数（如log、sqr、cos、sin等）和一些用于对字符串进行操作（运算）的函数（如length、substr等等）。这些函数的引用大大的提高了awk的运算功能。作为对条件转移指令的一部分，关系判断是每种程序设计语言都具备的功能，awk也不例外，awk中允许进行多种测试，作为样式匹配，还提供了模式匹配表达式~（匹配）和~!（不匹配）。作为对测试的一种扩充，awk也支持用逻辑运算符。

支持**算术运算符**、**赋值运算符**、**逻辑运算符**和**关系云算法**，还支持**正则运算**和一些其他运算符:

### 正则运算符

|运算符|描述| 
|:--|:--|
|~ !~| 匹配正则表达式和不匹配正则表达式|
**示例**
```bash
awk 'BEGIN{a="100testa";if(a ~ /^100*/){print "ok";}}'
ok
```

### 其他运算符
|运算符|描述| 
|:--|:--|
|？|c条件表达式三元运算符|
|in|数组中是否存在某键值|

**示例**
```bash
awk 'BEGIN{a="b";print a=="b"?"ok":"err";}'
ok
awk 'BEGIN{a="b";arr[0]="b";arr[1]="c";print (a in arr);}'
0
awk 'BEGIN{a="b";arr[0]="b";arr["b"]="c";print (a in arr);}'
1
```

# 流程控制语句
在linux awk的while、do-while和for语句中允许使用break,continue语句来控制流程走向，也允许使用exit这样的语句来退出。break中断当前正在执行的循环并跳到循环外执行下一条语句。if 是流程选择用法。awk中，流程控制语句，语法结构，与c语言类型。有了这些语句，其实很多shell程序都可以交给awk，而且性能是非常快的;每条命令语句后面可以用;分号结尾.

### next
awk中next语句使用：在循环逐行匹配，如果遇到next，就会跳过当前行，直接忽略下面语句。而进行下一行匹配。net语句一般用于多行合并:

```bash
cat text.txt
web01[192.168.2.100]
httpd            ok
tomcat               ok
sendmail               ok
web02[192.168.2.101]
httpd            ok
postfix               ok
web03[192.168.2.102]
mysqld            ok
httpd               ok
awk '/^web/{T=$0;next;}{print T": "$0;}' test.txt
web01[192.168.2.100]:   httpd            ok
web01[192.168.2.100]:   tomcat               ok
web01[192.168.2.100]:   sendmail               ok
web02[192.168.2.101]:   httpd            ok
web02[192.168.2.101]:   postfix               ok
web03[192.168.2.102]:   mysqld            ok
web03[192.168.2.102]:   httpd               ok
```

### getline
输出重定向需用到getline函数。getline从标准输入、管道或者当前正在处理的文件之外的其他输入文件获得输入。它负责从输入获得下一行的内容，并给NF,NR和FNR等内建变量赋值。如果得到一条记录，getline函数返回1，如果到达文件的末尾就返回0，如果出现错误，例如打开文件失败，就返回-1。
```bash
awk 'BEGIN{while(getline < "/etc/passwd"){print $0;};close("/etc/passwd");}'
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
```

# 数组
数组是awk的灵魂，处理文本中最不能少的就是它的数组处理。因为数组索引（下标）可以是数字和字符串在awk中数组叫做关联数组(associative arrays)。awk 中的数组不必提前声明，也不必声明大小。数组元素用0或空字符串来初始化，这根据上下文而定。

### 数组的定义
数字做数组索引（下标）：
```bash
Array[1]="sun"
Array[2]="kai"
```
需要注意的是下标是从1开始的，这一点跟c语音是有区别的;  

字符串做数组索引（下标）：
```bash
Array["first"]="www"
Array["last"]="name"
Array["birth"]="1987"
```
使用中print Array[1]会打印出sun；使用print Array[2]会打印出kai；使用print["birth"]会得到1987。

### 读取数组的值

```bash
{ for(item in array) {print array[item]}; }       #输出的顺序是随机的
{ for(i=1;i<=len;i++) {print array[i]}; }         #Len是数组的长度
```

示例:
```bash
awk 'BEGIN{info="it it is a test"; tlen=split(info,tA," "); delete tA[1]; for(key in tA) {print key,tA[key]} for(k=1;k<=tlen;k++){print k,tA[k];}}'
2 it
3 is
4 a
5 test
1 
2 it
3 is
4 a
5 test

```
这里有一点需要注意: 使用in遍历时，已经不包含tA[1]了，但是使用长度判断时，又包含了tA[1], 其值为空，这是因为awk数组是关联数组，只要通过数组引用它的key，就会自动创建该元素。

# 内置函数
awk内置函数，主要分以下3种类似：算数函数、字符串函数、其它一般函数、时间函数。

|函数|描述|
|--|--|
|gsub( Ere, Repl, [ In ] )|除了正则表达式所有具体值被替代这点，它和 sub 函数完全一样地执行。|
|sub( Ere, Repl, [ In ] )|用 Repl 参数指定的字符串替换 In 参数指定的字符串中的由 Ere 参数指定的扩展正则表达式的第一个具体值。sub 函数返回替换的数量。出现在 Repl 参数指定的字符串中的 &（和符号）由 In 参数指定的与 Ere 参数的指定的扩展正则表达式匹配的字符串替换。如果未指定 In 参数，缺省值是整个记录（$0 记录变量）|
|index( String1, String2 )|在由 String1 参数指定的字符串（其中有出现 String2 指定的参数）中，返回位置，从 1 开始编号。如果 String2 参数不在 String1 参数中出现，则返回 0（零）。|
|substr( String, M, [ N ] )|返回具有 N 参数指定的字符数量子串。子串从 String 参数指定的字符串取得，其字符以 M 参数指定的位置开始。M 参数指定为将 String 参数中的第一个字符作为编号 1。如果未指定 N 参数，则子串的长度将是 M 参数指定的位置到 String 参数的末尾 的长度。|
|match( String, Ere )|在 String 参数指定的字符串（Ere 参数指定的扩展正则表达式出现在其中）中返回位置（字符形式），从 1 开始编号，或如果 Ere 参数不出现，则返回 0（零）。RSTART 特殊变量设置为返回值。RLENGTH 特殊变量设置为匹配的字符串的长度，或如果未找到任何匹配，则设置为 -1（负一）。|

### 示例

**gsub,sub使用**
```bash
awk 'BEGIN{info="this is a test2010test!";gsub(/[0-9]+/,"!",info);print info}'
this is a test!test!
```
在 info中查找满足正则表达式，/[0-9]+/ 用””替换，并且替换后的值，赋值给info 未给info值，默认是$0

**查找字符串（index使用）**
```bash
awk 'BEGIN{info="this is a test2010test!";print index(info,"test")?"ok":"no found";}'
ok
```
未找到，返回0

**正则表达式匹配查找(match使用）**
```bash
awk 'BEGIN{info="this is a test2010test!";print match(info,/[0-9]+/)?"ok":"no found";}'
ok
```
**截取字符串(substr使用）**
```bash
awk 'BEGIN{info="this is a test2010test!";print substr(info,4,10);}'
s is a tes
```
从第 4个 字符开始，截取10个长度字符串.

