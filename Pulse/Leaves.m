//
//  Leaves.m
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "Leaves.h"
#import "SWRevealViewController.h"

@interface Leaves ()
{
    NSArray * leave;
}

@end

@implementation Leaves

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
    SWRevealViewController * controller = self.revealViewController;
    if (controller)
    {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    leave=@[@"Casual Leave",@"Sick Leave",@"Emergency Leave"];
    
    self.from.datePickerMode = UIDatePickerModeDate;
    self.from.date = [NSDate date];
    [self.from addTarget:self action:@selector(dateFrom:) forControlEvents:UIControlEventValueChanged];
    
    self.to.datePickerMode = UIDatePickerModeDate;
    self.to.date = [NSDate date];
    [self.to addTarget:self action:@selector(dateTo:) forControlEvents:UIControlEventValueChanged];
}
-(void)dateFrom:(id)sender{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString * str = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:self.from.date]];
    NSLog(@"From Date :%@",str);
}

-(void)dateTo:(id)sender{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString * str = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:self.to.date]];
    NSLog(@"From To :%@",str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return leave.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [leave objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.leaveText.text=leave[row];
}
@end
