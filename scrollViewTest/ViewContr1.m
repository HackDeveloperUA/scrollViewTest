//
//  ViewContr1.m
//  scrollViewTest
//
//  Created by MD on 21.09.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ViewContr1.h"
#import "ASScrollCell.h"
#import "ASColleCell.h"
#import "ASCustomCollCell.h"



@interface ViewContr1 () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,
                          UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray* imagesarray;
@property (nonatomic, strong) NSMutableArray* collectionarray;

@property (assign, nonatomic) int xOffset;

@property (strong, nonatomic) ASColleCell* ascollCell;
@property (assign,nonatomic)  BOOL loadingDataCollPhoto;

@end

@implementation ViewContr1


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.imagesarray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
   // self.collectionarray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    
    self.collectionarray = [NSMutableArray array];
    
    self.loadingDataCollPhoto = NO;

    

    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
     self.collectionarray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
     [self.ascollCell.collectionView reloadData];

}


-(void) parseDate {
    
    NSArray* arr = [NSArray arrayWithObjects:@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3", nil];
    
    NSMutableArray* arrPath = [NSMutableArray array];
    
    
    for (NSInteger i= [self.collectionarray count]; i<=[arr count]+[self.collectionarray count]-1; i++) {
        NSLog(@"Добавляем %ld",(long)i);
        [arrPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }

    [self.collectionarray addObjectsFromArray:arr];
    [self.imagesarray addObjectsFromArray:arr];

    [self.ascollCell superReloadData:arrPath];
    self.loadingDataCollPhoto = NO;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
 
    if ([UICollectionView isSubclassOfClass:[UIScrollView class]]) {

    if ((scrollView.contentOffset.x + scrollView.frame.size.width) >= scrollView.contentSize.width+5) {
        
        if (self.loadingDataCollPhoto == NO)
        {
            
            NSLog(@"Подгружаю !");
            
            self.loadingDataCollPhoto = YES;
            [self parseDate];
        }
    
     }
    }
}


#pragma mark - Table view data source


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return  CGSizeMake(100, 100);
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 111.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NSLog(@"cellForRowAtIndexPath = indexPath.row %ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {
      
            static NSString* identifier = @"ASScrollCell";
            
            ASScrollCell* cell = (ASScrollCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[ASScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }

            
            cell.customScroll.delegate = self;
            cell.customScroll.scrollEnabled = YES;
            
            int scrollWidth = 100;
            
        
            cell.customScroll.frame = CGRectMake(0, 0, self.view.frame.size.width, 110);

            self.xOffset = 0;
            
            for(int index=0; index < [self.imagesarray count]; index++)
            {
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.xOffset,5, 90, 90)];
                img.image = [UIImage imageNamed:[self.imagesarray objectAtIndex:index]];
                img.contentMode = UIViewContentModeScaleAspectFit;
            
                [cell.customScroll addSubview:img];
                self.xOffset+=100;
           
            }
            
            cell.customScroll.contentSize = CGSizeMake(scrollWidth+self.xOffset,110);
            
            return cell;
   }
    
    if (indexPath.row == 1) {
     

        ASColleCell* cell = (ASColleCell*)[tableView dequeueReusableCellWithIdentifier:@"ASCollCell"];
        if (!cell) {
            cell = [[ASColleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ASCollCell"];
        }
        

        //self.ascollCell = [[ASColleCell alloc]init];
        self.ascollCell = cell;
        
        return cell;
    }

    return nil;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.collectionarray count];
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collView" forIndexPath:indexPath];
    
    ASCustomCollCell* cell = (ASCustomCollCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"collView" forIndexPath:indexPath];
    
    NSString* str = self.collectionarray[indexPath.row];
    if ([str isEqualToString:@"1"]) {
        cell.backgroundColor = [UIColor blueColor];
    } else {
        cell.backgroundColor = [UIColor greenColor];

    }
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
