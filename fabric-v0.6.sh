docker ps -aq |xargs docker rm -f
docker images | xargs docker rmi -f
sleep 2

echo "清理掉系統內舊的images及容器中的舊的虛擬機程序"

echo "接著我們將要去下載docker所需要的印像檔，這個動作我們稱之為Pull images "
sleep 2 
sudo docker pull hyperledger/fabric-peer:x86_64-0.6.1-preview
sudo docker tag hyperledger/fabric-peer:x86_64-0.6.1-preview hyperledger/fabric-peer:latest
sudo docker tag hyperledger/fabric-peer:x86_64-0.6.1-preview hyperledger/fabric-baseimage:latest

echo "映像檔下載完成"
sleep 3

echo "接著準備利用docker將虛擬機運行起來，這次的實作情境是模擬一個四個節點的聯盟鏈，並在區塊鏈上運行一個智能合約是維護兩方之間的資產往來的紀錄"

sleep 4

echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝開始運行第一個節點＝＝＝＝＝＝＝＝＝＝＝＝"
sudo docker run -d --name=vp0 \
    -p 7050:7050 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e CORE_VM_ENDPOINT=unix:///var/run/docker.sock \
    -e CORE_LOGGING_LEVEL=debug \
    -e CORE_PEER_ID=vp0 \
    -e CORE_PEER_NETWORKID=dev \
    -e CORE_PEER_VALIDATOR_CONSENSUS_PLUGIN=pbft \
    -e CORE_PEER_ADDRESSAUTODETECT=true \
    -e CORE_PBFT_GENERAL_N=4 \
    -e CORE_PBFT_GENERAL_MODE=batch \
    -e CORE_PBFT_GENERAL_TIMEOUT_REQUEST=10s \
    --rm hyperledger/fabric-peer:latest peer node start
echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝第一個節點vp0運行起來了＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
sleep  6
echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝開始運行第二個節點＝＝＝＝＝＝＝＝＝＝＝＝"
sudo docker run -d --name=vp1 \
    -p 8050:7050 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e CORE_VM_ENDPOINT=unix:///var/run/docker.sock \
    -e CORE_LOGGING_LEVEL=info \
    -e CORE_PEER_ID=vp1 \
    -e CORE_PEER_NETWORKID=dev \
    -e CORE_PEER_VALIDATOR_CONSENSUS_PLUGIN=pbft \
    -e CORE_PEER_ADDRESSAUTODETECT=true \
    -e CORE_PBFT_GENERAL_N=4 \
    -e CORE_PBFT_GENERAL_MODE=batch \
    -e CORE_PBFT_GENERAL_TIMEOUT_REQUEST=10s \
    -e CORE_PEER_DISCOVERY_ROOTNODE=172.17.0.2:7051 \
    --rm hyperledger/fabric-peer:latest peer node start
echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝第二個節點vp1運行起來了＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
sleep 6

echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝開始運行第三個節點＝＝＝＝＝＝＝＝＝＝＝＝"

sudo docker run -d --name=vp2 \
    -p 9050:7050 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e CORE_VM_ENDPOINT=unix:///var/run/docker.sock \
    -e CORE_LOGGING_LEVEL=info \
    -e CORE_PEER_ID=vp2 \
    -e CORE_PEER_NETWORKID=dev \
    -e CORE_PEER_VALIDATOR_CONSENSUS_PLUGIN=pbft \
    -e CORE_PEER_ADDRESSAUTODETECT=true \
    -e CORE_PBFT_GENERAL_N=4 \
    -e CORE_PBFT_GENERAL_MODE=batch \
    -e CORE_PBFT_GENERAL_TIMEOUT_REQUEST=10s \
    -e CORE_PEER_DISCOVERY_ROOTNODE=172.17.0.2:7051 \
    --rm hyperledger/fabric-peer:latest peer node start

echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝第三個節點vp2運行起來了＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"

sleep 6
echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝開始運行第四個節點＝＝＝＝＝＝＝＝＝＝＝＝"
sudo docker run -d --name=vp3 \
    -p 10050:7050 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e CORE_VM_ENDPOINT=unix:///var/run/docker.sock \
    -e CORE_LOGGING_LEVEL=info \
    -e CORE_PEER_ID=vp3 \
    -e CORE_PEER_NETWORKID=dev \
    -e CORE_PEER_VALIDATOR_CONSENSUS_PLUGIN=pbft \
    -e CORE_PEER_ADDRESSAUTODETECT=true \
    -e CORE_PBFT_GENERAL_N=4 \
    -e CORE_PBFT_GENERAL_MODE=batch \
    -e CORE_PBFT_GENERAL_TIMEOUT_REQUEST=10s \
    -e CORE_PEER_DISCOVERY_ROOTNODE=172.17.0.2:7051 \
    --rm hyperledger/fabric-peer:latest peer node start
echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝第四個節點vp3運行起來了＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
sleep 3
echo "利用docker ps指令 列出以下運行中的虛擬機程序，總共有四個程序"
echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
docker ps
sleep 2
echo "利用docker images 可以觀察到我們目前有幾個映像檔，以下是輸出結果"
echo "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
docker images
