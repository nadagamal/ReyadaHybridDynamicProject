//
//  TodayViewController.m
//  MatchesWidget
//
//  Created by Yomna Ahmed on 10/23/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WidgetCellTableViewCell.h"
#import "MatchesWidgetData.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "MatchesWidgetDataHandler.h"
#import <UIKit/UIKit.h>





@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UIButton *tomorrowButton;
@property (weak, nonatomic) IBOutlet UIButton *yesterdayButton;
@property (weak, nonatomic) IBOutlet UIButton *todayButton;
@property (weak, nonatomic) IBOutlet UITableView *todayTableView;





@property (nonatomic, strong)  NSMutableArray *tomorrowChampList;
@property (nonatomic, strong)  NSMutableArray *todayChampList;
@property (nonatomic, strong)  NSMutableArray *yesterdayChampList;
@property (nonatomic, strong)  NSMutableArray *sectionsObject;



-(IBAction)selectTap1:(id)sender;
-(IBAction)selectTap2:(id)sender;
-(IBAction)selectTap3:(id)sender;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.todayButton setSelected:YES];
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
     whichButtonIsTapped=2;
    CGRect  screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.noMatchesView = [[UILabel alloc] init];
    self.noMatchesView.frame = CGRectMake(screenWidth/2-80, 50,180, 36);
    [self.noMatchesView setBackgroundColor:[UIColor clearColor]];
    [self.noMatchesView setTextColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.noMatchesView setTextAlignment:NSTextAlignmentCenter];
    [self.noMatchesView setFont:[UIFont boldSystemFontOfSize:14.0f]];
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        isFail=YES;
        [self.view addSubview:self.noMatchesView];
        
    }
   }

- (void)viewWillAppear:(BOOL)animated{

  [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
            if (result==NCUpdateResultNewData) {
                [self.todayTableView reloadData];
            }
        }];
    
}


//- (void) viewDidLayoutSubviews {
//    
//    [super viewDidLayoutSubviews];
//     self.todayTableView.layoutMargins = UIEdgeInsetsZero;

//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        isFail=YES;
        [self.view addSubview:self.noMatchesView];

    }
    
    //http://api.filgoal.com/matches/widget http://10.0.57.4:8083/matches/widget
    else{
    [MatchesWidgetData  getWidgetMatchesData:[NSURL URLWithString:@"http://api.filgoal.com/matches/widget"] success:^(NSArray *matchesArray) {
       
        if ([matchesArray count]==0&&isFail==NO) {
            [self.todayTableView setHidden:YES];
            self.preferredContentSize = CGSizeMake(320,100);
            [self.noMatchesView setText:@"لا يوجد مباريات"];
            isFail=NO;
            [self.view addSubview:self.noMatchesView];
        }
        else{
        self.widgetAllMatches= [NSArray arrayWithArray:matchesArray];
        [self.todayTableView setHidden:NO];
        [self updateTheTable];
        if ([self updateTheView]==YES){
        [NSTimer scheduledTimerWithTimeInterval: 30.0 target: self
                                                selector: @selector(updateWidgetView:) userInfo: nil repeats: YES];
        NSLog(@"Update the widget view ...");
        }
        }
        
    } failure:^(NSError *error) {
         NSLog(@"Faiiiiilll ...");
         [self.todayTableView setHidden:YES];
         self.preferredContentSize = CGSizeMake(320,100);
         [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
         isFail=YES;
         [self.view addSubview:self.noMatchesView];
         completionHandler(NCUpdateResultFailed);
    }];
    }
    
}

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(userDefaultsDidChange:)
//                                                     name:NSUserDefaultsDidChangeNotification
//                                                   object:nil];
//    }
//    return self;
//}



