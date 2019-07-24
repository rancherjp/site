---
date: "2017-03-03"
title: "リリース v1.5.0"
slug: "v1.5.0"
author: "Rancher JP"
description: "リリース v1.5.0"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/03"
---

# リリース v1.5.0

## バージョン
* rancher/server:v1.5.0
* rancher/agent:v1.2.1
* rancher/lb-service-haproxy:v0.6.2
* [rancher-v0.5.0](https://github.com/rancher/cli/releases/tag/v0.5.0)
* [rancher-compose-v0.12.3](https://github.com/rancher/rancher-compose/releases/tag/v0.12.3)

### 対応している Docker のバージョン

Docker 1.10.3  
Docker 1.12.3-1.12.6  
Docker 1.13.1 (Kubenetes未対応)  
Docker 17.03.0-ce (Kubenetes未対応)  

## Rancherサーバーのタグについて

Rancherサーバーには2種類のタグがあります。
いずれのメジャーリリースタグにおいても、個々のバージョンに向けたドキュメントを提供します。

- `rancher/server:latestタグ` 最新の開発中ビルドを提供するタグです。これらのビルドはCIの自動化フレームワークを使って検証済みです。これらのリリースは本番環境へのデプロイを意味していません。
- `rancher/server:stableタグ` 最新のリリースビルドのタグです。本番環境にデプロイする際は本タグを利用することを推奨します。

`rc{n}`サフィックスのついたリリースを使わないようにしてください。これらの`rc`ビルドはRancherチームがテストを行うためのものです。

### Beta - v1.5.0 - `rancher/server:latest`
### Stable - v1.4.1 - `rancher/server:stable`

## 重要な事項 - アップグレードについて
* 本リリースでは、network-servicesインフラストラクチャサービスが自動的にアップグレードされるため、手動でのアップグレードなしでは、あなたのリリースは動作しなくなります。もし、ホストを持たないenvironmentsが存在する場合、ホストを追加した際の自動アップグレードに遅延が発生する場合があります。したがって、当該environmentsにホストを追加した際は`network-services`スタックがアップグレードされていることを確認するか、ホストを追加した直後に手動でアップグレードするようにしてください。
* アップグレードマネージャーを利用することで、Rancherサーバーをアップグレードした後にあなたのインフラストラクチャスタックを最新のデフォルトバージョンにすることができます。これは ** Admin -> Settings -> Advanced Settings **、 `upgrade.manager`の設定からアップデート可能です。デフォルトでは本機能は無効になっています。

## 追加機能
- **カタログテンプレートにおけるテンプレートサポート[[#3239](http://docs.rancher.com/rancher/v1.5/en/cli/variable-interpolation/#templating)]** - [Goのテンプレートシステム](https://golang.org/pkg/text/template/)を利用することで、Rancherでテンプレートにおける条件分岐を実現できるようにしました。
変数の挿入を用いて条件ロジックを利用することで、より高い柔軟性をもつ動的なカタログテンプレートを出力することができます。
    _注意: 現在は文字列比較のみをサポートしています。_
- **APIインターセプター[[#7779](https://github.com/rancher/rancher/issues/7749),[#7134](https://github.com/rancher/rancher/issues/7134)]** - 本リリースからRancherではすべてのAPIリクエストにたいしてリクエスト前処理、後処理を加えられるようになりました。
これによって管理者はAPIのアクセスコントロールやAPIリクエストやレスポンスのペイロードを加工することでより細かい単位でのAPIポリシーの管理を実施できるようになりました。
インターセプターの具体的な作成方法については[#7749](https://github.com/rancher/rancher/issues/7749)を参照してください。
- **より多くの[ネットワークポリシー](http://docs.rancher.com/rancher/v1.5/en/rancher-services/network-policy/)[[#7743](https://github.com/rancher/rancher/issues/7743)]** - environment毎に設定可能な2つのネットワークポリシーが本リリースから利用可能になりました。本機能のサポートのために、environment設定配下に以下の項目を追加しました。
  - サービス内部のallow/deny - デフォルトではルールはallowですが、denyに設定した場合、全てのコンテナはサービスの外部のコンテナと通信できなくなります。
  - linkサポートの有効化 - サービスまたはスタックでdenyを設定した場合、docker linkまたはselectorラベルを用いて個々のコンテナ間の通信を許可することができます。
- **より多くの[webhookドライバ](http://docs.rancher.com/rancher/v1.5/en/cattle/webhook-service/)[[#7735](https://github.com/rancher/rancher/issues/7735),[#7713](https://github.com/rancher/rancher/issues/7713)]** - 追加で2つのwebhookドライバがRancherに追加されました。
  - ホストのスケーリング - ホストのスケールアップ/ダウンを設定できるようになりました。RancherAPIを用いて作成されたホストのみで利用可能です。
  - DockerHubサービスのアップグレード - DockerHubのイメージのアップデートに伴うwebhookを設定することができるようになりました。本webhookを用いてRancher内のサービスをアップデートすることができるようになりました。
- **特定のホストに対するコンテナスケジューリングの制限[[#7795](https://github.com/rancher/rancher/issues/7795)]** - Rancherでホストに対してタグを付与することで特定のラベルをもつホストにしてのみコンテナを配置することができるようになりました。
- **メタデータサービスの改善(フェーズ1) [[#8004](https://github.com/rancher/rancher/issues/8004)]** 
  - DBのスラッシングを減らすためにメタデータ情報のキャッシングを追加しました。個々のメタデータサービスにたいしてパスされるメタデータのフットプリントサイズを削減しました。結果、メタデータに依存する多くのサービスにおけるRancher全般に渡る改善が実現できています。例えば、一度に大量のコンテナを立ち上げた場合や、すでに多くの起動済みのコンテナがある場合に追加のコンテナを起動した際に改善を実感できるはずです。
- **SwarmではデフォルトのUIとしてPortainer.ioを利用するようになりました**
  - Swarm向けのデフォルトのenvironmentテンプレートではPortainer.ioをUIとして利用するようになりました。

## Known Major Issues
- If there is an environment with no hosts, after upgrading and adding the hosts, the `network-services` infrastructure stack, which is required to be upgraded, will not upgrade immediately. It will be delayed by an hour. [[#8047](https://github.com/rancher/rancher/issues/8047)]

## Major Bug Fixes since v1.4.1
- Fixed a memory leak issue with the metadata service  [[#7844](https://github.com/rancher/rancher/issues/7844)]
- Fixed an issue where the bulk action menu to view logs was not functioning properly [[#7787](https://github.com/rancher/rancher/issues/7787)]
- Fixed an issue where a stack named "Y" can cause the Rancher metadata service to crash [[#7776](https://github.com/rancher/rancher/issues/7776)]
- Updated Rancher's swarmkit orchestration engine [[#7774](https://github.com/rancher/rancher/issues/7774)]
- Increased the value size for secrets [[#7708](https://github.com/rancher/rancher/issues/7708)]
- Added multiple category support for catalog templates [[#7497](https://github.com/rancher/rancher/issues/7497)]
- Added sticky session support for Rancher's k8s ingress controller [[#7467](https://github.com/rancher/rancher/issues/7467)]
- Added support to allow admins to launch k8s with ability to customize location of system k8s images such as the kubelet, skydns, helm, etc. [[#7362](https://github.com/rancher/rancher/issues/7362)]
- Fixed an issue where you can no longer set a service scale to < 0. [[#7275](https://github.com/rancher/rancher/issues/7275)]
- Rancher now supports vxlan networking for k8s [[#6817](https://github.com/rancher/rancher/issues/6817)]
- Added openldap auth support for "accessMode" + "allowedIdentities" [[#5141](https://github.com/rancher/rancher/issues/5141)]
- Fixed an issue where EC private keys would cause the HAProxy LB to crash [[#4984](https://github.com/rancher/rancher/issues/4984)]
- Breaking change to the experimental secrets API  requires upgrading secrets volume driver. [[#7708](https://github.com/rancher/rancher/issues/7708)]

## [Rancher CLI](http://docs.rancher.com/rancher/v1.5/en/cli/) Downloads

https://github.com/rancher/cli/releases/tag/v0.5.0

## [Rancher-Compose](http://docs.rancher.com/rancher/v1.5/en/cattle/rancher-compose/) Downloads

https://github.com/rancher/rancher-compose/releases/tag/v0.12.3