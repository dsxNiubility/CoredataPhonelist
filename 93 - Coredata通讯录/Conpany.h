//
//  Conpany.h
//  93 - Coredata通讯录
//
//  Created by 董 尚先 on 15/2/17.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Conpany : NSManagedObject

@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSSet *persons;
@end

@interface Conpany (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(Person *)value;
- (void)removePersonsObject:(Person *)value;
- (void)addPersons:(NSSet *)values;
- (void)removePersons:(NSSet *)values;

@end
