//
//  XXTools.m
//  Demo_PhotoAlbum
//
//  Created by Eleven on 2020/7/17.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXTools.h"

@implementation XXTools


/*
 *@param array 待排序的数组
 *@param start  结点序号（从0开始），待排序的父结点。
 *@param  end   完全二叉树的最后一个尾结点序号，用来判断临
 *界情况
 */
+ (void)createMaxHeapWithArray:(NSMutableArray<NSNumber*> *)array start:(int)start end:(int)end {
    int dad = start;
    int son = dad * 2 + 1;
    while (son <= end) {
        //  比较两个儿子的大小
        if (son + 1 <= end &&
            [array[son] intValue] < [array[son+1] intValue]) {
            son ++;
        }
        
        if ([array[dad] intValue] > [array[son] intValue]) {
            return;
        } else {
            [array exchangeObjectAtIndex:dad withObjectAtIndex:son];
            //因为交互打乱了原来的顺利，这里继续对打乱的顺序进行再一次排序，所以dad = son ,son = dad * 2 + 1,直到满足return的条件或者找到了尾结点
            dad = son;
            son = dad * 2 + 1;
        }
    }
}

+ (void)heapSortWithArray:(NSMutableArray<NSNumber*> *)array {
    int len =(int) array.count;
    //  这里是关键，从最后一个非叶子结点开始,这里就是递归的思想。
    for (int i = len / 2 - 1; i >= 0; i-- ){
        [self createMaxHeapWithArray:array start:i end:len-1];
    }
    
    //  交换堆的根结点和尾结点的值，然后对交换后的除去尾结点的最大值的完全二叉树建大堆，一直交换，直到只剩下跟结点。
    for (int i = len - 1; i > 0 ; i -- ) {
        [array exchangeObjectAtIndex:0 withObjectAtIndex:i];
        [self createMaxHeapWithArray:array start:0 end:i-1];
    }
    
    [self printArray:array];
}

+ (void)printArray:(NSArray *)arr {
    NSLog(@"%@", arr);
}

@end
