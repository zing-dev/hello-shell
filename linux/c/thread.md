### 多线程编程-互斥锁

####  互斥锁

>  互斥锁，是一种信号量，常用来防止两个进程或线程在同一时刻访问相同的共享资源。可以保证以下三点：

- 原子性：把一个互斥量锁定为一个原子操作，这意味着操作系统（或`pthread`函数库）保证了如果一个线程锁定了一个互斥量，没有其他线程在同一时间可以成功锁定这个互斥量。
- 唯一性：如果一个线程锁定了一个互斥量，在它解除锁定之前，没有其他线程可以锁定这个互斥量。
- 非繁忙等待：如果一个线程已经锁定了一个互斥量，第二个线程又试图去锁定这个互斥量，则第二个线程将被挂起（不占用任何`cpu`资源），直到第一个线程解除对这个互斥量的锁定为止，第二个线程则被唤醒并继续执行，同时锁定这个互斥量。

#### 函数说明

> 需要的头文件：pthread.h 

####  初始化互斥锁

>  函数原型：`int  pthread_mutex_init(pthread_mutex_t *mp, const pthread_mutexattr_t *mattr)`

>  参数说明：`mp` 互斥锁地址   `mattr`  属性 通常默认 `null`

> 初始化互斥锁之前，必须将其所在的内存清零。

> 如果互斥锁已 初始化，则它会处于未锁定状态。互斥锁可以位于进程之间共享的内存中或者某个进程的专用内存中。

#### 锁定互斥锁

- 函数原型：

```c
int pthread_mutex_lock(pthread_mutex_t *mutex); 

#include <pthread.h> 
pthread_mutex_t mutex; 
int ret;
ret = pthread_ mutex_lock(&mp); /* acquire the mutex */
```

- 函数说明：
> 当 `pthread_mutex_lock()` 返回时，该互斥锁已被锁定。调用线程是该互斥锁的属主。如果该互斥锁已被另一个线程锁定和拥有，则调用线程将阻塞，直到该互斥锁变为可用为止。

1. 如果互斥锁类型为`PTHREAD_MUTEX_NORMAL`，则不提供死锁检测。尝试重新锁定互斥锁会导致死锁。如果某个线程尝试解除锁定的互斥锁不是由该线程锁定或未锁定，则将产生不确定的行为。

2. 如果互斥锁类型为`PTHREAD_MUTEX_ERRORCHECK`，则会提供错误检查。如果某个线程尝试重新锁定的互斥锁已经由该线程锁定，则将返回错误。如果某个线程尝试解除锁定的互斥锁不是由该线程锁定或者未锁定，则将返回错误。

3. 如果互斥锁类型为`PTHREAD_MUTEX_RECURSIVE`，则该互斥锁会保留锁定计数这一概念。线程首次成功获取互斥锁时，锁定计数会设置为 `1`。线程每重新锁定该互斥锁一次，锁定计数就增加 `1`。线程每解除锁定该互斥锁一次，锁定计数就减小 `1`。 锁定计数达到 `0` 时，该互斥锁即可供其他线程获取。如果某个线程尝试解除锁定的互斥锁不是由该线程锁定或者未锁定，则将返回错误。

4. 如果互斥锁类型是` PTHREAD_MUTEX_DEFAULT`，则尝试以递归方式锁定该互斥锁将产生不确定的行为。对于不是由调用线程锁定的互斥锁，如果尝试解除对它的锁定，则会产生不确定的行为。如果尝试解除锁定尚未锁定的互斥锁，则会产生不确定的行为。

- 返回值：
> `pthread_mutex_lock()` 在成功完成之后会返回零。其他任何返回值都表示出现了错误。如果出现以下任一情况，该函数将失败并返回对应的值。
> `EAGAIN`：由于已超出了互斥锁递归锁定的最大次数，因此无法获取该互斥锁。
> `EDEADLK`：当前线程已经拥有互斥锁。

#### 解除锁定互斥锁
- 函数原型：
```c
int pthread_mutex_unlock(pthread_mutex_t *mutex); 
#include <pthread.h> 

pthread_mutex_t mutex; 
int ret; 
ret = pthread_mutex_unlock(&mutex); /* release the mutex */
```
- 函数说明：
> `pthread_mutex_unlock()` 可释放 `mutex`引用的互斥锁对象。互斥锁的释放方式取决于互斥锁的类型属性。如果调用 `pthread_mutex_unlock()` 时有多个线程被 `mutex` 对象阻塞，则互斥锁变为可用时调度策略可确定获取该互斥锁的线程。对于 `PTHREAD_MUTEX_RECURSIVE` 类型的互斥锁，当计数达到零并且调用线程不再对该互斥锁进行任何锁定时，该互斥锁将变为可用。

- 返回值：
> `pthread_mutex_unlock()` 在成功完成之后会返回零。
> 其他任何返回值都表示出现了错误。如果出现以下情况，该函数将失败并返回对应的值。
> `EPERM` :当前线程不拥有互斥锁。

