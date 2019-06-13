//
//  ABCCollectionLayout.m
//  AutoLayoutHomework
//
//  Created by Gagik on 10/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "ABCCollectionLayout.h"

const CGFloat standartOffset = 20.f;
const CGFloat standartHeight = 50.f;

@implementation ABCCollectionLayout

//- (CGSize)collectionViewContentSize
//{
//    CGFloat contentWidth = self.collectionView.bounds.size.width;
//    CGFloat contentHeight = 500.f;
//    return CGSizeMake(contentWidth, contentHeight);
//}
//
//- (void)prepareLayout
//{
//    [super prepareLayout];
//}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSArray * original   = [super layoutAttributesForElementsInRect:rect];
//    NSArray * attributesInRect = [[NSArray alloc] initWithArray:original copyItems:YES];
//
//    for (UICollectionViewLayoutAttributes *cellAttributes in attributesInRect) {
//        [self modifyLayoutAttributes:cellAttributes];
//    }
//    return attributesInRect;
    NSMutableArray* elementsInRect = [NSMutableArray array];
    
    for(NSUInteger i = 0; i < [self.collectionView numberOfSections]; i++)
    {
        for(NSUInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++)
        {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            CGRect cellFrame = [self getFrameByIndexPath:indexPath];
            
            if(CGRectIntersectsRect(cellFrame, rect))
            {
                UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                
                attr.frame = cellFrame;
                [elementsInRect addObject:attr];
            }
        }
    }
    
    return elementsInRect;
}


- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"qweqweqweqweqweq");
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    //UICollectionViewLayoutAttributes *prevAttributes = [super layoutAttributesForItemAtIndexPath: [NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section]];
    attributes.frame = [self getFrameByIndexPath:attributes.indexPath];
    return attributes;
}



- (CGRect)getFrameByIndexPath:(NSIndexPath *)indexPath
{
    CGFloat frameMiddle = self.collectionView.frame.size.width / 2.f;
    CGRect frame;
    switch (indexPath.row % 6) {
        case 0:
            frame = CGRectMake(standartOffset,
                                          (indexPath.row/3) * 2 * (standartHeight + standartOffset) + standartOffset,
                                          frameMiddle - 2 * standartOffset,
                                          standartHeight);
            break;
        case 1:
            frame = CGRectMake(standartOffset,
                                          (indexPath.row/3 * 2 + 1) * (standartHeight + standartOffset) + standartOffset,
                                          frameMiddle - 2 * standartOffset,
                                          standartHeight);
            break;
        case 2:
            frame = CGRectMake(frameMiddle + standartOffset,
                                          (indexPath.row/3) * 2 * (standartHeight + standartOffset) + standartOffset,
                                          frameMiddle - 2 * standartOffset,
                                          standartHeight * 2 + standartOffset);
            break;
        case 3:
            frame = CGRectMake(standartOffset,
                                          (indexPath.row/3) * 2 * (standartHeight + standartOffset) + standartOffset,
                                          frameMiddle - 2 * standartOffset,
                                          standartHeight * 2 + standartOffset);

            break;
        case 4:
            frame = CGRectMake(frameMiddle + standartOffset,
                                          (indexPath.row/3) * 2 * (standartHeight + standartOffset) + standartOffset,
                                          frameMiddle - 2 * standartOffset,
                                          standartHeight);
            break;
        case 5:
            frame = CGRectMake(frameMiddle + standartOffset,
                                          (indexPath.row/3 * 2 + 1) * (standartHeight + standartOffset) + standartOffset,
                                          frameMiddle - 2 * standartOffset,
                                          standartHeight);
            break;
        default:
            frame = CGRectZero;
            break;
    }
    //NSLog(@"%@", frame);
    return frame;
}

@end
