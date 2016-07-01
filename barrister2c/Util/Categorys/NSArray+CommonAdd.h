//
//  NSArray+CommonAdd.h
//  peipei
//
//  Created by thinker on 5/6/16.
//  Copyright © 2016 com.58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType>(CommonAdd)
/**
 *  安全的访问
 *
 *  @param index index description
 *
 *  @return return value description
 */
- (ObjectType)safeObjectAtIndex:(NSUInteger)index;
/**
 *  随机访问
 *
 *  @return return value description
 */
- (ObjectType)randomObject;

@end


@interface NSMutableArray <ObjectType> (CommonAdd)

- (void)safeAddObject:(ObjectType)anObject;
/**
 *  删除第一个元素
 */
- (void)removeFirstObject;
/**
 *  pop操作
 *
 *  @return return value description
 */
- (ObjectType)popFirstObject;
/**
 *  first位置插入
 *
 *  @param anObject anObject description
 */
- (void)prependObject:(ObjectType)anObject;
/**
 *  first位置插入多个元素
 *
 *  @param objects objects description
 */
- (void)prependObjects:(NSArray *)objects;
/**
 *  反转
 */
- (void)reverse;
/**
 *  在index 依次插入多个元素
 *
 *  @param objects objects description
 *  @param index   index description
 *
 *  @return return value description
 */
- (BOOL)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/**
 *  讲每一项根据separator 转换成NSDictionary
 *
 *  @param separator eg:=, &等
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dicOfTransformByString:(NSString *)separator;

@end