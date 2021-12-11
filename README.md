# 说明
5分钟搭建vm集群 + 7分钟安装k8s < 15分钟。
- 一、搭建vm集群（默认3台vm，详见Vagrantfile文件）：基于oracle-vbox，通过vagrant编排vm集群。
- 二、安装k8s：使用sealos。  

**相关资源**
[vagrant docs](https://www.vagrantup.com/docs/cli) | [sealos docs](https://www.sealyun.com/instructions)


# 步骤

## 一、搭建vm集群

### 配置要求
- VM:CPU不低于2核 / 内存不低于4G / 安装SSHD&SSH（免密访问）
- 网络

```
网卡1：nat模式：采用vagrant默认配置
网卡2：host-only模式：用以node节点通讯：gateway ip：192.168.56.1（在vbox gui：管理 -> 主机网络管理器）
网卡3：bridged模式：vm互联网通讯
```

### 操作步骤

- 1.安装：[oracle vbox](https://www.virtualbox.org/wiki/Downloads)
- 2.安装：[vagrant](www.vagrantup.com/downloads)
- 3.安装：[vagrant box（虚拟机镜像本地化部署和提速）](http://cloud.centos.org/centos/7/vagrant/x86_64/images/)

```powershell
#添加box至本地
vagrant box add centos7.2004_01 [box文件绝对路径]
#查看box列表
vagrant box list 
```

- 4.安装vbox虚拟机插件（用于同步宿主机目录等高级特性，需要【翻墙】）：

```bash
# 安装指定版本
vagrant plugin install vagrant-vbguest --plugin-version 0.21
```

- 5.检出本工程 git clone me，启动vm集群：vagrant up

- 6.登录验证vm可用性

```powershell
#方式1：通过vagrant ssh
vagrant ssh kn1
#方式2：终端工具（默认密码vagrant/vagrant）
ssh root@ip / vagrant@ip
```



## 二、安装k8s
### 配置要求

- k8s version 17.1.7
- k8s dashborad version v2.0.0-bata5.2
- sealos [安装条件](https://sealyun.com/docs/tutorial.html#前提条件) | [安装指令](https://sealyun.com/docs/tutorial.html#安装教程) 

### 操作步骤

- 1.登录master

```powershell
vagrant ssh kn1
```

- 2.进入master执行

```bash
sudo -i
cp /vagrant/step1-install-k8s.sh /root/ -f
chmod 700 /root/step1-install-k8s.sh & sh /root/step1-install-k8s.sh
```

- 3.安装个人应用。
