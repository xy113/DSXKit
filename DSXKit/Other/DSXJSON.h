//
//  DSXJSON.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/8/30.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSXJSON : NSObject

+ (NSString *)jsonEncode:(id)object;
+ (id)jsonDecode:(NSData *)object;

@end
