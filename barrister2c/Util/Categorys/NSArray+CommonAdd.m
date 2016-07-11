//
//  NSArray+CommonAdd.m
//  peipei
//
//  Created by thinker on 5/6/16.
//  Copyright © 2016 com.58. All rights reserved.
//

#import "NSArray+CommonAdd.h"
#import "NSString+CommonAdd.h"

@implementation NSArray(CommonAdd)

- (__kindof id)  safeObjectAtIndex:(NSUInteger)index {
    
    return index < self.count ? self[index] : nil;
}

- (id)randomObject {
    
    if (self.count) {
        
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

@end

@implementation NSMutableArray(CommonAdd)

- (void)safeAddObject:(id)anObject {
    
    if (anObject) {
        
        [self addObject:anObject];
    }
}

- (void)removeFirstObject {
    
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (id)popFirstObject {
    
    id obj = nil;
    if (self.count) {
        
        obj = self.firstObject;
        [self removeFirstObject];
    }
    return obj;
}

- (void)prependObject:(id)anObject {
    
    if (!anObject) return;

    [self insertObject:anObject atIndex:0];
}

- (void)prependObjects:(NSArray *)objects {
    
    if (!objects) return;
    
    NSUInteger i = 0;
    for (id obj in objects) {
        
        [self insertObject:obj atIndex:i++];
    }
}

- (void)reverse {
    
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (BOOL)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    
    if (index > self.count - 1) {
        
        return NO;
    }
    
    NSUInteger i = index;
    
    for (id obj in objects) {
        
        [self insertObject:obj atIndex:i++];
    }
    
    return YES;
}

#pragma mark - Transform

- (NSDictionary *)dicOfTransformByString:(NSString *)separator {
    
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *itemDic = [obj dicOfcomponentsSeparatedByString:separator];
        
        if (itemDic) {
            
            [resultDic addEntriesFromDictionary:itemDic];
        }
        
    }];
    
    return resultDic;
}
@end
