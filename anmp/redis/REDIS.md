# Redis

## 【redis数据结构 – 简介】
- redis是一种高级的key:value存储系统，其中value支持五种数据类型：
```
    1.字符串（string）
    2.字符串列表（list）
    3.字符串集合（set）
    4.有序字符串集合（sorted set）
    5.哈希（hashe）
```
1. key不要太长，尽量不要超过1024字节，这不仅消耗内存，而且会降低查找的效率；
2. key也不要太短，太短的话，key的可读性会降低；
3. 在一个项目中，key最好使用统一的命名模式，例如user:10000:passwd。

## 【redis数据结构 – `string`】
- `string`是redis最基本的类型，而且`string`类型是二进制安全的。
- redis的string可以包含任何数据。包括jpg图片或者序列化的对象。
- 最大上限是1G字节。 
- 如果只用string类型，redis就可以被看作加上持久化特性的memcached

#### `set key value`
- 设置key对应的值为string类型的value,返回1表示成功，0失败

#### `setnx key value`
- 同上，如果key已经存在，返回0 。nx 是not exist的意思

#### `get key`
- 获取key对应的string值,如果key不存在返回nil

#### `getset key value`
- 设置key的值，并返回key的旧值。如果key不存在返回nil

#### `mget key1 key2 ... keyN`
- 一次获取多个key的值，如果对应key不存在，则对应返回nil。
- 下面是个实验, nonexisting不存在，对应返回nil

#### `mset key1 value1 ... keyN valueN`
- 一次设置多个key的值，成功返回1表示所有的值都设置了，失败返回0表示没有任何值被设置

#### `msetnx key1 value1 ... keyN valueN`
- 同上，但是不会覆盖已经存在的key

#### `incr key`
- 对key的值做加加操作,并返回新的值。注意incr一个不是int的value会返回错误，incr一个不存在的key，则设置key为1

#### `decr key`
- 同上，但是做的是减减操作，decr一个不存在key，则设置key为-1

#### `incrby key integer`
- 同incr，加指定值 ，key不存在时候会设置key，并认为原来的value是 0

#### `decrby key integer` 
- 同decr，减指定值。decrby完全是为了可读性，我们完全可以通过incrby一个负值来实现同样效果，反之一样。

#### `append key value`
- 给指定key的字符串值追加value,返回新字符串值的长度

#### `substr key start end` 
- 返回截取过的key的字符串值,注意并不修改key的值。下标是从0开始的。


## 【redis数据结构 – `list`】
- redis的`list`类型其实就是一个每个子元素都是`string`类型的双向链表。我们可以通过`push`,`pop`操作从链表的头部或者尾部添加删除元素。这使得`list`既可以用作栈，也可以用作队列。
- `list`的`pop`操作还有阻塞版本的。当我们`[lr]pop`一个`list`对象是，如果`list`是空，或者不存在，会立即返回`nil`。但是阻塞版本的`b[lr]pop`可以则可以阻塞，当然可以加超时时间，超时后也会返回`nil`。为什么要阻塞版本的`pop`呢，主要是为了避免轮询。举个简单的例子如果我们用`list`来实现一个工作队列。执行任务的`thread`可以调用阻塞版本的`pop`去获取任务这样就可以避免轮询去检查是否有任务存在。当任务来时候工作线程可以立即返回，也可以避免轮询带来的延迟。

#### `lpush key string`
- 在`key`对应`list`的头部添加字符串元素，返回1表示成功，0表示key存在且不是`list`类型

#### `rpush key string`
- 同上，在尾部添加

#### `llen key`
- 返回`key`对应`list`的长度，`key`不存在返回0,如果`key`对应类型不是`list`返回错误

#### `lrange key start end`
- 返回指定区间内的元素，下标从0开始，负值表示从后面计算，-1表示倒数第一个元素 ，`key`不存在返回空列表

#### `ltrim key start end`
- 截取`list`，保留指定区间内元素，成功返回1，`key`不存在返回错误

#### `lset key index value`
- 设置`list`中指定下标的元素值，成功返回1，`key`或者下标不存在返回错误

#### `lrem key count value`
- 从`key`对应`list`中删除`count`个和`value`相同的元素。`count`为0时候删除全部

#### `lpop key`
- 从`list`的头部删除元素，并返回删除元素。如果`key`对应`list`不存在或者是空返回`nil`，如果`key`对应值不是`list`返回错误

#### `rpop`
- 同上，但是从尾部删除

#### `blpop key1...keyN timeout`
- 从左到右扫描返回对第一个非空`list`进行`lpop`操作并返回，比如`blpop list1 list2 list3 0 `,如果`list`不存在，`list2,list3`都是非空则对`list2`做`lpop`并返回从`list2`中删除的元素。如果所有的`list`都是空或不存在，则会阻塞`timeout`秒，`timeout`为0表示一直阻塞。当阻塞时，如果有`client`对`key1...keyN`中的任意`key`进行`push`操作，则第一在这个`key`上被阻塞的`client`会立即返回。如果超时发生，则返回`nil`。

#### `brpop`
- 同blpop，一个是从头部删除一个是从尾部删除

#### `rpoplpush srckey destkey`
- 从`srckey`对应`list`的尾部移除元素并添加到`destkey`对应`list`的头部,最后返回被移除的元素值，整个操作是原子的.如果`srckey`是空或者不存在返回`nil`

## 【redis数据结构 – 集合】

## 【redis数据结构 – 有序集合】

## 【redis数据结构 – 哈希】
   

[from](http://www.cnblogs.com/yuhangwang/p/5817930.html)