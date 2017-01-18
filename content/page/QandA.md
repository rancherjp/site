---
title: "Q And A"
date: "2016-01-18"
slug: "qa"
author: "FoxBoxsnet"
description: "Question and Answer"
draft: false
tags:
  - "qa"
categories:
  - "qa"
---
# このページについて
Rancher JP では皆様に Rancher, Rancher>OS をご使用していただいて疑問や困った事などを SlackのChannel `#qa` にて議論・検討をしています。
その中で、一定の情報になった物を掲載していきます。
質問・疑問などがある方は  [Join rancherjp on Slack\!](https://rancherjp.herokuapp.com/) より 参加してみてください。



## Configuring(コンフィグレーション)


### SSH鍵を設定したい
+ ナレッジ: FoxBoxsnet(@FoxBoxsnet)

RancherOS では、SSH公開鍵暗号方式でのログインが使用できます。
`cloud-config` に記述します。

```yaml
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAA...ZZZ example1@rancher
  - ssh-rsa BBB...ZZZ example2@rancher
```

#### 参考
+ [SSH Keys in RancherOS](https://docs.rancher.com/os/configuration/ssh-keys/)


### ネットワーク設定
+ ナレッジ: FoxBoxsnet(@FoxBoxsnet)

RancherOS ではデフォルトでDHCPによりIPアドレスを決定しますが、固定したい場合もあるかと思います。
ここでは下記のように設定してみました。　適宜書き換えてください。

| Name | Value |
|:-----|:------|
| interface | eth0 |
| DNS  | 172.18.1.254|
| IP Address | 172.18.1.1/24 |
| Gate Way | 172.18.1.254 |

```yaml
#cloud-config
rancher:
  network:
    dns:
      nameservers:
      - 172.18.1.254
    interfaces:
      eth0:
        address: 172.18.1.1/24
        gateway: 172.18.1.254
```

#### 参考
+ [Configuring Network Interfaces in RancherOS](https://docs.rancher.com/os/networking/interfaces/)
+ [Configuring DNS in RancherOS](https://docs.rancher.com/os/networking/dns/)


### RancherOS を Proxy 配下で利用する
+ ナレッジ: FoxBoxsnet(@FoxBoxsnet)

RancherOSで Proxy 配下で DockerImage をダウンロードできるように設定します。
**この設定は ホストを再起動するまで適用されません**


```yaml
#cloud-config
rancher:
  network:
    http_proxy: https://myproxy.example.com
    https_proxy: https://myproxy.example.com
    no_proxy: localhost,127.0.0.1
```

`http_proxy`, `https_proxy` にポート番号が必要な場合は `<ホスト名>:<ポート番号>` で可能かと思います。
+ sample

```yaml
#cloud-config
rancher:
  network:
    http_proxy: https://myproxy.example.com:8080
    https_proxy: https://myproxy.example.com:8080
    no_proxy: localhost,127.0.0.1
```


#### 参考
[Configuring Proxy Settings in RancherOS](https://docs.rancher.com/os/networking/proxy-settings/)


### RancherOS のホスト名(HostName) 設定
+ ナレッジ: FoxBoxsnet(@FoxBoxsnet)

RancherOS はデフォルトでは `rancher` に設定されています。  
運用上、不便のためホスト名を設定します。

```yaml
#cloud-config
hostname: rancher-host01.local
```

#### 参考
+ [Setting the Hostname in RancherOS](https://docs.rancher.com/os/configuration/hostname/)


### NTPサーバーを設定したい
+ ナレッジ: FoxBoxsnet(@FoxBoxsnet)

RancherOS でNTPサーバーを任意設定します。
今回は、日本国内の stratum1サーバー NICT(情報通信研究機構) のサーバーからNTPを受信するように設定しました。

Linux標準の `/etc/ntpd.conf` とほぼ同じ記述で問題無いと思われます。

```yaml
#cloud-config
write_files:
  - path: /etc/ntp.conf
    permissions: 0644
    content: |
        tinker panic 0
        default kod nomodify notrap nopeer noquery
        restrict -6 default kod nomodify notrap nopeer noquery

        restrict 127.0.0.1
        restrict -6 ::1

        restrict 133.243.238.163 mask 255.255.255.255 nomodify notrap noquery
        restrict 133.243.238.164 mask 255.255.255.255 nomodify notrap noquery
        restrict 133.243.238.243 mask 255.255.255.255 nomodify notrap noquery
        restrict 133.243.238.244 mask 255.255.255.255 nomodify notrap noquery

        server ntp.nict.jp
```

#### 参考
+ [Writing Files in RancherOS](https://docs.rancher.com/os/configuration/write-files/)
+ [Built\-in System Services in RancherOS](https://docs.rancher.com/os/system-services/built-in-system-services/)

### RancherOS で TimeZone を JST に変更したい
+ 質問: FoxBoxsnet(@FoxBoxsnet)

RancherOS デフォルトの設定は、 TimeZoneは `UTC` に設定されます。  
コンソールのTimeZoneをJST(Japan Standard Time)に設定したい


```yaml
#cloud-config
rancher:
  services:
    console:
      environment:
        TZ: 'JST-9'
```

#### 参考
+ [Adding System Services in RancherOS](https://docs.rancher.com/os/system-services/adding-system-services/)
+ [Built\-in System Services in RancherOS](https://docs.rancher.com/os/system-services/built-in-system-services/)


