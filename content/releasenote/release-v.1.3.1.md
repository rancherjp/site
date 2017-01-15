---
date: "2017-01-14"
title: "リリース v1.3.1"
slug: "v.1.3.1" 
author: "Rancher JP"
description: "リリース v1.3.1"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/01"
---
# リリース v1.3.1

## バージョン
* rancher/server:v1.3.1
* rancher/agent:v1.1.3
* rancher/lb-service-haproxy:v0.4.8
* [rancher-compose-v0.12.1](https://github.com/rancher/rancher-compose/releases/tag/v0.12.1)
* [rancher-v0.4.1](https://github.com/rancher/cli/releases/tag/v0.4.1)

> *注意:* 新しい[infrastructure services](http://docs.rancher.com/rancher/v1.2/en/rancher-services/)では、ロードバランサの機能を指定のHAProxyイメージに変更し、ネットワークエージェントが起動されなくなりました。 したがって、rancher/agent-instanceが必要なくなりました。

## 重要!
* バージョン 1.2.0 から Rancher は AWS ELB をサポートしなくなり、AWS ALB (アプリケーションロードバランサー)のみをサポートします。高可用性設定は、ALB を利用してください。
* リリース v 1.2.x より前からアップグレードする場合、まずインフラストラクチャのスタックをチェックして、サービスが最新であることを確認してください。 [アップグレード可能]ボタンが表示されている場合は、最新のサービスに更新してください。**ひとつひとつのインフラストラクチャースタックが完全にアップグレードされてから次のスタックに移動してください**
* Rancherのリリースごとに、ロードバランサーサービスのための特定のロードバランサイメージ（つまり `rancher/lb-service-haproxy`）にタグを付けました。以前のバージョンのRancherからアップグレードして、新しいロードバランサイメージがリリースされている場合は、ロードバランサ名の横にシンボルが表示され、そのRancherバージョンで新しいイメージが使用可能であることを示します。ロードバランサの最新のイメージにアップグレードすることをお勧めします。
* 1.1.xからv1.2.2にアップグレードする場合は、アップグレードに関する重要な注意点に関する[v1.2.0](https://github.com/rancher/rancher/releases/tag/v1.2.0)のリリースノートをお読みください。

## Rancher サーバータグ

Rancher サーバーに2種類のタグを付けています。メジャーリリース毎に特定のバージョンののドキュメントを提供しています。

* `rancher/server:latest` タグは、最新の開発ビルドです。これらのビルドは、CI自動化フレームワークを通じて検証されています。これらのリリースは本番環境での展開用ではありません。
* `rancher/server:stable` タグは、最新の安定版リリースです。このタグは、本番環境に推奨するバージョンです。  

末尾が`rc{n}`のリリースはどれも利用しないでください。`rc` ビルドは、Rancherチームのテスト用です。

v1.3.1 は、`rancher/server:latest` タグが付いています。 

## インフラストラクチャーサービスの注意点
このバージョンでは、新しい `scheduler`エントリを追加しました。このエントリは、`network-services` より前にアップグレードする必要があります。ネットワークサービスをアップグレードするときのバグが修正されます。

## 主要な既知の問題
* UI（aka docker-machine）を使用してv1.1.4から作成されたAWSのホストは、UIから削除されたときに正しくクリーンアップされません[[#6750](https://github.com/rancher/rancher/issues/6750)]
* 自己署名証明書では、リモート kubectl クライアントを使用すると自動的には動作しません。回避策があります[[#7235](https://github.com/rancher/rancher/issues/7235)]
* 自己証明書とKubernetesを使っているときに、Helm オペレーションが固まる[[#7234](https://github.com/rancher/rancher/issues/7234)]

## v1.3.0からの主なバグ修正
* composeとCLIのダウンロードリンクが古いバージョンであるのを修正しました。[[#7361](https://github.com/rancher/rancher/issues/7361)]
* Kubernetes Dashboardが時折読み込まれない問題を修正しました。[[#7320](https://github.com/rancher/rancher/issues/7320)] **注意:** ダッシュボードがv1.3.0で動作していない場合は、アップグレード後に `kubernetes-dashboard-xxx`ポッドを削除する必要があります。 **Kubernetes**  -> **Pods** の下の **kube-system** 名前空間でポッドが見つかります。


## Rancher-Compose Downloads
https://github.com/rancher/rancher-compose/releases/tag/v0.12.1

## Rancher CLI Downloads
https://github.com/rancher/cli/releases/tag/v0.4.1