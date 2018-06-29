//
//  DataModel.h
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import "BaseModel.h"
@protocol DataModel                 @end
@protocol ParentModel               @end
@class DataModel,ParentModel;

@interface DataModel : BaseDataModel


@end


@interface ParentModel : BaseDataModel
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *lastLoginTime;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pswd;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *avaterUrl;
@end







