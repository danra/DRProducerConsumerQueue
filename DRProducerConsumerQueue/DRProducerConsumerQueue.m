//
//  DRProducerConsumerQueue.m
//  DRProducerConsumerQueue
//
//  Created by Dan Raviv on 7/7/14.
//  Copyright (c) 2014 Dan Raviv. All rights reserved.
//

#import "DRProducerConsumerQueue.h"

#import "NSMutableArray+DRQueueUtils.h"

@interface DRProducerConsumerQueue ()

@property (nonatomic, copy) NSMutableArray* itemsQueue;
@property (nonatomic, strong) producerBlock_t producerBlock;
@property (nonatomic, strong) dispatch_queue_t productionQueue;
@property (nonatomic, assign, getter = isProducing) BOOL producing;

@end


@implementation DRProducerConsumerQueue

-(id)initWithProducerBlock:(producerBlock_t)producerBlock productionQueue:(dispatch_queue_t)productionQueue targetNumberOfPreparedItems:(NSUInteger)targetNumberOfPreparedItems
{
    if ((self = [super init]) == nil) {
        return nil;
    }
    
    _itemsQueue = [NSMutableArray array];
    _producerBlock = [producerBlock copy];
    _productionQueue = productionQueue;
    
    return self;
}

-(void)produceIfNeedMoreItems
{
    if (self.itemsQueue.count < self.targetNumberOfPreparedItems) {
        [self produce];
    }
}

-(void)produce
{
    self.producing = YES;
    dispatch_async(self.productionQueue, ^{
        NSArray* producedItems = self.producerBlock();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.producing = NO;
            [self.itemsQueue dr_enqueueItemsInArray:producedItems];
            if ([self isProductionEnabled]) {
                [self produceIfNeedMoreItems];
            }
        });
    });
}

-(void)setProductionEnabled:(BOOL)productionEnabled
{
    if (productionEnabled == _productionEnabled) {
        return;
    }
    _productionEnabled = productionEnabled;
    if (_productionEnabled && ![self isProducing]) {
        [self produceIfNeedMoreItems];
    }
}

-(id)consumeItem
{
    id item = [self.itemsQueue dr_dequeue];
    if ([self isProductionEnabled] && ![self isProducing]) {
        [self produceIfNeedMoreItems];
    }
    return item;
}

@end
