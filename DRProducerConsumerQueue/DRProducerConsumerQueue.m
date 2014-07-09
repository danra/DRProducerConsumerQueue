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
@property (nonatomic, assign, getter = isProducing) BOOL producing;

@end


@implementation DRProducerConsumerQueue

-(id)initWithTargetNumberOfPreparedItems:(NSUInteger)targetNumberOfPreparedItems initialItems:(NSArray*)initialItems producerBlock:(producerBlock_t)producerBlock
{
    if ((self = [super init]) == nil) {
        return nil;
    }
    
    _itemsQueue = [NSMutableArray array];
    if (initialItems != nil) {
        [_itemsQueue dr_enqueueItemsInArray:initialItems];
    }
    _producerBlock = [producerBlock copy];
    _targetNumberOfPreparedItems = targetNumberOfPreparedItems;

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
    self.producerBlock(^(NSArray* producedItems) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.producing = NO;
            if (producedItems != nil) {
                [self.itemsQueue dr_enqueueItemsInArray:producedItems];
            }
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
