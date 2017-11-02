//
//  NSURL+DSXAdd.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "NSURL+DSXAdd.h"

@implementation NSURL(DSXAdd)

- (void)setParameters:(NSDictionary *)parameters{
    
}

- (NSDictionary *)parameters{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *array = [[self query] componentsSeparatedByString:@"&"];
    for (NSString *param in array) {
        NSArray *arr = [param componentsSeparatedByString:@"="];
        if ([arr count] == 2) {
            [params setObject:[arr[1] stringByRemovingPercentEncoding] forKey:arr[0]];
        }
    }
    self.parameters = params;
    return params;
}

- (NSString *)getParameter:(NSString *)name{
    return (NSString *)[self.parameters objectForKey:name];
}

@end
