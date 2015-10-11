//
//  ASColleCell.h
//  scrollViewTest
//
//  Created by MD on 21.09.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASColleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSString* str;

-(void) superReloadData:(NSArray*) arrayPath;

@end
