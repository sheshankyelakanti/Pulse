//
//  AttendenceDetails.h
//  Pulse
//
//  Created by student on 6/7/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendenceDetails : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
