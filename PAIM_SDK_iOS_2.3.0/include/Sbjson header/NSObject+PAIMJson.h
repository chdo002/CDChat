//
//  NSObject+PAIMJson.h
//  PAIM_Demo
//
//  Created by snake　 on 15/11/2.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PAIMJson)
-(NSString *)PAIMJSONRepresentation;

@end

@interface NSString (PAIMJson)


- (id)PAIMJSONValue;

@end
