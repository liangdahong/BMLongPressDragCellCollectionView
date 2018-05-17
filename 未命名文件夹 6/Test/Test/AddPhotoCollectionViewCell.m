//
//  AddPhotoCollectionViewCell.m
//  DatingCloud
//
//  Created by Denny on 2018/5/16.
//  Copyright © 2018年 Denny. All rights reserved.
//

#import "AddPhotoCollectionViewCell.h"

@implementation AddPhotoCollectionViewCell
- (UIImageView *)photo {
    if (!_photo) {
        _photo = [[UIImageView alloc]init];
    }
    return _photo;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.photo.frame = self.bounds;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.photo];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor grayColor];
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [self.photo sd_setImageWithURL:[NSURL URLWithString:url]];
}

@end
