//
//  PAIMApiMessage.h
//  PAIM_Demo
//
//  Created by chenshaojie on 15/5/12.
//  Copyright (c) 2015年 PA. All rights reserved.
//
#import "PAIMMessageDataType.h"
#import "PAIMApiGroupInfoModel.h"
#import "PAIMApiSettingModel.h"
#import "PAIMApiFriendModel.h"
#import "PAIMApiPublicMenuModel.h"
#import <Foundation/Foundation.h>

@class PAIMApiMessageModel;

/*!
 @abstract 上传群头像状态
 @constant GroupPortratit_UploadError 上传失败
 @constant GroupPortratit_Success 设置成功
 @discussion
 */
typedef NS_ENUM(NSUInteger, GroupPortratitState) {
    GroupPortratit_UploadError,//上传失败
    GroupPortratit_Success //设置成功
};



/*!
 @protocol PAIMApiMessageDelegate
 @discussion 单聊,群聊相关的Delegate
 */
@protocol PAIMApiMessageDelegate <NSObject>

@optional

/*!
 *  邀请加入群聊回调
 *
 *  @param value            YES为成功 NO为失败。
 *
 */
-(void)inviteFriendsCallBack:(BOOL)value;

/*!
 *  创建群聊回调
 *
 *  @param groupModel       群的信息。
 *
 */
-(void)createGroupCallBack:(PAIMApiGroupInfoModel *)groupModel;

/*!
 *  退出群回调。
 *
 *  @param value            YES为退出群成功，NO为退出群失败。
 *
 */
-(void)exitGroupCallBack:(BOOL)value;

/*!
 *  移出群回调。
 *
 *  @param value            YES为退出群成功，NO为退出群失败。
 *
 */
- (void)removeMemberCallBack:(BOOL)value;


/*!
 *  发送消息回调。
 *
 *  发送消息完成的回调。
 *
 *  @param isSuccess        发送成功或失败。
 *  @param messageId        消息 Id。
 *  @param conversationId   会话 Id.
 *  @param code   返回码.
 *
 */
- (void)sendMessageDone:(BOOL)isSuccess messageId:(NSString*)messageId conversationId:(NSString*)conversatcionId code:(NSInteger)code;

/*!
 *  发送多媒体消息进度回调。
 *
 *  @param progress         进度 0.0 - 1.0
 *  @param messageId        消息 Id。
 *   */
- (void)sendMessageProgress:(float)progress messageId:(NSString*)messageId conversationId:(NSString*)conversationId;

/*!
 *  下载多媒体回调。
 *
 *  @param localPath        下载在本地的路径。
 *  @param messageId        消息 Id。
 *  @param conversationId   会话 Id.
 *  @param result           下载的结果集。
 *
 */
-(void)downloadMediaDone:(NSString*)msgId conversationId:(NSString*)conversationId result:(NSDictionary*)result;

/*!
 *  下载多媒体进度回调。
 *
 *  @param progress         进度 0.0 - 1.0
 *  @param messageId        消息 Id。
 *  @param conversationId   会话 Id.
 *
 */
-(void)downloadMediaProgress:(float)progress msgId:(NSString*)msgId conversationId:(NSString*)conversationId;


/*!
 *  设置群名称的回调
 *
 *  @param success 0：失败，1：成功
 */
-(void)modifyGroupNameCallBack:(BOOL)success;
/*!
 *  解散群回调
 *
 *  @param success 0：失败，1：成功
 */
-(void)breakupGroupCallBack:(BOOL)success;
/*!
 *  设置我在本群中的昵称的回调
 *
 *  @param success 0：失败 1：成功
 */
-(void)modifyGroupNickNameCallBack:(BOOL)success;
/*!
 *  设置群头像的回调
 *
 *  @param state    状态：成功或失败
 *  @param albumUrl 返回的头像url
 */
-(void)setGroupPortraitWithState:(GroupPortratitState)state withAlbumUrl:(NSString *)albumUrl;
/*!
 *  新消息通知的回调
 *
 *  @param success success 0:失败 1:成功
 */
