//
//  CreateAccount.m
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "CreateAccount.h"

@interface CreateAccount ()
{
    NSArray * gender;
}
@end

@implementation CreateAccount

-(IBAction)chooseImage
{
    picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    gender=@[@"male",@"female",@"other"];
    
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
    return gender.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [gender objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.chooseGender.text=gender[row];
}

- (IBAction)submit:(id)sender
{
    NSLog(@"%@",self.userName.text);
    NSLog(@"%@",self.lastName.text);
    NSLog(@"%@",self.chooseGender.text);
    NSLog(@"%@",self.mobileNo.text);
    NSLog(@"%@",self.city.text);
    NSLog(@"%@",self.chooseState.text);
    NSLog(@"%@",self.email.text);
    NSLog(@"%@",self.password.text);
    NSLog(@"%@",self.retypePassword.text);
    
    if ([self.userName.text isEqualToString:@""]||[self.lastName.text isEqualToString:@""]||[self.chooseGender.text isEqualToString:@""]||[self.mobileNo.text isEqualToString:@""]||[self.city.text isEqualToString:@""]||[self.chooseState.text isEqualToString:@""]||[self.email.text isEqualToString:@""]||[self.password.text isEqualToString:@""]||[self.retypePassword.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"sorry" message:@"enter Details" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
