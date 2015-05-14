//
//  MatchesWidgetDataHandler.m
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/4/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "MatchesWidgetDataHandler.h"
#import "MatchesWidgetData.h"
#import "WidgetMatchModel.h"

@implementation MatchesWidgetDataHandler



static NSArray *allMatches;


+ (NSMutableArray *) getYesterdayMatches:(NSArray *)allMatches{

    NSArray   *yesterdayMatchestemp=   [allMatches objectAtIndex:0];
    NSMutableArray *yesterdayMatchesArray =[ [NSMutableArray alloc] init];
    
    for (int i=0 ;i<[yesterdayMatchestemp  count];i++) {
        
        WidgetMatchModel *matchModel =[[WidgetMatchModel alloc] init];
        
        matchModel.club1Name=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"FClubName"];
        matchModel.club2Name=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"SClubName"];
        matchModel.matchPlace = [[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"Place"];
        matchModel.timeOfTheWidgetMatch = [[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"Time"];
        matchModel.teamImageUrl1=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"FClubLogo"];
        matchModel.teamImageUrl2= [[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"SClubLogo"];
        matchModel.widgetMatchStatus=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"MatchStatus"];
        matchModel.score1=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"FClubScoreResult"];
        matchModel.score2=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"SClubScoreResult"];
        
        matchModel.liveScore1=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"FClubScoreLive"];
        matchModel.liveScore2=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"SClubScoreLive"];
        matchModel.penScore1= [[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"FClubScorePen"];
        matchModel.penScore2= [[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"SClubScorePen"];
        
        matchModel.champId=[[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"Champid"] intValue];
        matchModel.matchFormattedDate=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"FormattedDate"];
        matchModel.matchChampName=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"ChampName"];
        matchModel.ChampLogo=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"ChampLogo"];
        matchModel.club1ID=[[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"club1Id"] intValue];
        matchModel.club2ID=[[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"club2Id"] intValue];
        matchModel.matchDate=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"Date"];
        matchModel.channels=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"channels"];
        matchModel.team1Coach=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"FACoachName"];
        matchModel.team2Coach=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"SACoachName"];
        matchModel.statusID=  [[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"statusId"]intValue];
        matchModel.widgetNumberOfLiveMatches=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"NumOfLiveMatches"];
        matchModel.isLive=[[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"isLive"] boolValue];
        matchModel.championsMatches=[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"ChampionshipsNumOfMatches"];
        matchModel.iDProperty=[[[yesterdayMatchestemp objectAtIndex:i] objectForKey:@"ID"] intValue];
        [yesterdayMatchesArray addObject:matchModel];
    }

    
    return yesterdayMatchesArray;

}

