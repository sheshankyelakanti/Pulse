//
//  ViewController.h
//  Pulse
//
//  Created by student on 6/5/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController<NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)loginButton:(id)sender;
- (IBAction)createAccountButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)forgotPassword:(id)sender;

@end

