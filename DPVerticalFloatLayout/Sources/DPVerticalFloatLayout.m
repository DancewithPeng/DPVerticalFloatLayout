//
//  DPVerticalFloatLayout.m
//  DPVerticalFloatLayout
//
//  Created by 张鹏 on 2021/1/13.
//

#import "DPVerticalFloatLayout.h"

@interface DPVerticalFloatLayout ()

/// 代理
@property (nonatomic, weak, readonly) id<UICollectionViewDelegateFlowLayout> delegate;

@end

@implementation DPVerticalFloatLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect lastItemFrame = CGRectZero;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        if (attribute.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        
        if (abs(attribute.center.y - CGRectGetMidY(lastItemFrame)) > 0.01) { // 换行
            CGRect targetRect = attribute.frame;
            UIEdgeInsets sectionInsets = UIEdgeInsetsZero;
            
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:attribute.indexPath.section];
            }
            
            targetRect.origin.x = sectionInsets.left;
            attribute.frame = targetRect;
            
            lastItemFrame = attribute.frame;
        } else { // 同一行
            CGRect targetRect = attribute.frame;
            CGFloat spacing = self.minimumInteritemSpacing;
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
                spacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:attribute.indexPath.section];
            }
            
            // 调整x的位置为合适的位置
            targetRect.origin.x = lastItemFrame.origin.x + lastItemFrame.size.width + spacing;
            attribute.frame = targetRect;
            
            lastItemFrame = attribute.frame;
        }
    }
    return attributes;
}

- (id<UICollectionViewDelegateFlowLayout>)delegate {
    if ([self.collectionView.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)]) {
        return (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    
    if ([self.collectionView.dataSource conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)]) {
        return (id<UICollectionViewDelegateFlowLayout>)self.collectionView.dataSource;
    }
    
    return nil;
}

@end
