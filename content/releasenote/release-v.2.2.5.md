---
date: "2019-07-23"
title: "リリース v2.2.5"
slug: "v2.2.5"
author: "Rancher JP"
description: "リリース v2.2.5"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2019"
  - "2019/07"
---

# リリース v2.2.5

## 重要メモ

* このリリースはRancherのセキュリティーの脆弱性を修正しています。WorkivaのMatt BelisleとAlex Stevensonがこの問題を発見して、Rancherのバージョンv2.0.0-v2.0.15、v2.1.0-v2.1.10、 v2.2.0-v2.2.4に存在すると報告してくれました。この脆弱性に対する修正は、Rancher v2.1.11とv2.0.16でも利用できます。Rancher v1.6には影響しません。この脆弱性は、[Cross-Site Websocket Hijacking attack](https://www.christian-schneider.net/CrossSiteWebSocketHijacking.html)とよばれるものです。この攻撃では、攻撃者が被害者のロールとパーミッションを使ってRancherによって管理されているクラスターにアクセスすることができます。この攻撃には被害者がRancherサーバーにログインしており、攻撃者がホストしている別のサイトにアクセスする必要があります。それが成功したら、攻撃者は被害者の認証情報とパーミッションを使って、Kubernetes APIにコマンドを実行することができます。公式なCVEについては、[[CVE-2019-13209](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13209)]を参照してください。

以上により、次のバージョンが最新と安定バージョンです:

  |Type | Rancher バージョン | Docker Tag |Helm Repo| Helm Chart バージョン |
  |---|---|---|---|---|
  | Latest | v2.2.5 | `rancher/rancher:latest` | server-charts/latest | v2.2.5 |
  | Stable | v2.2.5 | `rancher/rancher:stable` | server-charts/stable | v2.2.5 |

詳細なバージョン管理とタグ付けの規約については、[version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) を参照してください。
* このリリースは、Kubernetes v1.15を実験的に、Kubernetes v1.14を公式にサポートしています。

## 機能と機能強化

* Kubernetes v1.14の公式サポートを追加[[20873](https://github.com/rancher/rancher/issues/20873)]
* Kubernetes v1.15の実験的サポートを追加[[21088](https://github.com/rancher/rancher/issues/21088)]
* Kubernetesクラスターのバージョンv1.14以降でのデフォルトのDNSプロバイダーをCoreDNSとするサポートを追加[[20872](https://github.com/rancher/rancher/issues/20872)]
* Rancherでプロビジョニングされたクラスターの証明書の有効期限をUI上で表示し、証明書が30日以内に期限が切れる場合に警告をサポートしました。[[20994](https://github.com/rancher/rancher/issues/20994)]
* Rancherでプロビジョニングされたクラスターで自己証明書を使ってS3スナップショットを取得するようスナップショット設定でカスタムCA設定のサポートを追加しました。[[21186](https://github.com/rancher/rancher/issues/21186)]
* EKSクラスターでKubernetes v1.13のサポートを追加しました。[[21147](https://github.com/rancher/rancher/issues/21147)]
* ムンバイ、ロンドン、パリリージョンのEKSクラスターのサポートを追加しました。[[21160](https://github.com/rancher/rancher/issues/21160)]

## v2.2.4からのメジャーバグフィックス

以下は、メジャーなバグフィックスのリストです。全リストを確認する場合は、[our milestone](https://github.com/rancher/rancher/milestone/168)を参照してください。

* Rancher v2.2.4 にアップグレードした後にプロジェクトメンバーが表示されない問題の修正[[20825](https://github.com/rancher/rancher/issues/20825)]
* ノードマシンドライバーがプロビジョニングで"SSHコマンドの実行時に何か問題が発生しました"というエラーが発生する問題を修正しました。[[20753](https://github.com/rancher/rancher/issues/20753)]
* Etcdのスナップショットを取得するときにバックアップターゲットがMinioのS3であるときにタイムアウトしてしまう問題を修正しました。[[19496](https://github.com/rancher/rancher/issues/19496)]
* RancherサーバーでHTTP_PROXYおよびHTTPS_PROXY環境変数し、インターネットにアクセスできるようにしている時にRancherのノードドライバー機能を使用してノードをプロビジョニングできなかった問題を修正しました [[20709](https://github.com/rancher/rancher/issues/20709)]
* etcメンバーを削除すると、Rancherプロビジョニングされたクラスターでetcdが壊れることがあるという問題が修正しました [[19696](https://github.com/rancher/rancher/issues/19696)]
* helmがアプリのアップデートでタイムアウトしていた問題を修正しました [[20289](https://github.com/rancher/rancher/issues/20289)]
* etcdスナップショットが設定されているセットアップでRancherサーバーが5分ごとにクラッシュする問題を修正しました [[20964](https://github.com/rancher/rancher/issues/20964)]
* 一度アンサーが保存され、カタログアプリが間違ったアンサーを持っている場合にカタログアプリを修正できない問題を修正しました [[21027](https://github.com/rancher/rancher/issues/21027)]
* 複数のサブスクリプションのサービスプリンシパルを持つAzureクラウド設定の場合、Rancherがプロビジョニングしたクラスターを操作できなかった問題を修正しました。[[21124](https://github.com/rancher/rancher/issues/21124)]
* 一般ユーザーが自分のマルチクラスタアプリケーションのリビジョンを一覧表示できない場合の問題を修正しました。[[20919](https://github.com/rancher/rancher/issues/20919)]
* http_proxyパラメータがアラート通知機能に適用されていなかった問題を修正しました。[[20926](https://github.com/rancher/rancher/issues/20926)]

## その他注意事項

### Rancherでプロビジョニングされたクラスターの証明書の有効期限

Rancher 2.0および2.1では、Rancherでプロビジョニングされたクラスター用に自動生成された証明書は有効期限が1年間です。つまり、Rancherでプロビジョニングされたクラスターは、1年経ったら証明書を入れ替える必要があります。そうしないと証明書が有効期限切れになり、クラスターが動かなくなります。Rancher 2.2.xからRancher UIからローテーションすることができます。詳細は[ここ](https://rancher.com/docs/rancher/v2.x/en/cluster-admin/certificate-rotation/)を参照してください。

### Air Gap(訳注:インターネットに接続していない状態)のインストールとアップグレードでの追加手順
v2.2.0からRancherがグローバルDNS、アラート、モニタリングなどの特定の機能のために展開するマイクロサービスを管理するための"システムカタログ"を導入しました。これらの追加の手順は[Air Gapインストール手順](https://rancher.com/docs/rancher/v2.x/en/installation/air-gap-high-availability/)のドキュメントの一部に記載されています。

### Known Major Issues

- Cluster alerting and logging can get stuck in Updating state after upgrading Rancher. Workaround steps are provided in the issue [[21480](https://github.com/rancher/rancher/issues/21480)]
- Certificate rotate for Rancher provisioned clusters will not work for the clusters which certificates had expired on Rancher versions v2.0.13 and earlier on 2.0.x release line, and 2.1.8 or earlier on 2.1.x release line. The issue won't exist if the certificates expired on later versions of Rancher. Steps to workaround can be found in comments to [[20381](https://github.com/rancher/rancher/issues/20381)] 
- Catalog app revisions are not visible to the regular user; as a result regular user is not able to rollback the app [[20204](https://github.com/rancher/rancher/issues/20204)]
- Global DNS entries are not properly updated when a node that was hosting an associated ingress becomes unavailable. A records to the unavailable hosts will remain on the ingress and in the DNS entry [[#18932](https://github.com/rancher/rancher/issues/18932)]
- If you have Rancher cluster with OpenStack cloud provider having LoadBalancer set, and the cluster was provisioned on version 2.2.3 or less, the upgrade to the Rancher version v2.2.4 and up will fail. Steps to mitigate can be found in the comment to [[20699](https://github.com/rancher/rancher/issues/20699)]
* UPDATE: Hardcoded etcd snapshot image breaks airgapped setups [[1472](https://github.com/rancher/rke/issues/1472)]. The workaround is provided in the issue's comments. We are working on addressing this high priority issue, and the fix will be available in the next RKE release.

## Versions

### Images
- rancher/rancher:v2.2.5
- rancher/rancher-agent:v2.2.5

### Tools
- cli - [v2.2.0](https://github.com/rancher/cli/releases/tag/v2.2.0)
- rke - [v0.2.5](https://github.com/rancher/rke/releases/tag/v0.2.5)

### システムチャートブランチ - air gap インストール用
- システムチャートブランチ - [`release-v2.2`](https://github.com/rancher/system-charts/tree/release-v2.2) - これは、監視、ログ記録、警告、グローバルDNSなどのツールに必要なカタログを生成するために使用されるブランチです。  これらの機能をエアギャップインストール時に利用するには、`system-charts`リポジトリを、Rancherが到達できるネットワーク上の場所にミラーリングして、Rancherからそのリポジトリが利用できるように設定する必要があります。

### Kubernetes

-  [1.12.9](https://github.com/rancher/hyperkube/releases/tag/v1.12.9-rancher1) 
-  [1.13.7](https://github.com/rancher/hyperkube/releases/tag/v1.13.7-rancher1) 
-  [1.14.3](https://github.com/rancher/hyperkube/releases/tag/v1.14.3-rancher1) (default)
-  [1.15.0](https://github.com/rancher/hyperkube/releases/tag/v1.15.0-rancher1) (experimental)


## アップグレードとロールバック

Rancherは、v2.0.2からアップグレードとロールバックの両方をサポートしています。 [アップグレード]または[ロールバック]でRancherのバージョンを変更する時は、対象バージョンに注意してください。

v2.1.0リリースで導入されたHA構成での改善により、Rancher helmチャートを使ったRancherのインストールまたはアップグレードが唯一サポートされている方法です。HA構成でのRancherをインストールするにはRancher helm chartを使用してください。 詳細は、[HA Install - Installation Outline](https://rancher.com/docs/rancher/v2.x/en/installation/ha/#installation-outline)を参照してください。

RKEアドオンインストール方法でHA構成を使用している場合は、[RKEアドオンインストールからの移行](https://rancher.com/docs/rancher/v2.x/en/upgrades/upgrades/migrating-from-rke-add-on/) でhelm chartを使った方法への移行を参照してください。

**v2.0.3よりも前のバージョンでワークロードをスケールアップする場合、ポッドは新しく作成されます。[[#14136](https://github.com/rancher/rancher/issues/14136)]** - ワークロードのルールを更新する [[#13527](https://github.com/rancher/rancher/issues/13527)]、新しいフィールドが `update`のすべてのワークロードに追加されました。これにより以前のバージョンからのワークロード内のポッドが再作成されます。

**注意:** ロールバックするときは、アップグレードする時の状態に戻って欲しいと思われていると思います。アップグレード後の変更は全て反映されていないことになります。[Rancher single-node install(Rancherシングルノードインストール)](https://rancher.com/docs/rancher/v2.x/en/installation/single-node-install/)でロールバックする場合は、デフォルトの`:latest`タグではなくて、変更したいRancherのバージョンを正確に指定する必要があります。

**注意:** v2.0.0でhelm stableカタログを有効にしている場合は、内部リポジトリではなくKubernetes helmリポジトリを直接参照するようにカタログが変更されています。この変更を反映するには、カスタムカタログを削除してhelm stableを再度有効にしてください。[[#13582](https://github.com/rancher/rancher/issues/13582)]
