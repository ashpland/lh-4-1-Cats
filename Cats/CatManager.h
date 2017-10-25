//
//  CatManager.h
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"

@interface CatManager : NSObject

+ (instancetype)sharedCatManager;

+(void)addCat:(NSDictionary *)catInfo;
+(Cat *)getCatForIndex:(NSInteger)index;
+(NSInteger)numberOfCats;
+(NSArray<Cat *> *)allTheCats;

@end
