//
//  ViewController.m
//  AutoLayoutHomework
//
//  Created by Gagik on 10/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "ViewController.h"
#import "ABCCollectionLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
    
    ABCCollectionLayout *collectionViewLayout = [ABCCollectionLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:collectionViewLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mu123"];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mu123" forIndexPath:indexPath];
    NSString *sNum = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50.f, 50.f)];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rocket"]];
    [cell addSubview:imageView];
    imageView.frame = imageView.superview.bounds;
    label.text = sNum;
    for (UIView *view in cell.subviews){
        [view removeFromSuperview];
    }
    
    [cell addSubview:imageView];
    [cell addSubview:label];
    
//    switch (indexPath.row) {
//        case 0:
//            cell.backgroundColor = [UIColor redColor];
//            break;
//        case 1:
//            cell.backgroundColor = [UIColor yellowColor];
//            break;
//        case 2:
//            cell.backgroundColor = [UIColor blueColor];
//            break;
//        default:
//            cell.backgroundColor = [UIColor greenColor];
//            break;
//    }
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = arc4random() % 100 + 50;
    NSInteger height = arc4random() % 100 + 50;
    return CGSizeMake(width, height);
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    self.collectionView.frame = CGRectMake(0, 0, size.width, size.height);
    [self.collectionView reloadData];
    NSLog(@"rotate");
}


@end
