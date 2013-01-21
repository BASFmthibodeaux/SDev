//
//  FirstViewController.m
//  XMLTest
//
//  Created by Javi on 17/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "FirstViewController.h"
#import "GetXML.h"

@interface FirstViewController ()

@end

@implementation FirstViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    loadUnknownXML();
    GetXML *test = [GetXML alloc];
    
    
    
    NSLog(@"init");
    test.loadXML;

    tableContent = [[NSMutableArray alloc] initWithArray:test.content copyItems:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// UITABLEVIEW -------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 return 1 ;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 // Return the number of rows in the section.
 // If you're serving data from an array, return the length of the array:
 return [tableContent count];
 }
 


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];
    NSString *title = [[NSString alloc] init];
    NSString *subtitle = [[NSString alloc] init];
    
    title = [title stringByAppendingString: [dic objectForKey:@"card_type"]];
    title = [title stringByAppendingString:@" XXXX-"];
    title = [title stringByAppendingString:[dic objectForKey:@"cc_number"]];

    subtitle = [subtitle stringByAppendingString:[dic objectForKey:@"holder"]];
    subtitle = [subtitle stringByAppendingString:@" "];
    subtitle = [subtitle stringByAppendingString:[dic objectForKey:@"bank"]];
    
    cell.textLabel.text = title;
    
    cell.detailTextLabel.text = subtitle;

    //cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
// FIN UITABLEVIEW -------------------------------------------------------------------------------------

@end
