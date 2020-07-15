//
//  XXCollectionViewLayout.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXCollectionViewLayout.h"

@implementation XXCollectionViewLayout

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    
}

/*
如果你的布局支持追加视图的话，必须重载该方法，该方法返回的是
追加视图的布局信息，kind这个参数区分段头还是段尾的，在collectionview注册的时候回用到该参数。
*/
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *obj = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    return obj;
}

/**
返回一个Supplementary View插入到Collection View中开始的布局信息。

这个方法在- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems;方法后调
用，在- (void)finalizeCollectionViewUpdates;方法之前调用，在任何
一个Supplementary View被插入之前都会调用。
你的实现需要返回描述了Supplementary View的最初位置和状态的布
局信息。Collection View使用这个信息作为动画的开始位置。（动画的
终点位置是这个Supplementary View在Collection View中的新位
置。）如果你返回nil，那么Supplementary View会使用它最后的属性
作为动画的开始和结束位置。
这个方法的默认实现就是返回nil。
*/
- (nullable UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
    UICollectionViewLayoutAttributes *obj = [super initialLayoutAttributesForAppearingSupplementaryElementOfKind:elementKind atIndexPath:elementIndexPath];
    return obj;
}

/**
返回一个Supplementary View从Collection View中被移除时的结束布局信息。

这个方法在- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems;方法后调
用，在- (void)finalizeCollectionViewUpdates;方法之前调用，在任何
一个Supplementary View被删除之前都会调用。
Collection View使用这个信息作为动画的结束位置。（动画的起始位置
是这个Supplementary View在Collection View中的当前位置。）如果
你返回nil，那么Supplementary View会使用它最后的属性作为动画的开始和结束位置。
这个方法的默认实现就是返回nil。
*/
- (nullable UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
    UICollectionViewLayoutAttributes *obj = [super finalLayoutAttributesForDisappearingSupplementaryElementOfKind:elementKind atIndexPath:elementIndexPath];
    return obj;
}

/**
返回将要移除的Supplementary View对应的索引组成的数组。如果你不想移除任何给定的类型的Supplementary View，请返回空数组。

无论你删除Collection View中的cell还是section，Collection View都会
调用这个方法。实现这个方法让你的布局对象有机会删除不再需要的
Supplementary View。
Collection View在调用- (void)prepareForCollectionViewUpdates:
(NSArray<UICollectionViewUpdateItem *> *)updateItems;和-
(void)finalizeCollectionViewUpdates;方法之间调用这个方法。
*/
- (NSArray<NSIndexPath *> *)indexPathsToDeleteForSupplementaryViewOfKind:(NSString *)elementKind NS_AVAILABLE_IOS(7_0) {
    NSArray<NSIndexPath *> *arr = [super indexPathsToDeleteForSupplementaryViewOfKind:elementKind];
    return arr;
}
/**
返回将要移除的Decoration View对应的索引组成的数组。如果你不想移除任何给定的类型的Decoration View，请返回空数组。

无论你删除Collection View中的cell还是section，Collection View都会
调用这个方法。实现这个方法让你的布局对象有机会删除不再需要的Decoration View。
Collection View在调用- (void)prepareForCollectionViewUpdates:
(NSArray<UICollectionViewUpdateItem *> *)updateItems;和-
(void)finalizeCollectionViewUpdates;方法之间调用这个方法。
*/
- (NSArray<NSIndexPath *> *)indexPathsToDeleteForDecorationViewOfKind:(NSString *)elementKind NS_AVAILABLE_IOS(7_0) {
    NSArray<NSIndexPath *> *arr = [super indexPathsToDeleteForDecorationViewOfKind:elementKind];
    return arr;
}

/**
返回你想要添加到布局中的Supplementary View对应的索引组成的数
组。如果你不想添加任何Supplementary View，请返回空数组。

无论你添加cell还是section到Collection View中，Collection View都会
调用这个方法。实现这个方法让你的布局对象有机会添加新的Supplementary View。
Collection View在调用- (void)prepareForCollectionViewUpdates:
(NSArray<UICollectionViewUpdateItem *> *)updateItems;和-
(void)finalizeCollectionViewUpdates;方法之间调用这个方法。
*/
- (NSArray<NSIndexPath *> *)indexPathsToInsertForSupplementaryViewOfKind:(NSString *)elementKind NS_AVAILABLE_IOS(7_0) {
    NSArray<NSIndexPath *> *arr = [super indexPathsToInsertForSupplementaryViewOfKind:elementKind];
    return arr;
}


@end
