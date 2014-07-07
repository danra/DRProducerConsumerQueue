//
//  DRProducerConsumerQueue.h
//  DRProducerConsumerQueue
//
//  Created by Dan Raviv on 7/7/14.
//  Copyright (c) 2014 Dan Raviv. All rights reserved.
//

#import <Foundation/Foundation.h>

// Note - DRProducerConsumerQueue is not thread-safe, and is only safe to access from main thread.
// The items production can be done on a non-main queue.
@interface DRProducerConsumerQueue : NSObject

typedef NSArray* (^producerBlock_t)(void);
-(id)initWithProducerBlock:(producerBlock_t)producerBlock productionQueue:(dispatch_queue_t)productionQueue targetNumberOfPreparedItems:(NSUInteger)targetNumberOfPreparedItems;

-(id)consumeItem;


@property (nonatomic, assign, getter = isProductionEnabled) BOOL productionEnabled;

@property (nonatomic, assign) NSUInteger targetNumberOfPreparedItems;

// Only use this to examine the queue state. To consume items, use the -consume method instead.
@property (nonatomic, copy, readonly) NSMutableArray* itemsQueue;

@end
