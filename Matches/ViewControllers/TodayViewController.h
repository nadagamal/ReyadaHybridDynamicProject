//
//  TodayViewController.h
//  MatchesWidget
//
//  Created by Yomna Ahmed on 10/23/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TodayViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{

    int whichButtonIsTapped;
    NSString *hi;
    BOOL isFail;


}



@property (strong, nonatomic) NSMutableArray *yesterdayMatches;

@property (strong, nonatomic) NSMutableArray *todayMatches;

@property (strong, nonatomic)  NSMutableArray *tomorrowMatches;

@property (strong, nonatomic)  NSArray *widgetAllMatches;

@property (strong, nonatomic) UILabel *noMatchesView;



@end
