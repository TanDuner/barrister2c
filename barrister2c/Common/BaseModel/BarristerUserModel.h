//
//  BarristerUserModel.h
//  barrister
//
//  Created by 徐书传 on 16/5/23.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"

@interface BarristerUserModel : BaseModel

@property (nonatomic,strong) NSString *userId;//userid

/**
 *  验证码 也就是密码
 */
@property (nonatomic,strong) NSString *verifyCode;
/**
 *  昵称
 */
@property (nonatomic,strong) NSString *nickName;

/**
 *  性别 0 男  1 女
 */
@property (nonatomic,strong) NSString *gender;

/**
 *  姓名
 */
@property (nonatomic,strong) NSString *username;

/**
 *  头像地址
 */
@property (nonatomic,strong) NSString *headUrl;

/**
 *  手机
 */
@property (nonatomic,strong) NSString *mobile;

/**
 *  邮箱
 */
@property (nonatomic,strong) NSString *mail;

/**
 * 律师事务所
 */
@property (nonatomic,strong) NSString *lawOffice;

/**
 * 市
 */
@property (nonatomic,strong) NSString *city;

/**
 *  地区
 */
@property (nonatomic,strong) NSString *area;

/**
 * 执业证书编号
 */
@property (nonatomic,strong) NSString *certificateNo;

/**
 * 律师执业证书照片http链接
 */
@property (nonatomic,strong) NSString *certificateUrl;

/**
 *  身份证号
 */

@property (nonatomic,strong) NSString *cardNum;

/**
 *  身份证照片链接
 */

@property (nonatomic,strong) NSString *cardUrl;

/**
 *  工作年限
 */

@property (nonatomic,strong) NSString *workTime;

/**
 *  星级数量
 */

@property (nonatomic,strong) NSString *startCount;

/**
 *  历史完成订单数
 */

@property (nonatomic,strong) NSString *orderCount;

/**
 *  法律职业资格证书
 */

@property (nonatomic,strong) NSString *gnvqsUrl;

/**
 *  法律执业证书年检照片
 */

@property (nonatomic,strong) NSString *yearCheckUrl;

/**
 *  小节率
 */

@property (nonatomic,strong) NSString *summaryRate;

/**
 *  认证失败原因
 */

@property (nonatomic,strong) NSString *refuseCause;

/**
 *  邮箱
 */
@property (nonatomic,strong) NSString *email;

/**
 *  年龄
 */
@property (nonatomic,strong) NSString *age;

/**
 *  通信地址
 */

@property (nonatomic,strong) NSString *address;

/**
 *  推送id
 */
@property (nonatomic,strong) NSString *pushId;

/**
 *  擅长
 */

@property (nonatomic,strong) NSString *goodAt;

/**
 *  律所
 */

@property (nonatomic,strong) NSString *company;

/**
 *  从业时间
 */

@property (nonatomic,strong) NSString *workingStartYear;

//String id;//用户id
//String nickname;//昵称
//String userIcon;//用户头像
//String name;//姓名
//String phone;//电话
//String email;//邮箱
//String age;//年龄：60后，70后，80后，90后，00后
//String introduction;//自我介绍
//String gender;//性别
//String address;//通信地址
//String state;//省、州
//String city;//市
//String area;//地区
//String location;//暂时无用，保留字段；位置信息 经纬度：x，y，逗号分隔
//String pushId;//推送id
//String goodAt;//擅长
//String company;//律所
//String verifyStatus;//认证状态 ；成功 STATUS_SUCCESS; 失败 STATUS_FAILED; 审核中 STATUS_VERIFYING;
//String workingStartYear;//从业开始时间。工作年限等于当前年减去工作开始时间


@end
