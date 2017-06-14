//
//  CreateAccount.m
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "CreateAccount.h"
#import "AppDelegate.h"
@interface CreateAccount ()
{
    NSArray * gender;
    NSURLSession * session;
    NSMutableURLRequest * URLReq;
    NSURLSessionDataTask * dataTask;
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
    AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    AD.reqDict = [[NSMutableDictionary alloc]init];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    URLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/ValidateLogin.php"]];
    
    NSString * dataInStr = [NSString stringWithFormat:@"firstName=%@&lastName=%@&gender=%@&mobileNum=%@&city=%@&state=%@&email=%@&password=%@&funcName=registerUser",self.userName.text,self.lastName.text,self.chooseGender.text,self.mobileNo.text,self.city.text,self.chooseState.text,self.email.text,self.password.text];
    
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
                        
                    });
                    
                }];
    
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
