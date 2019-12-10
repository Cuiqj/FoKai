//
//  UserPickerViewController.m
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-9-24.
//
//

#import "UserPickerViewController.h"
#import "UserInfo.h"

@interface UserPickerViewController ()
@property (nonatomic,retain) NSArray *data;
@end

@implementation UserPickerViewController


- (void)viewWillAppear:(BOOL)animated{
    NSMutableArray * mutablearray = [[NSMutableArray alloc] init];
    NSArray *temparray =[UserInfo allUserInfo];
    for(id obj in temparray) {
        if ([[obj valueForKey:@"name"] containsString:@"管理员"]) {
            
        }else{
            [mutablearray addObject:obj];
        }
    }
    self.data= [NSArray arrayWithArray:mutablearray];
}

- (void)viewDidUnload
{
    [self setData:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[[self.data objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *userName=[[self.data objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSString *userID=[[self.data objectAtIndex:indexPath.row] valueForKey:@"myid"];
    [self.delegate setUser:userName andUserID:userID];
    [self.pickerPopover dismissPopoverAnimated:YES];
}

@end
