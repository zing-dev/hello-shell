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

## Debian配置IP 

```
# The loopback network interface
auto lo
iface lo inet loopback

auto eth0 #网卡随系统自动启动
# iface eth0 inet dhcp # 网卡ip地址自动获取
iface eth0 inet static  # 网卡为静态ip地址
address 192.168.237.129 # ip地址
netmask 255.255.255.0 # 子网掩码	
getway  192.168.237.2  # 网关
```
> 重启网卡服务 /etc/init.d/networking restart
>
> 修改DNS nameserver XX.XX.XX.XX
