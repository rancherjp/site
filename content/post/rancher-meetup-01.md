---
date: "2016-10-27"
title: "Rancher もくもく勉強会 #1"
slug: "rancher-Workshop-01" 
author: "Rancher JP"
description: "Rancher もくもく勉強会 #1 - connpass"
draft: false
tags:
  - "Workshop"
categories:
  - "Workshop"
---

Rancher もくもく勉強会 #1 - connpass
http://connpass.com/event/41997/

挨拶


自己紹介


 自己紹介のつもりが、名刺交換会から開始になってしまいました。

・初心者向けチーム
・もくもくチーム
に分かれて開始しました。
{{<images "DSC_0070.JPG" >}}


新藤さんが初心者向けチームにRancherの概要説明中

chiba go さんがRancherとDockerの解説
・Rancherの日本語訳は、Chibaさんがされた
・Rancherのインストールは、コマンド一発 以上　とても簡単
・クラウドのサポートも楽ちん。
・AWSにあるRancherOSのイメージを使えば、ホストの追加もOK。

＃Chiba goさんの深い話がつづく
{{<images "DSC_0071.JPG" >}}

ネットワークとかスケジューリングとかは、K8sとかが担当するべき範囲
　docker-compose.ymlは、Dockerのコンテナの関係性を示す。
　rancher-compose.ymlは、Rancherのスケールするとかの設定を示す。

コンテナイメージは、どこからか取ってくるしかない。
CIツールは、別途必要になる。

yo コマンドでRancherのCatalogテンプレートを作ってくれる。

Kubernetesと、Cattleでのインフラの大きいので、カタログでも動く、動かないというのが実はある。
越えられない壁があって。。

Rancherのいいところは、Dockerのコマンドラインではちょっとお。と言う人向けにDockerの民主化の為に必要

@cyberblack28 さんのDocker解説
{{<images "DSC_0072.JPG" >}}

Dockerの手順は、自分の手で打つと勉強になるよ。
VMで動かす場合は、ネットワークが注意

@Cyberduck28 さんが解説してくれたDockerの資料は、以下です。
「Docker～WordPress環境を作ってみる ハンズオン編」
http://www.slideshare.net/cyberblackvoom/linaction-theme-docker

Dockerのいいところ
1. オーバーヘッドが少ない。
2. OSの部分まで入っているのでデプロイが簡単。
3. インフラ環境によらずに管理が楽になりました。

Docker勉強会になりつつありｗ。

Dockerのダメなところ。

1. ステートレスな形で構成しないとダメです。
2. トラブルをちゃんと解析しない。
3. それなりにマッチする環境や方法を踏まえないとダメです。 

Dockerをエンタープライズに適用することの難しさ。
--->発想が変わらないとなかなか難しい。

Googleとかとかと日本の環境との違いが大きすぎる。

業務系の開発からでは、コンテナの発想が大きくちがうのでワケワカ

IoT などの場合では、サーバーが何万台とある全てのIoTデバイスをコントロールするのは現実的ではないのではと思う。途中IoTのデバイスを中継する中継基地サーバーが必要なのではないだろうか。コンテナーはそういう用途に非常に向いていると思う。

それを受けて、Chiba go さんのIoT 関連話。Resin.io でのドローン内でコンテナが動いている話を紹介。参加者一同驚嘆

Home | Resin.io
https://resin.io/


Rancherでコンテナが100台とかになったら画面がどうなるか気になる。
「そのうちグルーピングできるようになるんじゃないだろうか？」
「検索インターフェースも必要だよね」
「画面は、レスポンシブ対応もありますよ。」

Rancherでのモニタリングとか、シェルとかもGUIから接続できますよ。

新藤さんが、今日の本題 3行でDocker+Rancherを解説

@ynott が DockerとRancherの関係を図で解説
{{<images "DSC_0075.JPG" >}}



「次回は、12月ぐらいに Meetup しましょう。Google のIan Lewis と会話中」

