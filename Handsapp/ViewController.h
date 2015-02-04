//
//  ViewController.h
//  Handsapp
//
//  Created by Yifang Zhang on 1/12/15.
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/* table properties */
@property (strong, nonatomic) NSMutableArray * tableData;
@property (weak, nonatomic) IBOutlet UITableView *notificationTable;


/* uploading functions */
-(void)uploadToken;

/* download functions */
- (IBAction)downloadSendToAllNotification:(id)sender;

/* updating shop info function */
-(void)downloadShopInfo; //TODO: real implementation with test on real server


@end

