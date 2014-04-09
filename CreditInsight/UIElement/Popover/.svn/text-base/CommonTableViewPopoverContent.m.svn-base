//
//  CommonTableViewPopoverContent.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/8/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CommonTableViewPopoverContent.h"

@interface CommonTableViewPopoverContent ()

@end

@implementation CommonTableViewPopoverContent

- (void)viewDidLoad {
  [super viewDidLoad];
   self.contentSizeForViewInPopover = CGSizeMake(266, 300);
}

- (void)viewDidUnload {
  [self setOptionsArray:nil];
  [self setCommonTableView:nil];
  [super viewDidUnload];
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_optionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"cellIdentifier";
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:cellIdentifier];
  }
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  cell.textLabel.text = NSLocalizedString([_optionsArray objectAtIndex:indexPath.row],nil);
  cell.textLabel.textColor = [UIColor lightGrayColor];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
  selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
  [self.delegate commonTableViewPopoverWithSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
  UITableViewCell *unSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
  unSelectedCell.accessoryType = UITableViewCellAccessoryNone;
}

@end
