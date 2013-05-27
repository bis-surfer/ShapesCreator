//
//  EPArrayCell.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 30.01.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EPArrayCell.h"


@implementation EPArrayCell

@synthesize propertyValueArray;
@synthesize arrayTitleView;
@synthesize arrayAddItemBtn;
@synthesize arrayTblView;
@synthesize theCell;

- (void)setupWithPropertyName:(NSString *)aPropertyName andValueObject:(id)aPropertyValueObject {
    
    [super setupWithPropertyName:aPropertyName andValueObject:aPropertyValueObject];
    
    [self setupWithPropertyValue:aPropertyValueObject];
}

- (void)setupWithPropertyValue:(NSArray *)aPropertyValueArray {
    
    self.propertyValueArray = aPropertyValueArray;
}

- (IBAction)addItem:(id)sender {
    
    // 
}

#pragma mark - EPArrayCell.arrayTblView related specific methods

- (EditablePropertyTableViewCell *)createCellForRowAtIndexPath:(NSIndexPath *)indexPath withIdentifier:(NSString *)cellIdentifier {
    
    [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    // Field 'theCell' is returned by this method and retained by the setter
    
    return self.theCell;
}

- (void)configureCell:(EditablePropertyTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.propertyValueArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"EPNumberCell";
    
    EditablePropertyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [self createCellForRowAtIndexPath:indexPath withIdentifier:cellIdentifier];
    }
	
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 46.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     EditablePropertyTableViewCell *cell = (EditablePropertyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
     self.firstResponder = [cell firstResponder];
     */
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
