---
date: "2017-09-02"
title: "リリース v1.6.8"
slug: "v1.6.8"
author: "Rancher JP"
description: "リリース v1.6.8"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/09"
---

# リリース v1.6.8

## バージョン
- rancher/server:v1.6.8
- rancher/agent:v1.2.6
- rancher/lb-service-proxy:v0.7.9
- rancher-v0.6.4
- rancher-compose-v0.12.5

## 対応しているDockerのバージョン

- Docker 1.12.3-1.12.6 
- Docker 1.13.1（Kubenetesのサポートなし）
- Docker 17.03.0-ce/ee（Kubenetesのサポートなし）
- Docker 17.06.0-ce/ee（Kubenetesのサポートなし）

> 注意: Kubenetes 1.7は Docker 1.12.6までのサポートです。


## Rancherサーバーのタグについて

Rancherサーバーには2種類のタグがあります。
いずれのメジャーリリースタグにおいても、個々のバージョンに向けたドキュメントを提供します。

- `rancher/server:latestタグ`
  最新の開発中ビルドを提供するタグです。
  これらのビルドはCIの自動化フレームワークを使って検証済みです。
  これらのリリースは本番環境へのデプロイを意味していません。
- `rancher/server:stableタグ`
  最新のリリースビルドのタグです。本番環境にデプロイする際は本タグを利用することを推奨します。

`rc{n}`サフィックスのついたリリースを使わないようにしてください。
これらの`rc`ビルドはRancherチームがテストを行うためのものです。

### Beta - v1.6.8 - `rancher/server:latest`
### Stable - v1.6.7 - `rancher/server:stable`

## 重要 - アップグレードについて

- Rancher v1.5.0以前のものを利用している場合
  - network-serviceインフラストラクチャスタックを自動的にアップグレードするため、
    インフラストラクチャスタックのアップグレードなしには、本リリースバージョンは動作しません。
- Rancher v1.6.0以前のものを利用している場合
  - 自身のカタログを設定するために、デフォルトのRancherライブラリの設定に変更を加えている場合、
    Admin->Settings->Catalogの順で選択します。
    その後、GUIからデフォルトのRancherライブラリのブランチを再度設定します。。
    以前のデフォルトブランチはmasterでしたが、現在はv1.6-releaseブランチです。
- バージョンのロールバック手順
  - Rancher v1.6.8からv1.6.7へのロールバックをサポートしています。
  - ロールバックの手順
    1. 管理者->拡張設定->APIの値 を選択した後、upgrade.managerの値をallに変更します。
    1. Rancherサーバーをアップグレードします。この時に古いバージョンRancher（v.1.6.7）を指定します。
       この作業を行う際には、データベースのバックアップを取得たうえで、
       Rancherサーバーが現在のデータベースを指すように設定します。
    1. Rancherが再度起動したら、すべてのインフラストラクチャスタックが自動的にv.1.6.7とマッチしたものにロールバックされます。
    1. 元の状態（v.1.6.7）に戻ったら、upgrade.managerの値を元の値（mandatory もしくは none）に戻します。

