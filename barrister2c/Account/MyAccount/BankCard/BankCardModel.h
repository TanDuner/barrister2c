//
//  BankCardModel.h
//  barrister
//
//  Created by 徐书传 on 16/6/5.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface BankCardModel : BaseModel

//"cardtype": "贷记卡",
//"cardlength": 16,
//"cardprefixnum": "518710",
//"cardname": "MASTER信用卡",
//"bankname": "招商银行信用卡中心",
//"banknum": "03080010"

@property (nonatomic,strong) NSString *cardtype;
@property (nonatomic,strong) NSString *cardlength;
@property (nonatomic,strong) NSString *cardprefixnum;
@property (nonatomic,strong) NSString *cardname;
@property (nonatomic,strong) NSString *bankname;
@property (nonatomic,strong) NSString *banknum;
@property (nonatomic,strong) NSString *cardNum;


+(NSString *)getIconNameWithBankName:(NSString *)name;

+(UIColor *)getColorWithIconName:(NSString *)iconName;

@end
