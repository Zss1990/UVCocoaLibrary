//  Copyright (c) 2014 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVRecord.h
//
// Project Code: CoreData
// Module Name:
// Date Created: 14-3-7
// Author: selectersky/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-3-7  c00891 create
//
#import "UVSafeData.h"

@interface UVIdEntity : NSObject
@property(nonatomic,strong) NSNumber *id_;



- (NSString*)getString:(id)obj_;
- (NSNumber*)getNum:(id)obj_;
- (NSArray*)getArr:(id)obj_;
- (NSDictionary*)getDict:(id)obj_;
@end
