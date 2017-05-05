---
date: "2017-02-05"
title: "リリース v1.4.0"
slug: "v.1.4.0" 
author: "Rancher JP"
description: "リリース v1.4.0"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/02"
---
# リリース v1.4.0

## バージョン
* rancher/server:v1.4.0
* rancher/agent:v1.2.0
* rancher/lb-service-haproxy:v0.5.9
* [rancher-compose-v0.12.2](https://github.com/rancher/rancher-compose/releases/tag/v0.12.2)
* [rancher-v0.4.1](https://github.com/rancher/cli/releases/tag/v0.4.1)

### 対応している Docker のバージョン
Docker 1.10.3  
Docker 1.12.3-1.12.6  

## Kubernetes UI の変更
Kubernetesをメインのオーケストレーションエンジンにしている場合、v1.4.0リリースからk8sの対応について2つの大きな変更があります。
1. Rancher による k8sデフォルトUIを廃止し、[k8s' ダッシュボードUI](https://github.com/kubernetes/dashboard)に引き継ぎました。各k8sの環境で自動的に起動して有効になります。2016年の後半、KubernetesダッシュボードUIは、一般的な用途向けのweb UIがものすごい貢献により発展し、RancherのデフォルトUIとしての機能と安定性を備えたところに到達したと思います。その為、1.4では Rancher k8s UI を廃止し k8sのダッシュボードUIを k8s リソースの管理UIとしました。

2. Rancher カタログにあるk8s グラフ化とテンプレートを廃止し、[k8s helm](https://github.com/kubernetes/helm) に引き継ぎました。Helm(とtiller)は、それぞれk8s環境で自動的に有効になります。便利な helmクライアントも 外部から動かせる kubectlシェルコンソールとして同様に追加されます。

## 重要!
- バージョン 1.4.0から Rancher [AWS ELBs](http://docs.rancher.com/rancher/v1.3/en/installing-rancher/installing-server/#elb) の利用を推奨します。
- Rancherサーバーをアップグレードした後、まずインフラストラクチャのスタックをチェックして、それぞれのサービスが最新であることを確認してください。 "アップグレード可能"ボタンが表示されている場合は、最新のサービスに更新してください。**ひとつひとつのインフラストラクチャースタックが完全にアップグレードされてから次のスタックに移動してください**
- Rancherのリリースごとに、ロードバランサーサービスのための特定のロードバランサイメージ（つまり `rancher/lb-service-haproxy`）にタグを付けました。以前のバージョンのRancherからアップグレードして、新しいロードバランサイメージがリリースされている場合は、ロードバランサ名の横にシンボルが表示され、そのRancherバージョンで新しいイメージが使用可能であることを示します。ロードバランサの最新のイメージにアップグレードすることをお勧めします。
* 1.1.xから v1.2.2にアップグレードする場合は、アップグレードに関する重要な注意点に関する[v1.2.0](https://github.com/rancher/rancher/releases/tag/v1.2.0)のリリースノートをお読みください。

## Rancher サーバータグ

Rancher サーバーに2種類のタグを付けています。メジャーリリース毎に特定のバージョンののドキュメントを提供しています。
- `rancher/server:latest` タグは、最新の開発ビルドです。これらのビルドは、CI自動化フレームワークを通じて検証されています。これらのリリースは本番環境での展開用ではありません。
- `rancher/server:stable` タグは、最新の安定版リリースです。このタグは、本番環境に推奨するバージョンです。  

末尾が`rc{n}`のリリースはどれも利用しないでください。`rc` ビルドは、Rancherチームのテスト用です。

v1.4.0 には、`rancher/server:latest` タグが付いています。 


## 追加機能
- **ウェブフック [[#619](https://github.com/rancher/rancher/issues/619)]** - Rancherは[サービススケールアップダウンのウェブフック生成](http://docs.rancher.com/rancher/v1.4/en/cattle/webhook-service/)機能を使えるようになりました。このフレームワークにより [ウェブフック](https://github.com/rancher/webhook-service) 機能へより簡単に貢献できるようになりました。また、その他のウェブフック機能をつかった機能追加のプルリクエストも歓迎しています。様々なウェブフックドライバーがRancherとUIの一つの機能として自動的に統合できるようになるでしょう。
- **ネットワークポリシー [[#3895](https://github.com/rancher/rancher/issues/3895)]** - 利用者側で[ネットワークポリシー](http://docs.rancher.com/rancher/v1.4/en/rancher-services/network-policy/) をそれぞれの環境毎に変更することができるようになりました。これにより、1つの環境内で作ったコンテナー間のデフォルト通信ポリシーを拒否や全て許可のように選択することができるようになりました。また、もっと洗練されたルールも選択することができるようになりました。例えば、イントラスタック内は、許可するが、インタースタックとのネットワーク通信は拒否するといったことです。** 注意: UI から追加することはまだできません。次のリリースで対応する予定です。**
- **マルチIPホストのスケジューラー接続[[#7034](https://github.com/rancher/rancher/issues/7034)]** - Ranche が複数のIPアドレスを持っているホストに対してコンテナのスケジューラーをサポート [the IPs are configured in Rancher](http://docs.rancher.com/rancher/v1.4/en/hosts/#scheduler-ips)
- **秘匿情報管理 - 試験的実装 [[#1269](https://github.com/rancher/rancher/issues/1269)]** - Rancher で [コンテナー内で利用される名前ラベル付き秘密情報](http://docs.rancher.com/rancher/v1.4/en/cattle/secrets/) 機能をサポートしました。Rancher がローカルAES(高度標準暗号)を使うか、[Vault Transit](https://www.vaultproject.io/docs/secrets/transit/) を使って裏側の暗号化機構にRancher内の値を安全に保持するインターフェースを提供します。

## 主要な既知の問題
- UI（aka docker-machine）を使用してv1.1.4から作成されたAWSのホストは、UIから削除されたときに正しくクリーンアップされません[[#6750](https://github.com/rancher/rancher/issues/6750)]
- 自己署名証明書では、リモート kubectl クライアントを使用すると自動的には動作しません。次の回避策があります[[#7235](https://github.com/rancher/rancher/issues/7235)]
- 自己証明書とKubernetesを使っているときに、Helm オペレーションが固まる[[#7234](https://github.com/rancher/rancher/issues/7234)]
-　マルチIPホストのスケジューラー接続を有効にした場合、スケジューラーIPと一致する指定されたホストIPが、ポートを公開するとき、またはロード・バランサーのために使用された場合、そのIPでホスト上でスケジュールされません。
[[#7675](https://github.com/rancher/rancher/issues/7675)]

## v1.3.0からの主なバグ修正
* [K8S 環境の特定のホスト上でのロードバランサースケジュール](http://docs.rancher.com/rancher/v1.4/en/kubernetes/ingress/#host-scheduling)や[全てのホスト上でロードバランサーをスケジュール](http://docs.rancher.com/rancher/v1.4/en/kubernetes/ingress/#example-of-a-load-balancer-scheduled-on-all-hosts)を設定する方法がないのを修正。[[#5240](https://github.com/rancher/rancher/issues/5240), [#4849](https://github.com/rancher/rancher/issues/4849)]
* コンテナーが複数のホストに散らばっている状態でサービスを起動しようとしたら動かないを修正 [[#7170](https://github.com/rancher/rancher/issues/7170)]
* ロードバランサーのアップグレードのスケジューリングが動かないを修正 [[#7251](https://github.com/rancher/rancher/issues/7251)]
* v1 のロードバランサーにあったセレクタがv2 ロードバランサーに変換されないを修正 [[#7269](https://github.com/rancher/rancher/issues/7269)]

## Rancher-Compose Downloads
https://github.com/rancher/rancher-compose/releases/tag/v0.12.2

## Rancher CLI Downloads
https://github.com/rancher/cli/releases/tag/v0.4.1
