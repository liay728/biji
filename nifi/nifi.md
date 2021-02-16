# nifi的使用

##                                              nifi的配置

### QueryDataBaseTable

​	作用：设置要拉取的数据源

![image-20210106134616967](nifi.assets/image-20210106134616967.png)

![image-20210106134640361](nifi.assets/image-20210106134640361.png)

![image-20210106134655528](nifi.assets/image-20210106134655528.png)

![image-20210106134714511](nifi.assets/image-20210106134714511.png)

![image-20210106134735699](nifi.assets/image-20210106134735699.png)

### ConvertAvroToJson

​	作用：将拉取的数据转化为 Json 格式

![image-20210106134750365](nifi.assets/image-20210106134750365.png)

![image-20210106134800466](nifi.assets/image-20210106134800466.png)



### SplitJson

​	作用：将获取到的 Json 数据拆分成一个个数据

![image-20210106134950085](nifi.assets/image-20210106134950085.png)

![image-20210106135020028](nifi.assets/image-20210106135020028.png)

![image-20210106135033634](nifi.assets/image-20210106135033634.png)

![image-20210106135045243](nifi.assets/image-20210106135045243.png)

![image-20210106135055575](nifi.assets/image-20210106135055575.png)

### EvaluateJsonPath

​	作用：将拆分的 数据 设置成 一个个变量

![image-20210106135107779](nifi.assets/image-20210106135107779.png)

![image-20210106135117757](nifi.assets/image-20210106135117757.png)

![image-20210106135130470](nifi.assets/image-20210106135130470.png)

![image-20210106135141124](nifi.assets/image-20210106135141124.png)

![image-20210106135155810](nifi.assets/image-20210106135155810.png)

### ExecuteSQL

​	作用：将获取的数据 通过 SQL 写入指定数据库当中

![image-20210106135206402](nifi.assets/image-20210106135206402.png)

![image-20210106135225094](nifi.assets/image-20210106135225094.png)

![image-20210106135237155](nifi.assets/image-20210106135237155.png)