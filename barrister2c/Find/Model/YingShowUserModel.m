//
//  YingShowUserModel.m
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "YingShowUserModel.h"
#import "YingShowInfoModel.h"

@implementation YingShowUserModel
-(void)handlePropretyWithDict:(NSDictionary *)dict
{

    self.yingShowUserId = [dict objectForKey:@"id"];
    
    self.addressHeight = [XuUtlity textHeightWithString:self.address withFont:YingShowDetailTextFont sizeWidth:SCREENWIDTH - 20];
    
    self.companyNameHeight  = [XuUtlity textHeightWithString:self.company withFont:YingShowDetailTextFont sizeWidth:SCREENWIDTH - 20];
    
    if (self.addressHeight < 13) {
        self.addressHeight = 13;
    }
    
    if (self.companyNameHeight < 13) {
        self.companyNameHeight = 13;
    }

    if (IS_NOT_EMPTY(self.licenseNuber)) {
//        self.cellHeight = 10 + (RowHeight + YingShowDetailVerSpace) *3 + self.companyNameHeight + (RowHeight + YingShowDetailVerSpace) *2 + YingShowDetailVerSpace + self.addressHeight + 10;
        self.cellHeight = 10 + 15 + 10 + self.companyNameHeight + (RowHeight + YingShowDetailVerSpace) *3 + self.addressHeight + YingShowDetailVerSpace + 10;
        
    }
    else{
    
//        self.cellHeight = 10 + (RowHeight + YingShowDetailVerSpace) *3 + self.companyNameHeight + (RowHeight + YingShowDetailVerSpace) *2 + YingShowDetailVerSpace + self.addressHeight + 10;
        self.cellHeight = 10 + 15 + 10 + self.companyNameHeight + (RowHeight + YingShowDetailVerSpace) *2 + self.addressHeight + YingShowDetailVerSpace + 10;

    }
    
    

    
}

@end
