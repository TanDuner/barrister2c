//
//  BankCardModel.m
//  barrister
//
//  Created by 徐书传 on 16/6/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BankCardModel.h"
#define Red RGBCOLOR(196, 81, 87)
#define Green RGBCOLOR(19, 139, 119)
#define Blue RGBCOLOR(32, 102, 161)
#define gray RGBCOLOR(221, 221, 221)
#define Qin  RGBCOLOR(22, 150, 68)

@implementation BankCardModel
+(NSString *)getIconNameWithBankName:(NSString *)name
{
    NSArray *array = @[@{@"icon_bank_gs.png":@"工商银行"},@{@"icon_bank_zg.png":@"中国银行"},@{@"icon_bank_zs.png":@"招商银行"},@{@"icon_bank_js.png":@"建设银行"},@{@"icon_bank_jt.png":@"交通银行"},@{@"icon_bank_ny.png":@"农业银行"},@{@"icon_bank_yc.png":@"邮政储蓄"},@{@"icon_bank_ms.png":@"民生银行"},@{@"icon_bank_pf.png":@"浦发银行"},@{@"icon_bank_bj.png":@"北京银行"},@{@"icon_bank_gd.png":@"光大银行"},@{@"icon_bank_gf.png":@"广发银行"},@{@"icon_bank_hx.png":@"华夏银行"},@{@"icon_bank_xy.png":@"兴业银行"},@{@"icon_bank_zx.png":@"中信银行"}];
    
    for ( int i = 0; i < array.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[array safeObjectAtIndex:i];
        if (dict.allKeys.count  > 0) {
            NSString *key = [[dict allKeys] firstObject];
            NSString *value = [dict objectForKey:key];
            if ([name containsString:value]) {
                return key;
            }
        }
    }
    return @"";
}


+(UIColor *)getColorWithIconName:(NSString *)iconName
{
    
    NSDictionary *dict = @{@"icon_bank_gs.png":Red,@"icon_bank_zg.png":Red,@"icon_bank_zs.png":Red,@"icon_bank_js.png":gray,@"icon_bank_jt.png":Blue,@"icon_bank_ny.png":Green,@"icon_bank_yc.png":Green,@"icon_bank_ms.png":Qin,@"icon_bank_pf.png":Green,@"icon_bank_bj.png":Red,@"icon_bank_gd.png":gray,@"icon_bank_gf.png":Red,@"icon_bank_hx.png":Blue,@"icon_bank_xy.png":Green,@"icon_bank_zx.png":Red};

    UIColor*color = [dict objectForKey:iconName];
    if (color) {
        return color;
    }
    
    return Red;

}

@end
