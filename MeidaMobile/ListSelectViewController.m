//
//  ListSelectViewController.m
//  GDRMMobile
//
//  Created by 高 峰 on 13-7-13.
//
//

#import "ListSelectViewController.h"

@interface ListSelectViewController ()

@end

@implementation ListSelectViewController
@synthesize data;
@synthesize delegate;
@synthesize pickerPopover;

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ListSelectPopoverCell";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text=[self.data objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(setSelectData:)]) {
        [self.delegate setSelectData:[self.data objectAtIndex:indexPath.row]];
    } else if ([self.delegate respondsToSelector:@selector(listSelectPopover:selectedIndexPath:)]) {
        [self.delegate listSelectPopover:self selectedIndexPath:indexPath];
    }
    if (self.selectedIndexPathBlock){
        self.selectedIndexPathBlock(indexPath);
    }
    [self.pickerPopover dismissPopoverAnimated:YES];
}

@end
