---
date: "2016-12-17"
title: "リリース v1.2.1"
slug: "v.1.2.1" 
author: "Rancher JP"
description: "リリース v1.2.1"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2016"
  - "2016/12"
---

## バージョン
* rancher/server:v1.2.1
* rancher/agent:v1.1.1
* rancher/lb-service-haproxy:v0.4.6
* [rancher-compose-v0.12.1](https://github.com/rancher/rancher-compose/releases/tag/v0.12.1)
* [rancher-v0.4.1](https://github.com/rancher/cli/releases/tag/v0.4.1)

> *注意:* 新しい[infrastructure services](http://docs.rancher.com/rancher/v1.2/en/rancher-services/)では、ロードバランサの機能を指定のHAProxyイメージに変更し、ネットワークエージェントが起動されなくなりました。 したがって、rancher/agent-instanceが必要なくなりました。

## 重要!
Rancher は今後 AWS ELB をサポートせず、AWS ALB (Application Load Balancers) のみのサポートとなります。そのため、今後は ALB を利用するよう設定をアップデートしてください。

## 1.2 へのアップグレード方法
Rancher 1.2 ではネットワークの管理に関していくつか主要な変更が含まれます、特筆すべき点としては CNI プラグイン向けに IPSec ネットワークをリファクタリングした点とより柔軟な HAProxy 設定が可能になった新しい v2 LB サービスが挙げられます。これらの変更によりアップグレードプロセスではネットワークのダウンタイムが生じ、ネットワークの接続性を回復させるには各環境のアップグレードが必要になります。アップグレードプロセスは Rancher 自身のアップデートとそれに続く個別環境のアップデートに分けられるため現在ご利用のバージョンから適切にアップグレードするには以下の手順を参照ください:

### Rancher サーバーをv1.1.4からアップグレード
必ずデータベースをバックアップしてください。Rancher 1.2.0へバージョンアップ後には、以前のバージョンに戻すことはできません。戻したい場合は、以前動いていたバージョン時点でのデータベースのスナップショットを利用するしかありません。データベースのバックアップを取ってから、ドキュメントに従ってアップグレードを開始してください。

> **注意:** AWS セキュリティグループを利用している場合、必ずICMPをセキュリティグループで有効にしてください。

### 環境のアップグレード
Rancherサーバーをアップグレードした後は、1.2環境に正常にアップグレードするまで、環境にアクセスできなくなります。1.2でネットワークとLBの変更される為、新しいネットワークコンポーネントに更新されて移行されるまでアップグレード処理中にネットワークが切断されます。アップデートが必要な環境ごとに**Upgrade Now***画面を表示して、いつ更新するかを決めることができる便利な機能を提供しました。更新を実行するまで、コンテナは機能し続けますが、管理機能は許可されません。この時、コンテナの再作成（ヘルスチェック）によってこれらのコンテナが動かなくなる可能性があります。HA、DNSプログラミング、ヘルスチェックなど、Rancherの関与が必要な機能は、完了するまで正常に動作しない可能性があるため、環境をなるべく早くアップグレードすることを強くお勧めします。

"今すぐアップグレード"をクリックすると、Rancherは環境のアップグレードを開始します。ご使用の環境の規模によっては最大10～20分かかる場合がありますので、しばらくお待ちください。**Stacks** - > **Infrastructure**の下にあるすべてのスタックが**active**状態になっていたら、環境は正常に更新されています。

*__Kubernetes環境の方は、すべてのインフラストラクチャサービスが「アクティブ」状態になったら、既存のk8s v1.2.6スタックをv1.4.6にアップグレードしなければなりません。注意:k8sをアップグレードする際、既存のポッドを削除して再作成する可能性のある既知の問題があることに注意してください。ポッドがレプリケーションコントローラの一部でない場合は、再作成されません。 それに考慮して計画してください。このケースでもアップグレードプロセスは環境に応じて5～10分以上かかる場合があり、スタックがアクティブな状態になると完了します。__*

### アップグレードの既知の制限事項
* Swarm環境のアップグレードはサポートされていません。DockerがDockerエンジンに移行することに関するDocker Swarmからの変更により、Swarmのサポートが最新のDocker 1.12 Swarmからになった為です。 
* 環境テンプレートオプションを表示するマイグレーション用フォルダのカタログエントリがいくつかあります。 これらのカタログ・エントリーは、古いエントリーへのロールバックをサポートしていません。 例えば、Kubernetesにすべての外部DNSエントリが含まれこれ以外にも同様のものがあります。 
* v1ロードバランサからv2ロードバランサへのアップグレード中に、セレクタを使用するルールはアップグレードされません。 これらのルールは、環境のアップグレード後にロードバランサーに再度追加する必要があります。
* 1.2からは、Rancherはcadvisorからの統計情報を取得せず、Dockerの統計情報から取得します。 これにより、Prometheusのようなcadvisorに依存する既存のカタログは、Dockerの統計情報から取得するように修正されるまで機能しなくなることに注意してください。

## 既知の問題
* 個々のコンテナ間リンクが正常に動作しない。この問題はコンテナのリンクのみが対象であり、サービスのリンクは正常に動作します。[[#6584]](https://github.com/rancher/rancher/issues/6584)
* Rancher サーバーにおいて自己証明書が正常に動作しない [[#6122]](https://github.com/rancher/rancher/issues/6122)
* 先のリリースで UI から(docker-machine から)作成された AWS ホストが UI から削除した際に正常にクリーンアップされない [[#6750]](https://github.com/rancher/rancher/issues/6750)

## v1.2.0からの主なバグ修正
* boot2docker ホストで rancher/plugin-manager:v0.2.12にあった問題を修正、新しい rancher/network-manager:v0.2.13 ネットワークサービスがあります。ネットワークサービススタックで"アップグレード利用可能" がボタン表示されている場合は、アップグレードしてください。[[#6874]](https://github.com/rancher/rancher/issues/6874)
* docker がvar/lib/docker 以外の場所にインストールされていても動くように修正 [[#6897]](https://github.com/rancher/rancher/issues/6897)
* ipsec やvxlan もしくはインフラストラクチャーのネットワークサービスでデフォルトのdocker0 からdocker ブリッジを構成できるように修正しました。[[#6896]](https://github.com/rancher/rancher/issues/6896)
* UIが固まってしまう問題を修正 [[#6995]](https://github.com/rancher/rancher/issues/6995)
* Rancherがデータベースを適切にクリーニングしておらず、Rancher UIがロックアップしていないのを修正 [[#6826](https://github.com/rancher/rancher/issues/6826), [#6978](https://github.com/rancher/rancher/issues/6978), [#6985](https://github.com/rancher/rancher/issues/6985) ]
* Rancherドメインを利用する前にRancherサービス検出がホストのパスを検索することができなかったのを修正 [[#7010]](https://github.com/rancher/rancher/issues/7010)
* ロードバランサーがホスト名を使って外部サービスをターゲットにできないのを修正 [[#2624]](https://github.com/rancher/rancher/issues/2624)
* 停止中のコンテナのログを見るを修正 [[#6442]](https://github.com/rancher/rancher/issues/6442)
* HA構成でノードを見ることができないのを修正 [[#6814]](https://github.com/rancher/rancher/issues/6814)
* 同じサービス名をターゲットとするロードバランサーからスタック名でエクスポートを修正 [[#6829]](https://github.com/rancher/rancher/issues/6829)
* UI上でロードバランサーにホストのIPアドレスを指定することができないのを修正 [[#6852]](https://github.com/rancher/rancher/issues/6852)
* コンテナが自分自身のホスト名にpingできないのを修正 [[#6855]](https://github.com/rancher/rancher/issues/6855)
* 古いネットワークエージェントに関連しているテーブルによりCPU使用率が高くなるのを修正 [[#6857]](https://github.com/rancher/rancher/issues/6857)
* Rancher-commpose でロードバランサーが正しくRancherで作成されない問題を修正 [[#6865](https://github.com/rancher/rancher/issues/6865), [#6920](https://github.com/rancher/rancher/issues/6920)]
* haproxyのカスタム設定がソートされないのを修正 [[#6888]](https://github.com/rancher/rancher/issues/6888)
* GCR(Google Container Registry)からdockerイメージをプルすることができないのを修正 [[#6916]](https://github.com/rancher/rancher/issues/6916)
* アップグレード後にロードバランサーのhaproxy設定が表示されない問題を修正 [[#6921]](https://github.com/rancher/rancher/issues/6921)
* volumes をキーとした変数が compose v2ファイルで置換されない問題を修正 [[#6936]](https://github.com/rancher/rancher/issues/6936)
* ホスト登録URLがhttpを受け付けないという問題を修正 [[#6957]](https://github.com/rancher/rancher/issues/6957)
* Rancherエージェントでproxyに関する環境変数が大文字と小文字が区別される問題を修正  [[#7019]](https://github.com/rancher/rancher/issues/7019)
* ロードバランサーのログが勢いよく増える問題を修正 [[#7028]](https://github.com/rancher/rancher/issues/7028)
