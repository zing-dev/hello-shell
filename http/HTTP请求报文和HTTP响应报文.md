#  HTTP请求报文和HTTP响应报文
- HTTP报文是面向文本的，报文中的每一个字段都是一些ASCII码串，各个字段的长度是不确定的。HTTP有两类报文：请求报文和响应报文。

## HTTP请求报文
- 一个HTTP请求报文由请求行（request line）、请求头部（header）、空行和请求数据4个部分组成。

![image](../images/2012072810301161.png)

```
<request-line>
<headers>
<blank line>
[<request-body>]
```


### 请求头
- 请求行由请求方法字段、URL字段和HTTP协议版本字段3个字段组成，它们用空格分隔。例如，GET /index.html HTTP/1.1。
- HTTP协议的请求方法有GET、POST、HEAD、PUT、DELETE、OPTIONS、TRACE、CONNECT。

#### GET
- 最常见的一种请求方式，当客户端要从服务器中读取文档时，当点击网页上的链接或者通过在浏览器的地址栏输入网址来浏览网页的，使用的都是GET方式。GET方法要求服务器将URL定位的资源放在响应报文的数据部分，回送给客户端。使用GET方法时，请求参数和对应的值附加在URL后面，利用一个问号（“?”）代表URL的结尾与请求参数的开始，传递参数长度受限制。例如，/index.jsp?id=100&op=bind,这样通过GET方式传递的数据直接表示在地址中，所以我们可以把请求结果以链接的形式发送给好友。以用google搜索domety为例，Request格式如下：
    ```
    GET /search?hl=zh-CN&source=hp&q=domety&aq=f&oq= HTTP/1.1  
    Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/vnd.ms-excel, application/vnd.ms-powerpoint, 
    application/msword, application/x-silverlight, application/x-shockwave-flash, */*  
    Referer: <a href="http://www.google.cn/">http://www.google.cn/</a>  
    Accept-Language: zh-cn  
    Accept-Encoding: gzip, deflate  
    User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; TheWorld)  
    Host: <a href="http://www.google.cn">www.google.cn</a>  
    Connection: Keep-Alive  
    Cookie: PREF=ID=80a06da87be9ae3c:U=f7167333e2c3b714:NW=1:TM=1261551909:LM=1261551917:S=ybYcq2wpfefs4V9g; 
    NID=31=ojj8d-IygaEtSxLgaJmqSjVhCspkviJrB6omjamNrSm8lZhKy_yMfO2M4QMRKcH1g0iQv9u-2hfBW7bUFwVh7pGaRUb0RnHcJU37y-
    FxlRugatx63JLv7CWMD6UB_O_r  
    ```
- 地址中”?”之后的部分就是通过GET发送的请求数据，我们可以在地址栏中清楚的看到，各个数据之间用”&”符号隔开。显然，这种方式不适合传送私密数据。另外，由于不同的浏览器对地址的字符限制也有所不同，一般最多只能识别1024个字符，所以如果需要传送大量数据的时候，也不适合使用GET方式。
  
   
    
    
#### POST
- 对于上面提到的不适合使用GET方式的情况，可以考虑使用POST方式，因为使用POST方法可以允许客户端给服务器提供信息较多。POST方法将请求参数封装在HTTP请求数据中，以名称/值的形式出现，可以传输大量数据，这样POST方式对传送的数据大小没有限制，而且也不会显示在URL中。还以上面的搜索domety为例，如果使用POST方式的话，格式如下：
    ```
    POST /search HTTP/1.1  
    Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/vnd.ms-excel, application/vnd.ms-powerpoint, 
    application/msword, application/x-silverlight, application/x-shockwave-flash, */*  
    Referer: <a href="http://www.google.cn/">http://www.google.cn/</a>  
    Accept-Language: zh-cn  
    Accept-Encoding: gzip, deflate  
    User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; TheWorld)  
    Host: <a href="http://www.google.cn">www.google.cn</a>  
    Connection: Keep-Alive  
    Cookie: PREF=ID=80a06da87be9ae3c:U=f7167333e2c3b714:NW=1:TM=1261551909:LM=1261551917:S=ybYcq2wpfefs4V9g; 
    NID=31=ojj8d-IygaEtSxLgaJmqSjVhCspkviJrB6omjamNrSm8lZhKy_yMfO2M4QMRKcH1g0iQv9u-2hfBW7bUFwVh7pGaRUb0RnHcJU37y-
    FxlRugatx63JLv7CWMD6UB_O_r  
    
    hl=zh-CN&source=hp&q=domety  
    ```
