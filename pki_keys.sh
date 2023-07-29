#!/bin/bash
mkdir "$1"
cd "$1" || exit
folder=(bank)

for i in "${folder[@]}"; do
	mkdir ${i} && cd ${i}

	openssl genpkey -algorithm RSA -out ${i}_sig.pem -pkeyopt rsa_keygen_bits:2048
	openssl rsa -in ${i}_sig.pem -pubout -out ${i}_sig_pub.pem
	openssl pkcs8 -topk8 -in ${i}_sig.pem -nocrypt -out ${i}_sig_pvt.pem
	sleep 1
	openssl genpkey -algorithm RSA -out ${i}_enc.pem -pkeyopt rsa_keygen_bits:2048
	openssl rsa -pubout -in ${i}_enc.pem -out ${i}_enc_pub.pem
	openssl pkcs8 -topk8 -in ${i}_enc.pem -nocrypt -out ${i}_enc_pvt.pem
	rm ${i}_sig.pem ${i}_enc.pem
	#single line
	echo encryption_private >>singleline_${i}.txt
	cat ${i}_enc_pvt.pem | sed '1,1d;$d' | awk '{print}' ORS='' >>singleline_${i}.txt
	echo sigature_private >>singleline_${i}.txt
	cat ${i}_sig_pvt.pem | sed '1,1d;$d' | awk '{print}' ORS='' >>singleline_${i}.txt
	echo $'\n' >>singleline_${i}.txt
	echo encryption_pub >>singleline_${i}.txt
	cat ${i}_enc_pub.pem | sed '1,1d;$d' | awk '{print}' ORS='' >>singleline_${i}.txt
	echo $'\n' >>singleline_${i}.txt
	echo signature_pub >>singleline_${i}.txt
	cat ${i}_sig_pub.pem | sed '1,1d;$d' | awk '{print}' ORS='' >>singleline_${i}.txt
	echo $'\n' >>singleline_${i}.txt

	cd ..
done
#cat encryption_private_key | sed '1,1d;$d' | awk '{print}' ORS=''

