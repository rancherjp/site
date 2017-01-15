# Rancher JP Site Project
---

## ショートコード
+ 写真(images)  
    `{{<images "<ファイル名>" "<写真のキャプション>">}}`

    + ファイル名
        画像ファイルを `/static/images/<年>/<月>/<日>/<ファイル名>.jpg` などで配置してください
    + 写真のキャプション
        何らかの原因で画像が表示出来なかった時に表示される文字例になります。  
        **できるだけ入力をお願いします**  
    + sample:
        ```
        {{<images "20161007_184910.jpg" "頂いたTシャツ">}}
        ```
+ slideshare(slideshare)  
    ```
    {{<slideshare "<Key_ID>" "<SlideShare_URL>" "<Slide_Title>" "<Slide_Author>">}}
    ```
    + 各種値取得方法
        これらに使用される値は、SlideShareのHTML埋め込みコードをHUGOのショートコードで呼び出しています。  
        その為、SlideShareの埋め込みコードより値を取得する必要があります。
        ```
        <iframe
            src="//www.slideshare.net/slideshow/embed_code/key/EzoHfmhyHBiTug"
            width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"
            style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;"
            allowfullscreen>
        </iframe>
        <div style="margin-bottom:5px">
        <strong>
            <a href="//www.slideshare.net/ssuser7faad1/hugo-70078484"
                title="“hugo” 使ってコミュニティサイトを構築してみた"
                target="_blank">“hugo” 使ってコミュニティサイトを構築してみた
            </a>
        </strong> from 
            <strong>
                <a target="_blank" href="//www.slideshare.net/ssuser7faad1">Naoki Aoyama</a>
            </strong>
        </div>
        ```
    + sample:
        ```
        {{<slideshare "EzoHfmhyHBiTug" "ssuser7faad1/hugo-70078484" "“hugo” 使ってコミュニティサイトを構築してみた" "Naoki Aoyama">}}
        ```
    + Key_ID
        スライド埋め込み用に発行されるコードです。  
        sample: `EzoHfmhyHBiTug`
    + SlideShare_URL  
        スライド本体のURLです。
        sample: `ssuser7faad1/hugo-70078484`
    + Slide_Title  
        スライドのタイトルです。  
        sample: `“hugo” 使ってコミュニティサイトを構築してみた`
    + Slide_Author
        スライドのオーナーです。  
        sample: `Naoki Aoyama`

        ```
+ docs.com(docscom)  
    ```
    {{<docscom "<Docs_URL>" "<Docs_Title>" "<Docs_Author_URL>" "<Docs_Author>" "<Docs_Embed_ID>" >}}
    ```

    + sample
    ```
    {{<docscom "https://docs.com/user722542/9000/rancher-meetup-2-hugo" "Rancher Meetup #2 hugo" "user722542" "青山 尚暉" "D25191802-4559-7794-5110-000460023674%7eMe70c81fe-3000-f9ae-fb6d-f9f2239e63d5" >}}
    ```

    + Docs_URL
        https://docs.com/ `user722542/9000/rancher-meetup-2-hugo`

    + Docs_Title
        `Rancher Meetup #2 hugo`

    + Docs_Author_ID
        https://docs.com/ `user722542`

    + Docs_Author
        `Naoki Aoyama`
        
    + Docs_Embed_ID
        https://docs.com/d/embed/ `D25191802-4559-7794-5110-000460023674%7eMe70c81fe-3000-f9ae-fb6d-f9f2239e63d5`




## CircleCI 設定
| Variable name | Variable | (Ex: |
|:--------------|:---------|:-----|
| GITHUB_USERNAME | User name of Github | CircleCI
| GITHUB_EMAIL_ADDRESS | Github email address | circleci@exsample.com |
| GITHUB_BRANCH | Github's branch | master |

## Disable CircleCI 

sample:
```
git commit -m "[ci skip] publish"
```