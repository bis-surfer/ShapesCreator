//
//  EditableObjectView.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 27.02.13.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "EditableObjectView.h"

#import "EPCompoundObjectCell.h"


@interface EditableObjectView ()

- (NSArray*)tableViewDataForSection:(NSInteger)section;
- (EPTVCellDataSource *)tableViewDataForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString*)cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString*)propertyNameForRowAtIndexPath:(NSIndexPath *)indexPath;
- (id)propertyValueObjectForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@implementation EditableObjectView

@synthesize obj;

@synthesize titleView;
@synthesize resetBtn;
@synthesize theTableView;
@synthesize theCell;

- (NSArray*)tableViewData {
    
    if (!_tableViewData) {
        
        _tableViewData = [self.obj editableObjectTableViewData];
    }
    
    return _tableViewData;
}


- (NSArray*)tableViewDataForSection:(NSInteger)section {
    
    return [self.tableViewData objectAtIndex:section];
}

- (EPTVCellDataSource *)tableViewDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *sectionData = [self tableViewDataForSection:section];
    
    return [sectionData objectAtIndex:row];
}


- (NSInteger)numberOfSectionsInTheTableView {
    
    return [self.tableViewData count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sectionData = [self tableViewDataForSection:section];
    
    return [sectionData count];
}


- (NSString*)cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EPTVCellDataSource *cellData = [self tableViewDataForRowAtIndexPath:indexPath];
    
    return cellData.cellIdentifier;
}

- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EPTVCellDataSource *cellData = [self tableViewDataForRowAtIndexPath:indexPath];
    
    return cellData.cellHeight;
}

- (NSString*)propertyNameForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EPTVCellDataSource *cellData = [self tableViewDataForRowAtIndexPath:indexPath];
    
    return cellData.propertyName;
}

- (id)propertyValueObjectForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EPTVCellDataSource *cellData = [self tableViewDataForRowAtIndexPath:indexPath];
    
    return cellData.propertyValueObject;
}


- (CGFloat)tableViewHeight {
    
    CGFloat tvHeight = 0.0;
    
    if (titleView) {
        tvHeight += 44.0;
    }
    
    for (NSInteger section = 0; section < [self numberOfSectionsInTheTableView]; section++) {
        for (NSInteger row = 0; row < [self numberOfRowsInSection:section]; row++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            tvHeight += [self cellHeightForRowAtIndexPath:indexPath];
        }
    }
    
    return tvHeight;
}


- (IBAction)reset:(id)sender {
    
    //
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - EditableObjectView.theTableView related specific methods

- (EditablePropertyTableViewCell *)createCellForRowAtIndexPath:(NSIndexPath *)indexPath withIdentifier:(NSString *)cellIdentifier {
    
    [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    // Field 'theCell' is returned by this method and retained by the setter
    
    return self.theCell;
}

- (void)configureCell:(EditablePropertyTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *propertyName = [self propertyNameForRowAtIndexPath:indexPath];
    id propertyValueObject = [self propertyValueObjectForRowAtIndexPath:indexPath];
    [cell setupWithPropertyName:propertyName andValueObject:propertyValueObject];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self numberOfSectionsInTheTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [self cellIdentifierForRowAtIndexPath:indexPath];
    
    EditablePropertyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [self createCellForRowAtIndexPath:indexPath withIdentifier:cellIdentifier];
    }
	
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = [self cellHeightForRowAtIndexPath:indexPath];
    
    if (cellHeight <= 0.0) {
        EPCompoundObjectCell *cell = (EPCompoundObjectCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[EPCompoundObjectCell class]]) {
            cellHeight = [cell.editableObjView tableViewHeight];
        }
    }
    
    return cellHeight;
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
