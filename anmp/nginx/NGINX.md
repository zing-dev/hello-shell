# Nginx配置详解

## Nginx常用功能

### Http代理，反向代理
- 作为web服务器最常用的功能之一，尤其是反向代理。

![image](../../images/398358-20160202133724350-1807373891.jpg)

```
Nginx在做反向代理时，提供性能稳定，并且能够提供配置灵活的转发功能。
Nginx可以根据不同的正则匹配，采取不同的转发策略，
比如图片文件结尾的走文件服务器，动态页面走web服务器，
只要你正则写的没问题，又有相对应的服务器解决方案，你就可以随心所欲的玩。
并且Nginx对返回结果进行错误页跳转，异常判断等。
如果被分发的服务器存在异常，他可以将请求重新转发给另外一台服务器，
然后自动去除异常服务器。
```

### 负载均衡
- Nginx提供的负载均衡策略有2种：内置策略和扩展策略。内置策略为轮询，加权轮询，Ip hash。扩展策略，就天马行空，只有你想不到的没有他做不到的啦，你可以参照所有的负载均衡算法，给他一一找出来做下实现。
- ![image](../../images/398358-20160202133753382-1863657242.jpg)
- Ip hash算法，对客户端请求的ip进行hash操作，然后根据hash结果将同一个客户端ip的请求分发给同一台服务器进行处理，可以解决session不共享的问题。
- ![image](../../images/398358-20160201162405944-676557632.jpg)

### web缓存
- Nginx可以对不同的文件做不同的缓存处理，配置灵活，并且支持FastCGI_Cache，主要用于对FastCGI的动态程序进行缓存。配合着第三方的ngx_cache_purge，对制定的URL缓存内容可以的进行增删管理。


## Nginx配置文件结构

```
...              #全局块

events {         #events块
   ...
}

http      #http块
{
    ...   #http全局块
    server        #server块
    { 
        ...       #server全局块
        location [PATTERN]   #location块
        {
            ...
        }
        location [PATTERN] 
        {
            ...
        }
    }
    server
    {
      ...
    }
    ...     #http全局块
}
```

- 全局块：配置影响nginx全局的指令。一般有运行nginx服务器的用户组，nginx进程pid存放路径，日志存放路径，配置文件引入，允许生成worker process数等。
- events块：配置影响nginx服务器或与用户的网络连接。有每个进程的最大连接数，选取哪种事件驱动模型处理连接请求，是否允许同时接受多个网路连接，开启多个网络连接序列化等。
- http块：可以嵌套多个server，配置代理，缓存，日志定义等绝大多数功能和第三方模块的配置。如文件引入，mime-type定义，日志自定义，是否使用sendfile传输文件，连接超时时间，单连接请求数等。
- server块：配置虚拟主机的相关参数，一个http中可以有多个server。
- location块：配置请求的路由，以及各种页面的处理情况。

```
########### 每个指令必须有分号结束。#################
#user administrator administrators;  #配置用户或者组，默认为nobody nobody。
#worker_processes 2;  #允许生成的进程数，默认为1
#pid /nginx/pid/nginx.pid;   #指定nginx进程运行文件存放地址
error_log log/error.log debug;  #制定日志路径，级别。这个设置可以放入全局块，http块，server块，级别以此为：debug|info|notice|warn|error|crit|alert|emerg
events {
    accept_mutex on;   #设置网路连接序列化，防止惊群现象发生，默认为on
    multi_accept on;  #设置一个进程是否同时接受多个网络连接，默认为off
    #use epoll;      #事件驱动模型，select|poll|kqueue|epoll|resig|/dev/poll|eventport
    worker_connections  1024;    #最大连接数，默认为512
}
http {
    include       mime.types;   #文件扩展名与文件类型映射表
    default_type  application/octet-stream; #默认文件类型，默认为text/plain
    #access_log off; #取消服务日志    
    log_format myFormat '$remote_addr–$remote_user [$time_local] $request $status $body_bytes_sent $http_referer $http_user_agent $http_x_forwarded_for'; #自定义格式
    access_log log/access.log myFormat;  #combined为日志格式的默认值
    sendfile on;   #允许sendfile方式传输文件，默认为off，可以在http块，server块，location块。
    sendfile_max_chunk 100k;  #每个进程每次调用传输数量不能大于设定的值，默认为0，即不设上限。
    keepalive_timeout 65;  #连接超时时间，默认为75s，可以在http，server，location块。

    upstream mysvr {   
      server 127.0.0.1:7878;
      server 192.168.10.121:3333 backup;  #热备
    }
    error_page 404 https://www.baidu.com; #错误页
    server {
        keepalive_requests 120; #单连接请求上限次数。
        listen       4545;   #监听端口
        server_name  127.0.0.1;   #监听地址       
        location  ~*^.+$ {       #请求的url过滤，正则匹配，~为区分大小写，~*为不区分大小写。
           #root path;  #根目录
           #index vv.txt;  #设置默认页
           proxy_pass  http://mysvr;  #请求转向mysvr 定义的服务器列表
           deny 127.0.0.1;  #拒绝的ip
           allow 172.18.5.54; #允许的ip           
        } 
    }
}
```

