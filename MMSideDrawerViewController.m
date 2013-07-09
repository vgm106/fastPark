// Copyright (c) 2013 Mutual Mobile (http://mutualmobile.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "MMSideDrawerViewController.h"
#import "MMSideDrawerTableViewCell.h"
#import "MMSideDrawerSectionHeaderView.h"
#import "FastParkViewController.h"


@implementation MMSideDrawerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:49.0/255.0
                                                      green:54.0/255.0
                                                       blue:57.0/255.0
                                                      alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:77.0/255.0
                                                       green:79.0/255.0
                                                        blue:80.0/255.0
                                                       alpha:1.0]];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:66.0/255.0
                                                  green:69.0/255.0
                                                   blue:71.0/255.0
                                                  alpha:1.0]];
    
    [self.mm_drawerController setMaximumLeftDrawerWidth:270];
    
    self.drawerWidths = @[@(160),@(200),@(240),@(280),@(320)];
    
//    CGSize logoSize = CGSizeMake(58, 62);
//    MMLogoView * logo = [[MMLogoView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.tableView.bounds)-logoSize.width/2.0,
//                                                                     -logoSize.height-logoSize.height/4.0,
//                                                                     logoSize.width,
//                                                                     logoSize.height)];
//    [logo setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
//    //[self.tableView addSubview:logo];
    [self.view setBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections-1)] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case MMDrawerFunctions:
            return 2;
        case MMDrawerWestLots:
            return 7;
        case MMDrawerEastLots:
            return 5;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[MMSideDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    switch (indexPath.section) {
        case MMDrawerWestLots:
            if(indexPath.row == 0){
                [cell.textLabel setText:@"HRI"];
            }
            else if(indexPath.row == 1){
                [cell.textLabel setText:@"NRC"];
            }
            else if(indexPath.row == 2){
                [cell.textLabel setText:@"Starfish"];
            }
            else if(indexPath.row == 3){
                [cell.textLabel setText:@"Angelfish"];
            }
            else if(indexPath.row == 4){
                [cell.textLabel setText:@"Seahorse"];
            }
            else if(indexPath.row == 5){
                [cell.textLabel setText:@"Jellyfish"];
            }
            else if(indexPath.row == 6){
                [cell.textLabel setText:@"Turtle Cove"];
            }
            break;
            
        case MMDrawerEastLots:{
            if(indexPath.row == 0){
                [cell.textLabel setText:@"Sand dollar"];
            }
            else if(indexPath.row == 1){
                [cell.textLabel setText:@"Hammerhead"];
            }
            else if(indexPath.row == 2){
                [cell.textLabel setText:@"Seabreeze"];
            }
            else if(indexPath.row == 3){
                [cell.textLabel setText:@"Tarpon"];
            }
            else if(indexPath.row == 4){
                [cell.textLabel setText:@"Curlew"];
            }
            break;
        }
        case MMDrawerFunctions:{
            if(indexPath.row == 0){
                [cell.textLabel setText:@"Suggest"];
            }
            else if(indexPath.row == 1){
                [cell.textLabel setText:@"Calendar"];
            }
            break;
            
        }
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case MMDrawerFunctions:
            return @"Functions";
        case MMDrawerWestLots:
            return @"West Parking Lots";
        case MMDrawerEastLots:
            return @"East Parking Lots";
        default:
            return nil;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MMSideDrawerSectionHeaderView * headerView =  [[MMSideDrawerSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 20.0f)];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [headerView setTitle:[tableView.dataSource tableView:tableView titleForHeaderInSection:section]];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 23.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FastParkViewController *center = [[FastParkViewController alloc] init];
    center.managedObjectContext = self.mm_drawerController.managedObjectContext;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:center];
    
    switch (indexPath.section)
    {
        case MMDrawerWestLots:
        {
            
            [self.mm_drawerController setCenterViewController:nav1
                                           withCloseAnimation:YES
                                                   completion:nil];
            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            
            [center moveCameraTo:str];
            break;
        }
            
        case MMDrawerEastLots:
        {
            [self.mm_drawerController setCenterViewController:nav1
                                           withCloseAnimation:YES
                                                   completion:nil];
            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            
            [center moveCameraTo:str];
            break;
        }
        case MMDrawerFunctions:
        {
            [self.mm_drawerController setShowsShadow:!self.mm_drawerController.showsShadow];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        default:
            break;
    }
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TestDelagate
-(NSString *) getMessageString{
    return @"from side drawer";
}


@end
