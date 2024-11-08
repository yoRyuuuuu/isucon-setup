## Ansible
### ツールのインストール
```sh
ansible-playbook -i hosts.yml playbook/install_tools.yml --verbose
```

### ベンチマーク準備

```sh
ansible-playbook -i hosts.yml playbook/before_bench.yml  --verbose
```

### アプリケーションを最適化する流れ
1. GitHubからソースコードをPullする
2. アプリケーションのビルド、ミドルウェア設定ファイルの反映、再起動、ログファイルの削除を行う
3. ベンチマーク実行をする
4. ログファイルを解析し、ボトルネックを見つける
5. ソースコード、設定ファイルの変更などで、ボトルネックを解消する
6. パフォーマンス改善に効果があれば、mainブランチに変更を取り込む

### 最初にやること
- Git管理するファイルをGitHubにプッシュする
  - アプリケーションサーバーのソースコード
  - テーブル定義のSQLファイル
  - NGINX、MySQLなどの設定ファイル
- アプリケーションサーバーをGoの実装に切り替える。問題ごとに方法が異なるため、当日マニュアルを参考すること。
```
# private-isuの切り替えコマンド
$ sudo systemctl stop isu-ruby
$ sudo systemctl disable isu-ruby
$ sudo systemctl start isu-go
$ sudo systemctl enable isu-go
```

### 問題サーバーでのGitHubログイン
以下のコマンドを実行し、ローカルPCのブラウザで認証を行う。
```
$ gh auth login
? Where do you use GitHub? GitHub.com
? What is your preferred protocol for Git operations on this host? SSH
? Generate a new SSH key to add to your GitHub account? No
? How would you like to authenticate GitHub CLI? Login with a web browser
```
###

### private-isuの起動準備
そのままではアプリケーションを実行できないため、`~/private_isu`で次のコマンドを実行する
```
# NOTE: これやる必要ないかもしれない
mkdir -p webapp/sql
mv ../backup/mysqldump.sql.bz2 webapp/sql
make init
```
