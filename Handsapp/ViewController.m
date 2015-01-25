//
//  ViewController.m
//  Handsapp
//
//  Created by Yifang Zhang on 1/12/15.
//  Copyright (c) 2015 Tailung. All rights reserved.
//

#import "ViewController.h"
#include "Handsapp_Header.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* upload the iphone device token */
    [self uploadToken];
    
    /* init tableData if it is not exist */
    self.tableData = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tableData"];
    if(!self.tableData ){
        self.tableData = [[NSMutableArray alloc] initWithCapacity:__MAX_DATA_LENGTH];
        [[NSUserDefaults standardUserDefaults] setObject: self.tableData forKey: @"tableData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"reloadTheTable" object:nil];
     
    }/**/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Methods

//instantly update the table and limit to 20 item
/*
- (void)reloadTable:(NSNotification *)notification
{
    //NSLog(@"updating the data");
    
    self.tableData = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tableData"];
    if (self.tableData.count > 20) {
        self.tableData =  [[self.tableData subarrayWithRange:NSMakeRange(([self.tableData count]-20), [self.tableData count]-1)] mutableCopy];;
    }
    [self.notificationTable reloadData];
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

// creates the cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:5];
    
    label.text = [self.tableData objectAtIndex:indexPath.row];
    //cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark Upload Functions

-(void)uploadToken
{
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"];
    //NSLog(@"device token in upload: %@ ", deviceToken);
    /*
    NSString * locationURL = @"http://192.168.180.4/Yifang/pushNotification/testInsertUser.php";
    
    NSString *urlString = [NSString stringWithFormat:@"%@?IOStoken=%@", locationURL, deviceToken];
    
    urlString =[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body= [NSMutableData data];
    
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:nil];
    
    //NSLog(@"%@",returnData);
    */
    
    NSString *post =[[NSString alloc] initWithFormat:@"token=%@",deviceToken];
    NSLog(@"PostData: %@",post);
    NSURL *url=[NSURL URLWithString:@"http://192.168.180.4/Yifang/pushNotification6.0/testInsertUser.php"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"Response code: %ld", (long)[response statusCode]);
}

#pragma mark Download Functions

- (IBAction)downloadSendToAllNotification:(id)sender {
    
    
    
    NSString * locationURL = @"http://192.168.180.4/Yifang/pushNotification6.0/sqlToJsonMessages.php"; // add the correct url here
    NSURL * url = [NSURL URLWithString:locationURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSMutableArray * jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSMutableArray * newTableData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSString * messageContent = [[jsonArray objectAtIndex:i] objectForKey:@"msg"];
        NSString * messageTime = [[jsonArray objectAtIndex:i] objectForKey:@"time_sent"];
        
        [newTableData addObject:[NSString stringWithFormat:@"%@ at (%@)", messageContent, messageTime]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject: newTableData forKey: @"tableData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.tableData = newTableData;
    
    [self.notificationTable reloadData];
    
    
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];

    //animation.type = kCATransitionFade;
    [[self.notificationTable layer] addAnimation:animation forKey:nil];
    
    
}










@end
