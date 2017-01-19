#!/bin/sh
#current_path=$(pwd)
shell_dir=$1
spec_file_url=$2
mustache_dir="$1/mustache4Api"
code_config="$1/code.config"

cd ${shell_dir}
cd ../../
#获取项目名称
project_name=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'`
#文件输入目录
out_put_dir="$(pwd)/Api"
rm -rf ${out_put_dir}
mkdir ${out_put_dir}

cd ${shell_dir}
java -jar swagger-codegen-cli.jar generate \
     -i ${spec_file_url} \
     -l objc \
     -o ${out_put_dir} \
     -t ${mustache_dir} \
     -c ${code_config} \
     -D modelDocs=false,apiDocs=false \
     --skip-overwrite
 cd ../../
 echo "pod:$(pwd)"
 export LC_ALL="en_US.UTF-8"
 export COCOAPODS_DISABLE_STATS="1"

podupdte=`/usr/local/bin/pod update --verbose --no-repo-update`
