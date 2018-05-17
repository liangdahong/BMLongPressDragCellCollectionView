//
//  AddPhotoCollectionViewCell.h
//  DatingCloud
//
//  Created by Denny on 2018/5/16.
//  Copyright © 2018年 Denny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface AddPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)UIImageView *photo;
@end
