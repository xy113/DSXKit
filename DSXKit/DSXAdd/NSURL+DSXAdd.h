//
//  NSURL+DSXAdd.h
//  CuGengForIPhone
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(DSXAdd)

@property(nonatomic, strong) NSDictionary *parameters;

- (NSString *)getParameter:(NSString *)name;

@end
