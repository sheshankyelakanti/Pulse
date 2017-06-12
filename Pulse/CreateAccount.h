//
//  CreateAccount.h
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccount : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController * picker;
    UIImage * image;
    IBOutlet UIImageView * imageView;
}

-(IBAction)chooseImage;


@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *chooseGender;
@property (weak, nonatomic) IBOutlet UITextField *mobileNo;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *chooseState;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *retypePassword;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


@end
