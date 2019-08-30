//    996 License https://github.com/996icu/996.ICU/blob/master/LICENSE
//
//    Copyright (c) https://github.com/liangdahong/UITableView-BMTemplateLayoutCell
//

#import "BMLeftCollectionViewFlowLayout.h"

@interface BMLeftCollectionViewFlowLayout ()

@property (nonatomic, assign) CGFloat sumWidth;

@end

@implementation BMLeftCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection         = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing      = 0.0;
        self.minimumInteritemSpacing = 0.0;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray * layoutAttributes = [[NSArray alloc] initWithArray:layoutAttributes_t copyItems:YES];
    // 用来临时存放一行的Cell数组是
    NSMutableArray * layoutAttributesTemp = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < layoutAttributes.count ; index++) {
        // 当前cell的位置
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[index];
        // 上一个cell 的位置
        UICollectionViewLayoutAttributes *previousAttr = index == 0 ? nil : layoutAttributes[index-1];
        // 下一个cell 位置
        UICollectionViewLayoutAttributes *nextAttr = index + 1 == layoutAttributes.count ? nil : layoutAttributes[index+1];
        //加入临时数组
        [layoutAttributesTemp addObject:currentAttr];
        _sumWidth += currentAttr.frame.size.width;
        CGFloat previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr.frame);
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame);
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame);
        // 如果当前cell是单独一行时
        if (currentY != previousY && currentY != nextY){
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                [layoutAttributesTemp removeAllObjects];
                _sumWidth = 0.0;
            } else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
                [layoutAttributesTemp removeAllObjects];
                _sumWidth = 0.0;
            } else {
                [self setCellFrameWith:layoutAttributesTemp];
            }
        }
        // 如果下一个cell在本行，这开始调整Frame位置
        else if( currentY != nextY) {
            [self setCellFrameWith:layoutAttributesTemp];
        }
    }
    return layoutAttributes;
}

- (void)setCellFrameWith:(NSMutableArray*)layoutAttributes{
    CGFloat nowWidth = 0.0;
    nowWidth = self.sectionInset.left;
    for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
        CGRect nowFrame   = attributes.frame;
        nowFrame.origin.x = nowWidth;
        attributes.frame  = nowFrame;
        nowWidth += nowFrame.size.width;
    }
    _sumWidth = 0.0;
    [layoutAttributes removeAllObjects];
}

@end
