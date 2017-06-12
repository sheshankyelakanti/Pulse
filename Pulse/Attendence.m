//
//  Attendence.m
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "Attendence.h"
#import "AttendanceCustom.h"
#import "SWRevealViewController.h"

@interface Attendence ()
{
    NSMutableArray * summary;
    AppDelegate * AD;
}

@end

@implementation Attendence

- (void)viewDidLoad {
    [super viewDidLoad];
    AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    SWRevealViewController * revealController = self.revealViewController;
    if (revealController)
    {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    summary = [[NSMutableArray alloc]initWithObjects:@"Total Days",@"Working Days",@"Leaves",@"Absents",@"Days Attended",@"Updates Sent",@"Working Hours",@"Worked Hours",@"Overall Spent Summary",@"Worked Per day(Avg.Hrs)",@"Shortage Per day(Avg.Hrs)",@"Late to Office",@"Minimum Hrs Missed",@"Max Points",@"Points Earned",@"Your Performance Score", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return summary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttendanceCustom * cells = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cells.customLabel.text = [summary objectAtIndex:indexPath.row];
    NSString * str = [NSString stringWithFormat:@"%@",[AD.summaryData objectAtIndex:indexPath.row]];
    cells.customValue.text = str;
    return cells;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
