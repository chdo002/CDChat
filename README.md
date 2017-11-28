# CDChatList
iOS 聊天界面的组件


想要提交代码请fork下，然后pullrequest，谢谢


## usage

>  作为pod依赖

```
 pod 'CDChatList'
```

>  将pod打包成framework

```
 pod package CDChatList.podspec --force  -verbose
```

>  将pod打包成静态库（需要手动处理资源文件）

```
 pod package CDChatList.podspec --library  --force  -verbose
```


## 更新记得打tag

git tag -m "first release" "0.1.0"
$ git push --tags     #推送tag到远端仓库
