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
    
    cell.backgroundColor = [UIColor blueColor];
        
    cell.catCellLabel.text = currentCat.photoDescription;
    
    cell.catCellImageView.image = nil;
    
    if (currentCat.image) {
        cell.catCellImageView.image = currentCat.image;
    } else {
        [currentCat getCatImage:^(UIImage *theImage) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                cell.catCellImageView.image = theImage;
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }];
        }];
    }
    
    return cell;
}



@end
