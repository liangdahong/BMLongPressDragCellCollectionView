//
//  AddPhotoView.h
//  DatingCloud
//
//  Created by Denny on 2018/5/16.
//  Copyright © 2018年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPhotoCollectionViewCell.h"
#import "BMDragCellCollectionView.h"

@interface AddPhotoView : UIView<BMDragCellCollectionViewDelegate, BMDragCollectionViewDataSource>
    
@property (strong, nonatomic)BMDragCellCollectionView *dragCellCollectionView;
@property (strong, nonatomic)UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic)NSMutableArray *dataSourceArray;

@end
