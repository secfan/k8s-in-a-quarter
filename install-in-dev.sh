# 主机云测试环境自动化安装脚本

sealos init --master 192.168.117.57 \
    --version v1.17.17 \
    --pkg-url ~/vagrant/k8s-with-sealos/k8s/kube1.17.17.tar.gz
echo "完成k8s master安装。"

sealos join --node 192.168.117.58
sealos join --node 192.168.117.59
echo "完成k8s nodes安装。"

sealos install --pkg-url  ~/vagrant/k8s-with-sealos/k8s/dashboard.tar
echo "完成k8s dashboard安装。"


kubectl get secret -nkubernetes-dashboard \
		$(kubectl get secret -n kubernetes-dashboard|grep dashboard-token |awk '{print $1}') \
		-o jsonpath='{.data.token}'  | base64 --decode
echo "完成获取kubectl token。"