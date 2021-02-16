## 基本配置

依赖

```xml
<!--MybatisPlus驱动包-->
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.0.5</version>
</dependency>
```

yml

```yaml
spring:
  # 设置数据源
  datasource:
    # 设置数据源 种类、IP、端口、数据库名称
    url: jdbc:mysql://10.58.241.10:3306/testspringboottwo?userSSL=false&useunicode=true&characterEncoding=utf8&serverTimezon=GMT%2B8
    # 数据源账号
    username: root
    # 数据源密码
    password: Wopt54321
    # 数据源驱动
    driver-class-name: com.mysql.cj.jdbc.Driver
```

## 日志配置

yml

```yaml
mybatis-plus:
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
```

## CRUD扩展

### 添加操作

> **insert**(Object)
>
> 作用：通过 对象信息 进行添加操作
>
> 参数：任何对象
>
> 返回值：Integer

```java
/**
 * 添加操作
 */
@Test
void test2() {
    Users users = new Users();
    users.setName("1");
    users.setAge(2);
    users.setEmail("12312@qq.com");

    int row = usersMapper.insert(users);
    System.out.println(row);
}
```

#### 主键生成策略

> 默认 ID_WORKER 雪花算法 全局唯一 

雪花算法配置：

* 实体类主键字段上`@TableId(type = IdType.I8D_WORKER)`

> AUTO 自增

自增配置：

* 实体类主键字段上`@TableId(type = IdType.AUTO)`
* 数据库字段开启自增

> 其他类型

```java
public enum IdType {
    AUTO(0), // 数据库ID自增
    NONE(1), // 不适用
    INPUT(2), // 手动输入
    ID_WORKER(3), // 默认的全局唯一ID
    UUID(4), // 全局唯一UUID
    ID_WORKER_STR(5); // ID_WORKER 字符串表示法
}
```

### 修改操作

> **updateById**(Object)
>
> 作用：根据 对象 进行修改操作
>
> 参数：任何对象
>
> 返回值：Integer

```java
/**
 * 修改操作
 * updateById 方法参数-实体类对象
 */
@Test
void test3() {
    Users users = new Users();
    users.setId(1335758693055754242L);
    users.setName("张三plus");
    int row = usersMapper.updateById(users);
    System.out.println(row);
}
```

### 自动填充

> 方式一：数据库级别

​	在数据库中设置字段的默认值以及修改时间属性的更新属性

> 方式二：代码级别

* 删除数据库中字段的默认值以及更新操作
* 实体类属性上加上对象注解

```java
/**
     * 创建时间
     */
@TableField(fill = FieldFill.INSERT)
private Date createTime;

/**
 * 修改时间
 */
@TableField(fill = FieldFill.INSERT_UPDATE)
private Date updateTime;
```

* 编写处理器

```java
package com.liay.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

@Slf4j
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    /**
     * setFieldValByName方法参数：
     * 第一个参数：属性名称
     * 第二个参数：填充值
     * 第三个参数：MetaObject对象
     * @param metaObject
     */

    // 插入时的填充策略
    @Override
    public void insertFill(MetaObject metaObject) {
        this.setFieldValByName("createTime", new Date(), metaObject);
        this.setFieldValByName("updateTime", new Date(), metaObject);
    }

    // 修改时的填充策略
    @Override
    public void updateFill(MetaObject metaObject) {
        this.setFieldValByName("updateTime", new Date(), metaObject);
    }
}
```

### 乐观锁与悲观锁

> 乐观锁：乐观锁总是认为不会出现问题，无论执行什么操作都不会上锁。
>
> 悲观锁：悲观锁总是认为会出现问题，无论执行什么操作都会上锁。

乐观锁实现方式：

* 更新时会先获取version
* 在执行更新时会在条件中带上version
* 执行时，set version = new version where version = old version
* 如果version不同，则不会执行更新

> 配置乐观锁

* 在表中添加 version 字段

![image-20210106134111007](MybatisPlus.assets/image-20210106134111007.png)

* 在实体类属性上加上@Version注解

```java
@Version
private Integer version;
```

* 注册组件

```java
/**
 * 注解乐观锁组件
 * @return
 */
@Bean
public OptimisticLockerInterceptor optimisticLockerInterceptor() {
    return new OptimisticLockerInterceptor();
}
```

* 乐观锁测试