+ (NSMutableArray *) getTodayMatches:(NSArray *)allMatches{

    NSArray   *todayMatchestemp=[allMatches objectAtIndex:1];
    NSMutableArray *todayMatchesArray=[[NSMutableArray alloc] init];
    
    for (int i=0 ;i<[todayMatchestemp  count];i++) {
        
        WidgetMatchModel *matchModel =[[WidgetMatchModel alloc] init];
        
        matchModel.club1Name=[[todayMatchestemp objectAtIndex:i] objectForKey:@"FClubName"];
        matchModel.club2Name=[[todayMatchestemp objectAtIndex:i] objectForKey:@"SClubName"];
        matchModel.matchPlace = [[todayMatchestemp objectAtIndex:i] objectForKey:@"Place"];
        matchModel.timeOfTheWidgetMatch = [[todayMatchestemp objectAtIndex:i] objectForKey:@"Time"];
        matchModel.teamImageUrl1=[[todayMatchestemp objectAtIndex:i] objectForKey:@"FClubLogo"];
        matchModel.teamImageUrl2= [[todayMatchestemp objectAtIndex:i] objectForKey:@"SClubLogo"];
        matchModel.widgetMatchStatus=[[todayMatchestemp objectAtIndex:i] objectForKey:@"MatchStatus"];
        matchModel.score1=[[todayMatchestemp objectAtIndex:i] objectForKey:@"FClubScoreResult"];
        matchModel.score2=[[todayMatchestemp objectAtIndex:i] objectForKey:@"SClubScoreResult"];
        
        matchModel.liveScore1=[[todayMatchestemp objectAtIndex:i] objectForKey:@"FClubScoreLive"];
        matchModel.liveScore2=[[todayMatchestemp objectAtIndex:i] objectForKey:@"SClubScoreLive"];
        matchModel.penScore1=[[todayMatchestemp objectAtIndex:i] objectForKey:@"FClubScorePen"];
        matchModel.penScore2=[[todayMatchestemp objectAtIndex:i] objectForKey:@"SClubScorePen"];
        
        matchModel.champId=[[[todayMatchestemp objectAtIndex:i] objectForKey:@"Champid"] intValue];
        matchModel.matchFormattedDate=[[todayMatchestemp objectAtIndex:i] objectForKey:@"FormattedDate"];
        matchModel.matchChampName=[[todayMatchestemp objectAtIndex:i] objectForKey:@"ChampName"];
        matchModel.ChampLogo=[[todayMatchestemp objectAtIndex:i] objectForKey:@"ChampLogo"];
        matchModel.club1ID=[[[todayMatchestemp objectAtIndex:i] objectForKey:@"club1Id"] intValue];
        matchModel.club2ID=[[[todayMatchestemp objectAtIndex:i] objectForKey:@"club2Id"] intValue];
        matchModel.matchDate=[[todayMatchestemp objectAtIndex:i] objectForKey:@"Date"];
        matchModel.channels=[[todayMatchestemp objectAtIndex:i] objectForKey:@"channels"];
        matchModel.team1Coach=[[todayMatchestemp objectAtIndex:i] objectForKey:@"FACoachName"];
        matchModel.team2Coach=[[todayMatchestemp objectAtIndex:i] objectForKey:@"SACoachName"];
        matchModel.statusID=  [[[todayMatchestemp objectAtIndex:i] objectForKey:@"statusId"]intValue];
        matchModel.widgetNumberOfLiveMatches=[[todayMatchestemp objectAtIndex:i] objectForKey:@"NumOfLiveMatches"];
        matchModel.isLive=[[[todayMatchestemp objectAtIndex:i] objectForKey:@"isLive"] boolValue];
        matchModel.championsMatches=[[todayMatchestemp objectAtIndex:i] objectForKey:@"ChampionshipsNumOfMatches"];
        matchModel.iDProperty=[[[todayMatchestemp objectAtIndex:i] objectForKey:@"ID"] intValue];
        matchModel.matchStartTime=[[todayMatchestemp objectAtIndex:i] objectForKey:@"StartTime"];
        NSLog(@"start time %@",matchModel.matchStartTime);
        [todayMatchesArray addObject:matchModel];
        
    }

    
    return todayMatchesArray;

}

+ (NSMutableArray *) getTomorrowMatches:(NSArray *)allMatches{
    
    
    NSArray   *tomorrowMatchestemp=[allMatches objectAtIndex:2];
    NSMutableArray *tomorrowMatchesArray=[[NSMutableArray alloc] init];
    
    for (int i=0 ;i<[tomorrowMatchestemp  count];i++) {
        
        WidgetMatchModel *matchModel =[[WidgetMatchModel alloc] init];
        
        
        matchModel.club1Name=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"FClubName"];
        matchModel.club2Name=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"SClubName"];
        matchModel.matchPlace = [[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"Place"];
        matchModel.timeOfTheWidgetMatch = [[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"Time"];
        matchModel.teamImageUrl1=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"FClubLogo"];
        matchModel.teamImageUrl2= [[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"SClubLogo"];
        matchModel.widgetMatchStatus=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"MatchStatus"];
        matchModel.score1=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"FClubScoreResult"];
        matchModel.score2=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"SClubScoreResult"];
        
        matchModel.liveScore1=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"FClubScoreLive"];
        matchModel.liveScore2=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"SClubScoreLive"];
        matchModel.penScore1=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"FClubScorePen"];
        matchModel.penScore2=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"SClubScorePen"];
        
        matchModel.champId=[[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"Champid"] intValue];
        matchModel.matchFormattedDate=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"FormattedDate"];
        matchModel.matchChampName=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"ChampName"];
        matchModel.ChampLogo=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"ChampLogo"];
        matchModel.club1ID=[[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"club1Id"] intValue];
        matchModel.club2ID=[[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"club2Id"] intValue];
        matchModel.matchDate=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"Date"];
        matchModel.channels=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"channels"];
        matchModel.team1Coach=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"FACoachName"];
        matchModel.team2Coach=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"SACoachName"];
        matchModel.statusID=  [[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"statusId"]intValue];
        matchModel.widgetNumberOfLiveMatches=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"NumOfLiveMatches"];
        matchModel.isLive=[[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"isLive"] boolValue];
        matchModel.championsMatches=[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"ChampionshipsNumOfMatches"];
        matchModel.iDProperty=[[[tomorrowMatchestemp objectAtIndex:i] objectForKey:@"ID"] intValue];
       [tomorrowMatchesArray addObject:matchModel];
    }
    
    return tomorrowMatchesArray;


}

@end
