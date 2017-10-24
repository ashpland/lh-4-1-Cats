//
//  CatCollectionViewCell.m
//  Cats
//
//  Created by Andrew on 2017-10-24.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "CatCollectionViewCell.h"

@implementation CatCollectionViewCell

-(void)setCat:(Cat *)cat
{
    _cat = cat;
    self.catCellLabel.text = cat.photoDescription;
    
    if (cat.image) {
        self.catCellImageView.image = cat.image;
    } else {
        self.catCellImageView.image = nil;
        [cat requestCatImage:^(Cat *theCat) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if ([self.cat isEqual:theCat])
                        self.catCellImageView.image = theCat.image;
                }];
        }];
    }
    
}

@end
