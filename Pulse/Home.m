//
//  Home.m
//  Pulse
//
//  Created by student on 6/6/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuButton setTarget: self.revealViewController];
        [self.menuButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    AppDelegate * AD = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.name.text = [NSString stringWithFormat:@"%@",[AD.reqDict objectForKey:@"firstName"]];
    self.name1.text = [NSString stringWithFormat:@"%@",[AD.reqDict objectForKey:@"surName"]];
    NSString * length =[AD.reqDict objectForKey:@"profileImagePath"];
    NSString * from = [length substringFromIndex:2];
    NSString * path = [NSString stringWithFormat:@"http://www.brninfotech.com/pulse/modules%@",from];
    NSURL * URLImage = [NSURL URLWithString:path];
    NSData * data = [[NSData alloc]initWithContentsOfURL:URLImage];
    self.image.image = [UIImage imageWithData:data];
    self.batchID.text = [NSString stringWithFormat:@"%@",[AD.reqDict objectForKey:@"batchID"]];
    self.studentID.text = [NSString stringWithFormat:@"%@",[AD.reqDict objectForKey:@"studentID"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self performSelector:@selector(setStyle:) withObject:self.image afterDelay:0];
}

-(void)setStyle:(UIImageView*)image
{
    image.layer.cornerRadius=self.image.frame.size.width/2.0;
    image.clipsToBounds=YES;
}
@end
