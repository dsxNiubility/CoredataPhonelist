//
//  Person.h
//  93 - Coredata通讯录
//
//  Created by 董 尚先 on 15/2/17.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conpany;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * personName;
@property (nonatomic, retain) NSString * personNo;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) Conpany *company;

@end
