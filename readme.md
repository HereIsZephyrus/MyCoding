##  CUG小萌新个人代码垃圾堆

记录CUG代码日常，~~之前的破烂cpp算法库就不端出来了~~

好像不知不觉间分享给了不少同学，那就走过路过点个star吧~

## Cpp I/O

1.包含了iostream文件的C++程序将自动打开8个流，并使用8个对象管理它们。

2.C++11添加了char16_t和char32_t具体化。

3.cerr对象 与标准错误流相对于，可用于显示错误信息。这个流没有缓冲（clog有）。

4.<<被iostream对象重载为插入运算符，而不是左移运算符。插入运算符被重载，使之能够识别c++中所有的基本类型。插入运算符的所有化身的返回类型都是ostream& / istream&。

| 文本文件 | 二进制文件 |
| -------- | ---------- |
| get      | read       |
| <<       | write      |

5.默认的C++模式对应于%g说明符，定点表示法对应于%f说明符，而科学表示法对应于%e说明符。同样精度指的是小数位数，而不是总位数。

6.在流状态被设置后的写法

```cpp
while (!isspace(cin.get()))
	continue;//get rid of bad input
cin>>input;
```

7.cin.get(char*)返回一个istream &，常被认为是比cin.get(void)更好的写法

istream & getline(char *, int, char)控制终止符

8.空行并不会导致getline()设置failbit。这是因为getline()仍将抽取换行符，虽然不会存储他。如果希望getline在遇到空行时停止则

```cpp
char temp[80];
while (cin.getline(temp,80) && temp[0]!='\\0')
```

9.peek()函数返回输入中的下一个字符，但不抽取输入流中的字符

```cpp
char great_input[80];
char ch;
int i=0;
while ((ch=cin.peek())!='.' && ch!='\\n')
	cin.get(great_input[i++]);
great_input[i]='\\0';
```

10.头问价发stream对大部分实现来说都包含了iostream

11.Cpp有与跟C一致的同命令行的交互方式int main(int argc , char* argv[])