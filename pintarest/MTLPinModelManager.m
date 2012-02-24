//
//  MTLPinModelManager.m
//  pintarest
//
//  Created by Funami Takao on 12/02/24.
//  Copyright (c) 2012年 Recruit. All rights reserved.
//

#import "MTLPinModelManager.h"
@interface MTLPinModelManager()
@property (nonatomic,strong) NSMutableDictionary *searchedPins;
@end

@implementation MTLPinModelManager
@synthesize searchedPins = _searchedPins;

+ (MTLPinModelManager *)sharedManager
{
    static MTLPinModelManager *sharedPinModelManager;
    static dispatch_once_t done;
    dispatch_once(&done, ^{ sharedPinModelManager = [MTLPinModelManager new]; });
    return sharedPinModelManager;
}

- (NSMutableDictionary *)searchedPins{
    if (_searchedPins == nil){
        _searchedPins = [[NSMutableDictionary alloc] init];
    }
    return _searchedPins;
}

- (NSArray *)searchPins:(NSString *)query 
{
    //ここで、DBから取得するのだが、モックということで、事前に用意したJSONから取得しています
    NSArray *pins = (NSArray *)[self.searchedPins objectForKey:query];
    if (pins == nil){
		// 事前に用意してあるjsonを読み込む。
        NSString *fileName = [NSString stringWithFormat:@"query_%@",query];
		NSString *jsonPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:jsonPath];
		
		// 読み込んだjsonをオブジェクトに変換
        NSError *error ;
		NSDictionary *rootObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
		
		if (rootObj){
			
			// オブジェクトに変換できたら,results要素を取り出す。
			pins = [rootObj objectForKey:@"pins"];
            [self.searchedPins setValue:pins forKey:query];
		}else{
			NSLog(@"json parse error:%@",rootObj);
		}
	}
    
    return pins;
}

@end
