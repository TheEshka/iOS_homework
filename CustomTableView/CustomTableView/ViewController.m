//
//  ViewController.m
//  CustomTableView
//
//  Created by Gagik on 12/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "ViewController.h"
#import "ABCTableViewCell.h"
#import "ABCReverseTableViewCell.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    //[self.tableView registerClass:[ABCTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ABCTableViewCell class])];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setEstimatedRowHeight: 60.f];
    [self.view addSubview:self.tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0){
        ABCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abcCell"];
        if (!cell)
        {
            cell = [[ABCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"abcCell"];
        }
        cell.image = [UIImage imageNamed:@"rocket"];
        cell.title = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        cell.subtitle = [self randomStringWithLength: arc4random_uniform(100)];
        
        return cell;
    }
    ABCReverseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abcReverseCell"];
    if (!cell)
    {
        cell = [[ABCReverseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"abcReverseCell"];
    }
    cell.image = [UIImage imageNamed:@"rocket"];
    cell.title = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.subtitle = [self randomStringWithLength: arc4random_uniform(100)];
    
    return cell;
}


-(NSString *) randomStringWithLength: (uint32_t) len
{
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end
