//
//  WidgetMatchModel.m
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/2/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "WidgetMatchModel.h"

@implementation WidgetMatchModel

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.club1ID = [aDecoder decodeIntForKey:@"club1Id"];
    self.timeOfTheWidgetMatch = [aDecoder decodeObjectForKey:@"Time"];
    self.champLogo = [aDecoder decodeObjectForKey:@"ChampLogo"];
    self.penScore2 = [aDecoder decodeObjectForKey:@"SClubScorePen"];
    self.team1Coach = [aDecoder decodeObjectForKey:@"FACoachName"];
    self.teamImageUrl2 = [aDecoder decodeObjectForKey:@"SClubLogo"];
    self.score2 = [aDecoder decodeObjectForKey:@"SClubScoreResult"];
    self.team2Coach = [aDecoder decodeObjectForKey:@"SACoachName"];
    self.teamImageUrl1 = [aDecoder decodeObjectForKey:@"FClubLogo"];
    self.liveScore2 = [aDecoder decodeObjectForKey:@"SClubScoreLive"];
    self.statusID = [aDecoder decodeIntForKey:@"statusId"];
    self.matchChampName = [aDecoder decodeObjectForKey:@"ChampName"];
    self.liveScore1 = [aDecoder decodeObjectForKey:@"FClubScoreLive"];
    self.matchDate = [aDecoder decodeObjectForKey:@"Date"];
    self.club2Name = [aDecoder decodeObjectForKey:@"SClubName"];
    self.matchFormattedDate = [aDecoder decodeObjectForKey:@"FormattedDate"];
    self.widgetNumberOfLiveMatches = [aDecoder decodeObjectForKey:@"NumOfLiveMatches"];
    self.score1 = [aDecoder decodeObjectForKey:@"FClubScoreResult"];
    self.champId = [aDecoder decodeIntForKey:@"Champid"];
    self.penScore1 = [aDecoder decodeObjectForKey:@"FClubScorePen"];
    self.iDProperty = [aDecoder decodeIntForKey:@"ID"];
    self.widgetMatchStatus = [aDecoder decodeObjectForKey:@"MatchStatus"];
    self.club2ID = [aDecoder decodeIntForKey:@"club2Id"];
    self.isLive = [aDecoder decodeBoolForKey:@"isLive"];
    self.championsMatches = [aDecoder decodeObjectForKey:@"ChampionshipsNumOfMatches"];
    self.club1Name = [aDecoder decodeObjectForKey:@"FClubName"];
    self.matchPlace = [aDecoder decodeObjectForKey:@"Place"];
    self.channels = [aDecoder decodeObjectForKey:@"channels"];
    self.matchStartTime = [aDecoder decodeObjectForKey:@"StartTime"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInt:self.club1ID forKey:@"club1Id"];
    [aCoder encodeObject:self.timeOfTheWidgetMatch forKey:@"Time"];
    [aCoder encodeObject:self.ChampLogo forKey:@"ChampLogo"];
    [aCoder encodeObject:self.penScore2 forKey:@"SClubScorePen"] ;
    [aCoder encodeObject:self.team1Coach forKey:@"FACoachName"];
    [aCoder encodeObject:self.teamImageUrl2 forKey:@"SClubLogo"];
    [aCoder encodeObject:self.score2 forKey:@"SClubScoreResult"];
    [aCoder encodeObject:self.team2Coach forKey:@"SACoachName"];
    [aCoder encodeObject:self.teamImageUrl1 forKey:@"FClubLogo"];
    [aCoder encodeObject:self.liveScore2 forKey:@"SClubScoreLive"];
    [aCoder encodeInt:self.statusID forKey:@"statusId"];
    [aCoder encodeObject:self.matchChampName forKey:@"ChampName"];
    [aCoder encodeObject:self.liveScore1 forKey:@"FClubScoreLive"];
    [aCoder encodeObject:self.matchDate forKey:@"Date"];
    [aCoder encodeObject:self.club2Name forKey:@"SClubName"];
    [aCoder encodeObject:self.matchFormattedDate forKey:@"FormattedDate"];
    [aCoder encodeObject:self.widgetNumberOfLiveMatches forKey:@"NumOfLiveMatches"];
    [aCoder encodeObject:self.score1 forKey:@"FClubScoreResult"];
    [aCoder encodeInt:self.champId forKey:@"Champid"];
    [aCoder encodeObject:self.penScore1 forKey:@"FClubScorePen"];
    [aCoder encodeInt:self.iDProperty forKey:@"ID"];
    [aCoder encodeObject:self.widgetMatchStatus forKey:@"MatchStatus"];
    [aCoder encodeInt:self.club2ID forKey:@"club2Id"];
    [aCoder encodeBool:self.isLive forKey:@"isLive"];
    [aCoder encodeObject:self.championsMatches forKey:@"ChampionshipsNumOfMatches"];
    [aCoder encodeObject:self.club1Name forKey:@"FClubName"];
    [aCoder encodeObject:self.matchPlace forKey:@"Place"];
    [aCoder encodeObject:self.channels forKey:@"channels"];
    [aCoder encodeObject:self.matchStartTime forKey:@"StartTime"];

}
@end
