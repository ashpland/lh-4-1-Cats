//
//  PhotoLayout.h
//  InstaKilo
//
//  Created by Andrew on 2017-10-19.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger imagesPerRow;

- (instancetype)initWithPhotosPerRow:(NSInteger)number;


@end
