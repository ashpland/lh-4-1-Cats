//
//  CatManager.m
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "CatManager.h"

@interface CatManager ()

@property (strong, nonatomic) NSMutableArray<Cat *> *theCats;

@end

@implementation CatManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.theCats = [NSMutableArray new];
    }
    return self;
}


-(void)addCat:(NSDictionary *)catInfo
{
    NSString *catURLString = [NSString
                              stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                              [catInfo objectForKey:@"farm"],
                              [catInfo objectForKey:@"server"],
                              [catInfo objectForKey:@"id"],
                              [catInfo objectForKey:@"secret"]
                              ];
    
    NSURL *catURL = [NSURL URLWithString:catURLString];
    
    
    
    Cat *newCat = [Cat newCatWithULR:catURL andDescription:[catInfo objectForKey:@"title"]];
    [self.theCats addObject:newCat];
}

-(Cat *)getCatForIndex:(NSInteger)index
{
    if (index < self.theCats.count)
        return self.theCats[index];
    else
        return nil;
}

-(NSInteger)numberOfCats
{
    return self.theCats.count;
}


@end