## 主配置文件框架解析
### MAIN配置段常用参数
#### 常规配置指令

`user  USERNAME  [GROUPNAME];`
- 指定用于运行worker进程的用户和组：例如user  nginx   nginx;

`pid  /PATH/TO/PID_FILE;`
- 指定nginx进程的pid文件路径；pid  /var/run/nginx.pid;

`worker_rlimit_nofile  #;`
- 指定一个worker进程所能够打开的最大文件描述符数量；

`worker_rlimit_sigpending  #;`
- 指定每个用户能够发往worker进程的信号的数量；

#### 性能优化相关指令
`worker_processes  #;`
- worker进程的个数；通常应该为物理CPU核心数量减1；"auto"实现自动设定

`worker_cpu_affinity  CPUMASK CPUMASK …;`
- CPU绑定；加上CPU掩码
- 实例：
`worker_cpu_affinity 00000001 00000010 00000100;`

`worker_priority  nice;`
- [-20, 19]

#### 调试定位Bug相关指令
`daemon  off|on;`
- 是否以守护进程方式启动nignx；

`master_process  on|off;`
- 是否以master/worker模型运行nginx；
`error_log  /PATH/TO/ERROR_LOG level;`

- 错误日志文件及其级别；调试需要可以设定为debug；但debug在编译时使用了"--with-debug"选项

#### event配置段常用参数
`worker_connections  #;`
- 每个worker进程所能够响应的最大并发请求数量；默认为1024；上限：worker_proceses * worker_connections

`use  [epoll|rgsig|select|poll];`
- 定义使用的事件模型；建议让nginx自动选择；

`accept_mutex  [on|off];`
- 各worker接收用户的请求的负载均衡锁(互斥锁) on：启用，表示用于让多个worker轮流地、序列化地响应新请求；

`lock_file  /PATH/TO/LOCK_FILE;`
- 锁文件位置

### Nginx：http常规配置

- http的所有配置需要在http{ } 配置段进行定义。未具体说明指令基于ngx_http_core_module模块配置
#### 主机或套接字相关指令

`server {}：`
- 定义一个虚拟主机；server可以出现一次货多次
```
server{
    listenPORT;
    server_name  NAME;
    root /PATH/TO/DOCUMENTROOT;
}
```
- 基于port：listen指令监听在不同的端口；
- 基于hostname：server_name指令指向不同的主机名；

`listen：`
- 配置监听端口
###### 使用格式：
- `listen address[:port] [default_server] [ssl] [http2 | spdy]`
- `listen port [default_server] [ssl] [http2 | spdy]`

- `default_server`：设置默认虚拟主机；用于基于IP地址，或使用了任意不能对应于任何一个server的name时所返回站点；
- `ssl`：用于限制只能通过ssl连接提供服务；
- `spdy`：SPDYprotocol（speedy），在编译了spdy模块的情况下，用于支持SPDY协议；
- `http2`：支持httpversion 2第二版http协议；

