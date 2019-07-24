---
date: "2017-01-04"
title: "リリース v1.3.0"
slug: "v.1.3.0" 
author: "Rancher JP"
description: "リリース v1.3.0"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/01"
---
# リリース v1.3.0

## バージョン
* rancher/server:v1.3.0
* rancher/agent:v1.1.3
* rancher/lb-service-haproxy:v0.4.8
* [rancher-compose-v0.12.1](https://github.com/rancher/rancher-compose/releases/tag/v0.12.1)
* [rancher-v0.4.1](https://github.com/rancher/cli/releases/tag/v0.4.1)

> *注意:* 新しい[infrastructure services](http://docs.rancher.com/rancher/v1.2/en/rancher-services/)では、ロードバランサの機能を指定のHAProxyイメージに変更し、ネットワークエージェントが起動されなくなりました。 したがって、rancher/agent-instanceが必要なくなりました。

## 重要!
* Rancher は今後 AWS ELB をサポートせず、AWS ALB (Application Load Balancers) のみのサポートとなります。そのため、今後は ALB を利用するよう設定をアップデートしてください。
* バージョン 1.2.0 から Rancher は AWS ELB をサポートしなくなり、AWS ALB (アプリケーションロードバランサー)のみをサポートします。高可用性設定は、ALB を利用してください。
* リリース v 1.2.x より前からアップグレードする場合、まずインフラストラクチャのスタックをチェックして、サービスが最新であることを確認してください。 [アップグレード可能]ボタンが表示されている場合は、最新のサービスに更新してください。**ひとつひとつのインフラストラクチャースタックが完全にアップグレードされてから次のスタックに移動してください**
* Rancherのリリースごとに、ロードバランサーサービスのための特定のロードバランサイメージ（つまり `rancher/lb-service-haproxy`）にタグを付けました。以前のバージョンのRancherからアップグレードして、新しいロードバランサイメージがリリースされている場合は、ロードバランサ名の横にシンボルが表示され、そのRancherバージョンで新しいイメージが使用可能であることを示します。ロードバランサの最新のイメージにアップグレードすることをお勧めします。
* 1.1.xからv1.2.2にアップグレードする場合は、アップグレードに関する重要な注意点に関する[v1.2.0](https://github.com/rancher/rancher/releases/tag/v1.2.0)のリリースノートをお読みください。

## Rancher サーバータグ

Rancher サーバーに2種類のタグを付けています。メジャーリリース毎に特定のバージョンののドキュメントを提供しています。

* `rancher/server:latest` タグは、最新の開発ビルドです。これらのビルドは、CI自動化フレームワークを通じて検証されています。これらのリリースは本番環境での展開用ではありません。
* `rancher/server:stable` タグは、最新の安定版リリースです。このタグは、本番環境に推奨するバージョンです。  

末尾が`rc{n}`のリリースはどれも利用しないでください。`rc` ビルドは、Rancherチームのテスト用です。

v1.3.0 は、`rancher/server:latest` タグが付いています。 

## 特徴
* __Windows Server 2016 サポート - 実験的 [[#4576](https://github.com/rancher/rancher/issues/4576)]__ - 実験的なプレビューで[Windowsコンテナーをサポート](http://docs.rancher.com/rancher/v1.3/en/windows/)。 Windowsコンテナに対するDockerのサポートの詳細については、[Dockerのウィンドウのサポート](https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/quick-start-windows-server)を参照してください。今回の実験的リリースでは、次の機能に制限しています:
  * RancherエージェントサービスとしてのWindows 2016サーバーホストの追加。
  * スタック、サービス、およびコンテナの追加。
  * [サポートされているネットワークモード](http://docs.rancher.com/rancher/v1.3/en/windows/#networking-in-windows)は、「NAT」と「透過」のみです。
  * _注意: 上記以外にも、LBサービス、DNS、メタデータなどの既存のRancherの機能は、まだWindowsコンテナで動作するように移植されていないため、現在は機能していません。今後にご期待下さい！_
* __Kubernetes のさらなる改善__ - 次のサポートが追加されました:
  * __Kubernetes 1.5.1__ - k8s 1.5.1 をサポートしました。 
  *  __SkyDNS サポート [[#5948](https://github.com/rancher/rancher/issues/5948)]__ - Rancher 1.3 + k8s 1.5.1からは、SkyDNSのみがデフォルトのDNSエンジンになりました。すべての Rancher DNSエントリは SkyDNS を使用するように自動的に移行され、RancherDNS は k8s では廃止されます。
  * __Helm と Dashboard UI [[#7003](https://github.com/rancher/rancher/issues/7003)]__ - Rancher 1.3から、デフォルトで k8s ダッシュボードUIとHelmサポートが自動的に起動し、Rancherから管理されます。 
* __UIの強化__ - その他のUI機能:
  * コンテナページに一括操作と検索を追加しました [[#342](https://github.com/rancher/rancher/issues/342), [#1533](https://github.com/rancher/rancher/issues/1533)]
  * ホストビューでスタック名をクリックする機能 [[#2557](https://github.com/rancher/rancher/issues/2557)]

## 主要な既知の問題
* UI（aka docker-machine）を使用してv1.1.4から作成されたAWSのホストは、UIから削除されたときに正しくクリーンアップされません[[#6750](https://github.com/rancher/rancher/issues/6750)]
* 自己署名証明書では、リモート kubectl クライアントを使用すると自動的には動作しません。回避策があります[[#7235](https://github.com/rancher/rancher/issues/7235)]
* 自己証明書とKubernetesを使っているときに、Helm オペレーションが固まる[[#7234](https://github.com/rancher/rancher/issues/7234)]

## v1.2.2からの主なバグ修正
* Rancherサーバーで自己署名証明書が動作しない問題を修正しました。[[#6122](https://github.com/rancher/rancher/issues/6122)]
* 個々のコンテナリンクを解決できない問題を修正しました。[[#6584](https://github.com/rancher/rancher/issues/6584)]
* Google Container Registryが機能しない問題を修正しました。[[#6956](https://github.com/rancher/rancher/issues/6956)]

## Rancher-Compose Downloads
https://github.com/rancher/rancher-compose/releases/tag/v0.12.1

## Rancher CLI Downloads
https://github.com/rancher/cli/releases/tag/v0.4.1