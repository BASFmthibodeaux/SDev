//
//  ValuesViewController.m
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "ValuesViewController.h"

@interface ValuesViewController ()

@end

@implementation ValuesViewController

@synthesize selectedCard;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [value addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /*
    IBOutlet UILabel *bank;
    IBOutlet UILabel *card;
    IBOutlet UIImageView *creditCardImage;
    IBOutlet UILabel *user;
    IBOutlet UILabel *dateSelection;
     */
    NSLog(@"received %@",selectedCard);

    NSString *title = [[NSString alloc] init];
    NSString *imageString = [[NSString alloc] init];
    NSDate *dateValue = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //    title = [title stringByAppendingString: [dic objectForKey:@"card_type"]];
    title = [title stringByAppendingString:@"XXXX-"];
    title = [title stringByAppendingString:[selectedCard objectForKey:@"cc_number"]];
    
    bank.text = [selectedCard objectForKey:@"bank"];
    user.text = [selectedCard objectForKey:@"holder"];
    card.text = title;
    
    imageString = [imageString stringByAppendingString:[selectedCard objectForKey:@"card_type"]];
    imageString = [imageString stringByAppendingString:@".png"];
    
    creditCardImage.image = [UIImage imageNamed:imageString];
    
    dateValue = [selectedCard objectForKey:@"date"];
    [formatter setDateFormat:@"dd LLLL YYYY"];
    dateSelection.text = [formatter stringFromDate:dateValue ];
    leyenda.text=@"";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
