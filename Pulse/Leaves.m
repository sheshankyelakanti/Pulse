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
    
    NSURLSession * session;
    NSMutableURLRequest * URLReq;
    NSURLSessionDataTask * dataTask;
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
    self.pickerView.hidden=YES;
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
    self.leaveText.text=[leave objectAtIndex:row];
    self.pickerView.hidden=YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.leaveText)
    {
        self.pickerView.hidden=NO;
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}


- (IBAction)applyLeave:(id)sender
{
    AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    AD.reqDict = [[NSMutableDictionary alloc]init];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    URLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/NewLeaveSnippets.php"]];
    
    NSString * dataInStr = [NSString stringWithFormat:@"leaveType=%@&leaveDescription=%@&funcName=createLeave",self.leaveText.text,self.descriptionForLeave.text];
    
    [URLReq setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * dataToPassServer = [dataInStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString * postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[dataToPassServer length]];
    
    [URLReq setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [URLReq setHTTPBody:dataToPassServer];
    
    URLReq.HTTPMethod = @"POST";
    
    dataTask = [session dataTaskWithRequest:URLReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                {
                    NSLog(@"Got Responce From Server");
                    AD.reqDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"dict ** %@",AD.userDict);
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        self.leaveText.text=@"";
                        self.descriptionForLeave.text=@"";
                    });
                    
                }];
    if ([self.leaveText.text isEqualToString:@""]||[self.descriptionForLeave.text isEqualToString:@""])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"sorry" message:@"enter valid details" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [dataTask resume];
}
@end
