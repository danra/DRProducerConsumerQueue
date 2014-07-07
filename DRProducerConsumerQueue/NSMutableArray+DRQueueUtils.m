//
//  NSMutableArray+DRQueueUtils.m
//  DRProducerConsumerQueue
//
//  Created by Dan Raviv on 7/7/14.
//  Copyright (c) 2014 Dan Raviv. All rights reserved.
//

#import "NSMutableArray+DRQueueUtils.h"

@implementation NSMutableArray (DRQueueUtils)

- (void) dr_enqueue: (id)item {
    [self addObject:item];
}

- (void)dr_enqueueItemsInArray:(NSArray *)otherArray {
    [self addObjectsFromArray:otherArray];
}

- (id) dr_dequeue {
    id item = [self firstObject];
    if (item != nil) {
        [self removeObjectAtIndex:0];
    }
    return item;
}

@end
