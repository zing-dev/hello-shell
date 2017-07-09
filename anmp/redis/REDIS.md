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

## 【redis数据结构 – `Set`集合】
- `redis`的`set`是`string`类型的无序集合。
- `set`元素最大可以包含(`2的32次方-1`)个元素。
- `set`的是通过`hash table`实现的，`hash table`会随着添加或者删除自动的调整大小
- 关于`set`集合类型除了基本的添加删除操作，其他有用的操作还包含集合的取并集(`union`)，交集(`intersection`)，差集(`difference`)。通过这些操作可以很容易的实现`sns`中的好友推荐和`blog`的`tag`功能。

#### `sadd key member` 
- 添加一个`string`元素到,`key`对应的`set`集合中，成功返回1,如果元素以及在集合中返回0,`key`对应的`set`不存在返回错误
#### `srem key member`
- 从`key`对应`set`中移除给定元素，成功返回1，如果`member`在集合中不存在或者`key`不存在返回0，如果`key`对应的不是`set`类型的值返回错误
#### `spop key` 
- 删除并返回`key`对应`set`中随机的一个元素,如果`set`是空或者`key`不存在返回`nil`
#### `srandmember key`
- 同`spop`，随机取`set`中的一个元素，但是不删除元素
#### `smove srckey dstkey member`
- 从`srckey`对应`set`中移除`member`并添加到`dstkey`对应`set`中，整个操作是原子的。成功返回1,如果`member`在`srckey`中不存在返回0，如果`key`不是`set`类型返回错误
#### `scard key`
- 返回`set`的元素个数，如果`set`是空或者`key`不存在返回0
#### `sismember key member` 
- 判断member是否在set中，存在返回1，0表示不存在或者key不存在
#### `sinter key1 key2...keyN`
- 返回所有给定key的交集
#### `sinterstore dstkey key1...keyN`
- 同`sinter`，但是会同时将交集存到`dstkey`下
#### `sunion key1 key2...keyN`
- 返回所有给定`key`的并集
#### `sunionstore dstkey key1...keyN`
- 同`sunion`，并同时保存并集到`dstkey`下
#### `sdiff key1 key2...keyN` 
- 返回所有给定key的差集
#### `sdiffstore dstkey key1...keyN` 
- 同`sdiff`，并同时保存差集到`dstkey`下
#### `smembers key` 
- 返回key对应set的所有元素，结果是无序的

## 【redis数据结构 – `Sorted Set` 有序集合】
- 和set一样`sorted set`也是`string`类型元素的集合，不同的是每个元素都会关联一个`double`类型的`score`。`sorted set`的实现是`skip list`和`hash table`的混合体。
- 当元素被添加到集合中时，一个元素到`score`的映射被添加到`hash table`中，另一个`score`到元素的映射被添加到`skip list`并按照`score`排序，所以就可以有序的获取集合中的元素。

#### `zadd key score member` 
- 添加元素到集合，元素在集合中存在则更新对应`score`
#### `zrem key member` 
- 删除指定元素，1表示成功，如果元素不存在返回0
#### `zincrby key incr member` 
- 增加对应`member`的`score`值，然后移动元素并保持`skip list`有序。返回更新后的`score`值
#### `zrank key member` 
- 返回指定元素在集合中的排名（下标，非`score`）,集合中元素是按`score`从小到大排序的
#### `zrevrank key member` 
- 同上,但是集合中元素是按`score`从大到小排序
#### `zrange key start end` 
- 类似`lrange`操作从集合中取指定区间的元素。返回的是有序结果
#### `zrevrange key start end` 
- 同上，返回结果是按`score`逆序的
#### `zrangebyscore key min max` 
- 返回集合中`score`在给定区间的元素
#### `zcount key min max` 
- 返回集合中`score`在给定区间的数量
#### `zcard key` 
- 返回集合中元素个数
#### `zscore key element`  
- 返回给定元素对应的`score`
#### `zremrangebyrank key min max `
- 删除集合中排名在给定区间的元素
#### `zremrangebyscore key min max`
- 删除集合中`score`在给定区间的元素

## 【redis数据结构 – 哈希】
   

[from](http://www.cnblogs.com/yuhangwang/p/5817930.html)