---
date: "2016-12-23"
title: "リリース v1.2.2"
slug: "v.1.2.2" 
author: "Rancher JP"
description: "リリース v1.2.2"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2016"
  - "2016/12"
---
# リリース v1.2.2

## バージョン
* rancher/server:v1.2.2
* rancher/agent:v1.1.2
* rancher/lb-service-haproxy:v0.4.6
* [rancher-compose-v0.12.1](https://github.com/rancher/rancher-compose/releases/tag/v0.12.1)
* [rancher-v0.4.1](https://github.com/rancher/cli/releases/tag/v0.4.1)

> *注意:* 新しい[infrastructure services](http://docs.rancher.com/rancher/v1.2/en/rancher-services/)では、ロードバランサの機能を指定のHAProxyイメージに変更し、ネットワークエージェントが起動されなくなりました。 したがって、rancher/agent-instanceが必要なくなりました。

## 重要!
* Rancher は今後 AWS ELB をサポートせず、AWS ALB (Application Load Balancers) のみのサポートとなります。そのため、今後は ALB を利用するよう設定をアップデートしてください。
* リリース v 1.2.x より前からアップグレードする場合、まずインフラストラクチャのスタックをチェックして、サービスが最新であることを確認してください。 [アップグレード可能]ボタンが表示されている場合は、最新のサービスに更新してください。
* 1.1.xからv1.2.2にアップグレードする場合は、アップグレードに関する重要な注意点に関する[v1.2.0](https://github.com/rancher/rancher/releases/tag/v1.2.0)のリリースノートをお読みください。

## 既知の問題
* 個々のコンテナ間リンクが正常に動作しない。この問題はコンテナのリンクのみが対象であり、サービスのリンクは正常に動作します。[[#6584](https://github.com/rancher/rancher/issues/6584)]
* Rancher サーバーにおいて自己証明書が正常に動作しない [[#6122](https://github.com/rancher/rancher/issues/6122)]
* 先のリリースで UI から(docker-machine から)作成された AWS ホストが UI から削除した際に正常にクリーンアップされない [[#6750](https://github.com/rancher/rancher/issues/6750)]

## v1.2.1からの主なバグ修正
* Dockerコンテナを削除しようとしたときに不正な状態になるという問題を修正しました。 [[#7013](https://github.com/rancher/rancher/issues/7013)、[#70161](https://github.com/rancher/rancher/issues/7016)、[#7152](https://github.com/rancher/rancher/issues/7152)]
* v1.2.1 でホスト削除時に`removing`のままになってしまうのを修正 [[#7122](https://github.com/rancher/rancher/issues/7122)]
* コンテナ内から外部公開用ポートに対してpingが反応しないのを修正 [[#7128](https://github.com/rancher/rancher/issues/7128)]
* k8s でポットがフラッピング中にRancherのイベントが溢れるのを修正 [[#7149](https://github.com/rancher/rancher/issues/7149)]
* k8s サービスがスピニング中にプロセスが`create stack on label provider` で溢れるのを修正 [[#7158](https://github.com/rancher/rancher/issues/7158)]
* swarm 環境が初期化時にスタックすることがあるのを修正 [[#7178](https://github.com/rancher/rancher/issues/7178)]