###### `server_name NAME [...];`：指明主机名称
- 后可跟一个或多个主机名；名称还可以使用通配符和正则表达式(~引导整个正则表达式)；
- 匹配顺序：
    ```
    1) 首先做精确匹配；例如：www.xxx.com
    2) 左侧通配符；例如：*.xxx.com
    3) 右侧通配符，例如：www.xxx.*
    4) 正则表达式，例如：~^.*\.xxx\.com$
    5) default_server
    ```


##### `tcp_nodelay on|off;`
- 对keepalive模式下的连接是否使用TCP_NODELAY选项；一般为off
- 提高带宽利用率，将发往同一主机很小的TCP报文合并成一个；实际生产上对于用户请求即使浪费带块也不能合并请求
  
#####  `tcp_nopush on|off;`
- 是否启用TCP_NOPUSH(FREEBSE）或TCP_CORK(Linux)选项；仅在sendfile为on时有用；
- 尝试将多个报文首部压缩成一个发送，默认off，不启用该功能

##### `sendfile on|off;`
- 是否启用sendfile功能；静态文件直接在内核中封装响应，而不是从内核空间到用户空间再发往内和空间


#### 路径相关指令
#####  `root`：指明根文件路径
- 设置web资源的路径映射；用于指明请求的URL所对应的文档的目录路径；可用与server或localtion中
```
server{
...
    root  /data/www/vhosts;
    }
    http://www.xuding.com/images/logo.jpg --> /data/www/vhosts/images/logo.jpg
    server{
        ...
        server_name  www.xuding.com;
        location/images/ {
            root  /data/imgs/;
        ...
    }
}
http://www.xuding.com/images/logo.jpg --> /data/imgs/images/logo.jpg
```
##### `location`
-  允许根据用户请求的URI来匹配定义的各location。匹配到时，此请求将被相应的location块中的配置所处理；即用于为需要用到专用配置的uri提供特定配置；
- =：URI的精确匹配，其后多一个字符都不可以，精确匹配根
- ~：做正则表达式匹配，区分字符大小写；
- ~*：做正则表达式匹配，不区分字符大小写；
- ^~：URI的左半部分匹配，不区分字符大小写；

##### `alias`：定义路径别名，只能用于location配置段
    ```
    location  /images/ {
        root/data/imgs/;
    }
    location  /images/ {
        alias/data/imgs/;
    }
    ```
#####  `index` ：设置默认主页(`ngx_http_index_module`模块引入)
- 可以带上变量，如$geo更具不同IP地区来设置不同的语言主页,indexfile ...;

##### `error_page code ... [=[response]] uri;`：自定义错误页面，根据http的状态码重定向错误页面；

##### `try_files file ... uri;`：以指定的顺序检查文件的存在性响应
- `try_files file ... =code;`
- 尝试查找第1至第N-1个文件，第一个即为返回给请求者的资源；若1至N-1文件都不存在，则跳转至最一个uri（必须不能匹配至当前location，而应该匹配至其它location，否则会导致死循环）；

#### 面向客户端请求相关的配置
##### `keepalive_timeout # ;`
- 设定keepalive连接的超时时长；0表示禁止长连接；默认为启用为75s；
##### `keepalive_requests # ;`
- 在keepalived连接上所允许请求的最大资源数量；默认为100；
##### `keepalive_disable … ….;`
- 指明禁止为何种浏览器使用keepalive功能；默认none，也可以指明具体浏览器名称
##### `send_timeout #;`
- 发送响应报文的超时时长，默认为60s;
##### `client_body_buffer_size size;`
- 接收客户请求报文body的缓冲区大小；默认为16k；超出此指定大小时将被移存于磁盘上；
##### `client_body_temp_pathpath [level1 [level2 [level3]]];`
- 设定用于存储客户端请求body的临时存储路径及子目录结构和数量；
client_body_temp_path  /var/tmp/client_body  2 2;

#### 文件操作优化相关的配置

##### `aio  on|off;`    
- 是否启用异步IO模式
##### `directio  size|off;`   
- 直接IO；不在内存中缓冲，直接从硬盘加载使用(当大于指定size)
Enablesthe use of the O_DIRECT flag (FreeBSD, Linux), the F_NOCACHE flag (Mac OS X),or the directio() function (Solaris), when reading files that are larger thanor equal to the specified size.
##### `open_file_cache` ：打开文件缓存
- `open_file_cache off;` 
- `open_file_cachemax=N [inactive=time];`
- 注释：nginx可以缓存以下三种信息
    - 1)文件描述符、文件大小和最近一次的修改时间；
    - 2)打开的目录的结构；
    - 3)没有找到的或者没有权限操作的文件的相关信息；
        max=N表示可缓存的最大条目上限；一旦达到上限，则会使用LRU算法从缓存中删除最近最少使用的缓存项；
        inactive=time：在此处指定的时长内没有被访问过的缓存项是为非活动缓存项，因此直接删除；
