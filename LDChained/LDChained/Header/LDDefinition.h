
//
//  LDDefinition.h
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#ifndef LDDefinition_h
#define LDDefinition_h

#define kPropertyViewObject(viewType ,type, name) \
@property (copy, nonatomic, readonly, getter=ld_##name) viewType *(^name##_block)(type *name)

#define kPropertyView(viewType ,type, name) \
@property (copy, nonatomic, readonly, getter=ld_##name) viewType *(^name##_block)(type name)


#define kImplementViewObject(viewType ,type, name)         \
- (viewType *(^)(type *name))ld_##name { \
\
    return ^viewType * (type *name) { \
        self.name = name; return self;\
    };\
}\

#define kImplementView(viewType ,type, name)         \
- (viewType *(^)(type name))ld_##name { \
\
    return ^viewType * (type name) { \
        self.name = name; return self;\
    }; \
}

#endif
