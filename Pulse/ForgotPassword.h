//
//  ForgotPassword.h
//  Pulse
//
//  Created by student on 6/10/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPassword : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
- (IBAction)submit:(id)sender;

@end
