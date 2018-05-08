//
//  CHHTTPManager.m
//  YMStarsProject
//
//  Created by huangcanhui on 2018/4/26.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "CHHTTPManager.h"
#import "UserToken.h"

@interface CHHTTPManager ()
/**
 * token
 */
@property (nonatomic, strong)UserToken *token;
@end

@implementation CHHTTPManager

+ (instancetype)manager
{
//    static CHHTTPManager *manager = nil;
//    static dispatch_once_t pred;
//    dispatch_once (&pred, ^{
//       manager  = [[self alloc] initWithBaseURL:[NSURL URLWithString:URL_main]];
//    });
//    return manager;
    static CHHTTPManager *manager = nil;
    manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:URL_main]];
    [manager configSSLCerticate]; //校验证书
    return manager;
}

-  (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        //设置请求超时的时间
        self.requestSerializer.timeoutInterval = 60.f;
        //设置请求头
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [self getUserAccessToken]] forHTTPHeaderField:@"Authorization"];
        NSNumber *number =[NSNumber readUserDefaultWithKey:KOrganizationID];
        if (number != nil) { //判断是否有机构ID存在
          [self.requestSerializer setValue:[NSString stringWithFormat:@"%@", number] forHTTPHeaderField:@"organizationKey"];
        }
        //设置接收服务器传回的格式
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    }
    return self;
}

#pragma mark - 获取用户的access_token
- (NSString *)getUserAccessToken
{
    self.token = [UserToken readUserDefaultWithKey:KUserTokenCache];
    if (self.token) {
        return self.token.access_token;
    }
    return nil;
}

#pragma mark - 校验HTTPS证书
- (void)configSSLCerticate
{
    self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]; //设置非校验证书模式
    self.securityPolicy.validatesDomainName = NO; //设置不需要验证域名
    self.securityPolicy.allowInvalidCertificates = NO; //不允许无效的证书(SSLPinningModeCertificate时候才有用)
}

#pragma mark - 监听网络
+ (void)networkStatusWithBlock:(CHNetworkStatus)networkStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(CHNetWorkStatusUnkonwn) : nil;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(CHNetWorkStatusReachable) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(CHNetWorkStatusReachableViaWWAN) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(CHNetWorkStatusReachableViaWiFi) : nil;
                    break;
                    
                default:
                    break;
            }
        }];
    });
}

- (void)requestWithMethod:(HTTPMethod)method WithPath:(NSString *)path WithParams:(NSDictionary *)params WithSuccessBlock:(requestSuccessBlock)success WithFailurBlock:(requestFailureBlock)failure
{
     NSString *url = [NSString stringWithFormat:@"%@%@", URL_main, path];
    switch (method) {
        case GET:
        {
            [self GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                failure(error);
                [self unifiedErrorCodeToMessageShow:error];
            }];
        }
            break;
        case POST:
        {
            [self POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
//                NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
//                NSInteger statusCode = response.statusCode;
                failure(error);
                [self unifiedErrorCodeToMessageShow:error];
            }];
        }
            break;
        case DELETE:
        {
            [self DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                [self unifiedErrorCodeToMessageShow:error];
            }];
        }
            break;
        case PATCH:
        {
            [self PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                [self unifiedErrorCodeToMessageShow:error];
            }];
        }
            break;
        case PUT:
        {
            [self PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                [self unifiedErrorCodeToMessageShow:error];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 错误的统一处理
- (void)unifiedErrorCodeToMessageShow:(NSError *)error
{
    NSData *data = [[error userInfo][@"com.alamofire.serialization.response.error.string"] dataUsingEncoding:NSUTF8StringEncoding];
    if (data != nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [MBProgressHUD showErrorMessage:dict[@"message"]];
    }
}

@end
