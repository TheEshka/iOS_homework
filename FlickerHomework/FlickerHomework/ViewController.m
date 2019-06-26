//
//  ViewController.m
//  FlickerHomework
//
//  Created by Gagik on 22/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "ViewController.h"
#import "SearchingViewCell.h"
#import "SearchingModel.h"
#import "ModelProtocol.h"

const CGFloat defOffset = 15.f;
const CGFloat defHeight = 200.f;

@interface ViewController ()<UISearchBarDelegate, ModelOutputProtocol, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SearchingModel *dataModel;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    
    self.dataModel = [[SearchingModel alloc] init];
    self.dataModel.changeDelegate = self;
}

- (void)prepareUI
{
    _searchBar = [[UISearchBar alloc] init]; // быстрее autoLayout
    _searchBar.delegate = self;
    _searchBar.placeholder = @"Write request";
    [self.view addSubview:self.searchBar];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(150.f, defHeight);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout: flowLayout];
    [_collectionView registerClass:[SearchingViewCell class] forCellWithReuseIdentifier:@"simpleCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self; //////////////////////--------------------------------
    [self.view addSubview:self.collectionView];
    
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray<NSLayoutConstraint *> *constraints =
    @[
      [_searchBar.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20.f],
      [_searchBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [_searchBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [_searchBar.bottomAnchor constraintEqualToAnchor:_collectionView.topAnchor],
      
      [_collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
      [_collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
      [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
      ];
    [NSLayoutConstraint activateConstraints:constraints];
}


#pragma mark - ModelOutputProtocol

- (void)startDownloadingCollectionView
{
    [self.collectionView reloadData];
}

- (void)setDownloadedImageForIndexPathNumber:(NSInteger)num withData:(NSData *)data
{
    NSIndexPath *path = [NSIndexPath indexPathForItem:num inSection:0];
    SearchingViewCell *cell = (SearchingViewCell *) [self.collectionView cellForItemAtIndexPath:path];
    [cell setImage:[UIImage imageWithData:data]];
    //[self.collectionView reloadItemsAtIndexPaths:@[path]];
    NSLog(@"set image adtre download %ld", num);
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchedText = searchBar.text;
    [self.dataModel newSearch:searchedText];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //здесь доделать лайв строку поиска
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataModel getSearchingResultCount];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchingViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simpleCell" forIndexPath:indexPath];
    
//////если качать и вставлять здесь, не всегда отображается, так как ячейка еще не появилось на экране и не рендериться ее контент
//    NSData *data = [self.dataModel getPhotoForPathNumber:indexPath.row];
//    if (data)
//    {
//        NSLog(@"set image imidiatly %ld", indexPath.row);
//        [cell setImage:[UIImage imageWithData:data]];
//    }
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *data = [self.dataModel getPhotoForPathNumber:indexPath.row]; //срабатывает заранее, чтоб подгрузить
    if (data)
    {
        NSLog(@"set image imidiatly %ld", indexPath.row);
        [(SearchingViewCell *)cell setImage:[UIImage imageWithData:data]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height)
    {
        NSLog(@"end");
    }
}

@end
