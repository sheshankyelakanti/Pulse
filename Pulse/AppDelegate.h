//
//  AppDelegate.h
//  Pulse
//
//  Created by student on 6/5/17.
//  Copyright © 2017 sheshank.ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSMutableDictionary * reqDict;
@property NSArray * userDict;
@property NSMutableArray * summaryData;

@property NSMutableArray * dayCount;
@property NSMutableArray * date;
@property NSMutableArray * day;
@property NSMutableArray * checkIn;
@property NSMutableArray * checkOut;
@property NSMutableArray * timeSpent;
@property NSMutableArray * spentSummary;
@property NSMutableArray * points;
@property NSMutableArray * dayType;
@end

