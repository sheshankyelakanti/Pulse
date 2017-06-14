//
//  ForgotPassword.m
//  Pulse
//
//  Created by student on 6/10/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "ForgotPassword.h"
#import "AppDelegate.h"

@interface ForgotPassword ()
{
    NSURLSession * session;
    NSMutableURLRequest * URLReq;
    NSURLSessionDataTask * dataTask;
}

@end

@implementation ForgotPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submit:(id)sender
{
    if ([self.emailText.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"sorry" message:@"enter Details" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        AD.reqDict = [[NSMutableDictionary alloc]init];
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        URLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/ValidateLogin.php"]];
        
        NSString * dataInStr = [NSString stringWithFormat:@"fpRegisteredEmail=%@&funcName=forgotPassword",self.emailText.text];
        
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
                            self.emailText.text=@"";
                        });
                        
                    }];

    }
    [dataTask resume];
}
@end
