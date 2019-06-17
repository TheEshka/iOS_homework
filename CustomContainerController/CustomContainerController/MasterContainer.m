//
//  MasterContainer.m
//  CustomContainerController
//
//  Created by Gagik on 14/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//



#import "MasterContainer.h"
#import "MasterContainerButton.h"


const CGFloat scrollViewHeight = 60.f;

/**
 Для создания нового контроллера свайп влево
 Для удаления текущего свайп вправо
 При создании контроллера создается кунопка внизу, при нажатии ставит соответсвующий контроль на передний план
 !!!!Но при удалении кот рллера его кнопка не удаляется, потому что scrollView надо самому искать элемент
 !!!!а у меня замтра экзамен, не успею исправить)))
 */
@interface MasterContainer ()

@property (nonatomic, strong)NSMutableArray<UIViewController *> *controllersStack;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger current;

@end

@implementation MasterContainer

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.controllersStack = [NSMutableArray new];
    self.num = 0;
    self.current = -1;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - scrollViewHeight, CGRectGetWidth(self.view.frame), scrollViewHeight)];
    self.scrollView.contentSize = CGSizeMake(0, scrollViewHeight);
    [self.view addSubview:self.scrollView];
    
    UISwipeGestureRecognizer *recognizerToNextContainer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(createContainer)];
    recognizerToNextContainer.delaysTouchesBegan = YES;
    recognizerToNextContainer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:recognizerToNextContainer];
    
    UISwipeGestureRecognizer *recognizerToPreviousContainer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(deleteContainer)];
    recognizerToPreviousContainer.delaysTouchesBegan = YES;
    recognizerToPreviousContainer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:recognizerToPreviousContainer];
}



#pragma mark - GestureRecognizer actions

- (void) createContainer
{
    NSLog(@"go to next");
    UIViewController *controller = [UIViewController new];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(controller.view.frame), 100)];
    label.text = [NSString stringWithFormat:@"№%ld view controller №%ld", (long)self.num, (long)self.num];
    [self addControllerButtonFor:controller];
    self.num ++;
    self.current = self.num;
    [controller.view addSubview:label];
    controller.view.backgroundColor = [UIColor redColor];
    [self pushViewController:controller];
}


- (void) deleteContainer
{
    NSLog(@"go to previous");
    
    [self deleteButton];
    [self popViewController];
}




#pragma mark - working with controlers

- (void)pushViewController:(UIViewController *)viewController
{
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    viewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(viewController.view.frame), CGRectGetHeight(viewController.view.frame) - scrollViewHeight);
    [self.controllersStack addObject:viewController];
}



- (void)popViewController
{
    UIViewController *viewController = [self.controllersStack lastObject];
    [self.controllersStack removeLastObject];
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}


- (void)goToContainer:(MasterContainerButton *)button
{
    NSLog(@"go target view");
    UIViewController *refController = [button targetViewController];
    [self.controllersStack removeObject:refController];
    [self.controllersStack addObject:refController];
    [self.view bringSubviewToFront:refController.view];
}




#pragma mark - button creating

- (void)addControllerButtonFor:(UIViewController *)viewController
{
    MasterContainerButton *button = [MasterContainerButton buttonWithType:UIButtonTypeSystem];
    [button addTargerViewController: viewController];
    [button setTitle:[NSString stringWithFormat:@"%ld", (long)self.num] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToContainer:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.layer.borderColor = UIColor.whiteColor.CGColor;
    button.layer.borderWidth = 3;
    button.frame = CGRectMake(70 * self.num, 0, 50, 50);
    [self.scrollView addSubview:button];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + 70, scrollViewHeight);
    CGPoint bottomOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.bounds.size.width + self.scrollView.contentInset.right, 0);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
}

- (void)deleteButton
{
    //здесь хотел сделать чтобы кнопка удалялась. Понял что надо было tableView юзать и забил))
}


@end
