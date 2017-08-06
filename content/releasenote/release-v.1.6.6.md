---
date: "2017-08-01"
title: "リリース v1.6.6"
slug: "v1.6.6"
author: "Rancher JP"
description: "リリース v1.6.6"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/08"
---

# リリース v1.6.6

## バージョン
- rancher/server:v1.6.6
- rancher/agent:v1.2.5
- rancher/lb-service-proxy:v0.7.6
- [rancher-v0.6.3](https://github.com/rancher/cli/releases/tag/v0.6.3)
- [rancher-compose-v0.12.5](https://github.com/rancher/rancher-compose/releases/tag/v0.12.5)

## 対応しているDockerのバージョン

- Docker 1.12.3-1.12.6 
- Docker 1.13.1 (Kubenetesのサポートなし)
- Docker 17.03.0-ce/ee(Kubenetesのサポートなし)
- Docker 17.06.0-ee/ee(Kubenetesのサポートなし)

> 注意：Kubernetesは、Docker 1.12.6までしかサポートしていません。

## Rancherサーバーのタグについて

Rancherサーバーには2種類のタグがあります。
いずれのメジャーリリースタグにおいても、個々のバージョンに向けたドキュメントを提供します。

- `rancher/server:latestタグ` 最新の開発中ビルドを提供するタグです。これらのビルドはCIの自動化フレームワークを使って検証済みです。これらのリリースは本番環境へのデプロイを意味していません。
- `rancher/server:stableタグ` 最新のリリースビルドのタグです。本番環境にデプロイする際は本タグを利用することを推奨します。

`rc{n}`サフィックスのついたリリースを使わないようにしてください。これらの`rc`ビルドはRancherチームがテストを行うためのものです。

### Beta - v1.6.6 - `rancher/server:latest`
### Stable - v1.6.5 - `rancher/server:stable`

## 重要 - アップグレード
* **Rancher v1.5.0 より前のバージョンからアップグレードする場合**: この場合のアップグレードでは、`ネットワークサービス` インフラストラクチャスタックをアップグレードしなければこのリリースでは動かないので、自動的にアップグレードします。 
* **Rancher v1.6.0より前のバージョンからアップグレードする場合**: デフォルトのライブラリー設定で自分のカタログを変更していた場合は、元に戻ります。**管理者** -> **設定** -> **カタログ** からデフォルトのブランチ設定を使うようにリセットする必要があります。現在のデフォルトのブランチは、`v1.6-release` ですが、古いデフォルトのブランチは、`master` です。 

* **バージョンのロールバック**: Rancher v1.6.6 から v1.6.5 へのロールバックをサポートしています。
  * **ロールバックの手順**:
    1. アップグレード済みのバージョンで **管理者** -> **拡張設定** -> APIの値 で `upgrade.manager` の値を `all` に変更. 
    2. Rancher サーバーをアップグレードしますが、古いバージョン Rancher (v1.6.5) を指定してください。当然、現在のデータベースバックアップして現在のデータベースを指定して起動してください。
    3. 一度 Rancher が再度起動したら、全てのインフラストラクチャスタックは v1.6.5 にマッチしたバージョンに自動的にロールバックします。
    4. そのインフラストラクチャスタックサービス内で2つのものを削除する必要があります。 
       a. Kubernetesスタックの `rancher-cloud-controller-manager` サービス
       b. IPSecスタックの `cni-driver` サービス
    5. 元の状態に戻ったら、`upgrade.manager` の値を元の状態 (`mandatory` もしくは `none`)にもどしてください。 

## 重要
[Rancher NFSドライバーでEFSが使えるようになった](http://rancher.com/docs/rancher/v1.6/en/rancher-services/storage-service/rancher-nfs/#using-the-rancher-nfs-driver-on-amazon-efs)ので、Rancher EFS ドライバーは非推奨にしようとしています。

## 追加機能
* **Kubernetes 1.7.2 をサポートしました**
* **サービスに複数のIPアドレスを要求できる機能を追加 [[#5297](https://github.com/rancher/rancher/issues5297)]** - `io.rancher.container.requested_ip` にIPアドレスリストをコンマ区切りで複数記述できる.
* **Rancher CLI の拡張**

  - compose files で `init` サポートの追加 [[#8608](https://github.com/rancher/rancher/issues/8608)]

  - compose で スタック名を変数名に利用できる機能を追加 [[#3393](https://github.com/rancher/rancher/issues/3393)]

## インフラストラクチャサービスの更新
インフラストラクチャサービスをアップグレードするときには、[推奨するアップグレードの順番](http://rancher.com/docs/rancher/v1.6/en/upgrading/#infrastructure-services) を必ず確認してください。

* **ネットワークサービス - v0.2.4**
  - _新規イメージ: `rancher/network-manager:v0.7.7`_
  - conntrack, arpsync のロジックを起動している若しくは、起動するコンテナーにのみ有効に修正しました [[#9508](https://github.com/rancher/rancher/issues/9508)]
  - 一つの環境で違うCNIプラグインを使っているときにネットワークを見つけることができない問題を修正[[#9330](https://github.com/rancher/rancher/issues/9330)]
* **IPsec - 0.1.2**
  - _新規イメージ: `rancher/net:v0.11.5`_
  - `cni-driver` サービスを `ipsec` サービスのサイドキックから外して、それ自身が独立したサービスにしました。
  - トンネルが停止したipsec コンテナーから取得される問題を修正しました。[[#9389](https://github.com/rancher/rancher/issues/9389)]
  - カスタムサブネットが `/16` に強制されてしまう問題を修正しました。[[#8938](https://github.com/rancher/rancher/issues/8938)]
* **VXLAN - 0.2.0**
  > **注意:** このバージョンのVXLANは、新しいバージョンでしか利用できません
    - _新規イメージ: `rancher/net:v0.11.5`_
    - トラフィックが破壊されることなしに、vxlan プログラムロジックがアップグレード、再起動できるようにしました。[[#9140](https://github.com/rancher/rancher/issues/9140)]
     - `cni-driver` サービスを `ipsec` サービスのサイドキックから外して、それ自身が独立したサービスにしました。 
     - カスタムサブネットが `/16` に強制されてしまう問題を修正しました。[[#8938](https://github.com/rancher/rancher/issues/8938)]
* **Kubernetes 1.7.2 - v1.7.2-rancher5**
  - _新規イメージ: `rancher/k8s:v1.7.2-rancher5`, `rancher/kubernetes-agent:v0.6.3`, `rancher/etcd:v2.3.7-12`, `rancher/kubectld:v0.8.2`, `rancher/etc-host-updater:v0.0.3`, `rancher/kubernetes-auth:v0.0.7`, `rancher/lb-service-rancher:v0.7.8`_
   - Kubernetesを設定するときに 追加の kubelet オプションを利用できるようにしました。[[#4751](https://github.com/rancher/rancher/issues/4571)]
  - SkyDNS を HA構成にできるように修正しました[[#8347](https://github.com/rancher/rancher/issues/8347)]
  - Rancher ingress コントローラーからロードバランサーを作成し、個別名称で動かせるようにしました。[[#9412](https://github.com/rancher/rancher/issues/9412)]
* **Rancher NFS - 0.4.0** 
  - _新規イメージ: `rancher/storage-nfs:v0.8.5`_
  - NFS v3 を NFS v4 と同じようにサポートしました[[#7080](https://github.com/rancher/rancher/issues/7080)] 
  - サービスが削除されていたときでも、ユーザーが作ったボリュームを削除しないようにする機能を追加しました。注意: The このボリュームオプションは、サービスとして利用する前にボリュームレベルで設定しておく必要があります。[[#8936](https://github.com/rancher/rancher/issues/8936)]
   - 楽にデバックできるようにログを詳細に出すことができるようにしました。[[#8937](https://github.com/rancher/rancher/issues/8937)]

## Known Major Issues

## Major Bug Fixes since v1.6.5
- Fixed an issue where load balancer logs were not being logged after logging was was enabled in the HAProxy configuration. [[#7591](https://github.com/rancher/rancher/issues/7591)]
- Fixed an issue where deleting a service that was linked to a load balancer would also delete the selector rule's on the load balancer [[#9118](https://github.com/rancher/rancher/issues/9118)]
- Fixed an issue where groups level permissions were not working with Kubernetes RBAC [[#9150](https://github.com/rancher/rancher/issues/9150)]
- FIxed an issuer where admins not part of a Kubernetes environment could not access the environment when RBAC was on [[#9468](https://github.com/rancher/rancher/issues/9468)]
- Fixed an issue where Kubernetes running on hosts using RHEL and native Docker were not working. [[#9348](https://github.com/rancher/rancher/issues/9348), [#9304](https://github.com/rancher/rancher/issues/9304)]
- Fixed an issue where updating an ingress would not update the HAProxy config for the load balancer in Rancher [[#9349](https://github.com/rancher/rancher/issues/9349)]
- Fixed an issue where exporting secrets in our compose files were exporting incorrectly. Note: if your secret came from a file, it will still not be exported [[#9059](https://github.com/rancher/rancher/issues/9059)]

## [Rancher CLI](http://docs.rancher.com/rancher/v1.6/en/cli/) Downloads

https://github.com/rancher/cli/releases/tag/v0.6.3

## [Rancher-Compose](http://docs.rancher.com/rancher/v1.6/en/cattle/rancher-compose/) Downloads

https://github.com/rancher/rancher-compose/releases/tag/v0.12.5