-(void)setNewMessageRemindCallBack:(BOOL)success;
/*!
 *  保存/取消保存通讯录的回调
 *
 *  @param success 成功 YES 失败 NO
 *  @param groupID 群ID
 */
-(void)saveGroupToAddressSuccess:(BOOL)success groupID:(NSString *)groupID;
/*!
 *  获取回话列表回调
 *
 *  @param succeed 成功YES 失败NO
 */
-(void)fetchConversationListSucceed:(BOOL)succeed;
@end


/*!
 @class PAIMApiMessage
 
 @abstract 聊天,群相关的接口.
 
 */
@interface PAIMApiMessage : NSObject

//代理使用多播代理关联，会强引用delegate  页面使用完成后需要removeMessageDelegate
@property (nonatomic, assign) id<PAIMApiMessageDelegate> messageDelegate;


+ (PAIMApiMessage *)shareInstance;


- (void)removeMessageDelegate:(id<PAIMApiMessageDelegate>)msgDelegate;

/*!
 *  注册消息接收器
 *
 *  @param   messageReciever         消息接收器，即接收消息的方法。
 *  @param   observer                消息接收器所在的类，通常传self即可。
 *   */
+ (void)resignMessageRecieverWithSelector:(SEL)messageReciever onObserver:(id)observer;

/*!
 *  获取会话列表
 *
 *  @param            返回会话列表，单聊时会获取本地没用的好友的信息，群里不会
 *   */
-(NSMutableArray *)fetchConversationList:(id<PAIMApiMessageDelegate>)mesgDelegate;

/*!
 *  置顶会话
 *
 *  @param  conversationID 会话ID
 *  @param  isTop          是否置顶
 *  @return YES            成功
 */
+ (BOOL)topConversationWithID:(NSString *)conversationID isTop:(BOOL)isTop;

/*!
 *  删除会话
 *
 *  @param  conversationID 会话ID
 *  @return YES            成功
 */
+ (BOOL)deleteConversationWithID:(NSString *)conversationID;

/*!
 *  删除消息
 *
 *  @param  messageID      消息ID
 *  @param  conversationID 会话ID
 *  @param  type           消息类型
 *  @param  content        消息内容
 *
 *  @return YES            成功
 */
+ (BOOL)deleteMessageWithID:(NSString *)messageID InConversation:(NSString *)conversationID messageType:(MESSAGE_TYPE)type content:(NSString *)content;

/*!
 *  删除通知消息(接收方已存入自己DB，IM的DB删除这些数据)
 *
 *  @param  conversationID 会话ID
 *
 *  @return YES            成功
 */
+ (BOOL)deleteBillingMessageWithConversation:(NSString *)conversationID;

/*!
 *  清空会话聊天记录
 *
 *  @param  conversationID 会话ID
 *  @return YES            成功
 */
+ (BOOL)clearAllMessageInConversation:(NSString *)conversationID;

/*!
 *  清除所有聊天记录
 *
 *  @return YES 成功
 */
+ (BOOL)clearAllConversation;

/*!
 *  修改聊天背景
 *
 *  @param  conversationID   会话ID
 *  @param  filePath         背景图片本地路径
 *  @param  defaultImageName 系统背景图片：chat_bg_1 ~ chat_bg_8
 *
 *  @return YES              成功
 */
+ (BOOL)modifyBackGroundInConversation:(NSString *)conversationID filePath:(NSString *)filePath defaultImage:(NSString *)defaultImageName;

/*!
 *  搜索会话中的消息内容
 *
 *  @param  conversationID 会话ID
 *  @param  keyword        搜索内容
 *
 *  @return NSArray*       PAIMApiMessageModel* 消息数组
 */
+ (NSArray *)searchMessageWithKeyWord:(NSString *)keyword conversationID:(NSString *)conversationID;

/*!
 *  搜索所有信息：返回的联系人、公众账号名称、群聊及文本聊天记录
 *
 *  @param  keyword  搜索内容
 *
 *  @return NSArray* [[PAIMApiFriendModel *],[[PAIMApiMessageModel *],..]]
 */
