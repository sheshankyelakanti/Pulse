//
//  updates.m
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "updates.h"
#import "SWRevealViewController.h"

@interface updates ()
{
    NSURLSession * session;
    NSMutableURLRequest * URLReq;
    NSURLSessionDataTask * dataTask;
}

@end

@implementation updates

- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController * controller = self.revealViewController;
    if (controller)
    {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UpdateButton:(id)sender
{
    AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    AD.reqDict = [[NSMutableDictionary alloc]init];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    URLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/NewDailyStatusUpdateSnippets.php"]];
    
    NSString * dataInStr = [NSString stringWithFormat:@"morningNine=%@&morningTen=%@&morningEleven=%@&afternoonTwelve=%@&afternoonOne=%@&afternoonTwo=%@&afternoonThree=%@&eveningFour=%@&eveningFive=%@&eveningSixAndAbove=%@&funcName=createUpdate",self.nineText.text,self.tenText.text,self.elevenText.text,self.twelveText.text,self.oneText.text,self.twoText.text,self.threeText.text,self.fourText.text,self.fiveText.text,self.leftText.text];

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
                dispatch_sync(dispatch_get_main_queue(), ^{
                   self.nineText.text=@"";
                    self.tenText.text=@"";
                    self.elevenText.text=@"";
                    self.twelveText.text=@"";
                    self.oneText.text=@"";
                    self.twoText.text=@"";
                    self.threeText.text=@"";
                    self.fourText.text=@"";
                    self.fiveText.text=@"";
                    self.leftText.text=@"";
                });
    }];
    if ([self.nineText.text isEqualToString:@""]||[self.tenText.text isEqualToString:@""]||[self.elevenText.text isEqualToString:@""]||[self.twelveText.text isEqualToString:@""]||[self.oneText.text isEqualToString:@""]||[self.twoText.text isEqualToString:@""]||[self.threeText.text isEqualToString:@""]||[self.fourText.text isEqualToString:@""]||[self.fiveText.text isEqualToString:@""]||[self.leftText.text isEqualToString:@""])
    {
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"sorry" message:@"enter Details" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
   [dataTask resume];
}
@end
