//
//  CDChatMacro.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//

#ifndef CDChatMacro_h
#define CDChatMacro_h


#define CRMHexColor(hexColor)  [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1]

#define CRMRadomColor(hexColor)  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define logTime(tag) [CellCaculator logTimeWhit:tag];;

#endif /* CDChatMacro_h */
