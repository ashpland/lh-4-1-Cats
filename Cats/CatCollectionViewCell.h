//
//  CatCollectionViewCell.h
//  Cats
//
//  Created by Andrew on 2017-10-24.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cat.h"

@interface CatCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *catCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *catCellLabel;
@property (strong, nonatomic) Cat *cat;



@end
