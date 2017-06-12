//
//  AttendenceDetailsCell.h
//  Pulse
//
//  Created by student on 6/8/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendenceDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numCount;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *day;

@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *dates;
@property (weak, nonatomic) IBOutlet UILabel *days;
@property (weak, nonatomic) IBOutlet UILabel *checkIn;
@property (weak, nonatomic) IBOutlet UILabel *checkOut;
@property (weak, nonatomic) IBOutlet UILabel *timeSpent;
@property (weak, nonatomic) IBOutlet UILabel *spentSummary;
@property (weak, nonatomic) IBOutlet UILabel *points;


@end
