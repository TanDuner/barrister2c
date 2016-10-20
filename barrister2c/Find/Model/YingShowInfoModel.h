//
//  YingShowInfoModel.h
//  barrister2c
//
//  Created by 徐书传 on 16/10/11.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "BaseModel.h"
#import "YingShowUserModel.h"

#define RowHeight 13
#define YingShowDetailVerSpace 5

#define YingShowDetailTextFont SystemFont(12.0f)


//债状态
static NSString *CREDIT_DEBT_STATUS_NOT_SUE = @"CREDIT_DEBT_STATUS_NOT_SUE";

static NSString *CREDIT_DEBT_STATUS_SUING = @"CREDIT_DEBT_STATUS_SUING";

static NSString *CREDIT_DEBT_STATUS_JUDGING = @"CREDIT_DEBT_STATUS_JUDGING";

static NSString *CREDIT_DEBT_STATUS_OUT_OF_DATE = @"CREDIT_DEBT_STATUS_OUT_OF_DATE";


////债类型
static NSString *TYPE_CONTRACT = @"TYPE_CONTRACT";

static NSString *TYPE_BORROW_MONEY = @"TYPE_BORROW_MONEY";

static NSString *TYPE_TORT = @"TYPE_TORT";

static NSString *TYPE_LABOR_DISPUTES = @"TYPE_LABOR_DISPUTES";

static NSString *TYPE_OTHER = @"TYPE_OTHER";


//凭证类型
static NSString *PROOF_TYPE_HETONG = @"hetong";

static NSString *PROOF_TYPE_XIEYI = @"xieyi";

static NSString *PROOF_TYPE_QIANTIAO = @"qiantiao";

static NSString *PROOF_TYPE_QITA = @"qita";

//判决文书类型

static NSString *JUDGE_TYPE_PANJUESHU = @"panjueshu";

static NSString *JUDGE_TYPE_TIAOJIESHU = @"tiaojieshu";

static NSString *JUDGE_TYPE_ZHONGCAISHU = @"zhongcaishu";

static NSString *JUDGE_TYPE_QITA = @"qita";

//债状态
//public static final String CREDIT_DEBT_STATUS_NOT_SUE = "CREDIT_DEBT_STATUS_NOT_SUE";//未起诉
//public static final String CREDIT_DEBT_STATUS_SUING = "CREDIT_DEBT_STATUS_SUING";//诉讼中
//public static final String CREDIT_DEBT_STATUS_JUDGING = "CREDIT_DEBT_STATUS_JUDGING";//执行中
//public static final String CREDIT_DEBT_STATUS_OUT_OF_DATE = "CREDIT_DEBT_STATUS_OUT_OF_DATE";//已过时效
//
////债类型
//public static final String TYPE_CONTRACT = "TYPE_CONTRACT";//合同欠款
//public static final String TYPE_BORROW_MONEY = "TYPE_BORROW_MONEY";//借款
//public static final String TYPE_TORT = "TYPE_TORT";//侵权
//public static final String TYPE_LABOR_DISPUTES = "TYPE_LABOR_DISPUTES";//劳动与劳务
//public static final String TYPE_OTHER= "TYPE_OTHER";//其它
//
////凭证类型
//public static final String PROOF_TYPE_HETONG = "hetong";//合同
//public static final String PROOF_TYPE_XIEYI = "xieyi";//协议
//public static final String PROOF_TYPE_QIANTIAO = "qiantiao";//欠条
//public static final String PROOF_TYPE_QITA = "qita";//其他
//
////判决文书类型
//public static final String JUDGE_TYPE_PANJUESHU = "panjueshu";//判决书
//public static final String JUDGE_TYPE_TIAOJIESHU = "tiaojieshu";//调解书
//public static final String JUDGE_TYPE_ZHONGCAISHU = "zhongcaishu";//仲裁书
//public static final String JUDGE_TYPE_QITA = "qita";//其他
//


//String id;
//String type;//债类型
//float money;//债的金额
////    String creditUserId;//债权人id --改成债券人对象
////    String debtUserId;//债务人id--改成债务人对象
//String desc;//债务描述
//String addTime;//上传时间
//String updateTime;//更新时间
//String creditDebtTime;//债形成的时间
//String creditDebtStatus;//债的状态
//String status;//信息状态,发布(审核通过)、未发布(刚上传)、已删除(垃圾信息)
//
//String proofName;//凭证类型名称(合同、协议、欠条等)
//String proof;//凭证
//String judgeDocumentName;//判决文书类型名称(判决书、调解书、仲裁书)
//String judgeDocument;//判决文书
//
//CreditDebtUser creditUser;//债权人
//CreditDebtUser debtUser;//债务人
//
//double price;//购买金额:上传成功后,后台管理员定价(建议根据债务金额百分比定价)



//addTime = "2016-10-13 09:52:27";
//creditDebtStatus = "CREDIT_DEBT_STATUS_NOT_SUE";
//creditDebtTime = "2016-10-13";
//creditUser = "<null>";
//debtUser = "<null>";
//desc = "<null>";
//id = 1;
//judgeDocument = "<null>";
//judgeDocumentName = qita;
//money = 1000;
//price = 16;
//proof = "<null>";
//proofName = hetong;
//status = published;
//type = "TYPE_CONTRACT";
//updateTime = "2016-10-13 22:48:39";


@interface YingShowInfoModel : BaseModel

@property (nonatomic,strong) NSString * yingShowInfoId;

@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSString * money;

@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *addTime;
@property (nonatomic,strong) NSString *updateTime;

@property (nonatomic,strong) NSString *creditDebtTime;

@property (nonatomic,strong) NSString *creditDebtStatus;

@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSString *proofName;

@property (nonatomic,strong) NSString *proof;

@property (nonatomic,strong) NSString *judgeDocumentName;

@property (nonatomic,strong) NSString *judgeDocument;

@property (nonatomic,strong) NSString *price;



@property (nonatomic,strong) YingShowUserModel *creditUser;
@property (nonatomic,strong) YingShowUserModel *debtUser;


@property (nonatomic,assign) CGFloat cellHeight;

@end