- (NSArray *)searchAllInfoWithKeyWord:(NSString *)keyword;

/*!
 *  发送一条消息。
 *
 *  @param apiMesasgeModel 消息模型。
 */
-(void)sendMessage:(PAIMApiMessageModel*)apiMesasgeModel;

/*!
 *  下载多媒体文件。
 *
 *  @param msgId            消息ID
 *  @param conversationId   会话ID
 *  @param type             下载的类型 缩略图，全量
 */
-(void)downloadMediaByMsgId:(NSString*)msgId conversationId:(NSString*)conversationId style:(DOWNLOAD_STYLE)style;

/*!
 *  在MwPhoto里下载全量图片文件。
 *
 *  @param msgId            消息ID
 *  @param conversationId   会话ID
 *  @param successBlock     下载的成功后返回本地路径，下载的Image对象
 *  @param failedBlock      下载的
 */
-(void)downloadMwPhotoImageByMsgId:(NSString*)msgId conversationId:(NSString*)conversationId successBlock:(void(^)(NSString *path,UIImage *image))successBlock failedBlock:(void(^)(void))failedBlock;

/*!
 *  停掉正在下载的任务
 *
 *  @param msgId            消息ID
 *  @param conversationId   会话ID
 */
-(void)stopDownloadByMsgId:(NSString*)msgId conversationId:(NSString*)conversationId;
/*!
 *  查询聊天类型
 *
 *  @param  conversationID 会话ID
 *
 *  @return CHAT_TYPE      聊天类型
 */
+ (CHAT_TYPE)queryChatTypeInConversation:(NSString *)conversationID;

+ (NSArray *)fetchMessagesInConversation:(NSString *)conversationID beforeDate:(NSDate *)date withCount:(NSInteger)count;

+ (NSArray *)fetchMessagesInConversation:(NSString *)conversationID withCount:(NSInteger)count afterMessage:(PAIMApiMessageModel *)messageModel;

+ (BOOL)saveMessageWithModel:(PAIMApiMessageModel *)msgModel;

- (void)transmitMessageWithMessageModel:(PAIMApiMessageModel *)apiMesasgeModel originMessageID:(NSString *)messageID OriginConversationID:(NSString *)conversationID;
/*!
 *  程序结束时把发送消息状态改为失败
 *
 *  @param conversationIDArr 会话id数组
 */
+(BOOL)changeSendingMessageStateToFailed:(NSArray *)conversationIDArr;
/*!
 *  根据conversationID清除有人@我的标志
 *
 *  @param conversationID 会话id
 */
+(void)clearFocusByOtherPeopleFlag:(NSString *)conversationID;
/*!
 *  设置消息为已读状态（区分语音）
 *
 *  @param  array PAIMApiMessageModel* 消息数组
 *
 *  @return YES    成功
 */
+(BOOL)updateMessageStateToReadWithArray:(NSArray *)array;
/*!
 *  设置语音消息为已读状态
 *
 *  @param  array PAIMApiMessageModel* 消息数组
 *
 *  @return YES    成功
 */
+(BOOL)updateVoiceMessageStateToReadWithArray:(NSArray *)array;
/*!
 *  设置会话ID中的所有消息为已读状态
 *
 *  @param  converstationID 会话ID
 *
 *  @return YES             成功
 */
+(BOOL)modifyMessageStateToReadByConversationID:(NSString *)converstationID;
/*!
 *  聊天消息保存草稿
 *
 *  @param  content        聊天内容
 *  @param  conversationID 聊天ID
 *  @param  msgTo          聊天消息接收者
 *  @param  chatType       聊天类型
 *
 *  @return YES            成功
 */
+ (BOOL)saveDraftWithContent:(NSString *)content conversationID:(NSString *)conversationID msgTo:(NSString *)msgTo chatType:(CHAT_TYPE)chatType;
/*!
 *  获取聊天消息草稿
 *
 *  @param  conversationID 聊天ID
 *
 *  @return NSString*      聊天内容
 */
