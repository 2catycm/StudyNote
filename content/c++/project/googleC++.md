<!--
 * @Date: 2020-09-30 21:01:42
 * @LastEditors: Lucian
 * @LastEditTime: 2020-10-03 00:48:28
 * @FilePath: /gitbook/content/c++/project/googleC++.md
-->
> -[https://git-scm.com/](https://git-scm.com/)
Google C++ 编程风格指南
---
参考网站:[Google 开源项目风格指南 - 中文版](https://github.com/zh-google-styleguide/zh-google-styleguide)

下面的内容是我从谷歌风格指南中提炼出来最需要注重的点,一定要注意哦!



## 头文件


### define 保护 

​	所有头文件都应该使用 `#define` 来防止头文件被多重包含（保证头文件使用的唯一性）

#### 好

```c++
#ifndef THE_FILE_FLAG
#define THE_FILE_FLAG
{头文件文件内容}
#endif
```

#### 坏

```
{头文件文件内容}
```

### 前置声明

​	前置声明（尽可能避免）：把声明和函数放在统一文件中。

​	尽可能：将声明放至.h文件中，在cpp文件中调用.h，然后在.cpp中实现函数好

#### 好

分成cpp和hpp函数

#### 坏

把声明和函数放在统一文件中(前置声明)


### #include的路径及顺序

​	项目内头文件应按照项目源代码目录树结构排列

​	1）将需要测试的文件放在第一个（会优先报错，节省测试时间）

​	2）c的系统文件（如stdio.h）

​	3）c++的系统文件（如iostream.h）

​	4）其他库的.h文件

​	5）本项目其他.h文件

​	为了保证可行性和稳定性，必须引用所有用到的头文件（可能导致多重包含，所以必须使用[define保护](#define-保护)）

#### 好


```cpp
#include "a.hpp"
#include "b.hpp"
```

#### 坏

假如`a.hpp` 引用了 `b.hpp`,当需要同时引用`a.hpp`和`b.hpp`时:

```cpp
#include "a.hpp"
```


## 作用域

### 局部变量（重点）

将函数变量尽可能置于最小作用域（一个大括号內）内, 并在变量声明时进行初始化.

#### 好

```java
for(int i = 0; i<=4; i++)｛
    int j=2*i;
｝
```

####　坏

```java
int j;
for(int i = 0; i<=4; i++)｛
    j=2*i;
｝
```

## 类

### 构造函数的职责

1. 不要在构造函数中调用虚函数, 也不要在无法报出错误时进行可能失败的初始化.(需要保证输入的参数都符合规范)

2. 写构造函数的时候，确保对象可以正常构建．尽量让每一个成员变量都有自己的初始值.

3. 构造函数不允许调用虚函数. 如果代码允许, 直接终止程序（exit）是一个合适的处理错误的方式. 否则, 考虑用 `Init()` 方法。

### 结构体 VS. 类

仅当只有数据成员时使用 `struct`, 其它一概使用 `class`。

需要使用函数时，定义为class。只有数据定义为struct。拿不准就用class。

#### 坏

使用struct定义函数

### 声明顺序

将相似的声明放在一起, 将 `public` 部分放在最前.

public -> protected -> private

#### 好

```
class class_example{
	public:
	protected:
	private:
}
```

坏

```
class class_example{
	private:
	protected:
	public:
}
```



## 函数 

### 参数顺序

函数的参数顺序为: 输入参数在先, 后跟输出参数.

#### 好

```c++
int add(int a, int b, const int &c){
    return c = a+b;
} // a, b为输入，c为输出
```

####　坏

```c++
int add(const int &c, int a, int b){
    return c = a+b;
} // a, b为输入，c为输出
```

####　

### 编写简短函数

如果函数**超过 40 行**, 可以思索一下能不能在不影响程序结构的前提下对其进行分割（封装一些功能），增强可读性，也便于验证较小的函数。



### 引用参数

所有按引用传递的输入参数必须加上 `const`.添加const表示输入不能被修改。（常量指针&指针常量）

#### 好

```c++
void Foo(const string &in, string *out);
```

#### 坏

```c++
void Foo(string &in, string *out);
```



### 函数重载

若要使用函数重载, 则必须能让读者一看调用点就胸有成竹, 而不用花心思猜测调用的重载函数到底是哪一种. 这一规则也适用于构造函数.

重载函数（相同的函数名，但输入可能不同，但功能相似）

#### 好

```c++
class MyClass {
    public:
    void printStr(const string &text);
    void printStr(const char *text, size_t textlen);
};
```

### 缺省参数

类似函数重载

```c++
void add(int a, int b=1)
```

### 函数返回类型后置语法

尽量少用函数返回类型后置

**good**

```c++
int foo(int x)
```

**bad**

```c++
auto fool(int x) -> int
```

