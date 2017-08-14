# debian cmd


##  更新系统时间

- 查看当前系统时间
> date

- 手动更改系统时间
> date 081214092017.30
> 月日时分年.秒

- 通过同步Internet时间来进行时间更新
> 首先安装时间同步软件
```
apt-get install ntpdate
ntpdate cn.pool.ntp.org

``` 

