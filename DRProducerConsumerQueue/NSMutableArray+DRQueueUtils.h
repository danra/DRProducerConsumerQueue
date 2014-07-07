//
//  NSMutableArray+DRQueueUtils.h
//  DRProducerConsumerQueue
//
//  Created by Dan Raviv on 7/7/14.
//  Copyright (c) 2014 Dan Raviv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (DRQueueUtils)

- (void)dr_enqueue: (id)item;
- (void)dr_enqueueItemsInArray: (NSArray*)otherArray;
- (id)dr_dequeue;

@end
