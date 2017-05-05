---
date: "2017-05-05"
title: "リリース v1.6.0"
slug: "v1.6.0"
author: "Rancher JP"
description: "リリース v1.6.0"
draft: false
tags:
  - "releasenote"
categories:
  - "releasenote"
archives:
  - "2017"
  - "2017/05"
---

# リリース v1.6.0

## バージョン
- rancher/server:v1.6.0
- rancher/agent:v1.2.2
- rancher/lb-service-proxy:v0.7.1
- rancher-v0.6.0
- rancher-compose-v0.12.5

## 対応しているDockerのバージョン

- Docker 1.10.3
- Docker 1.12.3-1.12.6 
- Docker 1.13.1 (Kubenetesのサポートなし)
- Docker 17.03.0-ce(Kubenetesのサポートなし)
- Docker 17.03.0-ee(Kubenetesのサポートなし)


## Rancherサーバーのタグについて

Rancherサーバーには2種類のタグがあります。
いずれのメジャーリリースタグにおいても、個々のバージョンに向けたドキュメントを提供します。

- `rancher/server:latestタグ` 最新の開発中ビルドを提供するタグです。これらのビルドはCIの自動化フレームワークを使って検証済みです。これらのリリースは本番環境へのデプロイを意味していません。
- `rancher/server:stableタグ` 最新のリリースビルドのタグです。本番環境にデプロイする際は本タグを利用することを推奨します。

`rc{n}`サフィックスのついたリリースを使わないようにしてください。これらの`rc`ビルドはRancherチームがテストを行うためのものです。

### Beta - v1.6.0 - `rancher/server:latest`
### Stable - v1.5.9 - `rancher/server:stable`

## 追加機能

