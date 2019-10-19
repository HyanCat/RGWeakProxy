//
//  RGWeakProxy.m
//  RGWeakProxy
//
//  Created by HyanCat on 2019/5/15.
//

#import "RGWeakProxy.h"

RGWeakProxy *RG_WeakProxy(id target)
{
    return [RGWeakProxy proxyWithTarget:target];
}

@interface RGWeakProxy ()

@property (nonatomic, weak) id target;

@end


@implementation RGWeakProxy

+ (instancetype)proxyWithTarget:(id)target
{
    RGWeakProxy *proxy = [RGWeakProxy alloc];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *methodSignature;
    // strongify
    __strong id object = self.target;
    if (object) {
        methodSignature = [object methodSignatureForSelector:aSelector];
    } else {
        NSString *signedId = [NSString stringWithUTF8String:@encode(id)];
        NSString *signedSel = [NSString stringWithUTF8String:@encode(SEL)];
        NSString *types = [NSString stringWithFormat:@"%@%@", signedId, signedSel];
        const char *objCTypes = [types UTF8String];
        if (objCTypes) {
            methodSignature = [NSMethodSignature signatureWithObjCTypes:objCTypes];
        } else {
            return nil;
        }
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:self.target];
}

@end
