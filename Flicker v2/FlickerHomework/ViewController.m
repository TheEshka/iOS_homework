//
//  ViewController.m
//  FlickerHomework
//
//  Created by Gagik on 22/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "ViewController.h"
#import "SearchingViewCell.h"
#import "Assembler.h"
#import "SearchingHistory.h"


const CGFloat defOffset = 15.f;
const CGFloat defHeight = 200.f;
const CGFloat tableCellHeight = 50.f;

@interface ViewController ()<UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, assign)BOOL nextPagePrepared;

@property (nonatomic, strong)UITableView *searchTableView;
@property (nonatomic, strong)NSArray<NSString *> *tableViewArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    
    [Assembler configureArchitectureForViewController:self];
    self.nextPagePrepared = YES;
}

- (void)instantSearch:(NSString *)searchString
{
    self.searchBar.text = searchString;
    [self.presenter newSearch:searchString];
    return;
}

#pragma mark - ViewControllerInputProtocol

- (void)triggerCollectionView
{
    self.nextPagePrepared = YES;
    [self.collectionView reloadData];
}

- (void)setDownloadedImageForIndexPathNumber:(NSInteger)num withData:(NSData *)data
{
    NSIndexPath *path = [NSIndexPath indexPathForItem:num inSection:0];
    SearchingViewCell *cell = (SearchingViewCell *) [self.collectionView cellForItemAtIndexPath:path];
    [cell setImage:[UIImage imageWithData:data]];
    NSLog(@"set image aftre download %ld", num);
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchTableView setHidden:NO];
    self.tableViewArray = [SearchingHistory getSearchesStartingWith:@""];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.tableViewArray = [SearchingHistory getSearchesStartingWith:searchText];
    [self.searchTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchTableView setHidden:YES];
    NSString *searchedText = searchBar.text;
    [SearchingHistory addSearchText:searchedText];
    [self.presenter newSearch:searchedText];
    [searchBar resignFirstResponder];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section\
{
    NSInteger num = self.tableViewArray.count > 3 ? 3 : self.tableViewArray.count;
    tableView.frame = CGRectMake(CGRectGetMinX(tableView.frame), CGRectGetMinY(tableView.frame), CGRectGetWidth(tableView.frame), tableCellHeight * num);
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    cell.textLabel.text = self.tableViewArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *searchedText = cell.textLabel.text;
    self.searchBar.text = searchedText;
    [self.presenter newSearch:searchedText];
    [self.searchTableView setHidden:YES];
    [self.searchBar resignFirstResponder];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.presenter findCollectinViewCellsCount];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchingViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simpleCell" forIndexPath:indexPath];
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *data = [self.presenter openPhotoForPathNumber:indexPath.row]; //срабатывает заранее, чтоб подгрузить
    if (data)
    {
        NSLog(@"set image imidiatly %ld", indexPath.row);
        [(SearchingViewCell *)cell setImage:[UIImage imageWithData:data]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if ((bottomEdge >= scrollView.contentSize.height) && (self.nextPagePrepared == YES))
    {
        self.nextPagePrepared = NO;
        [self.presenter openNextPage];
        NSLog(@"end");
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchTableView setHidden:YES];
}


#pragma mark - createUI

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


-(UITableView *)searchTableView
{
    if (_searchTableView) {
        return _searchTableView;
    }
    
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), CGRectGetWidth(self.view.frame), 0) style:UITableViewStylePlain];
    _searchTableView.dataSource = self;
    _searchTableView.delegate = self;
    _searchTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [_searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    [self.view addSubview:_searchTableView];
    return _searchTableView;
}


@end
