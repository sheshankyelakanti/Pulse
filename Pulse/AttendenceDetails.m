//
//  AttendenceDetails.m
//  Pulse
//
//  Created by student on 6/7/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "AttendenceDetails.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "AttendenceDetailsCell.h"

@interface AttendenceDetails ()
{
    AppDelegate * AD;
    NSInteger selectIndex;
    NSInteger deSelectIndex;
}

@end

@implementation AttendenceDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    SWRevealViewController * controller = self.revealViewController;
    if (controller)
    {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return AD.date.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttendenceDetailsCell * cell=[self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.numCount.text=[NSString stringWithFormat:@"%@",[AD.dayCount objectAtIndex:indexPath.row]];
    cell.date.text=[NSString stringWithFormat:@"%@",[AD.date objectAtIndex:indexPath.row]];
    cell.day.text=[NSString stringWithFormat:@"%@",[AD.day objectAtIndex:indexPath.row]];
    
    cell.num.text=[NSString stringWithFormat:@"%@",[AD.dayCount objectAtIndex:indexPath.row]];
    cell.dates.text=[NSString stringWithFormat:@"%@",[AD.date objectAtIndex:indexPath.row]];
    cell.days.text=[NSString stringWithFormat:@"%@",[AD.day objectAtIndex:indexPath.row]];
    cell.checkIn.text=[NSString stringWithFormat:@"%@",[AD.checkIn objectAtIndex:indexPath.row]];
    cell.checkOut.text=[NSString stringWithFormat:@"%@",[AD.checkOut objectAtIndex:indexPath.row]];
    cell.points.text=[NSString stringWithFormat:@"%@",[AD.points objectAtIndex:indexPath.row]];
    cell.timeSpent.text=[NSString stringWithFormat:@"%@",[AD.timeSpent objectAtIndex:indexPath.row]];
    cell.spentSummary.text=[NSString stringWithFormat:@"%@",[AD.spentSummary objectAtIndex:indexPath.row]];
                            
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([indexPath compare:self.expandPath]==NSOrderedSame)
//    {
//        return 360;
//    }
//    return 40;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView beginUpdates];
//    if ([indexPath compare:self.expandPath]==NSOrderedSame)
//    {
//        self.expandPath=nil;
//    }
//    else
//    {
//        self.expandPath=indexPath;
//    }
//    [tableView endUpdates];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
