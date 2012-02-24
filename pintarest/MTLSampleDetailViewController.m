//
//  MTLSampleDetailViewController.m
//  pintarest
//
//  Created by Funami Takao on 12/02/24.
//  Copyright (c) 2012年 Recruit. All rights reserved.
//

#import "MTLSampleDetailViewController.h"
#import "EGOCache.h"

@interface MTLSampleDetailViewController ()
- (void)configureView;
@end

@implementation MTLSampleDetailViewController

@synthesize detailItem = _detailItem;
@synthesize image = _image;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
        
        NSString *closeupURL = [[self.detailItem objectForKey:@"images"]objectForKey:@"closeup"]; 
        NSString *key = [NSString stringWithFormat:@"closeup%@",[self.detailItem objectForKey:@"id"]];
        
        UIImage *img = [[EGOCache currentCache] imageForKey:key];
        if (img){
            self.image.image = img;
        }else{
            
            NSString *thum_key = [self.detailItem objectForKey:@"id"];
            
            UIImage *thum = [[EGOCache currentCache] imageForKey:thum_key];
            if (thum){
                self.image.image = thum;
            }
            

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                
                NSURL *url = [NSURL URLWithString: closeupURL];
                NSData *data = [NSData dataWithContentsOfURL: url];
                UIImage *img = [UIImage imageWithData: data];
                
                // 画像の読み込みとキャッシュへの登録
                // dispatch_asyncはキャンセルできないよね。たしか。NSOperationを使うべきか...
                // とりあえず、呼び出し時と同じIDかどうかをチェックしてしのいでいる。
                if (img) {
                    [[EGOCache currentCache] setImage:img forKey:key withTimeoutInterval:3600*24];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image.image = img;
                    });
                }
            });
            
        }

        
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
