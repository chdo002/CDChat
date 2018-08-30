//
//  CDMessageModel.m
//  CDChatList
//
//  Created by chdo on 2018/3/20.
//

#import "CDMessageModel.h"

@implementation CDMessageModel

@synthesize bubbleWidth;

@synthesize userThumImage;

@synthesize willDisplayTime;

@synthesize messageId;

@synthesize msg;

@synthesize isLeft;

@synthesize msgType;

@synthesize createTime;

@synthesize textlayout;

@synthesize modalInfo;

@synthesize msgState;

@synthesize cellHeight;

@synthesize userThumImageURL;

@synthesize audioSufix;

@synthesize audioText;

@synthesize audioTime;

@synthesize userName;

@synthesize ctDataconfig;

@synthesize chatConfig;

@synthesize reuseIdentifierForCustomeCell;

-(instancetype)init:(NSDictionary *)dic{
    self = [super init];
    
    self.msg  = dic[@"msg"];
    self.msgType = [dic[@"msgType"] integerValue];
    if (dic[@"isLeft"]) {
        self.isLeft = [dic[@"isLeft"] integerValue];
    }
    
    if (dic[@""]) {
        
    }
    
    return self;
}
@end
