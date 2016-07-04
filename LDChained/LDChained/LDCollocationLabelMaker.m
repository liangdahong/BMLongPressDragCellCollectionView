//
//  LDCollocationLabelMaker.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "LDCollocationLabelMaker.h"

@implementation LDCollocationLabelMaker

- (LDCollocationMakerBlockTextBlock)textBlock {

    LDCollocationMakerBlockTextBlock block = ^LDCollocationLabelMaker * (NSString *text){
        ((UILabel *)self.view).text = text;
        return self;
    };
    return block;
}


- (LDCollocationMakerFontBlock)fontBlock {

    LDCollocationMakerFontBlock block = ^LDCollocationLabelMaker * (UIFont *font){
        ((UILabel *)self.view).font = font;
        return self;
    };
    return block;
}

- (LDCollocationMakerTextColorBlock)textColorBlock {
    
    LDCollocationMakerTextColorBlock block = ^LDCollocationLabelMaker * (UIColor *color){
        ((UILabel *)self.view).textColor = color;
        return self;
    };
    
    return block;
}

- (LDCollocationMakerShadowColorBlock)shadowColorBlock {

    LDCollocationMakerShadowColorBlock block = ^LDCollocationLabelMaker * (UIColor *color){
        ((UILabel *)self.view).shadowColor = color;
        return self;
    };
    return block;
}

- (LDCollocationMakerTextAlignmentBlock)textAlignmentBlock {
    
    LDCollocationMakerTextAlignmentBlock block = ^LDCollocationLabelMaker * (NSTextAlignment textAlignment){
        ((UILabel *)self.view).textAlignment = textAlignment;
        
        return self;
    };
    return block;
}
@end