+ (NSString *)fetchConversationDraftByConversationID:(NSString *)conversationID;
/*!
 *  计算会话总的bageNumber
 *
 *  @return NSInteger bageNumber数目
 */
+ (NSInteger)fetchBadgeNumber;
/*!
 *  获取会话中的bageNumber
 *
 *  @param  conversationID 会话ID
 *
 *  @return NSString *     bageNumber数目
 */
+(NSString *)fetchBadgeNumberByConversationID:(NSString *)conversationID;
/*!
 *  清除会话中的bageNumber
 *
 *  @param conversationID 会话ID
 */
+(void)clearBadgeNumberByConversationID:(NSString *)conversationID;
/*!
 *  解析单图文数据
 *
 *  @param  content   数据报文
 *
 *  @return NSString* 图文数据
 */
+ (NSString *)handleMessageOfSinglePicAndTextByContent:(NSString *)content;
/*!
 *  解析多图文
 *
 *  @param  content   数据报文
 *  @param  index     图文的下标
 *
 *  @return NSString* 图文数据
 */

+ (NSString *)handleMessageOfPublicADByContent:(NSString *)content atIndex:(NSInteger)index;
/*!
 *  解析多图文报文
 *
 *  @param content        内容
 *  @param contentType    消息类型
 *  @param index
 *
 *  @return NSDictionary* 数据
 */
+ (NSDictionary *)DictionaryFromContent:(NSString *)content contentType:(MESSAGE_TYPE)contentType index:(NSInteger)index;
/*!
 *  解析多图文数据
 *
 *  @param  content     内容
 *  @param  contentType 消息类型
 *
 *  @return NSArray*    解析后的数据
 */
+ (NSArray *)DictionaryFromContent:(NSString *)content contentType:(MESSAGE_TYPE)contentType;
/*!
 *  解析模板消息
 *
 *  @param  clearGroupCache 消息内容
 *
 *  @return NSDictionary*   解析后的数据
 */
+ (NSDictionary *)DictionaryFromContentOfTemplateMessage:(NSString *)content;
/*!
 *  删除会话时清除上传队列
 *
 *  @param conversationID 会话ID
 */
+(void)clearUploadingArrayByConversationID:(NSString *)conversationID;
/*!
 *  更新联系人Section字段
 *
 *  @param sectionName section名字
 *  @param jid         联系人ID
 */
+(void)updateFriendSectionName:(NSString *)sectionName AndJID:(NSString *)jid;
/*!
 *  更新消息高度
 *
 *  @param apiMessageModel 消息model
 */
+(void)updateMessageHeightByMessageModel:(PAIMApiMessageModel *)apiMessageModel;
/*!
 *  获取聊天内容
 *
 *  @param conversationId 会话ID
 *
 *  @return 聊天数据
 */
+(NSArray *)fetchChatRecordsByConversationId:(NSString *)conversationId;

/*********************************群聊*******************************/
/*!
 *  清空群组缓存，退出群聊使用
 */
+ (void)clearGroupCache;

/*!
 *  邀请加入群聊
 *
 *  @param friendJids           被邀请的好友的id。
 *  @param groupID              要加入的群。
 *   */
- (void)inviteFriendJids:(NSArray *)friendJids intoGroup:(NSString *)groupID;
/*!
 *  设置群名称
 *
 *  @param groupName 群名称
 *  @param groupID   群ID
 */
-(void)modifyGroupName:(NSString *)groupName withGroupID:(NSString *)groupID;
/*!
 *  设置我在本群中的昵称
 *
 *  @param groupNickName 群昵称
 *  @param groupID       群ID
 */
-(void)modifyGroupNickName:(NSString *)groupNickName withGroupID:(NSString *)groupID;

/*!
 *  从服务器直接更新群成员
 *
 *  @param  groupID 群ID
 *  @param  YES 更新成功 NO 更新失败
 */
- (void)updateGroupMemberFromServerWithGroupID:(NSString *)groupID;
- (void)updateGroupMemberFromServerWithGroupID:(NSString *)groupID resultBlock:(void(^)(BOOL result))callBackBlock;



