//
//  CatCollectionDataSource.m
//  Cats
//
//  Created by Andrew on 2017-10-23.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "CatCollectionDataSource.h"

@implementation CatCollectionDataSource




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.catManager numberOfCats];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"catCell"];
    
    Cat *currentCat = [self.catManager getCatForIndex:indexPath.item];
    
    cell.textLabel.text = currentCat.photoDescription;
    
    [currentCat getCatImage:^(UIImage *theImage) {
        cell.imageView.image = theImage;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];

    return cell;
}



@end