##### `open_file_cache_errorson | off;`
- 是否缓存找不到其路径的文件，或没有权限没有权限访问的文件相关信息；
##### `open_file_cache_valid # ;`
- 每隔多久检查一次缓存中缓存项的有效性；默认为60s;
##### `open_file_cache_min_uses # ; `
- 缓存项在非活动期限内最少应该被访问的次数；

#### `ngx_http_access_module`模块调用配置（基于IP的访问控制）
- `allow address | CIDR | unix: | all;`   允许
- `deny address | CIDR | unix: | all;`  拒绝

#### `ngx_http_log_module`模块调用配置（访问日志）

##### `log_format  name string  ...;`：定义日志格式及其名称；
- 日志格式一般通过调用内置变量来定义；
- string：通过nginx所支持的变量(每个模块会引入自变量)来支持的

##### `access_log`：访问日志
- access_logpath [format [buffer=size [flush=time]]];
- access_logoff;
- 访问日志文件路径，格式名称以及缓存大小和刷写时间间隔；建议定义缓冲以提升性能；

##### `open_log_file_cachemax=N [inactive=time] [min_uses=N] [valid=time];`
- `open_log_file_cache off;`

#### `ngx_http_stub_status_module`模块调用配置：
- `stub_status;` 调用查看nginx状态指令
```
location /staus{
      stub_status;
}
```
`Active connections`
- 当前活动的客户端连接数

`accepts`
- 已经接受的客户端连接总数量：16630948

`handled`
- 已经处理过后客户端连接总数量：16630948

`requests`
- 客户端的总的请求数量：31070465

`Readking`
- 正在读取的客户端请求的数量

`Writing`
- 正向其发送响应报文的连接数量

`Waiting`
- 等待其发出请求的空闲连接数量

#### `ngx_http_gzip_module`模块：gip压缩

`gzip on | off;`
- 启用或禁用gzip压缩响应报文；

`gzip_comp_level  level;`
- 压缩比，1-9，默认为1;

`gzip_disable regex  ...;`
- regex是为用于匹配客户端响应器类型的正则表达式；表示对何种浏览器禁止使用压缩功能；

`gzip_min_length  length;`
- 触发压缩功能的响应报文的最小长度；

`gzip_http_version  1.0 | 1.1;`
- 设定启用压缩功能时，协议的最小版本；

`gzip_proxied # ;`
- `off | expired |  no-cache | no-store | private | no_last_modified | no_etag | auth | any ...;`
- 定义对客户端请求的具有何种请求属性的资源启用压缩功能；如expired则表示对由于使用了expire首部而无法缓存的对象启用压缩功能；

`gzip_types  mime-type ...;`
- 指明仅对哪些类型的资源执行压缩操作；即压缩过滤器；
```
gzip  on;
gzip_http_version1.0;
gzip_comp_level6;
gzip_disablemsie6;
gzip_min_length2;
gzip_typestext/plain text/css text/xml application/x-javascript application/xmlapplication/jsonapplication/java-script;                
```

