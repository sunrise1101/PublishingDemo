//
//  UIMacros.h
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#ifndef UIMacros_h
#define UIMacros_h

#ifndef PBSCREEN_WIDTH
#define PBSCREEN_WIDTH   ([[UIScreen mainScreen]bounds].size.width)
#endif

#ifndef Magin
#define Magin   (10)
#endif

#ifndef PBSysFont
#define PBSysFont(a)        [UIFont systemFontOfSize:a]
#endif

#ifndef PBSysBoldFont
#define PBSysBoldFont(a)    [UIFont boldSystemFontOfSize:a]
#endif


#endif /* UIMacros_h */
