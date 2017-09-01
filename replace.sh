export LC_ALL=C
sudo find ./ -type f -exec sed -i "s/bitcoin/abccoin/g" {} \;
sudo find ./ -type f -exec sed -i "s/bitcoin/abccoin/g" {} \; 
sudo find ./ -type f -exec sed -i "s/Bitcoin/Abccoin/g" {} \;
sudo find ./ -type f -exec sed -i "s/BTC/ABC/g" {} \;
for file in `find ./`
        do
                newname=`echo $file | sed "s/bitcoin/abccoin/g"`
                mv $file $newname;
        done
for file in `find ./`
        do
                newname=`echo $file | sed "s/Bitcoin/Abccoin/g"`
                mv $file $newname;
        done
for file in `find ./`
        do
                newname=`echo $file | sed "s/BTC/ABC/g"`
                mv $file $newname;
        done

