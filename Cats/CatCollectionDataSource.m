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
    
    cell.cat = [self.catManager getCatForIndex:indexPath.item];
    
    return cell;
}



@end
