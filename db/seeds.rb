# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
user = User.new(username: 'Yamada', email: 'yamada@qiitan.com', password: 'password', super_admin: true)
user.skip_confirmation!
user.save!

user2 = User.new(username: 'Takada', email: 'takada@qiitan.com', password: 'password')
user2.skip_confirmation!
user2.save!

# Article
body = <<~EOS
  # はじめに
  1対多で関連するデータを1つのフォーム画面にしたい時、 みなさんはどのようなコードを書きますか？
  僕は [nested_form](https://github.com/ryanb/nested_form) を使うことが多いです。
  しかし会社の同僚に [cocoon](https://github.com/nathanvda/cocoon)  でも同じことができますよー。
  しかも最終コミットが nested_form が2013年12月に対して cocoon が2016年1月で新しいですよ、と。
  (**※2016年2月時点**)
  それは気になる！！
  ということで調査してみたので nested_form との簡単な比較と導入例をこの記事に書いていきます。
  また、ここでは nested_form については導入方法や詳しい説明は省きます。
  
  # nested_form との比較
  
  ## ダウンロード数
  今まで聞いたことのない名前だったのでまずは知名度がどうなのかダウンロード数を調べました。
  gemのランキングやダウンロード数が見れる[BestGems](http://bestgems.org/)で比較してみました。
  nested_form -> 2,011,028(497位)
  cocoon -> 767,998(913位)
  
  ![Search_--_BestGems.png](https://qiita-image-store.s3.amazonaws.com/0/41362/df1b3dbc-80a0-662d-8abe-1cca55c0cd51.png "Search_--_BestGems.png")
  
  nested_form の圧勝です。
  3倍近い差がありますね。。
  それでも約77万なので多く使われていることがわかりました。
  
  ## GitHubのstar数
  GitHubでのstar数を見てみました。
  
  nested_form -> 1649
  cocoon -> 1863
  
  こちらは cocoon が若干上回っていますね！
  
  
  ## stack overflowで検索
  続いて`gem nested_form` 、`gem cocoon` でそれぞれ検索してヒット数を見ました。
  
  nested_form -> 384
  cocoon -> 356
  
  ほぼ同じですね。
  
  
  ## Qiitaで検索
  次にQiitaの記事としてはどうか検索してみました。
  
  nested_form -> 3906
  cocoon -> 0!!!
  
  なんと cocoon は0という結果になりました。
  知名度は低いようです。
  
  
  まとめると世界的には知名度もあって使われているが日本ではほぼ使われていないだろうということがわかりました。
  
  ## 機能
  ではその差は何か。
  次に機能についてREADMEを読んで調べました。
  
  
  結果、大きく見ると全く一緒でした・・。
  両方とも以下のように主に3つのことができます。
  
  - 子レコードのフォームを追加するヘルパーメソッドの追加
  - 子レコードのフォームを削除するヘルパーメソッドの追加
  - javascriptで子レコードの追加や削除時のイベントのフック
  
  cocoon のREADMEの方が細かいオプションやフックできるイベントの数が丁寧に書かれているので柔軟性は cocoon の方が高そうです。
  
  # 導入例
  機能に差がないなら導入の仕方が難しいのでしょうか？
  実際に導入してみたので導入方法を以下に書いていきます。
  
  また nested_form 利用時でもコントローラーやモデルの書き方は同じになります。
  
  ## サンプルアプリケーションの概要
  1対多のデータを保管するフォームを作成する。
  
  下記のようにscaffold機能を使って雛形を作成したところから進めました。
  
  ```
  rails genereate scaffold Project
  ```
  
  
  ## Gemfile
  Gemfile に以下のコードを追加します。
  
  ```
  gem 'cocoon'
  ```
  
  ## application.js
  application.js に以下のコードを追加します。
  
  ```js
  //= require cocoon
  ```
  
  ## モデル
  モデルのコードは以下の通りです。
  ProjectとTaskが1対多の関係となっています。
  
  ```ruby
  # project.rb
  class Project < ActiveRecord::Base
    has_many :tasks, dependent: :destroy, inverse_of: :project
    accepts_nested_attributes_for :tasks, allow_destroy: true
  
    validates :name, presence: true
  end
  ```
  
  ```ruby
  # task.rb
  class Task < ActiveRecord::Base
    belongs_to :project
  
    validates :name, presence: true
  end
  ```
  
  
  
  ## コントローラー
  scaffold でCRUDのアクションが作られますが、以下のように子レコードのパラメータを受け取れるようにする必要があります。
  
  ```ruby
  # projects_controller.rb
  def project_params
    params.require(:project).permit(:name, tasks_attributes: [:id, :name, :_destroy])
  end
  ```
  
  
  ## ビュー
  今回は[simple_form](https://github.com/plataformatec/simple_form) と [haml](https://github.com/haml/haml) で書きました。
  [Formtastic](https://github.com/justinfrench/formtastic) やフォームビルダーのgemを利用しなくても実装することができるようです。
  
  書いたコードは以下の通りです。
  `link_to_add_association` メソッドを使うことでタスク追加を動的にできるようになります。 
  
  
  ```html
  <!-- _form.html.haml -->
  = simple_form_for(@project) do |f|
    - if @project.errors.any?
      #error_explanation
        %h2
          = pluralize(@project.errors.count, "error")
          prohibited this project from being saved:
        %ul
          - @project.errors.full_messages.each do |message|
            %li= message
    .js-project
      .field
        = f.input :name
      .field
        %h2 タスク
        = f.simple_fields_for :tasks do |task|
          = render 'task_fields', f: task
          %br
          %br
      .field
        = link_to_add_association 'タスク追加', f, :tasks
    .actions
      = f.submit '登録'
  ```
  
  `link_to_remove_association ` メソッドを使うことでタスク削除を動的にできるようになります。 
  
  ```html
  <!-- _task_fields.html.haml -->
  .nested-fields.field
    = f.input :name
    = link_to_remove_association 'タスク削除', f
  ```
  
  
  ## イベントのフック
  イベントのフックは以下の通りです。
  CoffeeScriptで書いています。
  タスク追加リンクを押下時のフォーム追加前後と
  タスク削除リンクを押下時のフォーム削除前後のタイミングでフックさせています。
  
  ```javascript
  // projects.coffee
    $('.js-project')
      .on 'cocoon:before-insert', (e, task_to_be_added) ->
        console.log('before insert')
        task_to_be_added.fadeIn('slow')
      .on 'cocoon:after-insert', (e, added_task) ->
        console.log('after insert')
        added_task.css("background","red")
      .on 'cocoon:before-remove', (e, task_to_be_removed) ->
        console.log('before remove')
        task_to_be_removed.fadeOut('slow')
      .on 'cocoon:after-remove', (e, removed_task) ->
        console.log('after remove')
  ```
  
  
  ## フォーム
  ブラウザで表示したフォームは以下の通り。
  フォーム内でタスクの追加や削除が行えます。
  
  ![CocoonSample.png](https://qiita-image-store.s3.amazonaws.com/0/41362/09dc0b29-f333-1e1a-69df-3d7f2bd55ee4.png "CocoonSample.png")
  
  
  ここまでが導入方法です。
  こちらも、nested_form とほとんど変わらないですね。。
  
  
  
  # 結論
  調査結果としては知名度は日本では全然ないようだが主な機能や導入方法まで nested_form とほとんど変わらない。
  細かいオプションまで見ていくと当然できることに違いはあるが基本的には同じ。
  
  他の人に nested_form の良さは何か？を聞いてみると新たな発見があるかも知れません。
  自分の場合は他の人が使っているから。と最初に使ったのが nested_form だから。
  くらいしか理由がないです。
  
  であれば、もしかしたらこのまま nested_form のコードが更新されなければ今後 cocoon がメジャーになってくるのかも!?と思いました。
  
  # 参考サイト
  [1対多の関連を持つオブジェクトを編集可能なフォーム](http://rails.densan-labs.net/form/relation_register_form.html)

EOS
user.articles.create!(title: 'nested_form はもう古い！？ Cocoon で作る1対多のフォーム', body: body)
user.articles.create!(title: '記事タイトル2', body: 'ここに本文が入ります。')
user2.articles.create!(title: '記事タイトル3', body: 'ここに本文が入ります。')