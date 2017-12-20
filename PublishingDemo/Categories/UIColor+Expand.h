//
//  UIColor+Expand.h
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Expand)

#define c_pinkishOrange         @"#ff6040"
#define c_pinkishGrey           @"#cccccc"
#define c_black                 @"#3D3D3D"
#define c_black_alpha           @"#14000000"
#define c_blackTwo              @"#4A4A4A"
#define c_blackThree            @"#2E2E2E"
#define c_softPink              @"#ffacb5"
#define c_whiteTwo              @"#f9f9f9"
#define c_warmGrey              @"#999999"
#define c_warmGreyTwo           @"#888888"
#define c_seafoamBlue           @"#71d2d2"
#define c_darkSkyBlue           @"#3caae6"
#define c_deepLilac             @"#8278c8"
#define c_greenishTeal          @"#41cd8a"
#define c_greenishTealTwo       @"#39bf7f"
#define c_greenishTealThree     @"#41cd8c"
#define c_brownishGrey          @"#666666"
#define c_grapefruit            @"#ff5a54"
#define c_grapefruit_alpha      @"#FF7B76"
#define c_orangishingrapefruit  @"#ff6a57"
#define c_orangish              @"#f78649"
#define c_whiteTwo_line         @"#ededed"
#define c_veryLightPink         @"#fffdfc"
#define c_softBlue              @"#508cee"
#define c_tangerine             @"#f89618"
#define c_littesoftBlue         @"#59c8ed"
#define c_dustyOrange           @"#f69132"
#define c_whiteSix              @"#f7f7f7"
#define c_dark                  @"#14191e"
#define c_tealish               @"#32c9d7"
#define c_weirdGreen            @"#5edea6"
#define c_lightGold             @"#ffd34c"
#define c_whiteFour             @"#f8f8f8"
#define c_lightGreyBlue         @"#a1c0d1"
#define c_lightWhite            @"#fafafa"
#define c_lightWhiteTwo         @"#FBFBFB"
#define c_lightGreyYellow       @"#f2f2f2"
#define c_wineRed               @"#993330"
#define c_deepYellow            @"#FFB000"
#define c_statusYellow          @"#EDEDED"
#define c_lightGreyDark         @"#f6f7f8"
#define c_midYellow             @"#FBC02D"
#define c_lightBlue             @"#E8F4F7"
#define c_midOrange             @"#FF9800"
#define c_midGreen              @"#689F38"
#define c_whiteSeven            @"#d7d7d7"
#define c_deepOrange            @"#ff8542"
#define c_deepGray              @"#9B9B9B"
#define c_yellowBackGround      @"#FFFBEE"
#define c_placeholderGray       @"#B8B8B8"

/**
 *    @brief    generate color
 *
 *    @param     hexString     eg:#34DE8A
 *
 *    @return    color's instance
 */

+ (UIColor *)pb_colorWithHexString:(NSString *)hexString;

+ (UIColor *)pb_colorWithHexString:(NSString *)hexString Alpha:(CGFloat)alpha;

+ (UIColor*)randomColor;

@end
