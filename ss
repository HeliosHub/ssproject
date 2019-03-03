用putty连接服务器，能连接证明没被block

禁用fastestmirror插件

vi  /etc/yum/pluginconf.d/fastestmirror.conf  
#修改内容
enabled = 1//由1改为0，禁用该插件


安装
yum install m2crypto python-setuptools  
yum install python-pip  
pip install shadowsocks

配置
vi /etc/shadowsocks.json

单用户

{  
     "server":"0.0.0.0",  
     "server_port":1234,  
     "local_address": "127.0.0.1",  
     "local_port":1080,  
     "password":"设置ss客户端的连接密码",  
     "timeout":600,  
     "method":"aes-256-cfb",  
     "fast_open": false
}

多用户：

{
    "server":"0.0.0.0",
    "local_address":"127.0.0.1",
    "local_port":1080,
    "port_password":{
         "1234":"password0",
         "1235":"password1",
    },
    "timeout":600,
    "method":"aes-256-cfb",
    "fast_open": false
}

开启防火墙
yum install firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-port=1234/tcp --permanent
firewall-cmd --reload

启动服务
vim /usr/lib/systemd/system/ss.service
加入

[Unit]
Description=ssserver
[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json &
[Install]
WantedBy=multi-user.target

设置开启启动
systemctl enable ss

常用命令
systemctl start ss    #开启
systemctl restart ss  #重启
systemctl status      #查看状态

下载客户端连接即可
下载
win：	https://github.com/shadowsocks/shadowsocks-windows/releases 
mac：	https://github.com/shadowsocks/ShadowsocksX-NG/releases 
linux：	https://github.com/shadowsocks/shadowsocks-qt5/wiki/Installation

bbr加速
http://vultr.aicnm.com/CentOS%E5%AE%89%E8%A3%85Google-BBR%E5%8A%A0%E9%80%9F%E5%B7%A5%E5%85%B7%E5%9B%BE%E6%96%87%E6%95%99%E7%A8%8B/
