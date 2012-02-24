//
//  MTLSampleMasterViewController.m
//  pintarest
//
//  Created by Funami Takao on 12/02/24.
//  Copyright (c) 2012年 Recruit. All rights reserved.
//

#import "MTLSampleMasterViewController.h"

#import "MTLSampleDetailViewController.h"
#import "MTLPinModelManager.h"
#import "MTLSampleMasterCellViewCell.h"
#import "EGOCache.h"

@interface MTLSampleMasterViewController () {
    NSArray *_objects;
}
@property (nonatomic,strong) NSArray *objects;
@end

@implementation MTLSampleMasterViewController
@synthesize objects = _objects;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    MTLPinModelManager *mgr = [MTLPinModelManager sharedManager];
    self.objects = [mgr searchPins:@"station"]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTLSampleMasterCellViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell"];

    NSDictionary *object = [self.objects objectAtIndex:indexPath.row];
    
    NSLog(@"object:%@",object);

    cell.userName.text = [[object objectForKey:@"user"]objectForKey:@"username"] ;
    cell.title.text = [[object objectForKey:@"user"]objectForKey:@"full_name"] ;
    NSString *thumbnailURL = [[object objectForKey:@"images"]objectForKey:@"thumbnail"];
    
    cell.key = [object objectForKey:@"id"];
    UIImage *image = [[EGOCache currentCache] imageForKey:cell.key];
    if (image){
        cell.userImageView.image = image;
    }else{
        cell.userImageView.image = nil;
        /*
        cell.userImageView.image = nil;
        NSBlockOperation* operation = [NSBlockOperation blockOperationWithBlock: ^{
            NSURL *url = [NSURL URLWithString: thumbnailURL];
            NSData *data = [NSData dataWithContentsOfURL: url];
            UIImage *image = [UIImage imageWithData: data]; 
            if (image){
                [[EGOCache currentCache] setImage:image forKey:key withTimeoutInterval:3600*24];
                [cell.userImageView setImage:image];
                
                [cell.userImageView performSelectorOnMainThread:@selector(setImage:) 
                                                     withObject:image 
                                                  waitUntilDone:YES];
            }
        }];
        [operation start];
        cell.currentOperation = operation;
        */
        [cell.progress startAnimating];
        __block NSString *key_org = [cell.key copy];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            
            NSURL *url = [NSURL URLWithString: thumbnailURL];
            NSData *data = [NSData dataWithContentsOfURL: url];
            UIImage *image = [UIImage imageWithData: data];
            
            // 画像の読み込みとキャッシュへの登録
            // dispatch_asyncはキャンセルできないよね。たしか。NSOperationを使うべきか...
            // とりあえず、呼び出し時と同じIDかどうかをチェックしてしのいでいる。
             if (image && [key_org isEqualToString:cell.key]) {
                [[EGOCache currentCache] setImage:image forKey:key_org withTimeoutInterval:3600*24];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     cell.userImageView.image = image;
                     [cell.progress stopAnimating];
                 });
             }
        });
        
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
