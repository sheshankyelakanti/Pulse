//
//  updates.h
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface updates : UIViewController<NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@property (weak, nonatomic) IBOutlet UITextField *nineText;
@property (weak, nonatomic) IBOutlet UITextField *tenText;
@property (weak, nonatomic) IBOutlet UITextField *elevenText;
@property (weak, nonatomic) IBOutlet UITextField *twelveText;
@property (weak, nonatomic) IBOutlet UITextField *oneText;
@property (weak, nonatomic) IBOutlet UITextField *twoText;
@property (weak, nonatomic) IBOutlet UITextField *threeText;
@property (weak, nonatomic) IBOutlet UITextField *fourText;
@property (weak, nonatomic) IBOutlet UITextField *fiveText;
@property (weak, nonatomic) IBOutlet UITextField *leftText;
- (IBAction)UpdateButton:(id)sender;
@end
