---
date: "2017-09-02"
title: "リリース v2.0.0 テクニカルプレビュー"
slug: "v2.0.0 テクニカルプレビュー"
author: "Rancher JP"
description: "リリース v2.0.0 テクニカルプレビュー"
≈: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/09"
---

# リリース v2.0.0 テクニカルプレビュー

## バージョン
- rancher/server:v2.0.0-alpha8
- rancher/agent:v2.0-alpha4
- rancher/lb-service-haproxy:v0.8.1
- rancher-v1.0.0-alpha3

## 対応しているDockerのバージョン

- Docker 1.12.6
- Docker 1.13.1
- Docker 17.03.0-ce
- Docker 17.06.0-ce

## 追加機能

> **注意**: テクニカルプレビューにおいては、全機能が使用できるわけではない点についてご理解ください。
管理パネル上で無効になっている機能がある場合もあります。開発チームとしても、できるだけ早い段階で提供できるようにいたします。
以下、本ビルドで追加された主な機能について紹介します。

- **2.0 UI* - Kubernetes上でRancherのUXを提供するために、UIを作り直しました。以下の変更を行っております。
  - "exec shell"と"view logs"の画面サイズを変更可能にした → 旧UIで最も要望の高かった変更の一つです。

  - 任意の資源(リソース)に対して、アクションを複数同時に実行可能になった
  - Rancher上の殆どのリソース(コンテナ、ホスト、カタログなど)を検索できるオプションを追加
  - コンテナとホスト用の、フィルターオプションとテーブルヘッダを含む新しいリストビュー、テーブルビュー
  - 検索機能向上を目的としてカタログページをリニューアルした 管理しやすいように各カタログが含むインスタンス一覧を"Apps"配下に表示
  - コンテナ/ホスト管理/詳細/新規作成のページを一新
  - 古いバージョンとのdiffを表示、任意のリビジョンに切り戻す機能などを、ロールバックについて機能を向上
  - その他、UIの全般的な応答速度などを速めた

- **クラスターと環境** - Kubernetesの優位性を活かし、Rancherでもついにクラスターの概念を導入、これによってクラスター上で(K8s namespaceのように)複数環境を構築できるようになりました。複数コンテナが物理的に同じノードを共有しながらも、k8s namespaceを利用してそれぞれ独立したワークスペースを所有できるようになります。

- **Kunernetes環境のインポート** - Rancherを使ってどこからでもK8sクラスターを管理できるようになります。Rancher上で管理されるあなた自身のK8s clusterを作成するということもできます。また、GKEやACSなどの主要なホスティングプロバイダからk8s上のクラスターをインポートすることもできます。 to bring-your-own deployments created from popular tools like kops and kubeadm.

