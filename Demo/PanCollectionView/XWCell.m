
//
//  XWCell.m
//  PanCollectionView
//
//  Created by YouLoft_MacMini on 16/1/4.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCell.h"
#import "XWCellModel.h"

@interface XWCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation XWCell

- (void)setData:(XWCellModel *)data{
    _data = data;
    _label.text = data.title;
    self.backgroundColor = data.backGroundColor;
}

@end