#### 使用非阻塞互斥锁锁定
- 函数原型：
```c
int pthread_mutex_trylock(pthread_mutex_t *mutex); 

#include <pthread.h> 
pthread_mutex_t mutex; 
int ret; 
ret = pthread_mutex_trylock(&mutex); /* try to lock the mutex */
```
- 函数说明：
  `pthread_mutex_trylock()` 是 `pthread_mutex_lock()` 的非阻塞版本。如果 `mutex` 所引用的互斥对象当前被任何线程（包括当前线程）锁定，则将立即返回该调用。否则，该互斥锁将处于锁定状态，调用线程是其属主。

- 返回值：
  `pthread_mutex_trylock()`  在成功完成之后会返回零。其他任何返回值都表示出现了错误。如果出现以下任一情况，该函数将失败并返回对应的值。

-  `EBUSY `
  由于 mutex 所指向的互斥锁已锁定，因此无法获取该互斥锁。

- `EAGAIN`

  由于已超出了 mutex 的递归锁定最大次数，因此无法获取该互斥锁。

#### 销毁互斥锁

- 函数原型：

  ```c
  int pthread_mutex_destroy(pthread_mutex_t mp);

  #include <pthread.h> 
  pthread_mutex_t mp; 
  int ret; 
  ret = pthread_mutex_destroy(&mp); / mutex is destroyed */
  //请注意，没有释放用来存储互斥锁的空间。
  ```

- 返回值：

> `pthread_mutex_destroy()` 在成功完成之后会返回零。其他任何返回值都表示出现了错误。如果出现以下任一情况，该函数将失败并返回对应的值。

> `EINVAL`:` mp` 指定的值不会引用已初始化的互斥锁对象。



```c
void reader_function ( void );
void writer_function ( void );
char buffer;
int buffer_has_item=0;
pthread_mutex_t mutex;
struct timespec delay;
void main ( void ){
　pthread_t reader;
　/* 定义延迟时间*/
　delay.tv_sec = 2;
　delay.tv_nec = 0;
　/* 用默认属性初始化一个互斥锁对象*/
　pthread_mutex_init (&mutex,NULL);
pthread_create(&reader, pthread_attr_default, (void *)&reader_function), NULL);
　writer_function( );
}
void writer_function (void){
　while(1){
　　/* 锁定互斥锁*/
　　pthread_mutex_lock (&mutex);
　　if (buffer_has_item==0){
　　　buffer=make_new_item( );
　　　buffer_has_item=1;
　　}
　　/* 打开互斥锁*/
　　pthread_mutex_unlock(&mutex);
　　pthread_delay_np(&delay);
　}
}
void reader_function(void){
　while(1){
　　pthread_mutex_lock(&mutex);
　　if(buffer_has_item==1){
　　　consume_item(buffer);
　　　buffer_has_item=0;
　　}
　　pthread_mutex_unlock(&mutex);
　　pthread_delay_np(&delay);
　}
}

/**
程序说明：
这里声明了互斥锁变量mutex，结构pthread_mutex_t为不公开的数据类型，其中包含一个系统分配的属性对象。函数pthread_mutex_init用来生成一个互斥锁。NULL参数表明使用默认属性。如果需要声明特定属性的互斥锁，须调用函数pthread_mutexattr_init。函数pthread_mutexattr_setpshared和函数pthread_mutexattr_settype用来设置互斥锁属性。前一个函数设置属性pshared，它有两个取值，PTHREAD_PROCESS_PRIVATE和PTHREAD_PROCESS_SHARED。前者用来不同进程中的线程同步，后者用于同步本进程的不同线程。
在上面的例子中，我们使用的是默认属性PTHREAD_PROCESS_ PRIVATE。后者用来设置互斥锁类型，可选的类型有PTHREAD_MUTEX_NORMAL、PTHREAD_MUTEX_ERRORCHECK、PTHREAD_MUTEX_RECURSIVE和PTHREAD _MUTEX_DEFAULT。它们分别定义了不同的上锁、解锁机制，一般情况下，选用最后一个默认属性。
pthread_mutex_lock声明开始用互斥锁上锁，此后的代码直至调用pthread_mutex_unlock为止，均被上锁，即同一时间只能被一个线程调用执行。当一个线程执行到pthread_mutex_lock处时，如果该锁此时被另一个线程使用，那此线程被阻塞，即程序将等待到另一个线程释放此互斥锁。在上面的例子中，我们使用了pthread_delay_np函数，让线程睡眠一段时间，就是为了防止一个线程始终占据此函数。
*/
```

#### 饥饿和死锁的情形

>  当一个互斥量已经被别的线程锁定后，另一个线程调用`pthread_mutex_lock()`函数去锁定它时，会挂起自己的线程等待这个互斥量被解锁。可能出现以下两种情况：

>  “饥饿状态”：这个互斥量一直没有被解锁，等待锁定它的线程将一直被挂着，即它请求某个资源，但永远得不到它。用户必须在程序中努力避免这种“饥饿”状态出现。`Pthread`函数库不会自动处理这种情况。

>  “死锁”：一组线程中的所有线程都在等待被同组中另外一些线程占用的资源，这时，所有线程都因等待互斥量而被挂起，它们中的任何一个都不可能恢复运行，程序无法继续运行下去。这时就产生了死锁。`Pthread`函数库可以跟踪这种情形，最后一个线程试图调用`pthread_mutex_lock()`时会失败，并返回类型为`EDEADLK`的错误。