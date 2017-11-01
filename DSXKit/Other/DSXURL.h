//
//  DSXURL.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/8/29.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSXURL : NSURL{
    @protected
    NSMutableDictionary *_parameters;
}

- (NSDictionary *)params;
- (NSString *)getParameter:(NSString *)name;
+ (NSString *)buildQueryString:(NSDictionary *)params;

@end