- (UIEdgeInsets ) widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (whichButtonIsTapped == 1 ){
        if ([self.tomorrowMatches count]!=0) {
         return [[self.tomorrowChampList objectAtIndex:section] count];
        }
       
        return 0;
    }
    
    if (whichButtonIsTapped ==2){
        if ([self.todayMatches count]!=0) {
         
          return [[self.todayChampList objectAtIndex:section ]count];
        }
        return 0;
    }
    
    
    else{
        if ([self.yesterdayMatches count]!=0) {
        return [[self.yesterdayChampList objectAtIndex:section] count];
        }
        return 0;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

 if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable){
       isFail=YES;
       return 0;
    }


else if ([self.widgetAllMatches count]==0)
        return 0;
    
else{
    if (whichButtonIsTapped == 1)
        return [self.tomorrowChampList count];
        
    
    if (whichButtonIsTapped ==2)
        
        return [self.todayChampList count];
    
    if (whichButtonIsTapped ==3)
       return [self.yesterdayChampList count];
    
    return 0;

}
    
  
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 75.0;

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
//=====set Hearder view ==============//
    
    UIView *headerView=[[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0  blue:68.0/255.0  alpha:1.0]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    UILabel *title;
    if(screenWidth>320&&screenWidth<380)
     title=[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 305, 22)];
    else if (screenWidth>380)
     title=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 305, 22)];
    else{
     title=[[UILabel alloc] initWithFrame:CGRectMake(8, 0, 305, 22)];
     
    }
    
    [title setTextAlignment:NSTextAlignmentRight];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
    [title setTextColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
  
    
    
    
    
    if (whichButtonIsTapped == 1){
        if ([self.tomorrowMatches count]!=0) {
        title.text= [[[self.tomorrowChampList objectAtIndex:section] objectAtIndex:0] matchChampName];
        [headerView addSubview:title];
        }
        else
         headerView=nil;
    }
    if (whichButtonIsTapped ==2){
        
        if ([self.todayMatches count]!=0){
        title.text= [[[self.todayChampList objectAtIndex:section] objectAtIndex:0] matchChampName];
        [headerView addSubview:title];
        }
        
        else{
         headerView=nil;
        }
    }
    
    if (whichButtonIsTapped ==3) {
        
        if ([self.yesterdayMatches count]!=0){
         title.text=[[[self.yesterdayChampList objectAtIndex:section] objectAtIndex:0] matchChampName];
         [headerView addSubview:title];
        }
        
       else
           headerView=nil;
    }
   
    return headerView;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [tableView setLayoutMargins:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WidgetMatchModel *match;
    if (whichButtonIsTapped ==1) {
        match=[[self.tomorrowChampList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
    
    if (whichButtonIsTapped ==2) {
        
        match=[[self.todayChampList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        
    }

    
    if (whichButtonIsTapped ==3) {
        
       match=[[self.yesterdayChampList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
    
    NSURL *url = [NSURL URLWithString:@"FilgoalWidget://com.sarmady.filgoalWidget"];
   
    [self.extensionContext openURL:url completionHandler:nil];
     NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:match];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    [defaults setObject:encodedObject forKey:@"MatchWidget"];
    [defaults synchronize];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}




// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellIdentifier= @"TomorrowMatchesWidgetCell";
    
    WidgetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[WidgetCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
     //cell.layoutMargins = UIEdgeInsetsZero;
   
    if (whichButtonIsTapped == 1){
        if ([self.tomorrowMatches count]!=0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        cell.team1Name.text=[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] club1Name];
        cell.team2Name.text=[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] club2Name];
       
        cell.teamscore1Label.text=[NSString stringWithFormat:@"%@",[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score1]];
        cell.teamscore2Label.text=[NSString stringWithFormat:@"%@",[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score2]];
        [cell.matchStatus setText:@""];
        [cell.matchCounter setText:@""];
        
        cell.didntStartImage.image=[UIImage imageNamed:@"not_yet_btn.png"];
        
        if ([[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score1] intValue]==-1) {
            cell.teamscore1Label.text= @"-";
        }
        if ([[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score2] intValue]==-1) {
            cell.teamscore2Label.text= @"-";
        }
        
        
        [cell.teamImage2 setImageWithURL:[NSURL URLWithString:[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] teamImageUrl2]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
        
        [cell.teamImage1 setImageWithURL:[NSURL URLWithString:[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]teamImageUrl1]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
        

        cell.timeOfTheMatch.text=[[[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]timeOfTheWidgetMatch];
        return cell;
        }
        
        
        else{
            return nil;
            
        }
        
    }
    
    if (whichButtonIsTapped == 2){
        if ([self.todayMatches count]!=0) {
        WidgetMatchModel *matchModel= (WidgetMatchModel *)([[self.todayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
        cell.contentView.backgroundColor=[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        cell.team1Name.text=[[[self.todayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] club1Name];
        cell.team2Name.text=[[[self.todayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] club2Name];
        cell.teamscore1Label.text=[NSString stringWithFormat:@"%@",[[[self.todayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score1]];
        cell.teamscore2Label.text=[NSString stringWithFormat:@"%@",[[[self.todayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score2]];
  
    if ([matchModel.score1 intValue] ==-1) {
        NSString *s=[matchModel.liveScore1 intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[matchModel.liveScore1 intValue]];
        UILabel *jokeTextLabel = (UILabel*)cell.teamscore1Label;
        [jokeTextLabel setText:s];
        cell.teamscore2Label.text=[matchModel.liveScore2 intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[matchModel.liveScore2 intValue]];
            }
    else{
        cell.teamscore1Label.text=[matchModel.score1 intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[matchModel.score1 intValue]];
        cell.teamscore2Label.text=[matchModel.score2 intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[matchModel.score2 intValue]];
            }
        
        cell.matchStatus.text=matchModel.widgetMatchStatus;
        cell.timeOfTheMatch.text=matchModel.timeOfTheWidgetMatch;
        
        if ([[[self.todayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]statusID]==0) {
            [cell.matchStatus setHidden:YES];
             cell.didntStartImage.image=[UIImage imageNamed:@"not_yet_btn.png"];
        }
        

        
        else if (matchModel.statusID==6) {
            cell.didntStartImage.image=[UIImage imageNamed:@"done_btn.png"];
            
            if([matchModel.penScore1 intValue] !=-1){
                [cell.matchStatus setText:@"ركلات الترجيح"];
            }
            else{
                [cell.matchStatus  setHidden:YES];
            }
            
            cell.teamscore1Label.text= [cell.teamscore1Label.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",[matchModel.penScore1 intValue]==-1?@"":[NSString stringWithFormat:@"(%i)",[matchModel.penScore1 intValue]]]];
            
            cell.teamscore2Label.text= [cell.teamscore2Label.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",[matchModel.penScore2 intValue]==-1?@"":[NSString stringWithFormat:@"(%i)",[matchModel.penScore2 intValue]]]];  
            
        }
            
        else if (matchModel.statusID==7) {
            
            cell.didntStartImage.image=[UIImage imageNamed:@"now_btn.png"];
            cell.teamscore1Label.text= [cell.teamscore1Label.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",[matchModel.penScore1 intValue]==-1?@"":[NSString stringWithFormat:@"(%i)",[matchModel.penScore1 intValue]]]];
            
            cell.teamscore2Label.text= [cell.teamscore2Label.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",[matchModel.penScore2 intValue]==-1?@"":[NSString stringWithFormat:@"(%i)",[matchModel.penScore2   intValue]]]];
            cell.matchStatus.text=matchModel.widgetMatchStatus;
     
        }
        else{
            cell.didntStartImage.image=[UIImage imageNamed:@"now_btn.png"];
            cell.matchStatus.text=matchModel.widgetMatchStatus;

        }
      
           [cell.teamImage2 setImageWithURL:[NSURL URLWithString: [matchModel teamImageUrl2]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
           [cell.teamImage1 setImageWithURL:[NSURL URLWithString: [matchModel teamImageUrl1]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
            
           return cell;
        }
        
        else{
            return nil;
        }
    }

    else{
        if ([self.yesterdayMatches count]!=0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        
        cell.team1Name.text=[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] club1Name];
        [cell.matchStatus setText:@""];
        [cell.matchCounter setText:@""];
        cell.team2Name.text=[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] club2Name];
        cell.teamscore1Label.text=[NSString stringWithFormat:@"%@",[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score1]];
        cell.teamscore2Label.text=[NSString stringWithFormat:@"%@",[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score2]];
        //cell.matchStatus.text=[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] widgetMatchStatus];
        
        if ([[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score1] intValue]==-1) {
            cell.teamscore1Label.text= @"-";
        }
        if ([[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] score2] intValue]==-1) {
            cell.teamscore2Label.text= @"-";
        }
        
        cell.didntStartImage.image=[UIImage imageNamed:@"done_btn.png"];
        
        cell.timeOfTheMatch.text=[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]timeOfTheWidgetMatch];
       
        [cell.teamImage2 setImageWithURL:[NSURL URLWithString:[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] teamImageUrl2]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
       
        [cell.teamImage1 setImageWithURL:[NSURL URLWithString:[[[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] teamImageUrl1]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
         return cell;
    }
        
        else{
            return nil;
        
        }
    }

}


-(IBAction)selectTap1:(id)sender{
    [self.tomorrowButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.yesterdayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    whichButtonIsTapped=1;
  if ([self.tomorrowMatches count]==0&&isFail==YES) {
     [self.todayTableView setHidden:YES];
     self.preferredContentSize = CGSizeMake(320,100);
     [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
     [self.view addSubview:self.noMatchesView];
    }
    
    else if ([self.tomorrowMatches count]==0&&isFail==NO) {
        
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@" لا يوجد مباريات "];
        [self.view addSubview:self.noMatchesView];
    }
    
  else {
     [self.todayTableView setHidden:NO];
     self.todayTableView.contentSize = CGSizeMake(320, [self.tomorrowMatches count]*75+[self.tomorrowChampList count]*25);
     self.preferredContentSize = CGSizeMake(320,self.todayTableView.contentSize.height+50);
     [self.noMatchesView removeFromSuperview];
     [self.todayTableView reloadData];
    }
  
    

}
-(IBAction)selectTap2:(id)sender{
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.tomorrowButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.yesterdayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    whichButtonIsTapped=2;
    
    if ([self.todayMatches count]==0&&isFail==YES) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noMatchesView];
    }
    
    else if ([self.self.todayMatches count]==0&&isFail==NO) {
        
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@" لا يوجد مباريات "];
        [self.view addSubview:self.noMatchesView];
    }
    
    else {
        [self.todayTableView setHidden:NO];
        self.todayTableView.contentSize = CGSizeMake(320, [self.todayMatches count]*75+[self.todayChampList count]*25);
        self.preferredContentSize = CGSizeMake(320,self.todayTableView.contentSize.height+50);
        [self.noMatchesView removeFromSuperview];
        [self.todayTableView reloadData];
    }
}
-(IBAction)selectTap3:(id)sender{
    
    [self.yesterdayButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.tomorrowButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
     whichButtonIsTapped=3;
    
    if ([self.yesterdayMatches count]==0&&isFail==YES) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noMatchesView];
    }
    
    else if ([self.self.todayMatches count]==0&&isFail==NO) {
        
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@" لا يوجد مباريات "];
        [self.view addSubview:self.noMatchesView];
    }
    
    else {
        [self.todayTableView setHidden:NO];
        self.todayTableView.contentSize = CGSizeMake(320, [self.yesterdayMatches count]*75+[self.yesterdayChampList count]*25);
        self.preferredContentSize = CGSizeMake(320,self.todayTableView.contentSize.height+50);
        [self.noMatchesView removeFromSuperview];
        [self.todayTableView reloadData];
    }
}

- (void)updateTheTable{
    
    self.tomorrowMatches = [MatchesWidgetDataHandler getTomorrowMatches:self.widgetAllMatches];
    self.todayMatches =    [MatchesWidgetDataHandler getTodayMatches:self.widgetAllMatches];
    self.yesterdayMatches =[MatchesWidgetDataHandler getYesterdayMatches:self.widgetAllMatches];

    
    if (([self.tomorrowMatches count]==0 || [self.yesterdayMatches count]==0 || [self.todayMatches count] == 0)&&isFail==NO) {
        [self.noMatchesView setText:@" لا يوجد مباريات "];

    }
    else if (([self.tomorrowMatches count]==0 || [self.yesterdayMatches count]==0 ||[self.todayMatches count] == 0)&&isFail==YES) {
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
    }
    
    
   else if ([self.tomorrowMatches count]!=0 || [self.yesterdayMatches count]!=0 ||[self.todayMatches count] != 0){
       
        [self getSectionsArray];
        }
 
    
    if ([self.todayMatches count]==0 && whichButtonIsTapped==2 && isFail==NO) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.view addSubview:self.noMatchesView];
            
    }

}

-(NSMutableArray*)getSectionArray:(NSArray*)matches{
   
    
    NSMutableArray *sectiondMatches=[[NSMutableArray alloc] init];
    NSMutableArray *subMatches=[[NSMutableArray alloc] init];
    int current=-1;
    for (WidgetMatchModel * match  in matches ) {
        
        if (current==-1) {
            current=match.champId;
            [subMatches addObject:match];
        }
        else if (current!=match.champId) {
            current=match.champId;
            [sectiondMatches addObject:subMatches];
            subMatches=[[NSMutableArray alloc] init];
            [subMatches addObject:match];
        }
        else {
            [subMatches addObject:match];
        }
    }
    [sectiondMatches addObject:subMatches];
    return sectiondMatches;
}


- (void)getSectionsArray{

   /// === getting today sections
    self.todayChampList=[[NSMutableArray alloc] init];
    self.tomorrowChampList=[[NSMutableArray alloc] init];
    self.yesterdayChampList=[[NSMutableArray alloc] init];
    
    self.todayChampList =[self getSectionArray:self.todayMatches];
    self.yesterdayChampList=[self getSectionArray:self.yesterdayMatches];
    self.tomorrowChampList = [self getSectionArray:self.tomorrowMatches];
    
    
 if (whichButtonIsTapped==2 && [self.todayMatches count]!=0) {
    self.todayTableView.contentSize = CGSizeMake(320, [self.todayMatches count]*75+[self.todayChampList count]*25);
    self.preferredContentSize = CGSizeMake(320,self.todayTableView.contentSize.height+50);
  }
 [self.todayTableView reloadData];

}


- (void) updateWidgetView:(NSTimer *)t{
    
    [NSThread detachNewThreadSelector:@selector(loadTheUpdatedView:) toTarget:self withObject:nil];
    
}

- (void)loadTheUpdatedView:(NSTimer *)t{

 [MatchesWidgetData  getWidgetMatchesData:[NSURL URLWithString:@"http://api.filgoal.com/matches/widget"] success:^(NSArray *matchesArray) {
        self.widgetAllMatches= [NSArray arrayWithArray:matchesArray];
        [self updateTheTable];
        isFail=NO;
        NSLog(@"Update the widget view ...");
     
    } failure:^(NSError *error) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(320,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        isFail=YES;
        [self.view addSubview:self.noMatchesView];
         NSLog(@"Faiiiiilll ...");
    }];
}

- (BOOL)updateTheView{
    
    BOOL isMatchLive=NO;
    
    if ([self.todayMatches count]!=0) {
    for (WidgetMatchModel *match in self.todayMatches) {
      
    if ([match statusID]!=0 && [match statusID]!=6)
        isMatchLive=YES;
        NSLog(@"Status is %d", [match statusID]);
    }
   
    }
  return isMatchLive;
}



@end