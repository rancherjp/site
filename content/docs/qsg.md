---
date: "2016-11-30"
title: "クイックスタートガイド"
slug: "qsg"
author: "Rancher JP"
description: "初めて Rancher を触る方向けのクイックスタートガイド"
draft: false
lang: ja
redirect_from:
  - /rancher/quick-start-guide/
  - /rancher/latest/en/quick-start-guide/
---

## クイック スタート ガイド ##

このガイドでは、1台のLinuxサーバーに全てインストールして動く、最も簡単なRancherをインストールしてみます。

### Linuxホストを準備する

3.10 + のカーネルが最低限入っている64 ビット Ubuntu 16.04 と Linux ホストを準備します。 ノートパソコンでも、仮想環境でも、物理サーバーも利用可能です。 Linux ホストには少なくとも **1GB** のメモリがあることを確認してください。 [Docker](https://www.docker.com/) をホストにインストールします。

サーバーにDockerをインストールするには、 [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/) 社の手引きを参照してください。

> **注:** 現在、Windows と Mac のDockerはサポートされていません。

### Rancher サーバータグ

`rancher/server:latest` タグはRancherの安定版ビルドにつけられます。Rancher社が推奨している本番環境展開用です。 各マイナーリリースタグに対して、それぞれのバージョンでのドキュメントを提供します。

もし、CI自動化フレームワークで検証済の最新開発版のビルドに興味があれば、最新の開発版のリリースタグが付いた[リリースページ](https://github.com/rancher/rancher/releases) を確認してください。 このリリースは本番環境デプロイ用ではありません。 開発ビルドには、全て開発リリースであることを示す`*-pre{n}` という接尾辞が付加されます。 `rc{n}` サフィックスの付いているリリースはいずれも使用しないでください。 `rc` ビルドは、Rancherチームが開発版ビルドをテストするためのものです。

### Rancherサーバーを動かす

Rancherサーバーを起動するコマンドは1つだけです。コンテナを起動したら、コンテナのログを調べて、サーバが起動して動いているかを確認します。

```bash
$ sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
# Rancherのログを表示
$ sudo docker logs -f <CONTAINER_ID>
```

Rancherサーバーの起動に数分おまちください。 `.... Startup Succeeded, Listening on port....` が表示されたら、RancherのUIは起動して稼働中です。 ログのこの行が表示されたら、ほとんど設定は終了です。 この出力の後に追加のログが出力される可能性があるので、これが初期起動時のログの最後の行であるとは限りません。

UIは `8080` ポートで動いているので、表示するには `http://<SERVER_IP>:8080` をブラウザーで開いてください。 Rancherサーバーとブラウザーが同じホストで動いている場合は、`http://192.168.1.100:8080` のように実IPを使ってください。`http://localhost:8080` や `http://127.0.0.1:8080` としないようにしてください。

> **注:** Rancherサーバーにはアクセス制限が設定されておらず、このIPアドレスにアクセスできる誰でもこのUIとAPIを利用できます。 [アクセス制限]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/)を設定することをお勧めします。

### ホストを追加

わかりやすくするためにRancherサーバーを実行しているサーバーをRancherのホストとして追加します。実際の運用では、専用のRancherを実行するホストを動かすことをお勧めします。

ホストを追加するには、UIから **Infrastructure** をクリックして、**Hosts** ページを表示してください。 **Add Host** をクリックします。 Rancherで利用するURLを選択するように指示されます。 このURLは、Rancherサーバーが動いているURLになり、これから追加するRancherホストから接続可能なものでなくてはなりません。 この設定は、RancherサーバーがファイヤウォールでNATされたり、ロードバランサーを介してインターネットに公開される場合に便利です。 ホストに`192.168.*.*`のようなプライベートやローカルIPなアドレスがついていた場合、Rancherサーバーにホストが本当にURLにアクセスできるかどうかを尋ねる警告が表示されます。

今のところ、これらの警告は無視してRancherサーバーホスト自体を追加することができます。 **Save** をクリックします。 デフォルトでは、Rackherエージェントコンテナを起動するDockerコマンドを提供する **Custom** オプションが選択されます。 RancherがDocker Machineを使用してホストを起動するクラウドプロバイダ向けのオプションもあります。

UIでホスト上でオープンにするポートの指示とオプションの設定項目が表示されます。Rancherサーバーも稼動しているホストを追加するので、このホストで使用するパブリックIPを追加する必要があります。 このオプションで入力されたIPにより、カスタムコマンドでの環境変数が自動的に変更されます。

Rancherサーバーを実行しているホストでこのコマンドを実行します。

Rancher UIで **Close** をクリックすると、**Infrastructure** -> **Hosts** 表示に戻ります。 数分後にホストが自動的に表示されます。

### インフラストラクチャーサービス

最初にRancherにログインすると自動的に [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)になります。この[infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/)を開始するためにデフォルトのcattle [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template)が選択されます。この[infrastructure services]は、Rancherの持っている[dns]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/dns-service/)や[metadata]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/metadata-service)、[networking]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/networking)そして[health checks]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/health-checks/)のような機能の利点を活用するため有利なものです。これらのインフラストラクチャスタックは、**Stacks** -> **Infrastructure** にあります。これらのスタックは、ホストがRancherに完全に追加されるまで、`不健全な` 状態です。ホストを追加した後は、サービスを追加する前にすべてのインフラストラクチャスタックが `active` になるまで待つことをお勧めします。

