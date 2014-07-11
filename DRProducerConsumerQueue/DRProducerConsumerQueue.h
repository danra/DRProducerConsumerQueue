//
//  DRProducerConsumerQueue.h
//  DRProducerConsumerQueue
//
//  Created by Dan Raviv on 7/7/14.
//  Copyright (c) 2014 Dan Raviv. All rights reserved.
//

#import <Foundation/Foundation.h>

// Note - DRProducerConsumerQueue is not thread-safe, and is only safe to access from main thread.
// The producer block can perform some work in the background and call its completion block with the results when the produced items are ready.
@interface DRProducerConsumerQueue : NSObject

typedef void (^producerCompletionBlock_t)(NSArray* producedItems);
typedef void (^producerBlock_t)(producerCompletionBlock_t completionBlock);

-(id)initWithTargetNumberOfPreparedItems:(NSUInteger)targetNumberOfPreparedItems producerBlock:(producerBlock_t)producerBlock;

-(id)consumeItem;

-(void)enqueueItemsManually:(NSArray*)items;


@property (nonatomic, assign, getter = isProductionEnabled) BOOL productionEnabled;

@property (nonatomic, assign) NSUInteger targetNumberOfPreparedItems;

// Only use this to examine the queue state. To consume items, use the -consumeItem method.
@property (nonatomic, copy, readonly) NSMutableArray* itemsQueue;

@end
