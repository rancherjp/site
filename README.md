# Rancher JP Site Project

## ローカル実行

```bash
hugo server -D --disableFastRender --gc --cleanDestinationDir --source docs
```

## スライドの追加

XXXXにアップロードされたスライドは下記手順でコンテンツに追加してください。

### スライド一覧に追加

以下ファイルを作成すると自動でスライド一覧に追加されます。

#### ファイルを作成

```bash
docs/content/slide/<YYYYMMDD>/<スライド名>.md
```

#### ファイル内のXXXに日付、タイトル、スライドのURLを指定

```
---
date: "2025-08-26"
title: "サポートエンジニアから見たRancher運用の現場"
slug: "slide"
slide_url: "https://speakerdeck.com/player/795d4990babf44bfb6c35e7c44d43980?slide=1"
---
```

## イベントページ追加

### ファイルを作成

```bash
docs/content/events/<YYYYMMDD>/<スライド名>.md
```

### ファイル内のXXXに日付、タイトル、説明文、Youtubeおよびサムネイル画像のURLを指定

```
---
title: "RancherJP Online Meetup #07"
date: 2025-08-28T14:00:00Z
draft: false
description: "今回の RancherJP Online Meetup #07 は 「Rancher v2.12 リリース情報 + Rancherの仕組み」と「Rancher Prime の現場から見る運用 Tips」の２テーマをじっくり掘り下げます。"
youtube_url: "https://www.youtube.com/embed/I4kfajUDXK8?i=__LwhvWOVmfMvhey" 
youtube_thumbnail: "https://i.ytimg.com/vi/I4kfajUDXK8/hqdefault.jpg?sqp=-oaymwEnCNACELwBSFryq4qpAxkIARUAAIhCGAHYAQHiAQoIGBACGAY4AUAB&rs=AOn4CLCQs7k_lJy3VKUfcXF7PxIdSxmazg"
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