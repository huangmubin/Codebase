#!/bin/sh

# 需要自动进行 Git 操作的文件夹
folders=(
	"/Users/myron/EF English/English" 
	"/Users/myron/Developer/Work/MyApp"
)

# 默认的 Commit 备注
note="Macbook Pro default git commit."

# 循环访问文件夹，然后进行 Git 操作
for (( i = 0; i < ${#folders[@]}; i++ )); do
	folder=${folders[i]}

	echo ""
	echo "Start push and pull "$folder

	cd "${folder}"
	git add *
	git commit -m "${note}"
	git pull
	git push
	cd ~
	
	echo ""
done