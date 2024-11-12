.PHONY: before_bench
before_bench:
	ANSIBLE_HOST_KEY_CHECKING=False \
		ansible-playbook -i ansible/hosts.yml ansible/playbook/before_bench.yml  --verbose

.PHONY: install_tools
install_tools:
	ANSIBLE_HOST_KEY_CHECKING=False \
		ansible-playbook -i ansible/hosts.yml ansible/playbook/install_tools.yml  --verbose

# TODO: ベンチマーカーを実行するコマンドを記述する(Optional)
# .PHONY: bench
# bench:
# 	ssh isucon@54.65.128.22 \
# 		/home/isucon/private_isu.git/benchmarker/bin/benchmarker -u /home/isucon/private_isu.git/benchmarker/userdata -t http://52.195.33.162