ホストでは、**Show System** チェックボックスをクリックしない限り、インフラストラクチャサービスのコンテナは非表示になります。

### UIを使用してコンテナを作成する

**Stacks** 画面に移動して、まだサービスがない場合は、Welcome画面の **Define a service** ボタンをクリックします。 Rancherに既にサービスが存在する場合は、既存のスタックの **Add Service** をクリックするか、新しいスタックを作成してサービスを追加できます。 新しいスタックを作成する必要がある場合は、 **Add Stack** をクリックし、名前と説明を入力して **Create** をクリックします。 次に新規スタックで **Add Service** をクリックします。

"first-container"のような名前でサービスを追加します。 デフォルトの設定を使用して **Create** をクリックするだけです。 Rancherは、ホスト上でコンテナの起動を開始します。ホストのIPアドレスにかかわらず、Rancherがipsecインフラストラクチャサービスで管理オーバーレイネットワークを作成したため、最初のコンテナのIPアドレスは `10.42 *.*` の範囲になります。管理オーバーレイネットワークで、コンテナが異なるホスト間で相互に通信できるように管理しています。

**_first-container_** のドロップダウンをクリックすると、コンテナの停止、ログの表示、コンテナコンソールへのアクセスなどの管理アクションを実行できます。

### DockerのCLIを直接使ってコンテナを作成する

Rancherは、コンテナがUIの外で作成されていてもホスト上のコンテナを表示できます。ホストのシェル端末からコンテナを作成してみます。

```bash
$ docker run -d -it --name=second-container ubuntu:14.04.2
```

UI上では、 **_second-container_** がホスト上にポップアップ表示されます。

RancherはDockerデーモンで発生するイベントに反応し、実際の動作状況とRancherでの状況を調整します。 [native docker CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/native-docker/)を使用してRancherを利用する方法の詳細を読むことができます。

**_second-container_** のIPアドレスを見ると、`10.42.*.*` の範囲には**ない**ことがわかります。 これは、Dockerデーモンによって割り当てられた通常のIPアドレスです。 CLIを使用してDockerコンテナを作成するとこのようになります。

CLIを使用してRancherのオバーレイネットワークからIPアドレスのDockerコンテナを作成するにはどうすればよいでしょうか？ しなければならないこと、コマンドにラベル(i.e. `io.rancher.container.network=true`)を追加するだけで、Rancherは、このコンテナが`管理`ネットワークに属しなければならないと認識します。

```bash
$ docker run -d -it --label io.rancher.container.network=true ubuntu:14.04.2
```

### マルチコンテナアプリケーションの作成