/*!
 *  创建群聊
 *
 *  @param memberJids           群成员的id。
 *   */
- (void)createGroupWithMemberJids:(NSArray *)memberJids;

/*!
 *  创建群聊
 *
 *  @param memberJids           群成员的id。
 *  @param groupName           群名称。
 *   */
- (void)createGroupWithMemberJids:(NSArray *)memberJids groupName:(NSString *)groupName;

/*!
 *  创建群聊
 *
 *  @param memberJids 群成员的id。
 *  @param groupType  群类型。
 *  @param groupName  群名称。
 *   */
- (void)createGroupWithMemberJids:(NSArray *)memberJids groupType:(NSUInteger)groupType groupName:(NSString *)groupName;

/*!
 *  退出群聊
 *
 *  @param groupID           群id。
 *   */
- (void)exitGroupWithGroupID:(NSString *)groupID;

/*!
 *  群聊聊天是否显示昵称
 *
 *  @param isShow         是否显示
 *  @param conversationID 会话ID
 *
 *  @return 操作是否成功
 */
- (BOOL)isShowNickName:(BOOL)isShow withConversationID:(NSString *)conversationID;
/*!
 *  移出群聊
 *
 *  @param memberID          群成员id。
 *  @param groupID           群id。
 *   */
- (void)removeMemberByID:(NSString *)memberID outofGroup:(NSString *)groupID;

/*!
 *  更改群头像
 *
 *  @param groupID 群ID
 *  @param img     群头像
 */
- (void)setGroupPortrait:(NSString *)groupID withImage:(UIImage *)img;
/*!
 *  设置新消息通知开关
 *
 *  @param state   是否开启
 *  @param groupID 群ID
 */
-(void)setNewMessageRemindState:(BOOL)state withGroupID:(NSString *)groupID;


/*!
 *  群是否保存到通讯录
 *
 *  @param isSave  YES 保存  NO 不保存
 *  @param groupID 群ID
 */
- (void)saveGroupToAddress:(BOOL)isSave groupID:(NSString *)groupID;


/*!
 *  获取群列表
 *
 *  @return 群列表
 */
+ (NSArray *)fetchMyGroupList;

/*!
 *  获取群成员列表
 *
 *  @return 群成员列表 PAIMApiFriendModel类型
 */
+ (NSArray *)fetchGroupMembersByGroupID:(NSString *)groupID;

/*!
 *  获取群信息
 *
 *  @param groupID 群ID
 *
 *  @return 群的对象 如果群不存在 返回nil
 */
+ (PAIMApiGroupInfoModel *)fetchGroupInfoByGroupID:(NSString *)groupID;

/*!
 *  获取群信息和群成员
 *
 *  @param groupID 群ID
 *
 *  @return 群的对象 如果群不存在 返回nil
 */
+ (PAIMApiGroupInfoModel *)fetchGroupInfoAndMembersByGroupID:(NSString *)groupID;

/*!
 *  上传群操作数据
 *
 *  @param groupID 群ID
 *  @param time 操作时间
 *  @param block 操作结果回调
 */
- (void)uploadGroupOperation:(NSString *)groupID operationTime:(NSDate *)time block:(void (^) (BOOL))block;

/*!
 *  获取设置信息
 *
 *  @param conversationID 会话id
 *
 *  @return 设置对象 如果不存在返回ni
 */
+ (PAIMApiSettingModel *)fetchSettingInfoByConversationID:(NSString *)conversationID;
/*!
 *  存储设置信息
 *
 *  @param model 设置信息的model
 *
 *  @return 成功YES 失败NO
 */

+ (BOOL)setSettingInfoWithModel:(PAIMApiSettingModel *)model;
/*!
 *  查询声音播放模式
 *
 *  @return YES 为听筒模式 NO 为扬声器模式
 */
+ (BOOL)fetchSpeekOnSetting;
/*!
 *  设置声音播放模式
 *
 *  @param type "0"听筒模式 "1"扬声器模式
 *
 *  @return 设置 成功YES 失败NO
 */
