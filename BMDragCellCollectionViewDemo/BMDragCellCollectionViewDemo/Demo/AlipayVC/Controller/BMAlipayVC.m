
//
//  BMAlipayVC.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/25.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMAlipayVC.h"
#import "BMDragCellCollectionView.h"
#import "BMAlipayCell.h"
#import "BMAlipayHeaderCollectionView.h"
#import "BMAlipayHeaderSelectView.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMAlipayVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet BMAlipayHeaderCollectionView *alipayHeaderCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alipayHeaderCollectionViewHeightCons;
@property (weak, nonatomic) IBOutlet BMAlipayHeaderSelectView *alipayHeaderSelectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alipayHeaderHeightCons;

@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *cellCollectionView;

@end

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation BMAlipayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝-正在完善中...";
    self.cellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
    self.cellCollectionView.alwaysBounceVertical = YES;
    [self.cellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMAlipayCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}


- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [UICollectionViewFlowLayout new];
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionViewFlowLayout.minimumLineSpacing = 1;
        _collectionViewFlowLayout.minimumInteritemSpacing = 1;
        _collectionViewFlowLayout.itemSize = CGSizeMake((WIDTH-4)/4.0, 55);
        _collectionViewFlowLayout.headerReferenceSize = CGSizeMake(100, 40);
    }
    return _collectionViewFlowLayout;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMAlipayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.alipayHeaderSelectView.isHidden) {
        self.alipayHeaderSelectView.hidden = NO;
        self.alipayHeaderSelectView.hidden = NO;
        self.alipayHeaderHeightCons.constant = 0;
        self.alipayHeaderSelectView.hidden = NO;
    } else {
        self.alipayHeaderHeightCons.constant = 0;
        self.alipayHeaderSelectView.hidden = NO;
        self.alipayHeaderSelectView.hidden = NO;
    }
}

@end