- 可以看到，POST方式请求行中不包含数据字符串，这些数据保存在”请求内容”部分，各数据之间也是使用”&”符号隔开。POST方式大多用于页面的表单中。因为POST也能完成GET的功能，因此多数人在设计表单的时候一律都使用POST方式，其实这是一个误区。GET方式也有自己的特点和优势，我们应该根据不同的情况来选择是使用GET还是使用POST。

#### HEAD
- HEAD就像GET，只不过服务端接受到HEAD请求后只返回响应头，而不会发送响应内容。当我们只需要查看某个页面的状态的时候，使用HEAD是非常高效的，因为在传输的过程中省去了页面内容。
  
### 请求头部
- 请求头部由关键字/值对组成，每行一对，关键字和值用英文冒号“:”分隔。请求头部通知服务器有关于客户端请求的信息，典型的请求头有：
    ```
     User-Agent：产生请求的浏览器类型。
     Accept：客户端可识别的内容类型列表。
     Host：请求的主机名，允许多个域名同处一个IP地址，即虚拟主机。
    ```
### 空行
- 最后一个请求头之后是一个空行，发送回车符和换行符，通知服务器以下不再有请求头。

### 请求数据
- 请求数据不在GET方法中使用，而是在POST方法中使用。POST方法适用于需要客户填写表单的场合。与请求数据相关的最常使用的请求头是Content-Type和Content-Length。
    

## HTTP报文
- HTTP响应也由三个部分组成，分别是：状态行、消息报头、响应正文。
    ```
    <status-line>
    <headers>
    <blank line>
    [<response-body>]
    ```
    
    ```html
    HTTP/1.1 200 OK
    Date: Sat, 31 Dec 2005 23:59:59 GMT
    Content-Type: text/html;charset=ISO-8859-1
    Content-Length: 122
    
    <html>
    <head>
        <title>Wrox Homepage</title>
    </head>
    <body>
    <!-- body goes here -->
    </body>
    </html>
    ```
   
### _关于HTTP请求GET和POST的区别_
```
  GET提交，请求的数据会附在URL之后（就是把数据放置在HTTP协议头<request-line>中） ，以?分割URL和传输数据，多个参数用&连接;
  例如：login.action?name=hyddd&password=idontknow&verify=%E4%BD%A0 %E5%A5%BD。
  如果数据是英文字母/数字，原样发送，如果是空格，转换为+，如果是中文/其他字符，则直接把字符串用BASE64加密，
  得出如： %E4%BD%A0%E5%A5%BD，其中％XX中的XX为该符号以16进制表示的ASCII。
  POST提交：把提交的数据放置在是HTTP包的包体<request-body>中。
  上文示例中红色字体标明的就是实际的传输数据
  因此，GET提交的数据会在地址栏中显示出来，而POST提交，地址栏不会改变
```
```
传输数据的大小：
   首先声明,HTTP协议没有对传输的数据大小进行限制，
   HTTP协议规范也没有对URL长度进行限制。 而在实际开发中存在的限制主要有：
   GET:特定浏览器和服务器对URL长度有限制，
   例如IE对URL长度的限制是2083字节(2K+35)。对于其他浏览器，如Netscape、FireFox等，理论上没有长度限制，其限制取决于操作系统的支持。
   因此对于GET提交时，传输数据就会受到URL长度的限制。
   POST:由于不是通过URL传值，理论上数据不受限。
   但实际各个WEB服务器会规定对post提交数据大小进行限制，Apache、IIS6都有各自的配置。
```
```
安全性：
    POST的安全性要比GET的安全性高。
    注意：这里所说的安全性和上面GET提到的“安全”不是同个概念。
    上面“安全”的含义仅仅是不作数据修改，而这里安全的含义是真正的Security的含义，
    比如：通过GET提交数据，用户名和密码将明文出现在URL上，因为
    (1)登录页面有可能被浏览器缓存， 
    (2)其他人查看浏览器的历史纪录，那么别人就可以拿到你的账号和密码了，
```


[from](http://blog.csdn.net/zhangliang_571/article/details/23508953)