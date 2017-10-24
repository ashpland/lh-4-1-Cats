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
    
    cell.catCellImageView.image = nil;
    
    Cat *currentCat = [self.catManager getCatForIndex:indexPath.item];
    
    cell.catCellLabel.text = currentCat.photoDescription;

    [currentCat getCatImage:^(UIImage *theImage) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.catCellImageView.image = theImage;
        }];
    }];
    
    return cell;
}



@end
