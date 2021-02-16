## IO概念

> I：input 输入（读取）
>
> O：output 输出（写入）
>
> 流：数据（字符，字节）

## 流的顶级父类

|        |           输入流            |            输出流            |
| :----: | :-------------------------: | :--------------------------: |
| 字节流 | 字节输入流<br />InputStream | 字节输出流<br />OutputStream |
| 字符流 |   字符输入流<br />Reader    |    字符输出流<br />Wirter    |

## OutputStream

> java.io.**OutputStream**：**字节输出流**，此抽象类是所有字节输出流类的父类
>
> 写入数据的原理：（内存 --> 硬盘）
>
> ​	Java程序 --> JVM（Java虚拟机）--> OS（操作系统）--> OS调用对应方法 --> 将数据写入指定文件中                    

### FileOutputStream

> java.io.**FileOutputStream**：**文件字节输出流**，集成于OutputStream抽象类
>
> 构造方法：
>
> ​	FileOutputStream(String name)：创建一个向 指定名称的文件中 写入数据的文件输出流
>
> ​	FileOutputStream(File file)：创建一个向指定 File 对象指向的文件中 写入数据的文件输出流
>
> ​	参数：
>
> ​		String name：文件路径
>
> ​		File file：文件对象
>
> ​	构造方法的作用：
>
> ​		1.创建一个 FileOutputStream 对象
>
> ​		2.根据构造方法中的传递的文件/文件路径，创建一个空的文件
>
> ​		3.把 FileOutputStream 指向创建好的文件