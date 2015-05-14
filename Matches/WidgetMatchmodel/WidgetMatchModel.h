//
//  WidgetMatchModel.h
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/2/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WidgetMatchModel : NSObject


@property (strong, nonatomic) NSString *teamImageUrl2;
@property (strong, nonatomic) NSString *teamImageUrl1;
@property (strong, nonatomic) NSString  *score1;
@property (strong, nonatomic) NSString  *score2;
@property (strong, nonatomic) NSString  *liveScore1;
@property (strong, nonatomic) NSString  *liveScore2;
@property (nonatomic, assign) int  club1ID;
@property (nonatomic, assign) int  club2ID;
@property (strong, nonatomic) NSString  *penScore1;
@property (strong, nonatomic) NSString  *penScore2;
@property (nonatomic, assign) int  champId;
@property (strong, nonatomic) NSString  *widgetNumberOfLiveMatches;
@property (nonatomic, assign) int  statusID;
@property (strong, nonatomic) NSString *club1Name;
@property (strong, nonatomic) NSString *club2Name;
@property (strong, nonatomic) NSString *timeOfTheWidgetMatch;
@property (strong, nonatomic) NSString *matchDate;
@property (strong, nonatomic) NSString *matchFormattedDate;
@property (strong, nonatomic) NSString *matchChampName;
@property (strong, nonatomic) NSString *widgetMatchStatus;
@property (nonatomic, assign) BOOL isLive;
@property (strong, nonatomic) NSString *ChampLogo;
@property (strong, nonatomic) NSString *matchPlace;
@property (strong, nonatomic) NSString *channels;
@property (strong, nonatomic) NSString *matchStartTime;
@property (strong, nonatomic) NSString *team1Coach;
@property (strong, nonatomic) NSString *team2Coach;
@property (strong, nonatomic) NSString *championsMatches;
@property (nonatomic, assign) int iDProperty;






























@end