## 重要 - AD認証を使っている場合のv1.6.8へのアップグレードについて
Rancherではv1.6.8からActive Directoryの認証プラグインを新しい認証フレームワークに変更しています。
ADサーバのホスト名/IPとTLS証明書のホスト名/IPと一致するかを確認することで
AD+TLSオプションをさらにセキュアなものにしています。
詳細は、[[#9459](https://github.com/rancher/rancher/issues/9459)]を参照してください。

新たなチェック機構が追加されたため、ホスト名/IPがTLS証明書と一致しているかを注意するべきです。
アップグレード前に修正を行わなかった場合は、Rancherサーバにログインできなくなります。
アップグレートに伴う問題を回避するためも、いかに述べる手順に沿って設定が正しいかを確認してください。

- AD設定のホスト名/IPを確認する。
  これを行うには、Rancherにブラウザでログインし、Admin -> Access Controlとアクセスします。
  serverフィールドがあなたの設定したADサーバのホスト名/IPアドレスです。
- TLS証明書のホスト名/IPを確認するために、以下のコマンドを実行して、CN属性の値を取得してください。
  - `openssl s_client -showcerts -connect domain.example.com:443`
- コマンドの実行結果として以下のようなものが得られるはずです。
  - `subject=/OU=Domain Control Validated/CN=domain.example.com`
  - CN属性の値が先ほど確認したserverフィールドの値と一致しているかを確認してください。

フィールドの値とCN属性の値が一致した場合は、一切の作業は不要です。
もし、フィールドの値が一致しなかった場合は、次の手順に従って設定を修正してください。

- ブラウザを使ってRancherのsettingsのURLへと移動します。
  これは、Rancherにログイン後API->Keysの順でクリックすることで移動できます。
  Endpoint(v2-beta)フィールドが見えるはずです。
  フィールドの値を確認し、/settingsにくわえます。
  最終的なURLはmuy.rancher.url:8080/v2-seta/settingsのようになるはずです。
  このURLにブラウザでアクセスすることでRancherのAPIブラウザを利用できます。
- api.auth.ldap.serverを検索し、その値を編集するためにクリックします。
  画面上部、右側にeditボタンがあるのでクリックします。
  ホスト名/IPの値を変更して先ほど確認したCN属性の値と一致するようにします。
  その後、Show Request->Send Requestとクリックし、値をRancherのDBで永続化させます。
　レスポンスには先ほど設定した新しい値が含まれているはずです。

一度この作業が完了し、ホスト名/IPが証明書のCN属性と一致すれば、
v1.6.8にアップグレードした後も特に問題は発生しないはずです。

## 追加機能
- RHEL 7.4のサポート
  [[#9674](https://github.com/rancher/rancher/issues/9674)]
  - なお、network-servicesをバージョン0.2.5にアップグレードする必要があります。
- アクセス制御を無効化せずにLDAPをアップデート可能にしました
  [[#8115](https://github.com/rancher/rancher/issues/8115)]
  - ADサーバーガアップデートされた際に、Rancherでアクセス制御を無効化することなしにアクセス制御のアップデートができるようになりました。
- Rancher CLIの機能拡張
  - composeファイル内部で環境変数を使えるようになりました。
    [[#8791](https://github.com/rancher/rancher/issues/8791)]
  - stop/grace:periodのサポートが実装されました
    [[#7715](https://github.com/rancher/rancher/issues/7715)]
- コンテナへの環境UUIDの自動ラベリングサポート
  [[#8442](https://github.com/rancher/rancher/issues/8442)]


## インフラストラクチャーサービスのアップデート
インフラストラクチャーサービスをアップグレードするときは、
[推奨された手順に従ってアップグレード](http://rancher.com/docs/rancher/v1.6/en/upgrading/#infrastructure-services)してください。

- Network Services - v0.2.6
  - 新しいイメージを利用するようになりました。
    - rancher/networkmanager:v0.7.8
    - rancher/dns:v0.15.3
    - rancher/metadata:v0.9.4
  - アップストリームのTTLを引き継ぐようになりました。
    [[#8805]](https://github.com/rancher/rancher/issues/8805)
  - nilポインタのキャッシュを修正しました。
  - グローバルキャッシュを検索する前にローカルを検索するようになりました。
    [[#8504](https://github.com/rancher/rancher/issues/8504)]
  - jsonをエンコードする際にgo panicをおこすことがあった問題を修正しました。
    [[#9637](https://github.com/rancher/rancher/issues/9637)]
- IPsec - 0.1.4
  - 新しいイメージを利用するようになりました。
    - rancher/net:v0.11.9
  - 名前解決の回避のためにRancherメタデータのIPを直接利用するよう修正しました。
    [[#9521](https://github.com/rancher/rancher/issues/9521)]
  - ホストが2台の時に両方からIPsecトンネルを張ろうとする問題を修正しました
    [[#8204](https://github.com/rancher/rancher/issues/8204)]
  - リプレイウインドウサイズの設定を可能にしました。[[#9377](https://github.com/rancher/rancher/issues/9377)]
  - rekey間隔の設定を可能にしました。[[#9705](https://github.com/rancher/rancher/issues/9705)]
- Healthcheck - v0.3.3
  - 新しいイメージを利用するようになりました。
    - rancher/healthcheck:v0.3.3
  - networkFromプライマリをつかうようsidekickサービスコンテナのヘルスチェックを追加しました。[[#6305](https://github.com/rancher/rancher/issues/6305)] 
  - 名前解決の回避のためにRancherメタデータのIPを直接利用するよう修正しました。[[#9521](https://github.com/rancher/rancher/issues/9521)] 
- VXLAN - 0.2.1
  - 新しいイメージを利用するようになりました。
    - rancher/net:v0.11.9
  - 名前解決の回避のためにRancherメタデータのIPを直接利用するよう修正しました。[[#9521](https://github.com/rancher/rancher/issues/9521)]  
- Kubernetes 1.7.4 - v1.7.4-rancher2
  - 新しいイメージを利用するようになりました。
    - rancher/k8s:v1.7.4-rancher2,
    - rancher/kubernetes-agent:v0.6.5
    - rancher/etcd:v2.3.7-13
    - rancher/kubectld:v0.8.3
    - rancher/etc-host-updater:v0.0.3
    - rancher/kubenetes-auth:v0.0.8
    - rancher/lb-service-rancher:v0.7.10

## 既知の主要なバグ
- 認証で保護されたプライベートレジストリを持つKubernetesユーザの場合に以下の問題が発生しています。
  - 事象
    - アドオンスターターがpause-amd64:3.0イメージをプルすることができす、
      アドオンを起動させることができません。
  - ワークアラウンド
    - ホストにあらかじめpause-amd64:3.0イメージをプルしておきます。

## v1.6.7からの主要なバグの修正
- アクセス制御認証の間APIからサービスのアカウントパスワードが返されていた問題を修正しました。
  [[#8625](https://github.com/rancher/rancher/issues/8625)]
- HAProxyのログがファイルのみに送られていた問題を修正しました。stdout/stderrにも送られるようになりました。
  [[#9616](https://github.com/rancher/rancher/issues/9616)]
- プライベートカタログがアルファベット順にソートされない問題を修正しました。[[#9446](https://github.com/rancher/rancher/issues/9446)]
- カスタムHAProxy設定に2つ以上のバックエンドが含まれていた場合に、
  ロードバランサが作動しない問題を修正しました。
  [[#8226](https://github.com/rancher/rancher/issues/8226)]
- rancher upが --waitや--wait-stateオプションを無視する問題を修正しました。
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