```java
/**
 * 乐观锁成功测试
 */
@Test
void test4() {
    Users users = usersMapper.selectById(1335760137477586949L);
    users.setId(1335760137477586949L);
    users.setName("张三plus");
    int row = usersMapper.updateById(users);
    System.out.println(row);
}

/**
     * 乐观锁失败测试
     */
@Test
void test5() {
    // 线程1 设置了值后还没有执行操作
    Users users = usersMapper.selectById(1335760137477586949L);
    users.setId(1335760137477586949L);
    users.setName("张三plus111");
    // 线程2 插队对同一个数据进行了操作
    Users users2 = usersMapper.selectById(1335760137477586949L);
    users2.setId(1335760137477586949L);
    users2.setName("张三plus222");
    usersMapper.updateById(users2);
    // 如果没有乐观锁，插队执行的操作就会被覆盖
    usersMapper.updateById(users);
    // 而有乐观锁的话，后面执行的相同操作就不会被执行
}
```

### 查询操作

> **selectById**(id)
>
> 作用：根据 ID 查询对应数据对象
>
> 参数：ID
>
> 返回值：Object

> **selectBatchIds**(id集合)
>
> 作用：根据 ID 集合 查询 对应数据集合
>
> 参数：ID 集合
>
> 返回值：List

> **selectByMap**(map集合)
>
> 作用：使用 Map 集合 做 条件查询
>
> 参数：Map 集合
>
> 返回值：List

> **selectList**(QueryWrapper<>)
>
> 作用：根据 QueryWrapper对象 做条件查询 多条数据
>
> 参数：QueryWrapper对象
>
> 返回值：List

> **selectOne**(QueryWrapper<>)
>
> 作用：使用 QueryWrapper对象 做条件查询 单条数据
>
> 参数：QueryWrapper对象
>
> 返回值：Object

> **selectCount**(QueryWrapper<>)
>
> 作用：使用 QueryWrapper对象 做条件查询 总记录数
>
> 参数：QueryWrapper对象
>
> 返回值：Integer

> **selectMaps**(QueryWrapper<>)
>
> 作用：使用 QueryWrapper对象 做条件查询
>
> 参数：QueryWrapper对象
>
> 返回值：List<Map<String, Object>>

> **selectObjs**(QueryWrapper<>)
>
> 作用：使用 QueryWrapper对象 做条件查询
>
> 参数：QueryWrapper对象
>
> 返回值：List<Object>

### 分页插件

分页插件实现方式：

* 配置拦截器

```java
/**
 * 分页插件
 * @return
 */
@Bean
public PaginationInterceptor paginationInterceptor() {
    return new PaginationInterceptor();
}
```

* 直接使用 Page 对象即可

```java
/**
 * 分页查询
 */
@Test
void test7() {
    /**
     * Page：
     *  泛型：查询对象
     *  构造函数：
     *   参数 1：当前页
     *   参数 2：每页查询数量
     */
    Page<Users> page = new Page<>(3, 5);
    IPage<Users> selectPage = usersMapper.selectPage(page, null);

    /**
     * getRecords()：查询数据
     * getCurrent()：当前页
     * getSize()：每页记录数
     * getTotal()：总记录数
     * getPages()：总页数
     * hasNext()：是否有下一页
     * hasPrevious()：是否有上一页
     */
    page.getRecords().forEach(System.out::println);
    System.out.println(page.getCurrent());
    System.out.println(page.getSize());
    System.out.println(page.getTotal());
    System.out.println(page.getPages());
    System.out.println(page.hasNext());
    System.out.println(page.hasPrevious());
}
```

### 逻辑删除

> 物理删除：直接从数据库中删除
>
> 逻辑删除：没有直接删除数据库中数据，而是通过一个变量来让他不做显示	deleted = 0 -> deleted = 1

逻辑删除实现方式：

* 在数据库中添加 deleted 字段

![image-20210106134212953](MybatisPlus.assets/image-20210106134212953.png)

* 在实体类属性上添加`@TableLogic`

```java
@TableLogic
private Integer deleted;
```

* 注册组件

```java
/**
 * 逻辑删除组件
 * @return
 */
@Bean
public ISqlInjector sqlInjector() {
    return new LogicSqlInjector();
}
```

* yml配置

