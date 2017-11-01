//
//  DSXApi.m
//  CuGengForIPhone
//
//  Created by songdewei on 2017/8/31.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import "DSXApi.h"

static AFHTTPSessionManager *afmanager;
@implementation DSXApi

+ (AFHTTPSessionManager *)afmanager{
    if (!afmanager) {
        afmanager = [AFHTTPSessionManager manager];
    }
    return afmanager;
}

+ (NSString *)getToken{
    return [[NSString stringWithFormat:@"%@%@%@", APPID, APPKEY, [[DSXDate timestamp] substringToIndex:6]] md5];
}

+ (NSString *)getApiUrlWithToken{
    return [SITEAPI stringByAppendingFormat:@"&appid=%@&token=%@", APPID, [DSXApi getToken]];
}

+ (void)setResponseSeriallizer:(AFHTTPResponseSerializer *)serializer{
    [afmanager setResponseSerializer:serializer];
}

+ (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    
    AFHTTPSessionManager *manager = [self afmanager];
    URLString = [[self getApiUrlWithToken] stringByAppendingString:URLString];
    return [manager GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
}

+ (nullable NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    AFHTTPSessionManager *manager = [self afmanager];
    URLString = [[self getApiUrlWithToken] stringByAppendingString:URLString];
    return [manager POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}

+ (nullable NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    AFHTTPSessionManager *manager = [self afmanager];
    URLString = [[self getApiUrlWithToken] stringByAppendingString:URLString];
    return [manager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
}

@end
