//
//  CatCollectionDataSource.m
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "CatCollectionDataSource.h"
#import "CatCollectionViewCell.h"

@implementation CatCollectionDataSource


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.catManager numberOfCats];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CatCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"catCell" forIndexPath:indexPath];
    

    Cat *currentCat = [self.catManager getCatForIndex:indexPath.item];

    cell.cat = currentCat;
        
    cell.catCellImageView.image = nil;
    
    cell.catCellLabel.text = currentCat.photoDescription;

    if (currentCat.image) {
        cell.catCellImageView.image = currentCat.image;
    } else {
        [currentCat downloadCatImage:^(Cat *theCat) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if ([cell.cat isEqual:theCat])
                    cell.catCellImageView.image = theCat.image;

            }];
        }];
    }
    
    return cell;
}



@end
