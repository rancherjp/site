---
date: "2017-01-24"
title: "リリース v1.3.3"
slug: "v.1.3.3" 
author: "Rancher JP"
description: "リリース v1.3.3"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/01"
---
# リリース v1.3.3

## バージョン
* rancher/server:v1.3.3
* rancher/agent:v1.1.3
* rancher/lb-service-haproxy:v0.4.9
* [rancher-compose-v0.12.1](https://github.com/rancher/rancher-compose/releases/tag/v0.12.1)
* [rancher-v0.4.1](https://github.com/rancher/cli/releases/tag/v0.4.1)

> *注意:* 新しい[infrastructure services](http://docs.rancher.com/rancher/v1.2/en/rancher-services/)では、ロードバランサの機能を指定のHAProxyイメージに変更し、ネットワークエージェントが起動されなくなりました。 したがって、rancher/agent-instanceが必要なくなりました。

## 重要!
* このリリースから Rancher で高可用性のために[ELB を再び利用する](http://docs.rancher.com/rancher/v1.3/en/installing-rancher/installing-server/#elb)ことができるようになりました。
* リリース v 1.2.x より前からアップグレードする場合、まずインフラストラクチャのスタックをチェックして、サービスが最新であることを確認してください。 [アップグレード可能]ボタンが表示されている場合は、最新のサービスに更新してください。**ひとつひとつのインフラストラクチャースタックが完全にアップグレードされてから次のスタックに移動してください**
* Rancherのリリースごとに、ロードバランサーサービスのための特定のロードバランサイメージ（つまり `rancher/lb-service-haproxy`）にタグを付けました。以前のバージョンのRancherからアップグレードして、新しいロードバランサイメージがリリースされている場合は、ロードバランサ名の横にシンボルが表示され、そのRancherバージョンで新しいイメージが使用可能であることを示します。ロードバランサの最新のイメージにアップグレードすることをお勧めします。
* 1.1.xからアップグレードする場合は、アップグレードに関する重要な注意点に関する[v1.2.0](https://github.com/rancher/rancher/releases/tag/v1.2.0)のリリースノートをお読みください。

## Rancher サーバータグ

Rancher サーバーに2種類のタグを付けています。メジャーリリース毎に特定のバージョンののドキュメントを提供しています。

* `rancher/server:latest` タグは、最新の開発ビルドです。これらのビルドは、CI自動化フレームワークを通じて検証されています。これらのリリースは本番環境での展開用ではありません。
* `rancher/server:stable` タグは、最新の安定版リリースです。このタグは、本番環境に推奨するバージョンです。  

末尾が`rc{n}`のリリースはどれも利用しないでください。`rc` ビルドは、Rancherチームのテスト用です。

v1.3.3 は、`rancher/server:latest` タグが付いています。 

## インフラストラクチャーサービスの注意点
このバージョン1.3.1では、新しい `scheduler`エントリを追加しました。このエントリは、`network-services` より前にアップグレードする必要があります。ネットワークサービスをアップグレードするときのバグが修正されます。

## 主要な既知の問題
* UI（aka docker-machine）を使用してv1.1.4から作成されたAWSのホストは、UIから削除されたときに正しくクリーンアップされません[[#6750](https://github.com/rancher/rancher/issues/6750)]
* 自己署名証明書では、リモート kubectl クライアントを使用すると自動的には動作しません。回避策があります[[#7235](https://github.com/rancher/rancher/issues/7235)]
* 自己証明書とKubernetesを使っているときに、Helm オペレーションが固まる[[#7234](https://github.com/rancher/rancher/issues/7234)]
* コンテナを再起動後に、コンテナが利用可能になるまでDNSの解決が遅延します[[#74021](https://github.com/rancher/rancher/issues/7402)]


## v1.3.2からの主なバグ修正
* ELB を利用する設定を有効にしていると、`kubectl exec` がALB 配下で動作しないという問題を修正しました。[ELB を設定する追加操作](http://docs.rancher.com/rancher/v1.3/en/installing-rancher/installing-server/#elb)と[SSL を有効にする追加操作](http://docs.rancher.com/rancher/v1.3/en/installing-rancher/installing-server/basic-ssl-config/#elb) [[#7464](https://github.com/rancher/rancher/issues/7464)]


## Rancher-Compose Downloads
https://github.com/rancher/rancher-compose/releases/tag/v0.12.1

## Rancher CLI Downloads
https://github.com/rancher/cli/releases/tag/v0.4.1