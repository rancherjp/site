---
date: "2016-12-04"
title: "リリース v1.2.0"
slug: "v.1.2.0" 
author: "Rancher JP"
description: "リリース v1.2.0"
draft: false
tags:
  - "release-announce"
categories:
  - "release-announce"
archives:
  - 2016
  - 2016/12
  - 2016/12/04
---

## バージョン
* rancher/server:v1.2.0
* rancher/agent:v1.1.0
* rancher/lb-service-haproxy:v0.4.2
* [rancher-compose-v0.12.0](https://github.com/rancher/rancher-compose/releases/tag/v0.12.0)
* [rancher-v0.4.0](https://github.com/rancher/cli/releases/tag/v0.4.0)

> *注意:* 新しい[infrastructure services](http://docs.rancher.com/rancher/v1.2/en/rancher-services/)では、ロードバランサの機能を指定のHAProxyイメージに変更し、ネットワークエージェントが起動されなくなりました。 したがって、rancher/agent-instanceが必要なくなりました。

## 新機能 (v1.1.4からの変更点)
* __Kubernetes 1.4.6 に対応__ - 最新のk8sに対応することに加えて、Rancherは以下の機能が提供されます:
  * 既定のRancherオプションに加えて、ユーザーがAWSをKubernetesのクラウドプロバイダーとして選択できるようになりました。
  * kubectl exec、logs、attachがサポートされました。
  * k8sノード にラベル付けがサポートされました。
  * PetSetオブジェクトを使用してステートフルアプリケーションの管理がサポートされました。
  * 環境内でのk8sクラスタアップグレードがサポートされました。
  * Added Rancher UI support for the concept of a Stack to manage k8s templates as individual applications.  Stacks can be upgraded and deleted as an application.
  * Rancher UIで、k8sテンプレートを個々のアプリケーションとして管理するスタックをサポートしました。 スタックは、アプリケーションとしてアップグレード、削除することができます。
  * Rancher UIでk8sの展開とレプリカセットをサポーターしました。
* __Docker 1.12.x サポート [[#5179](https://github.com/rancher/rancher/issues/5179)]__ - Docker 1.12.xがRancherでサポートされ、いくつかの機能が強化されました。
  * Docker Swarmモードは、環境作成時にオーケストレーションフレームワークのオプションとして利用できるようになりました。
  * CattleはDocker 1.12.3以降のすべてのdocker runオプションをサポートするようになりました。更新された実行オプションの詳細については、[#4708](https://github.com/rancher/rancher/issues/4708)を参照してください。
* __改善 [Network](http://docs.rancher.com/rancher/v1.2/en/rancher-services/networking) サポート [[#5256](https://github.com/rancher/rancher/issues/5256), [#5276](https://github.com/rancher/rancher/issues/5276)]__ - Container Network Interface(CNI)仕様用に作成されたカスタムネットワークプラグインのライフサイクル、配布、および更新管理を管理する機能が追加されました。
  * 現在のRancher IPSec管理ネットワークオプションがCNIプラグインとして完全に書き直されて、Cattleとk8sオーケストレーションフレームワークの両方で利用できます。
  * Rancherは、暗号化されていない(その為に性能の良い)クロスホスト用の管理ネットワークの代替オプションとして、VXLAN CNIプラグインが提供されるようになりました。
* __改善 [Load Balancer v2](http://docs.rancher.com/rancher/v1.2/en/cattle/adding-load-balancers/) のサポート [[#2179](https://github.com/rancher/rancher/issues/2179)]__ - RancherのLBサービスは、以下のサポートを受けて完全に書き直されました。
  * SNIルーティングがLB v2で利用可能になりました。
  * HAProxyロギングがLB v2で利用可能になりました。[[#2414](https://github.com/rancher/rancher/issues/2414)]
  * 既にサポートされているグローバルセクションとデフォルトセクションに加えて、フロントエンドとバックエンドのカスタム構成をHAProxy構成に追加できるようになりました。[[#2171](https://github.com/rancher/rancher/issues/2171), [#1871](https://github.com/rancher/rancher/issues/1871)]
  * ユーザはホスト名ルーティングルールを持つセレクタを追加できるようになりました。[[#2288](https://github.com/rancher/rancher/issues/2288)]
  * v2ではポートからサービスへのマッピングをより柔軟に定義できるようになりました。 v1では、ポートをすべてのサービスに対応づける必要がありました。
  * 好きなLBエンジン(nginxなど)を使って独自のカスタムLBサービスを実装し、Rancherのメタデータサービスと統合して、コンテナがLBに登録することをリクエストするタイミングを判断できるようになりました。
* __改善 [Storage Support](http://docs.rancher.com/rancher/v1.2/en/rancher-services/storage-service/)__ - カスタムk8sのflexvolumeとDockerボリュームプラグインのライフサイクル、配布、および更新管理を管理する機能が追加されました。
  * CattleでNFSボリュームプラグインがサポートされました。 _**1.2からRancherNFSはNFS Dockerプラグインソリューションをサポートするようになります。Convoy-NFSは1.2からオプションとして利用できなくなり、1.3以上では利用できなくなります。**_
  * _**[実験的機能]**_ EC2のEBSとAWS EFSがサポートされました。
* __認証サポートの改善 [[[#5265](https://github.com/rancher/rancher/issues/5265)]]__ - 認証のフレームワークをリライトすることでRancherに新しい認証・認可サービスを加えるためのより高い柔軟性を実現しました。
  * Shibboleth v3がRancherにおけるSAML 2.0サポートの認証プロバイダとしてくわえられました。
* __全体的なパフォーマンス/スケーラビリティの改善__ - Rancherにおけるパフォーマンスとスケーラビリティを改善するために様々な機能強化が行なわれました。
  * インフラストラクチャビューのUIがより環境あたりより多くのホストとコンテナを表示できるよう変更されました。
  * スケジューリングの改善と、コンテナの並列起動を実現することでコンテナのデプロイ性能を改善しました。
* __[Rancher CLI][#5265](https://github.com/rancher/rancher/issues/5265)__ - Rancherは下に示す機能をサポートしたRancher CLIが同梱されています。
  * 管理ホストに対するネイティブなDocker CLI操作のサポート
  * 環境管理
  * スタック管理
  * サービス管理
  * ホスト管理
  * 管理ホストに対するSSHアクセス
* __リソーススケジューリング__ - CattleではCPUとメモリのリソース制約に応じてコンテナ配置のスケジューリングをサポートしていました。管理者も同様にホストあたりのCPU/メモリのリソース制限を設定することができるようになりました。
* __[環境テンプレート](http://docs.rancher.com/rancher/v1.2/en/environments/#what-is-an-environment-template)__ - Rancehrではユーザが必要なインフラストラクチャサービス(LBやネットワークなど)を記述したテンプレートを作成できるようになりました。また、このテンプレートに基づいた環境の立ち上げをサポートするようになりました。
  * Rancherではユーザが環境を立ち上げ、利用することができるようデフォルトのテンプレートを継続して提供しています。
  * 環境テンプレートの作成と管理をユーザが行えるようになりました。環境テンプレートでは、環境の作成に先立ってデプロイするインフラストラクチャサービスを記述することができます。
  * ユーザはRancherによって、コミュニティに提供されたサービスおよび地震で作成したサービスの両方を活用することができるようになりました。
* __HAサポートの改善(http://docs.rancher.com/rancher/v1.2/en/installing-rancher/installing-server/#launching-rancher-server---full-activeactive-ha)__ - Rancher HAの設定と管理が劇的にシンプルになりました。 複数ノードへのRancherのデプロイに際して、RedisとZookeeperが不要になりました。
* __さらに...__
  * Rancherのデプロイにおいて利用可能なDocker Registryのみを含んだホワイトリストの作成を管理者権限を用いてできるようになりました。
  * イメージにprefixがなかった場合に利用するデフォルトのDockerレジストリをadminが指定できるようになりました。
  * カタログのポートおよびラベルへのバインディングが可能になりました。
  * gitブランチを取り扱うためのカタログサポートがくわえられました。
  * Rancher AgentをGo言語でリライトしました。
  * Docker Machineがアップデートされ、新しくアップデートされたUIとともにAzureが新しいホストドライバに加えられました。
  * RancherOS 0.6.0以降がサポートされました。
  * サービスが適切に起動しなかった際、ユーザにより良いロギングを提供することを目的として、サービスログのジャーナリング機能を追加しました。
