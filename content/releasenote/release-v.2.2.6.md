---
date: "2019-07-24"
title: "リリース v2.2.6"
slug: "v2.2.6"
author: "Rancher JP"
description: "リリース v2.2.6"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2019"
  - "2019/07"
---

# リリース v2.2.6

## 重要メモ

* この修正は、AirGap環境でプライベートレジストリが導入されている時にv2.2.5でEtcdのスナップショットが失敗するという問題[[21628](https://github.com/rancher/rancher/issues/21628)]を修正したものです。

以上により、次のバージョンが最新と安定バージョンです:

  |Type | Rancher バージョン | Docker Tag |Helm Repo| Helm Chart バージョン |
  |---|---|---|---|---|
  | Latest | v2.2.6 | `rancher/rancher:latest` | server-charts/latest | v2.2.6 |
  | Stable | v2.2.6 | `rancher/rancher:stable` | server-charts/stable | v2.2.6 |

詳細なバージョン管理とタグ付けの規約については、[version documentation](https://rancher.com/docs/rancher/v2.x/en/installation/server-tags/) を参照してください。

## 機能と機能強化

## v2.2.5からのメジャーバグフィックス

* AirGap環境でプライベートレジストリが導入されている時にv2.2.5でEtcdのスナップショットが失敗するという問題[[21628](https://github.com/rancher/rancher/issues/21628)]を修正
* クラスターダッシュボードで、"モニタリングを有効"ボタンをクリックしても動かない問題の修正[[21541](https://github.com/rancher/rancher/issues/21541)]
* 設定S3スナップショットを
* セキュリティーキーパラメーターがRancher UI/API画面で設定したスナップショット設定に必要なため、IAMを使ってがS3スナップショットを設定することができないという問題を修正[[21623](https://github.com/rancher/rancher/issues/21623)]

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

## Versions

### Images

- rancher/rancher:v2.2.6
- rancher/rancher-agent:v2.2.6

### Tools

- cli - [v2.2.0](https://github.com/rancher/cli/releases/tag/v2.2.0)
- rke - [v0.2.6](https://github.com/rancher/rke/releases/tag/v0.2.6)

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