```yaml
mybatis-plus:
  global-config:
    db-config:
      logic-delete-value: 1
      logic-not-delete-value: 0
```

### SQL性能分析

​	作用：性能分析拦截器，用于输入每条SQL语句以及执行时间

* 注册插件

```java
/**
 *  sql性能分析插件，输出sql语句及所需时间
 * 注意：mybatis plus 3.1.2以上版本不支持该插件，请使用p6spy
 * @return
 */
@Bean
@Profile({"dev","test","sit","uat"})
public PerformanceInterceptor performanceInterceptor() {
    PerformanceInterceptor performanceInterceptor = new PerformanceInterceptor();
    /** SQL 执行性能分析，开发环境使用，线上不推荐。 maxTime 指的是 sql 最大执行时长 */
    performanceInterceptor.setMaxTime(1000);
    /** SQL是否格式化 默认false */
    performanceInterceptor.setFormat(true);
    return performanceInterceptor;
}
```

> 注意：一定要在yml中配置当前项目环境

yml配置

```yaml
spring:
  # 设置当前环境
  profiles:
    active: dev
```

### 条件构造器

​	Wrapper

​	作用：用于复杂SQL条件

> 方法含义

* isNotNull(column)

```properties
column：字段
作用：指定字段不为空的数据
```

* ge(column, val)

```properties
column：字段
val：值
作用：指定字段 大于等于 val值 的数据
```

* gt(column, val)

```properties
column：字段
val：值
作用：指定字段 大于 var值 的数据
```

* le(column, val)

```properties
column：字段
val：值
作用：指定字段 小于等于 var值 的数据
```

* lt(column, val)

```properties
column：字段
val：值
作用：指定字段 大于 var值 的数据
```

* eq(column, val)

```properties
column：字段
val：值
作用：指定字段 等于 var值 的数据
```

* between(column, val1, val2)

```properties
column：字段
val1：值1
val2：值2
作用：指定字段 的值 在 val1 和 val2 之间的数据
```

* notLike(column, val)

```properties
column：字段
val：值
作用：取反模糊查询 %在两边
```

* like(column, val)

```properties
column：字段
val：值
作用：模糊查询 %在两边
```

* likeLeft(column, val)

```properties
column：字段
val：值
作用：模糊查询 %在左边
```

* likeRight(column, val)

```properties
column：字段
val：值
作用：模糊查询 %在右边
```

* inSql(column, inValue)

```properties
column：字段
inValue：sql语句
作用：将 sql语句查询出来的值当做条件查询
例如：
	wrapper.inSql("id", "select id from users where id < 3")
	=
 	WHERE id IN (select id  from users where id < 3 )
```

* orderByDesc(...columns)

```properties
...columns：可变参数，一个或多个字段
作用：根据一个或多个参数进行 倒序排序
```

* orderByAsc(...columns)

```properties
...columns：可变参数，一个或多个字段
作用：根据一个或多个参数进行 正序排序
```

## Spring Boot 使用 MybatisPlus 配置多个数据源

配置步骤：

​	1、在 application.yml 配置文件中配置数据源信息，并分别起上别名进行区分

```yaml
#普通版本
spring:

  # 设置数据源
  datasource:

    sqlone:
      # 设置数据源 种类、IP、端口、数据库名称
      jdbc-url: jdbc:mysql://10.58.241.10:3306/testspringboottwo?userSSL=false&useunicode=true&characterEncoding=utf8&serverTimezon=UTC
      # 数据源账号
      username: root
      # 数据源密码
      password: Wopt54321
      # 数据源驱动
      driver-class-name: com.mysql.cj.jdbc.Driver

    sqltwo:
      # 设置数据源 种类、IP、端口、数据库名称
      jdbc-url: jdbc:mysql://10.58.241.10:3306/testspringboot?userSSL=false&useunicode=true&characterEncoding=utf8&serverTimezon=UTC
      # 数据源账号
      username: root
      # 数据源密码
      password: Wopt54321
      # 数据源驱动
      driver-class-name: com.mysql.cj.jdbc.Driver
```

