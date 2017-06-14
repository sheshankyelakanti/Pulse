//
//  CreateRequest.m
//  Pulse
//
//  Created by student on 6/8/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "CreateRequest.h"
#import "SWRevealViewController.h"

@interface CreateRequest ()
{
//    UIPickerView * createRequest;
//    UIPickerView * labNum;
//    UIPickerView * seat;
    
    NSArray * requestArray;
    NSArray * labArray;
    NSArray * seatArray;
    
    NSString * reqString;
    NSString * labString;
    NSString * numString;
    
    NSURLSession * session;
    NSMutableURLRequest * URLReq;
    NSURLSessionDataTask * dataTask;
}
@end

@implementation CreateRequest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);

    SWRevealViewController * controller = self.revealViewController;
    if (controller)
    {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
requestArray=@[@"softWare installation",@"internet not working",@"monitor display problem",@"system hangs",@"audio not working",@"os not booting",@"install xcode",@"keyboard problem",@"mouse problem",@"Dusty room",@"cleaning required in bathroom",@"problem with chair",@"drinking water",@"no system for me",@"no marker in lab",@"others"];
    
labArray=@[@"L1H",@"L12",@"L13",@"L14",@"L2H",@"L21",@"L22",@"L23",@"L24",@"L31",@"L32",@"L33"];

seatArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25"];
        
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return requestArray.count;
    }
    else if(component==1)
    {
        
        return labArray.count;
    }
    else
    {
        if ([labString isEqualToString:@"L1H"])
        {
            return 25;
        }
        else if ([labString isEqualToString:@"L12"])
        {
            return 9;
        }
        else if ([labString isEqualToString:@"L13"])
        {
            return 9;
        }
        else if ([labString isEqualToString:@"L14"])
        {
            return 4;
        }
        else if ([labString isEqualToString:@"L2H"])
        {
            return 9;
        }
        else if ([labString isEqualToString:@"L21"])
        {
            return 9;
        }
        else if ([labString isEqualToString:@"L22"])
        {
            return 9;
        }
        else if ([labString isEqualToString:@"L23"])
        {
            return 15;
        }
        else if ([labString isEqualToString:@"L24"])
        {
            return 9;
        }
        else if ([labString isEqualToString:@"L31"])
        {
            return 9;
        }
        else if ([labString isEqualToString:@"L32"])
        {
            return 11;
        }
        else if ([labString isEqualToString:@"L33"])
        {
            return 9;
        }
        return seatArray.count;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [requestArray objectAtIndex:row];
    }
    else if(component==1)
    {
        return [labArray objectAtIndex:row];
    }
    else
    {
        return [seatArray objectAtIndex:row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
    {
        reqString=[requestArray objectAtIndex:row];
        self.requestText.text=requestArray[row];
    }
    else if(component==1)
    {
        labString=[labArray objectAtIndex:row];
        [pickerView reloadAllComponents];
        self.labIDText.text=labArray[row];
    }
    else
    {
        numString=[seatArray objectAtIndex:row];
        self.seatNumText.text=seatArray[row];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButton:(id)sender
{
    AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    AD.reqDict = [[NSMutableDictionary alloc]init];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    URLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/NewRequestSnippets.php"]];
    
    NSString * dataInStr = [NSString stringWithFormat:@"requestType=%@&locationID=%@&seatNumber=%@&requestDescription=%@&funcName=createRequest",self.requestText.text,self.labIDText.text,self.seatNumText.text,self.descriptionText.text];
    
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

    if ([self.requestText.text isEqualToString:@""]||[self.labIDText.text isEqualToString:@""]||[self.seatNumText.text isEqualToString:@""]||[self.descriptionText.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"sorry" message:@"enter Details" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok =[UIAlertAction actionWithTitle:@"done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [dataTask resume];
}
@end