- **RHEL 7.4のサポート**
  [[#9674](https://github.com/rancher/rancher/issues/9674)]
  - なお、 `network-services` をバージョン `0.2.5` にアップグレードする必要があります。
- **アクセス制御を無効化せずにLDAPをアップデート可能にしました**
  [[#8115](https://github.com/rancher/rancher/issues/8115)]
  - ADサーバーがアップデートされた際に、Rancherでアクセス制御を無効化することなしにアクセス制御のアップデートができるようになりました。
- **Rancher CLIの機能拡張**
  - composeファイル内部で環境変数を使えるようになりました。
    [[#8791](https://github.com/rancher/rancher/issues/8791)]
  - `stop_grace_period` のサポートが実装されました
    [[#7715](https://github.com/rancher/rancher/issues/7715)]
- **コンテナーへの環境UUIDの自動ラベリングサポート**
  [[#8442](https://github.com/rancher/rancher/issues/8442)]

## 重要 - アップグレードについて

- Rancher v1.5.0以前のものを利用している場合
  - `network-service` インフラストラクチャスタックを自動的にアップグレードするため、
    インフラストラクチャスタックのアップグレードなしには、本リリースバージョンは動作しません。
- Rancher v1.6.0以前のものを利用している場合
  - 自身のカタログを設定するために、デフォルトのRancherライブラリの設定に変更を加えている場合、
    **管理者** -> **設定** -> **カタログ** の順で選択します。
    その後、GUIからデフォルトのRancherライブラリのブランチを再度設定します。。
    以前のデフォルトブランチは `master` ブランチでしたが、現在は `v1.6-release` ブランチです。
- バージョンのロールバック手順
  - Rancher v1.6.8からv1.6.7へのロールバックをサポートしています。
  - ロールバックの手順
    1. **管理者** -> **拡張設定** -> APIの値を選択した後、 `upgrade.manager` の値を `all` に変更します。
    1. Rancherサーバーをアップグレードします。この時に古いバージョンRancher（v.1.6.7）を指定します。
       この作業を行う際には、データベースのバックアップを取得たうえで、
       Rancherサーバーが現在のデータベースを指すように設定します。
    1. Rancherが再度起動したら、すべてのインフラストラクチャスタックが自動的にv.1.6.7とマッチしたものにロールバックされます。
    1. 元の状態（v.1.6.7）に戻ったら、 `upgrade.manager` の値を元の値（ `mandatory` もしくは `none` ）に戻します。

## 重要 - AD認証を使っている場合のv1.6.8へのアップグレードについて
Rancherではv1.6.8からActive Directoryの認証プラグインを新しい認証フレームワークに変更しています。
ADサーバーのホスト名/IPとTLS証明書のホスト名/IPが一致するかを確認することで
AD+TLSオプションをさらにセキュアなものにしています。
詳細は、[[#9459](https://github.com/rancher/rancher/issues/9459)]を参照してください。

新たなチェック機構が追加されたため、ホスト名/IPがTLS証明書と一致しているかを注意するべきです。
アップグレード前に修正を行わなかった場合は、Rancherサーバーにログインできなくなります。
アップグレートに伴う問題を回避するためも、以下に述べる手順に沿って設定が正しいかを確認してください。

- AD設定のホスト名/IPを確認する。
  これを行うには、Rancherにブラウザでログインし、 **管理者** -> **アクセスコントロール** の順でアクセスします。
  serverフィールドがあなたの設定したADサーバーのホスト名/IPアドレスです。
- TLS証明書のホスト名/IPを確認するために、以下のコマンドを実行して、CN属性の値を取得してください。
  - `openssl s_client -showcerts -connect domain.example.com:443`
- コマンドの実行結果として以下のようなものが得られるはずです。
  - `subject=/OU=Domain Control Validated/CN=domain.example.com`
  - CN属性の値が先ほど確認したserverフィールドの値と一致しているかを確認してください。

フィールドの値とCN属性の値が一致した場合は、一切の作業は不要です。
もし、フィールドの値が一致しなかった場合は、次の手順に従って設定を修正してください。

- ブラウザを使ってRancherの `settings` のURLへと移動します。
  これは、Rancherにログイン後に **API** -> **Keys** の順でクリックすることで移動できます。
  `Endpoint（v2-beta）` フィールドが見えるはずです。
  フィールドの値を確認し、 `/settings` にくわえます。
  最終的なURLは `my.rancher.url:8080/v2-beta/settings` のようになるはずです。
  このURLにブラウザでアクセスすることでRancherのAPIブラウザを利用できます。
- `api.auth.ldap.server` を検索し、その値を編集するためにクリックします。
  画面上部、右側に編集ボタンがあるのでクリックします。
  ホスト名/IPの値を変更して先ほど確認したCN属性の値と一致するようにします。
  その後、 **Show Request->Send Request** とクリックし、値をRancherのデータベースで永続化させます。
  レスポンスには先ほど設定した新しい値が含まれているはずです。

一度この作業が完了し、ホスト名/IPが証明書のCN属性と一致すれば、
v1.6.8にアップグレードした後も特に問題は発生しないはずです。


## インフラストラクチャーサービスのアップデート
インフラストラクチャーサービスをアップグレードするときは、
[推奨された手順に従ってアップグレード](http://rancher.com/docs/rancher/v1.6/en/upgrading/#infrastructure-services)してください。

- **Network Services - v0.2.6**
  - 新しいイメージを利用するようになりました。
    - `rancher/networkmanager:v0.7.8`
    - `rancher/dns:v0.15.3`
    - `rancher/metadata:v0.9.4`
  - アップストリームのTTLを引き継ぐようになりました。
    [[#8805]](https://github.com/rancher/rancher/issues/8805)
  - nilポインタのキャッシュを修正しました。
  - グローバルキャッシュを検索する前にローカルを検索するようになりました。
    [[#8504](https://github.com/rancher/rancher/issues/8504)]
  - jsonをエンコードする際にgo panicをおこすことがあった問題を修正しました。
    [[#9637](https://github.com/rancher/rancher/issues/9637)]
- **IPsec - 0.1.4**
  - 新しいイメージを利用するようになりました。
    - `rancher/net:v0.11.9`
  - 名前解決の回避のためにRancherメタデータのIPを直接利用するよう修正しました。
    [[#9521](https://github.com/rancher/rancher/issues/9521)]
  - ホストが2台の時に両方からIPsecトンネルを張ろうとする問題を修正しました
    [[#8204](https://github.com/rancher/rancher/issues/8204)]
  - リプレイウインドウサイズの設定を可能にしました。[[#9377](https://github.com/rancher/rancher/issues/9377)]
  - rekey間隔の設定を可能にしました。[[#9705](https://github.com/rancher/rancher/issues/9705)]
- **Healthcheck - v0.3.3**
  - 新しいイメージを利用するようになりました。
    - `rancher/healthcheck:v0.3.3`
  - networkFromプライマリをつかうようsidekickサービスコンテナーのヘルスチェックを追加しました。[[#6305](https://github.com/rancher/rancher/issues/6305)] 
  - 名前解決の回避のためにRancherメタデータのIPを直接利用するよう修正しました。[[#9521](https://github.com/rancher/rancher/issues/9521)] 
- **VXLAN - 0.2.1**
  - 新しいイメージを利用するようになりました。
    - `rancher/net:v0.11.9`
  - 名前解決の回避のためにRancherメタデータのIPを直接利用するよう修正しました。[[#9521](https://github.com/rancher/rancher/issues/9521)]  
- **Kubernetes 1.7.4 - v1.7.4-rancher2**
  - 新しいイメージを利用するようになりました。
    - `rancher/k8s:v1.7.4-rancher2`
    - `rancher/kubernetes-agent:v0.6.5`
    - `rancher/etcd:v2.3.7-13`
    - `rancher/kubectld:v0.8.3`
    - `rancher/etc-host-updater:v0.0.3`
    - `rancher/kubenetes-auth:v0.0.8`
    - `rancher/lb-service-rancher:v0.7.10`
  - 名前解決の回避のためにRancherメタデータのIPを直接利用するよう修正しました。[[#9521](https://github.com/rancher/rancher/issues/9521)] 
  - `kubernetes.io/ingress.class` アノテーションのサポートを追加しました[[#6344](https://github.com/rancher/rancher/issues/6344)]
  - ホストネットワークを使う Pod でネットワークが壊れている状態を解消しました。[[#9678](https://github.com/rancher/rancher/issues/9678)]


## 既知の主要なバグ
- 認証で保護されたプライベートレジストリを持つKubernetesユーザの場合に以下の問題が発生しています。
  - 事象
    - アドオンスターターが `pause-amd64:3.0` イメージをpullすることができす、
      アドオンを起動させることができません。
  - ワークアラウンド
    - ホストにあらかじめ `pause-amd64:3.0` イメージをpullしておきます。

## v1.6.7からの主要なバグの修正
- アクセス制御認証の間、APIからサービスのアカウントパスワードが返されていた問題を修正しました。
  [[#8625](https://github.com/rancher/rancher/issues/8625)]
- HAProxyのログがファイルのみに送られていた問題を修正しました。stdout/stderrにも送られるようになりました。
  [[#9616](https://github.com/rancher/rancher/issues/9616)]
- プライベートカタログがアルファベット順にソートされない問題を修正しました。[[#9446](https://github.com/rancher/rancher/issues/9446)]
- カスタムHAProxy設定に2つ以上のバックエンドが含まれていた場合に、
  ロードバランサが作動しない問題を修正しました。
  [[#8226](https://github.com/rancher/rancher/issues/8226)]
- rancher upが--waitや--wait-stateオプションを無視する問題を修正しました。
  [[#8492](https://github.com/rancher/rancher/issues/8492)]
- ldap接続時のデフォルトタイムアウト設定の値が小さすぎたので修正しました。
  [[#8944](https://github.com/rancher/rancher/issues/8944)]
- Rancherをデバッグのために起動させた際のrancher-auth-serviceのログレベルを変更できるようにしました。
  [[#9390](https://github.com/rancher/rancher/issues/9390)]
- インフラストラクチャースタックの前にユーザースタックを起動した場合にデッドロックに陥る問題を修正しました。
  [[#9554](https://github.com/rancher/rancher/issues/9554)]
- インターネットに接続できない環境で、キャッシュされたカタログからセットアップを行なった場合に、
  テンプレートを設定するのに長い時間がかかる問題を修正しました。
  [[#9669](https://github.com/rancher/rancher/issues/9669)]

## [Rancher CLI](http://docs.rancher.com/rancher/v1.6/en/cli/) Downloads

https://github.com/rancher/cli/releases/tag/v0.6.4

## [Rancher-Compose](http://docs.rancher.com/rancher/v1.6/en/cattle/rancher-compose/) Downloads

https://github.com/rancher/rancher-compose/releases/tag/v0.12.5