個別のコンテナを作成する方法と、ホスト間ネットワークでそれらがどのように接続されるかを説明しました。 しかし、実際のアプリケーションのほとんどは複数のサービスで構成されており、各サービスは複数のコンテナで構成されています。 たとえば、[LetsChat](http://sdelements.github.io/lets-chat/)アプリケーションは、次のようなサービスで構成されます。

  1. ロードバランサー ロードバランサーはインターネットからのリクエストを" LetsChat" アプリケーションに中継します。
  2. _ウェブ_ サービス "LetsChat" コンテナ2つで構成されます。
  3. _データーベース_ サービス "Mongo" コンテナ1つで構成されます。

ロードバランサーは_ウェブ_ サービス(例 LetsChat) に接続し、_ウェブ_ サービスは_データーベース_ サービス(例 Mongo)にリンクします。

このセクションでは、Rancherに [LetsChat](http://sdelements.github.io/lets-chat/) アプリケーションのコンテナを作成して展開する方法を説明します。

**Stacks** 画面に移動します。まだサービスがない場合は、Welcome画面の **Define a Service** ボタンをクリックします。 Rancherに既にサービスが存在する場合は、既存のスタックの **Add Service** をクリックするか、新しいスタックを作成してサービスを追加できます。 新しいスタックを作成する必要がある場合は、 **Add Stack** をクリックし、名前と説明を入力して **Create** をクリックします。 次に新規スタックで **Add Service** をクリックします。

まず、`mongo` イメージを使い *データベース* というサービスを作成します。 **Create** をクリックします。_データーベース_ サービスが含まれるスタックページがすぐに表示されます。

次に、もう一度 **Add Service** をクリックして、別のサービスを追加します。 LetsChatサービスと_データーベース_ サービスとをリンクをさせます。 `sdelements/lets-chat`イメージを使用して、`web` 名前を付けます。UI上でスライダを動かして、サービスのスケールをコンテナ2つにします。 **Service Links** に`mongo` という名前の _データベース_ サービスを追加します。 Dockerの場合と同様に、Rancherは、`mongo` の名前を選択すると、リンクされたデータベースとして `letschat` イメージに必要な環境変数をリンクします。 **Create** をクリックします。

最後にロードバランサーを作成します。 **Add Service** ボタンの横にあるドロップダウンメニューアイコンをクリックします。 **Add Load Balancer** を選択します。 `letschatapplb` のような名前を入力し、接続先アプリケーションにアクセスするために使用するホスト上のソースポート(例 `80`)とターゲットサービス(例 _web_)とターゲットポート(例 `8080`) を選択します。 この場合、_ウェブ_ サービスで `8080`番ポートを使用します。 

LetsChatアプリケーションが完成しました！ **Stacks**画面で、ロードバランサが公開しているポートをリンクとして見つけることができます。 そのリンクをクリックすると、新しいブラウザが開き、LetsChatアプリケーションが表示されます。

### Rancher CLI を使用して複数コンテナアプリケーションを作成する

このセクションでは、[Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/) というコマンドラインツールを使用して前のセクションで作成したと同じ[LetsChat](http://sdelements.github.io/lets-chat/)アプリケーションを作成して展開する方法を説明します。

Rancherサービスが起動したときに、Rancher CLIツールは一般的なDocker Composeツールと同じように機能します。 これは、同じように `docker-compose.yml` ファイルを読み込んでRancherにアプリケーションをデプロイします。 `rancher-compose.yml` ファイルを利用すると `docker-compose.yml` ファイルを拡張して上書きする追加の属性を指定することができます。

前のセクションでは、ロードバランサを備えたLetsChatアプリケーションを作成しました。 Rancherで作成していた場合、スタックのドロップダウンメニューから **Export Config** を選択して、UIから直接ファイルをダウンロードできます。 `docker-compose.yml` と `rancher-compose.yml` ファイルは次のようになります。

#### Example docker-compose.yml

```yaml
version: '2'
services:
  letschatapplb:
    #If you only have 1 host and also created the host in the UI,
    # you may have to change the port exposed on the host.
    ports:
    - 80:80/tcp
    labels:
      io.rancher.container.create_agent: 'true'
      io.rancher.container.agent.role: environmentAdmin
    image: rancher/lb-service-haproxy:v0.4.2
  web:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: sdelements/lets-chat
    links:
    - database:mongo
    stdin_open: true
  database:
    labels:
      io.rancher.container.pull_image: always
    tty: true
    image: mongo
    stdin_open: true
```

#### Example rancher-compose.yml

```yaml
vversion: '2'
services:
  letschatapplb:
    scale: 1
    lb_config:
      certs: []
      port_rules:
      - hostname: ''
        path: ''
        priority: 1
        protocol: http
        service: quickstartguide/web
        source_port: 80
        target_port: 8080
    health_check:
      port: 42
      interval: 2000
      unhealthy_threshold: 3
      healthy_threshold: 2
      response_timeout: 2000
  web:
    scale: 2
  database:
    scale: 1
```
<br>
フッター右側にある **Download CLI** をクリックして、RancherのUIからRancher CLIバイナリをダウンロードします。 Windows、Mac、Linux用のバイナリを提供しています。

Rancher CLIを使用してRancherでサービスを開始するには、いくつか環境変数を設定する必要があります。 Rancher UIで[account API Key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/)を作成します。 **API** をクリックし、**Add Account API Key** をクリックします。 ユーザー名 (アクセスキー) とパスワード (秘密キー) を保存します。 Rancher CLIに必要な次の環境変数を設定します: `RANCHER_URL`、`RANCHER_ACCESS_KEY` と `RANCHER_SECRET_KEY`

```bash
# Set the url that Rancher is on
$ export RANCHER_URL=http://server_ip:8080/
# Set the access key, i.e. username
$ export RANCHER_ACCESS_KEY=<username_of_key>
# Set the secret key, i.e. password
$ export RANCHER_SECRET_KEY=<password_of_key>
```
<br>
`docker-compose.yml` と `rancher-compose.yml` を保存したディレクトリに移動し、コマンドを実行します。

```bash
$ rancher -p NewLetsChatApp up -d
```

Rancherで **NewLetsChatApp** という新しいスタックが作成され、サービスがすべて起動します
