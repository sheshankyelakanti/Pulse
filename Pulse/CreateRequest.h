//
//  CreateRequest.h
//  Pulse
//
//  Created by student on 6/8/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateRequest : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *requestText;
@property (weak, nonatomic) IBOutlet UITextField *labIDText;
@property (weak, nonatomic) IBOutlet UITextField *seatNumText;

- (IBAction)submitButton:(id)sender;

@end
