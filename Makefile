INSUTANCE1_IP:=XXX.XXX.XXX.XXX
INSUTANCE2_IP:=XXX.XXX.XXX.XXX
INSUTANCE3_IP:=XXX.XXX.XXX.XXX
BENCHMARKER_IP:=XXX.XXX.XXX.XXX

.PHONY: before_bench
before_bench:
	ANSIBLE_HOST_KEY_CHECKING=False \
		ansible-playbook -i ansible/hosts.yml ansible/playbook/before_bench.yml  --verbose

.PHONY: install_tools
install_tools:
	ANSIBLE_HOST_KEY_CHECKING=False \
		ansible-playbook -i ansible/hosts.yml ansible/playbook/install_tools.yml  --verbose

.PHONY: ssh_config
ssh_config:
	# TODO: コンテスト終了時に追加されたSSH設定を削除する
	echo "Host isucon1\n	HostName $(INSUTANCE1_IP)\n	User pi\n	ServerAliveInterval 120\n	TCPKeepAlive yes\n" >> ~/.ssh/config
	echo "Host isucon2\n	HostName $(INSUTANCE2_IP)\n	User isucon\n	ServerAliveInterval 120\n	TCPKeepAlive yes\n" >> ~/.ssh/config
	echo "Host isucon3\n	HostName $(INSUTANCE3_IP)\n	User isucon\n	ServerAliveInterval 120\n	TCPKeepAlive yes\n" >> ~/.ssh/config
	echo "Host bench\n	HostName $(BENCHMARKER_IP)\n	User isucon\n	ServerAliveInterval 120\n	TCPKeepAlive yes\n" >> ~/.ssh/config

# TODO: ベンチマーカーを実行するコマンドを記述する(Optional)
# 以下の例は、private-isuのベンチマーカーを実行するコマンドです。
# .PHONY: bench
# bench:
# 	ssh isucon@bench \
# 		/home/isucon/private_isu.git/benchmarker/bin/benchmarker -u /home/isucon/private_isu.git/benchmarker/userdata -t http://$(INSUTANCE1_IP)
