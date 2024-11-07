## Ansible
### ツールのインストール
```sh
ansible-playbook -i hosts.yml playbook/install_tools.yml --verbose
```

### ベンチマーク準備
```sh
ansible-playbook -i hosts.yml playbook/before_bench.yml --verbose
```

### フロー
1. GitHubからソースコードをPullする
2. アプリケーションのビルド、ミドルウェア設定ファイルの反映、再起動、ログファイルの削除を行う
3. ベンチマーク実行をする
4. ログファイルを解析し、ボトルネックを見つける
