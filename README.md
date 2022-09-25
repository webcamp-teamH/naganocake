# :birthday:ながのCAKE
長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト

## :thought_balloon:背景
元々近隣住民が顧客だったが、昨年始めたInstagramから人気となり、全国から注文がくるようになった。  
InstagramのDMやメールで通販の注文を受けていたが、情報管理が煩雑になってきたため、管理機能を含んだ通販サイトを開設しようと思い至った。

## :gem:開発環境
**Ruby on Rails**

## :wrench:インストール手順
```
  $ git clone https://github.com/webcamp-teamH/naganocake.git
  $ cd nagano_cake
  $ bundle install
  $ rails db:migrate
  $ rails db:seed
  $ rails s
```
* :bust_in_silhouette:管理者ログイン：～/admin/sign_in
* :envelope:メールアドレス：test@test.com
* :key:パスワード：111111

## :closed_book:設計書
### :memo:ER図
![ER図](https://user-images.githubusercontent.com/108283848/192127116-51b79564-b431-47e6-8312-23436aaba74f.png)

### :memo:顧客側側ルーティング
![顧客側側](https://user-images.githubusercontent.com/108283848/192127148-e51490b1-d52b-4840-97d7-fc967f85f95a.png)

### :memo:管理者側ルーティング
![管理者側](https://user-images.githubusercontent.com/108283848/192127186-ffa1009a-3470-445d-8c91-08459464f80d.png)


## 開発者
### チーム名
ひよこくらぶ

### メンバー
* がんちゃん
* むらちゃん
* すぎちゃん
* みーさん
