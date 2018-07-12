
# 第一个参数记为commit 默认update
param=$1
if [[ $1 = '' ]]
then
	read -p "commit 提交说明（默认update）：" cmmm;  
	param=$cmmm;
	if [[ $param = '' ]]; then
		param='update';
	fi
fi


# 第二个参数记为tag版本，默认0.0.1
param2=$2
if [[ $2 = '' ]]
then
	read -p "tag 版本(默认0.2.4) ：" taggg;
	param2=$taggg;
	if [[ $param2 = '' ]]; then
		param2='0.2.4';
	fi
fi


echo '<<<<提交>>>>'
git status
git add -A
git commit -m $param
git push

echo '<<<<删除tag>>>>'
# 这里的版本可以由外部传入
git tag --d $param2
git push origin --delete tag $param2

echo '<<<<添加tag>>>>'
git tag -m "$param2" "$param2"
git push origin --tags

echo '<<<<清除pod缓存>>>>'
pod cache clean --all

# echo '<<<<打印log>>>>'
# git log --all --pretty  --graph --date=short
git status

echo "参数1： $param"
echo "参数2： $param2"