- **HAProxyにおけるデータボリュームを経由したSSL証明書の読み込みサポート[[#7520](https://github.com/rancher/rancher/issues/7520)]** - Rancherで本バージョンからSSL証明書を含んだデータボリュームをHAProxyのLBサービスに設定できるようになりました。
これによって定常的にが変更される証明書をHAProxyにアップロードすることへの代替手段が提供されました。
また、複数の証明書設定をHAProxyのLBサービスでサポートすることが可能になりました。
- **LDAP/ADにおける複数のグループに基づく検索のサポート[[#8157](https://github.com/rancher/rancher/issues/8157)][[#8112](https://github.com/rancher/rancher/issues/8122)]** - 異なる検索ベース(search bases)を経由したユーザ、グループの検索できるようLDAPを設定することができるようになりました。
- **Rancher EBSボリュームのサポート[[#8295](https://github.com/rancher/rancher/issues/8295)], [[#8618](https://github.com/rancher/rancher/issues/8618)], [[#7599](https://github.com/rancher/rancher/issues/7599)]** - Rancher EBSボリュームがGAになりました。同一のアベイラビリティゾーンに所属するホストにコンテナが移動されるようにアベイラビリティゾーンを意識できるようRancherのスケジューラ機能が強化されました。EBSは各種ボリュームタイプやIOPS指定有無(*訳注:原文中ではIOSとなっているがIOPSのtypoと思われます*)、暗号化の有無やksmkeyIdやスナップショットIDなどの追加オプションを用いた場合でも利用することが可能です。
- **Rancher secretのcomposeにおけるサポート[[#8016](https://github.com/rancher/rancher/issues/8016)],[[#8025](https://github.com/rancher/rancher/issues/8025)]** - Rancher CLIでcomposeファイルを用いたsecretsの生成が可能になりました。過去のバージョンのrancher-compose CLIには本機能は存在しないことに留意してください。全ての新しい機能は新しいRancher CLIツールでしか開発されず、過去のバージョンのRancher CLIへの取り込みは行われません。


## 既知の主要なバグ
特にありません。

## v1.5.9からの主要なバグの修正
- Fixed an issue where k8s certs were stale and causing k8s addons such as Dashboard UI to fail to launch [[#8613](https://github.com/rancher/rancher/issues/8613)]
- Rancher now supports k8s daemon sets on hosts dedicated to orchestration and etcd [[#8397](https://github.com/rancher/rancher/issues/8397)]
- Fixed an issue where large labels on stateful sets would cause k8s would cause Rancher DB to throw exceptions [[#8168](https://github.com/rancher/rancher/issues/8168)]
- Fixed an issue where Centos 7.3 networking was not working [[#6111](https://github.com/rancher/rancher/issues/6111)], [[#8496](https://github.com/rancher/rancher/issues/8496)]
- Rancher now supports the ability to have SELinux enabled hosts for cattle and k8s with some [additional kernel modules](http://docs.rancher.com/rancher/v1.6/en/installing-rancher/selinux/) [[#8071](https://github.com/rancher/rancher/issues/8071)]
- Fixed an issue with LDAP/AD or OpenLDAP would no longer function if Rancher loses connection with the AD server [[#8513](https://github.com/rancher/rancher/issues/8513)], [[#8270](https://github.com/rancher/rancher/issues/8270)]
- Fixed an issue where alpine linux containers does not work with internal DNS on k8s [[#8588](https://github.com/rancher/rancher/issues/8588)]
- Fixed an issue where services/containers are not properly failing over if all hosts become disconnected and new ones are added [[#8416](https://github.com/rancher/rancher/issues/8416)]
- Fixed an issue where SSL certs in HAProxy were not being properly cleaned up [[#8161](https://github.com/rancher/rancher/issues/8161)]
- Fixed an issue where custom LB backend configurations can corrupt the haproxy config if the backend does not have any servers available [[#8424](https://github.com/rancher/rancher/issues/8424)]
- Rancher now supports self-signed certs for the Route53 external dns service [[#8284](https://github.com/rancher/rancher/issues/8284)]
- Fixed an issue where a race condition during volume creation can cause it to fail. [[#8357](https://github.com/rancher/rancher/issues/8357)]
- Fixed an issue where re-using the same volume name would cause services to fail to launch [[#8607](https://github.com/rancher/rancher/issues/8607)]
- Fixed an issue where rancher-ebs volumes are not created as an empty volume [[#8465](https://github.com/rancher/rancher/issues/8465)]
- Fixed an issue where hard anti-affinity rules are not being honored with sidekicks present [[#8070](https://github.com/rancher/rancher/issues/8070)]
- Fixed an issue where the German language does not work for the delete modals in the UI [[#8489](https://github.com/rancher/rancher/issues/8489)],[[#8113](https://github.com/rancher/rancher/issues/8113)]
- Fixed an issue where the UI would not display the environment management UI if the Community and Rancher catalogs are disabled [[#8461](https://github.com/rancher/rancher/issues/8461)]
- Fixed an issue where the UI would error when switching from the detail page of a lb service to a non-lb service [[#8460](https://github.com/rancher/rancher/issues/8460)]
- Rancher now supports t2.large and t2.2xlarge in the aws add host screen [[#8239](https://github.com/rancher/rancher/issues/8239)]
- Fixed an issue where a bad catalog URL would cause all catalogs to fail to display [[#8030](https://github.com/rancher/rancher/issues/8030)]
- Fixed an issue where Rancher DNS does not properly randomized the list of IP assigned to it [[#7990](https://github.com/rancher/rancher/issues/7990)]
- Rancher now supports Azure in Germany, China, and the US Government [[#7964](https://github.com/rancher/rancher/issues/7964)]
- Fixed an issue where containers created via compose outside of Rancher does not show up as unmanaged containers in Rancher [[#7941](https://github.com/rancher/rancher/issues/7941)],[[#7916](https://github.com/rancher/rancher/issues/7916)]
- Fixed an issue where CPU/Memory resources are not freed up until the containers are purged [[#7933](https://github.com/rancher/rancher/issues/7933)]
- Fixed an issue LDAP can fail due to a NullPointerException [[#7824](https://github.com/rancher/rancher/issues/7824)]
- Fixed an issue where services could be stuck in "stopping" state while others could remain in "running" states when being removed [[#7640](https://github.com/rancher/rancher/issues/7640)]
- Fixed an issue where you can change the scale of global services via the API [[#7630](https://github.com/rancher/rancher/issues/7630)]
- Fixed an issue where jsession tokens are not being invalidated after they timeout or the user explicitly logs out [[#7581](https://github.com/rancher/rancher/issues/7581)]
- Fixed an issue where upgrades of services would fail if you add a new scheduler rule to would force containers to be launched on a different host than original [[#7380](https://github.com/rancher/rancher/issues/7380)]
- Fixed an issue where --pull does not pull the latest image from registry [[#7209](https://github.com/rancher/rancher/issues/7209)]
- Fixed an issue where webproxy does not start if "edns0" or single-request-reopen" are present in resolv.conf [[#6487](https://github.com/rancher/rancher/issues/6487)]
- Rancher now supports the disabling of Custom Host option in Add Host screen in the UI [[#5124](https://github.com/rancher/rancher/issues/5124)]

## [Rancher CLI](http://docs.rancher.com/rancher/v1.6/en/cli/) Downloads

https://github.com/rancher/cli/releases/tag/v0.6.0

## [Rancher-Compose](http://docs.rancher.com/rancher/v1.6/en/cattle/rancher-compose/) Downloads

https://github.com/rancher/rancher-compose/releases/tag/v0.12.5