+ (BOOL)setSpeakOnWithType:(NSString *)type;
/*!
 *  收到消息播放声音
 */
+ (void)playSound;
/*!
 *  获取群成员信息
 *
 *  @param groupID  群ID
 *  @param friendID 群成员ID
 *
 *  @return 群成员的对象 如果群不存在或者friendID 返回nil
 */
+(PAIMApiFriendModel *)fetchGroupMemberInfoByFriendID:(NSString *)friendID
                                           andGroupID:(NSString *)groupID;
/*!
 *  获取群成员信息
 *
 *  @param friendID       群成员ID
 *  @param conversationID 会话ID
 *  @param chatType       聊天类型
 *
 *  @return 群成员的对象 如果群不存在或者friendID 返回nil
 */
+(PAIMApiFriendModel *)fetchFriendInfoByFriendID:(NSString *)friendID
                                  conversationID:(NSString *)conversationID
                                        chatType:(CHAT_TYPE)chatType;

/*!
 *  更换群聊背景图片
 *
 *  @param path    背景图片路径
 *  @param groupID 群ID
 *
 *  @return 成功或者失败
 */
+ (BOOL)updateGroupChatBackgroudImageWithPath:(NSString *)path
                                      groupID:(NSString *)groupID;
/********************************消息铃声*******************************/

/*!
 *  设置铃声源文件
 *
 *  @param path  文件路径
 */
-(BOOL)setNewMessageAudioLocalPath:(NSString *)path;

/*!
 *  获取公众帐号Model的菜单
 *  @param jid 公众号jid
 *  @return 对应Jid公众号的公众号菜单
 */
+(PAIMApiPublicMenuModel*)getPublicMenuModelByJid:(NSString*)jid;

/**
 获取所有通知消息列表
 
 @param conversationId 会话Id
 @return 所有通知消息列表
 */
+ (NSArray<PAIMApiMessageModel *> *)fetchBillingMessagesInConversation:(NSString *)conversationId;

/**
 获取所有通知消息列表
 
 @param conversationId 会话Id
 @param msgId 消息Id
 @return success
 */
+ (BOOL)updateBillingMessageStateToDeleteWithConversationId:(NSString *)conversationID msgId:(NSString *)msgId;

/*!
 *  通过群ID解散群
 *  @param groupID 群ID
 *
 */
-(void)breakupGroupwithGroupID:(NSString *)groupID;

/*!
 *  设置群公告
 *  @param title    群公告标题
 *  @param content  群公告内容(可不设置，传空)
 *  @param groupID  群ID
 *  @param callBack 设置回调
 */
-(void)setGroupNoticeWithTitle:(NSString *)title content:(NSString *)content groupID:(NSString *)groupID callBack:(void (^) (BOOL))callBack;
/*!
 *  查询群公告接口
 *  @param groupID  群ID
 *  @param callBack 设置回调(dictArray返回的公告数组,errorStr返回的错误信息)
 */
-(void)fetchTheLastGroupNoticeWithGroupID:(NSString *)groupID callBack:(void (^) (NSDictionary *dict,NSString *errorStr))callBack;

/*!
 *  群管理员设置
 *  @param members  设置群管理员ID
 *  @param groupID   群ID
 *  @param callBack 设置回调(isSuccess:YES成功,error:1118管理员超出)
 */
-(void)setGroupManagerWithMembers:(NSString *)memberID groupID:(NSString *)groupID callBack:(void (^) (BOOL isSuccess,NSError *error))callBack;

/*!
 *  群管理员踢除
 *  @param members  删除群管理员ID
 *  @param groupID   群ID
 *  @param callBack 设置回调(isSuccess:YES成功,error错误信息)
 */
-(void)delGroupManagerWithMembers:(NSString *)memberID groupID:(NSString *)groupID callBack:(void (^) (BOOL isSuccess,NSError *error))callBack;

/*!
 *  开始同步群信息和群成员，同步结果监听kSyncGroupInfoFinished通知
 */
- (void)syncGroupList;

@end
