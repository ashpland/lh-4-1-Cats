//
//  PhotoLayout.m
//  InstaKilo
//
//  Created by Andrew on 2017-10-19.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "PhotoLayout.h"

@implementation PhotoLayout

- (instancetype)initWithPhotosPerRow:(NSInteger)number
{
    self = [super init];
    if (self) {
        _imagesPerRow = number;
    }
    return self;
}

-(void)prepareLayout
{
    CGFloat cellWidth = self.collectionView.frame.size.width / self.imagesPerRow;
    
    self.itemSize = CGSizeMake(cellWidth, cellWidth);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
}


@end
