# ISO_C_文件系统

计算机的组成

> - 软件
>    - 系统软件
>       - 操作系统：
>       - 编译器：msvc、gcc、clang；
>       - 数据库：MySQL；
>    - 应用软件
> - 硬件
>    - CPU
>       - 运算器，控制器
>       - 寄存器
>       - 高速缓冲存储器（Cache）：L1、L2、L3；
>    - **主存储器**：分配一部分空间映射到外存储器，真正操作数据，都是在主存操作，等操作完成之后在写回到磁盘（主存文件缓冲区/文件流）；
>    - 外部设备
>       - 外存储器
>       - I/O设备
>
> > 凡是持久存储的都可以叫做文件：
> >
> > - 特殊/设备文件：所有的 I/O设备都是文件；
> > - 普通文件；
> >    - 文本文件：人类能看懂；
> >    - 二进制文件；

## 文件缓冲区（ ISO-C：文件流 ）

### 常用接口

`FILE *fopen ( const char *fname, const char *mode )`;

- 在用户态中创建一片内存，作为文件缓冲区；
- 如果打开错误，会返回：NULL；

`FILE *fclose ( FILE *stream )`;

- 回收内存；

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
   FILE *fp;
   fp = fopen("1.txt", "r");//和main在同一个文件夹
   if (fp == NULL){
      
   }
   /*
   void perror( const char *str);
   全局变量：errno，根据其打印报错信息，此字符串是自己制定的，一般写入函数名方便调试（标记第几行出现了错误）；
   r : 只读；
   */
   fclose(fp);
}
```

- 绝对路径：win下从盘符开始；
- 相对路径：从当前工作目录开始；**（常用）**

### 读写文件接口

`int fgetc( FILE *stream )`;

- 返回来自文件流中的下一个字符，如果到达文件尾或发生错误时返回 `EOF`;

#### 文件流的结构

文件流由三个指针定位标注； 

<img src="https://tva1.sinaimg.cn/large/e6c9d24egy1h0uefta04uj209806o0sn.jpg" alt="image-20210428152417065" style="zoom:50%;" />

- base：文件流起始地址；
- end：base 和 end 之间表示文件缓冲区所占用的所有内存；
- ptr：下一次要读写的位置；

每一次使用 fgetc() 都会把 ptr 向后移动一个；

```c
FILE *fp;
fp = fopen("1.txt", "r");
if(fp == NULL){
   perror("fopen");
   return -1;
}
char ch;
while( (ch = fgetc(fp)) != EOF ){
   printf("%c", ch);
}
printf("\n");
fclose(fp);
```

`int fputc( int ch, FILE *stream )`;

-  函数把给出的字符 ch 写到给出的输出流；

```c
FILE *fp;
fp = fopen("1.txt", "r+");
//可以用“r+”表示读写模式打开
if(fp == NULL){
   perror("fopen");
   return -1;
}
char ch = 'H';
int ret = fputc( ch, fp );
//此时只修改了文件缓冲区，真正要修改磁盘的话，要使用 fclose()；
if(ret == EOF ){
   //不能用只读方式打开；
   perror("fputc");
   return -1;
}
fclose(fp);
```

`int fflush( FILE *stream )`;

- 如果给出的文件是一个输出流，那么函数把输出到缓冲区的内容写入到文件；

```c
FILE *fp;
fp = fopen("1.txt", "r+");
//可以用“r+”表示读写模式打开
if(fp == NULL){
   perror("fopen");
   return -1;
}
char ch = 'H';
int ret = fputc( ch, fp );
//此时只修改了文件缓冲区，真正要修改磁盘的话，要使用 fclose()；
if(ret == EOF ){
   //不能用只读方式打开；
   perror("fputc");
   return -1;
}
fflush(fp);
//直接写入文件，再不关闭文件的情况下
//但是频繁地写入磁盘会非常的容易损坏磁盘
fclose(fp);
```

缓冲区写入到磁盘的三个时机：

1. 使用`fclose()`;（自动）
2. 使用`fflush()`;（手动写）
3. 缓冲区满了，一次性写入缓冲区中的全部数据；

`int fseek( FILE *stream, long offset, int origin )`;

- 成功时返回0，否则返回一个错误码；
   - origin：偏移开始的位置；
      - `SEEK_SET`：从文件的开始处；
      - `SEEK_CUR`：从当前位置；
      - `SEEK_END`：从文件结尾开始搜索；

```c
FILE *fp;
fp = fopen("1.txt", "r+");
//可以用“r+”表示读写模式打开
if(fp == NULL){
   perror("fopen");
   return -1;
}
char ch;
while( (ch = fgetc(fp)) != EOF ){
   if( ch >= 'a' && ch <= 'z' ){
      ch -= 32;
      fseek(fp, -1, SEEK_CUR);
      fputc(ch, fp);
   }
   //to solve the bug of Microsoft VS
   fseek(fp, 0, SEEK_CUR);
}
fclose(fp);
```

## 命令行参数

> 可以向`main()`函数传递参数；
>
> ```c
> int main( int argc , char *argv[] ){}
> ```
>
> 