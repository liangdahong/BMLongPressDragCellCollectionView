//
//  BMChannelEditVC.h
//  ToutiaoDemo
//
//  Created by ___liangdahong on 2017/12/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMChannelModel;

typedef void(^BMChannelEditBlock)(NSMutableArray <NSMutableArray <BMChannelModel *> *> *channelModelArray);

@interface BMChannelEditVC : UIViewController

@property (nonatomic, strong) NSMutableArray <NSMutableArray <BMChannelModel *> *> *channelModelArray; ///< channelModelArray
@property (nonatomic, copy) BMChannelEditBlock editCompleteBlock; ///< editCompleteBlock

@end
