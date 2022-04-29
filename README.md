# 【Rails5】AWS S3+CarrierWave+Fog::AWS + Rails Admin を利用して画像アップロード機能を作成する

<a href="https://ty-engineer.com/ruby-on-rails/s3-carrierwave-fog-imageupload/">https://ty-engineer.com/ruby-on-rails/s3-carrierwave-fog-imageupload/</a>

## アプリ側

### ベースとなるアプリケーションを作成する

```
$ rails new ImageUploadApp
```

### Rails Admin を導入

Gemfile

```
gem 'rails_admin', '~> 2.0.0.beta'
```

```
$ bundle install
```

### 画像アップロード対象のモデルを作成する

```
$ rails g model image name:string image:string
```

```
$ rails db:migrate
```

### 対応したコントローラを作成する

```
$ rails g controller api/v1/images
```

### ルーティングを修正する

config/routes.rb

```
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/', as: 'rails_admin' # rails adminをルートURLに指定
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :images, only: %i[index]
    end
  end
end
```

### コントローラ内の記述を埋めていく(get all images)

app/controllers/api/v1/images_controller.rb

```
class Api::V1::ImagesController < ApplicationController
    def index
        images = Live.all.order(created_at: :desc)
        render json: images
    end
end
```

## AWS 側

### 画像アップロード機能を作成する

IAM ユーザの作成

1. AWS コンソールを開いて I AM のページを開く
2. IAM ユーザを作成します

IAM ユーザを作成するときの注意点ですが、Rails アプリケーションからアクセスするためにアクセスキーとシークレットキーによるアクセスを許可する必要があります。よって以下のチェックボックスに必ずチェックを入れましょう。名前は適当で OK。

また、セキュリティの関係上、AWS マネジメントコンソールへのアクセスも IAM ユーザーごとにします。「AWS マネジメントコンソールへのアクセス」にチェックを入れてパスワードを設定します。IAM ユーザー作成後にログインリンク情報が取得できるので次回からはそこからアクセスして下さい。

次のステップでは、アクセス権限の設定をします。この I AM ユーザで S3 を操作するため、S3 へのフルアクセスを可能にしておきます。（ここら辺の設定は様々な組み合わせがあるので、慣れてきたら自分で変えてみるのも良いでしょう。）

タグの設定は任意です。

内容を確認して OK であればユーザーを作成します。

csv のダウンロードのところから、クレデンシャル情報をダウンロードできます。

3. S3 バケットを作成する

IAM ユーザーが作成できたら、画像を保存するサーバーである S3 のバケットの作成を行います。IAM ユーザー作成時と同様に「S3」とサービスを検索するとすぐにアクセスできます。

S3 のバケット名を設定して、後は推奨通り設定し、バケットを作成します。

これで AWS 側の設定は以上です。次は gem の設定をしていきましょう！

## アプリ側

### CarrierWave を使った画像アップロード機能実装

1. gem のインストール

Gemfile

```
gem 'carrierwave'
gem 'fog-aws'
```

2. アップローダを作成する

CarrireWave の Uploader と呼ばれるものを作成します。gem が導入できていれば以下のコマンドで作成可能です。

```
$ rails g uploader Image
```

作成されたアップローダを以下の様に変更します。

app/uploaders/image_uploader.rb

```
class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
     var = :"@#{mounted_as}_secure_token"
     model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
```

2~8 行目では、環境の違いによる画像の保存先の設定をしています。この場合だと test または development 環境では/public 配下に、production 環境だと fog すなわち S3 に保存されます。

3. モデルとアップローダを紐づける

対象のモデルに以下の一行を追加し、アップローダとモデルを紐づけます。

app/models/image.rb

```
class Image < ApplicationRecord
    mount_uploader :image, ImageUploader
end
```

4. CarrierWave の設定

CarrierWave の設定を行います。config/initializers/carrierwave.rb というファイルを自分で作って、以下の設定を記述しましょう。

config/initializers/carrierwave.rb

```
CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = '設定したバケット名'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION'],
      path_style: true
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
```

この設定は、本番環境であれば AWS S3 を利用し、開発及びテスト環境ではローカルに画像を保存する設定です。とりあえずはこれで設定しておきます。

バケット名と書かれている部分は、先ほど作成したバケット名を、環境変数にはそれぞれ各自のものを .env に設定して下さい。環境変数にアクセスできるように、gem ‘dotenv-rails’ を導入して $ bundle install としておきます。

ENV["~~"]という箇所は S ３を作成した際のアクセスキーやシークレットアクセスキーにしたがってサーバー側に登録する。

実際に画像をアップロードして、画像がバケット内に保存されていたら成功です。

## チケット予約時に予約者にメール送信

- 入力されたメールアドレスにメールを送信
  - メール送信元を設定する必要

config/environments/development.rb

```
config.action_mailer.default_options = { from: ENV["EMAIL_ADDRESS"] }
# hostにはデフォルトでlocalhost3000になっているので、Railsのポート番号である3001に変更する。
config.action_mailer.default_url_options = { host: 'localhost:3001' }
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                  587,
  domain:               'gmail.com',
  user_name:            ENV["EMAIL_ADDRESS"],
  password:             ENV["EMAIL_PASSWORD"],
  authentication:       'plain',
  enable_starttls_auto:  true
}
```

Gmail のパスワードを取得

Gmail で２段階認証をオンにし、アプリパスワードを取得する。

https://accounts.google.com/signin/v2/challenge/pwd?continue=https%3A%2F%2Fmyaccount.google.com%2Fapppasswords&service=accountsettings&osid=1&rart=ANgoxccVr9suYl7GzWv-ZjatyHtjXe1QrhYMrXcFNpo0mr31JFPzr_rVIrpf9OlpNrKdD299LUoHkP1NK7-doFdlRwBL0gU8NA&TL=AM3QAYam4TsACWwtCgIK_RPwqjjCCXIMxDUIYi6JxwoTCzGZXOC61mRHG_iOXuxc&flowName=GlifWebSignIn&cid=1&flowEntry=ServiceLogin

![](https://storage.googleapis.com/zenn-user-upload/b937d33dca8b-20220124.png)

取得したパスワードは環境変数に設定するため控えておく。

登録したメールアドレスとパスワードを環境変数に設定 → 本番では Heroku 側
