# Rancher JP Site Project

## 利用レイアウト

[Beautiful Hugo](https://themes.gohugo.io/themes/beautifulhugo/)

## ローカル実行

hugo v0.148 or later

```bash
go mod tidy
hugo server -D --disableFastRender --gc --cleanDestinationDir
```

## スライドの追加

SlideShare、Docswellにアップロードされたスライドは下記手順でコンテンツに追加してください。

### スライド一覧に追加

以下ファイルを作成すると自動でスライド一覧に追加されます。

#### ファイルを作成

```bash
docs/content/slide/<YYYYMMDD>/<スライド名>.md
```

#### ファイル内のフロントマターに日付、タイトル、スライドのURLを指定

```
---
date: "2025-08-26"
title: "サポートエンジニアから見たRancher運用の現場"
slug: "slide"
slide_url: "https://speakerdeck.com/player/795d4990babf44bfb6c35e7c44d43980?slide=1"
---
```

SlideのURL配下の手順で取得

- Docswell
  - スライドページを開く
  - 右下の埋め込むの書かれたコードのdata-srcに書かれたURLを取得
- SlideShare
  - スライドページを開く
  - スライド右下の共有リンクボタンを押下
  - Embed、This slideを選択し、「copy iframe embed code」を押下
  - コピーしたURLをテキストエディタなどに張り付け、srcに書かれたURLを取得

## イベントページ追加

### ファイルを作成

```bash
docs/content/events/<YYYYMMDD>_meetup.md
```

### ファイル内のフロントマターに日付、タイトル、説明文、Youtubeおよびサムネイル画像のURLを指定

```
---
title: "RancherJP Online Meetup #07"
date: 2025-08-28T14:00:00Z
draft: false
description: "今回の RancherJP Online Meetup #07 は 「Rancher v2.12 リリース情報 + Rancherの仕組み」と「Rancher Prime の現場から見る運用 Tips」の２テーマをじっくり掘り下げます。"
youtube_url: "https://www.youtube.com/embed/I4kfajUDXK8?i=__LwhvWOVmfMvhey" 
thumbnail: "http://img.youtube.com/vi/I4kfajUDXK8/mqdefault.jpg"
---
```

### 本文作成

マークダウンで本文の作成をします。

#### スライドの埋め込み

importmd でパスを指定することでスライドの埋め込みが可能です。

```bash
{{< importmd path="slide/20250826/rancher_support.md" >}}
```

#### Youtubeの埋め込み

フロントマターにyoutube_urlを指定しておくと本文下部にYoutubeが埋め込まれます。

## トップ画面に最新情報の表示

### ファイルを作成

```bash
post/<YYYYMMDD>_<任意の名前>/index.md
```

### フロントマター

title、date、authorsなどを入力

```markdown
---
title: "RancherJP Online Meetup"
date: 2025-08-26
draft: false
categories: ["event"]
tags: ["event","meetup"]
keywords: ["RancherJP Online Meetup"]
authors: ["Katsuhiro Yamanaka"]
---
```

### 本文作成

マークダウンで本文の作成をします。

### サムネイル画像

マークダウンの本文の最初に下記のように画像リンクを埋め込むことでトップ画面にサムネイル画像が表示されます。（詳細ページの最初にも画像表示されます。）

```markdown
![meetup](meetup.png)
{ .img-fluid .mb-5}
```

画像はindex.mdと同じ場所に配置しておく
