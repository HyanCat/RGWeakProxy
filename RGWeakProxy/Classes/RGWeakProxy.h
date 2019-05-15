//
//  RGWeakProxy.h
//  RGWeakProxy
//
//  Created by HyanCat on 2019/5/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef RG_WEAK_PROXY
#define RG_WEAK_PROXY(x) [RGWeakProxy proxyWithTarget:x]
#endif

@class RGWeakProxy;
RGWeakProxy *RG_WeakProxy(id target);

@interface RGWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
