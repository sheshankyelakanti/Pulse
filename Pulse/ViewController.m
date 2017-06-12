//
//  ViewController.m
//  Pulse
//
//  Created by student on 6/5/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "CreateAccount.h"
#import "ForgotPassword.h"

@interface ViewController ()
{
    NSURLSession * session;
    NSMutableURLRequest * URLReq;
    NSURLSessionDataTask * dataTask;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loginData
{
    AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    AD.reqDict = [[NSMutableDictionary alloc]init];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    URLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/ValidateLogin.php"]];
    
    NSString * dataInStr = [NSString stringWithFormat:@"registeredEmail=%@&registeredPassword=%@&funcName=verifyLogin",self.userName.text,self.passWord.text];
    
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
        NSLog(@"dict ** %@",AD.reqDict);
        
        if ([[AD.reqDict objectForKey:@"loggedIn"]isEqualToString:@"yes"]) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self getData];
                [dataTask resume];
            });
        }
    }];
}

-(void)getData
{
    AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    AD.userDict = [[NSArray alloc]init];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    URLReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/DashboardSnippets.php"]];
    
    NSString * dataInStr = @"funcName=getUserAttendance";
    
    [URLReq setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData *dataToPassToServer = [dataInStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[dataToPassToServer length]];
    
    [URLReq setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [URLReq setHTTPBody:dataToPassToServer];
    
    URLReq.HTTPMethod = @"POST";
    
    dataTask = [session dataTaskWithRequest:URLReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"got response from pulse server");
        AD.userDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"server response is %@",AD.userDict);
        
        AD.dayCount = [[NSMutableArray alloc]init];
        AD.date = [[NSMutableArray alloc]init];
        AD.day = [[NSMutableArray alloc]init];
        AD.checkIn = [[NSMutableArray alloc]init];
        AD.checkOut = [[NSMutableArray alloc]init];
        AD.timeSpent = [[NSMutableArray alloc]init];
        AD.spentSummary = [[NSMutableArray alloc]init];
        AD.points = [[NSMutableArray alloc]init];
        AD.dayType = [[NSMutableArray alloc]init];
        
        for (int i=(int)AD.userDict.count-1; i>=0; i--) {
            
            if (i>0)
            {
                [AD.dayCount addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"attendanceDayCount"]];
                [AD.date addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"attendanceDate"]];
                [AD.day addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"attendanceDay"]];
                [AD.checkIn addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"checkIn"]];
                [AD.checkOut addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"checkOut"]];
                [AD.timeSpent addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"timeSpent"]];
                [AD.spentSummary addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"shortageExcessTime"]];
                [AD.points addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"totalPoints"]];
                [AD.dayType addObject:[[AD.userDict objectAtIndex:i]objectForKey:@"dayType"]];
            }
            else
            {
                AD.summaryData = [[NSMutableArray alloc]init];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalDays"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalWorkingDays"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalLeaves"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalAbsents"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalDaysAttended"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalUpdatesSent"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalWorkingHours"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalWorkedHours"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"totalShortageHours"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"avgWorkingHours"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"avgShortageHours"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"numberOfTimesLateToOffice"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"numberOfTimesMinimumHoursMissed"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"maxPoints"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"pointsScored"]];
                [AD.summaryData addObject:[[AD.userDict objectAtIndex:0]objectForKey:@"percScored"]];
            }
        }
        NSLog(@"%lu",AD.checkOut.count);
        if (AD.summaryData.count>0) {
            dispatch_async(dispatch_get_main_queue(),^{
                SWRevealViewController * SW = [self.storyboard instantiateViewControllerWithIdentifier:@"reveal"];
                [self presentViewController:SW animated:YES completion:nil];
            });
        }
        else
        {
            NSLog(@"sorry !");
        }
    }];
}


- (IBAction)loginButton:(id)sender
{
    [self loginData];
    [dataTask resume];
    if ([self.userName.text isEqualToString:@""] || [self.passWord.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"sorry" message:@"enter emailID and password" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)createAccountButton:(id)sender
{
    CreateAccount * details =[self.storyboard instantiateViewControllerWithIdentifier:@"create"];
    [self.navigationController pushViewController:details animated:YES];
}
- (IBAction)forgotPassword:(id)sender
{
    ForgotPassword * forgot=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPassword"];
    [self.navigationController pushViewController:forgot animated:YES];
}
@end