```yaml
#druid版本
spring:

  # 设置数据源
  datasource:

    sqlone:
      type: com.alibaba.druid.pool.DruidDataSource
      # 设置数据源 种类、IP、端口、数据库名称
      jdbc-url: jdbc:mysql://10.58.241.10:3306/testspringboottwo?userSSL=false&useunicode=true&characterEncoding=utf8&serverTimezon=UTC
      # 数据源账号
      username: root
      # 数据源密码
      password: Wopt54321
      # 数据源驱动
      driver-class-name: com.mysql.cj.jdbc.Driver
      druid:
        #初始化连接池的连接数量 大小，最小，最大
        initial-size: 5
        min-idle: 5
        max-active: 20
        #配置获取连接等待超时的时间
        max-wait: 60000
        #配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
        time-between-eviction-runs-millis: 60000
        # 配置一个连接在池中最小生存的时间，单位是毫秒
        min-evictable-idle-time-millis: 30000
        validation-query: SELECT 1 FROM DUAL
        test-while-idle: true
        test-on-borrow: true
        test-on-return: false

    sqltwo:
      type: com.alibaba.druid.pool.DruidDataSource
      # 设置数据源 种类、IP、端口、数据库名称
      jdbc-url: jdbc:mysql://10.58.241.10:3306/testspringboot?userSSL=false&useunicode=true&characterEncoding=utf8&serverTimezon=UTC
      # 数据源账号
      username: root
      # 数据源密码
      password: Wopt54321
      # 数据源驱动
      driver-class-name: com.mysql.cj.jdbc.Driver
      druid:
        #初始化连接池的连接数量 大小，最小，最大
        initial-size: 5
        min-idle: 5
        max-active: 20
        #配置获取连接等待超时的时间
        max-wait: 60000
        #配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
        time-between-eviction-runs-millis: 60000
        # 配置一个连接在池中最小生存的时间，单位是毫秒
        min-evictable-idle-time-millis: 30000
        validation-query: SELECT 1 FROM DUAL
        test-while-idle: true
        test-on-borrow: true
        test-on-return: false
```

​	2、编写对应数据源的 config 文件

> 主数据库与从数据库之间的区分：主数据库在 config 文件需加上`@Primary`注解

> `@Primary`注解的作用：当主从数据库同时操作一个数据时，主数据库拥有优先执行权

​	主数据库配置文件

```java
package com.liay.config.mybatisPlusDataSources;

import com.baomidou.mybatisplus.extension.spring.MybatisSqlSessionFactoryBean;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@Configuration
/**
 * basePackages： 这里的路径与对应的 dao 层路径对应
 */
@MapperScan(basePackages = "com.liay.mapper.sqlone",sqlSessionTemplateRef  = "sqloneSessionTemplate")
public class SqlOneConfig {

    @Bean(name = "sqloneSource")
    /**
     * prefix： 这里的名称需与yml中设置的名称对应
     */
    @ConfigurationProperties(prefix = "spring.datasource.sqlone")
    @Primary
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "sqloneSessionFactory")
    @Primary
    public SqlSessionFactory sessionFactory(@Qualifier("sqloneSource") DataSource dataSource) throws Exception {
        MybatisSqlSessionFactoryBean bean = new MybatisSqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper/sqlone/*.xml"));
        return bean.getObject();
    }

    @Bean(name = "sqloneSessionTemplate")
    @Primary
    public SqlSessionTemplate sqlSessionTemplate(@Qualifier("sqloneSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}
```

​	从数据库 config 文件

```java
package com.liay.config.mybatisPlusDataSources;

import com.baomidou.mybatisplus.extension.spring.MybatisSqlSessionFactoryBean;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;

@Configuration
/**
 * basePackages： 这里的路径与对应的 dao 层路径对应
 */
@MapperScan(basePackages = "com.liay.mapper.sqltwo",sqlSessionTemplateRef  = "sqltwoSessionTemplate")
public class SqlTwoConfig {

    @Bean(name = "sqltwoSource")
    /**
     * prefix： 这里的名称需与yml中设置的名称对应
     */
    @ConfigurationProperties(prefix = "spring.datasource.sqltwo")
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "sqltwoSessionFactory")
    public SqlSessionFactory sessionFactory(@Qualifier("sqltwoSource") DataSource dataSource) throws Exception {
        MybatisSqlSessionFactoryBean bean = new MybatisSqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper/sqltwo/*.xml"));
        return bean.getObject();
    }

    @Bean(name = "sqltwoSessionTemplate")
    public SqlSessionTemplate sqlSessionTemplate(@Qualifier("sqltwoSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}                           
```

