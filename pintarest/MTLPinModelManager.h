//
//  MTLPinModelManager.h
//  pintarest
//
//  Created by Funami Takao on 12/02/24.
//  Copyright (c) 2012年 Recruit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MTLPinModelManager : NSObject

+ (MTLPinModelManager *)sharedManager;
- (NSArray *)searchPins:(NSString *)query;

@end