### Nginx：http请求重写(ngx_http_rewrite_module)
#### `ngx_http_rewrite_module`功能
- 将请求的url基于正则表达式进行重写(URL重定向)，在如下情况下可以使用：ttp转换成httpd服务http--> https、域名转换domain1.tld --> domain2.tld,、URL转换uri1 --> uri2、实现SEO搜索引擎优化效果 …

#### 指令
- `rewrite  regex replacement [flag];`

- `regex`：正则表达式，用于匹配用户请求的url；
- `replacement`：重写(重定向、替换)成为的结果；
- `[flag]`：
    ```
    last：重写完成之后停止对当前uri的进一步处理，重新请求URL，对新url的新一轮从第一条开始匹配处理；
    可能会出现死循环情况，此时可以设置循环次数，超过次数后返回给客户端错误
    break：重写完成之后停止对当uri的处理，重写检查结果结束，转向其后面的其它配置；
    redirect：重写完成之后会返回客户端一个临时的重定向，由客户端对新的url重新发起请求（302）；
    permanent：重写完成之后会返回客户端一个永久的重定向，由客户端对新的url重新发起请求（301）；
    ```
    
```
server{
...
rewrite^(/download/.*)/media/(.*)\..*$ $1/mp3/$2.mp3 last;
rewrite^(/download/.*)/audio/(.*)\..*$ $1/mp3/$2.ra last;
return  403;
...
}                                
  验证请求：http://www.xxx.com/download/a/b/c/media/32.wmv -->   /download/a/b/c/mp3/32.mp3
```

- last和break请求处理是在服务器内部完成，客户端仅请求一次。redirect和permanent需要客户端再次请求
- URL重写时所用的正则表达式需要使用PCRE格式。PCRE正则表达式元字符：

```
    字符匹配：.,[ ], [^]
    次数匹配：*,+, ?, {m}, {m,}, {m,n}
    位置锚定：^,$
    或者：|
    分组：(),后向引用, $1, $2, ...
```

#### `if (condition) { ... }`：条件判断，引用新的配置上下文
- condition可以为以下格式  ：
- 比较表达式：
```
==，!=
~：模式匹配，区分字符大小写；
~*：模式匹配，不区分字符大小写；
!~：模式不匹配，区分字符大小写；
!~*:模式不匹配，不区分字符大小写；
```
- 文件及目录判断：
```-f,!-f：是否存在且为普通文件；
-d,!-d: 是否存在且为目录；
-e,!-e：是否存在；
-x,!-x：是否存在且可执行；
```

- cookie首部检测匹配
```
if($http_cookie ~* "id=([^;]+)(?:;|$)") {
    set $id $1;
}
```

- 请求报文的请求方法是POST，返回405
if($request_method = POST) {
    return 405;
}
- 限速(如会员认为不是slow不做限速)
```
if($slow) {
    limit_rate 10k;
}
```
- 非法引用，返回403。注：也可以对非法引用到其他网页
```
if($invalid_referer) {
    return 403;
}
```

- reture：立即停止对请求的uri的处理，并返回指定的状态码；
```
returncode [text];
returncode URL;
returnURL;
```
- set：设定变量值，或者自定义变量
 `set $variable value;   变量赋值；`
 
- rewrite_log 重写日志
  `rewrite_log on | off;`：是否将重写日志记入errorlog中，默认为关闭；
  
- 错误日志调试方法：错误日志debug，并开启rewrite_log；


- 可以应用于http, server, location, limit_except上下文范围内，直接指定IP
1. $remote_addr 与$http_x_forwarded_for 用以记录客户端的ip地址； 
2. $remote_user ：用来记录客户端用户名称； 
3. $time_local ： 用来记录访问时间与时区；
4. $request ： 用来记录请求的url与http协议；
5. $status ： 用来记录请求状态；成功是200， 
6. $body_bytes_sent ：记录发送给客户端文件主体内容大小；
7. $http_referer ：用来记录从那个页面链接访问过来的； 
8. $http_user_agent ：记录客户端浏览器的相关信息；

[from](http://www.cnblogs.com/knowledgesea/p/5175711.html)
[from](http://xuding.blog.51cto.com/4890434/1743666)
