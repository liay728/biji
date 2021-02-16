# TypeScript

## 数据类型

### 基本数据类型

- number-数值

- string-字符串
- boolean-布尔值
- undefinded-声明但未赋值的变量值（找不到值）
- null-声明了变量并已赋值，值为null（能找到，值就为空）
- any-所有类型

### 引用数据类型

- any[]-数组

## 对象的类型注解

​	创建对象时，对对象的属性进行类型声明，以进行规范。

### 属性的类型注解

```typescript
// 对象的类型注解，对属性进行类型约束
let peo: {
    name : string;
    age : number;
}
peo = {
    name :'张三',
    age : 12
}
```

### 方法的类型注解

​	箭头（=>）左边小括号中的内容为方法的参数及类型

​	箭头（=>）右边的内容为方法的返回值类型

```typescript
let person = {
    sayHi: () => void
    sing: (name: string) => void
    sum: (num1: number, num2: number) => number
}
```

### 接口

​	**interface**：用来作为对象的类型注解，对对象进行约束。

​	在对象后 + **:接口名** 使用

```typescript
interface Iuser {
    name: string
    age: number
    sayHi: () => void
}

let user: Iuser = {
    name: 'zx',
    age: 12,
    sayHi: function(){
        console.log("sayHi");
    }
}
console.log(user.name);
console.log(user.age);
user.sayHi();
```

## 数组

> forEach

​	含义：数组便利

```typescript
const strArr: string[] = ['1','2','3'];
strArr.forEach(function(item, index){
    console.log(item, "", index);
})
```

> some

​	含义：遍历数组，查找是否有满足条件的元素（如过有，则可以终止循环）

​	特点：根据回调函数的返回值，决定是否停止循环。如果返回true，就停止；如果返回false，则继续循环。

​	返回值：如果找到满足条件的元素，true；否则为false。

```typescript
let has:boolean = numArr.some(function (num) {
    console.log(num);
    if(num > 10){
        return true;
    }
    return false;
})
console.log(has);
```

