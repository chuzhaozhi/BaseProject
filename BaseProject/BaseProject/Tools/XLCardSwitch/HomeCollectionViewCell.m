//
//  HomeCollectionViewCell.m
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/2/28.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "HomeListModel.h"
#import "AddCarveViewController.h"

@interface HomeCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) HomeListModel *model;

@end
@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setCellInfoWithModel:(HomeListModel *)model{
    self.model = model;
    self.nameLabel.text = model.title;
    self.picImageView.image = DOCUMENT_PATH_IMG(model.pic);
    self.timeLabel.text = model.time;
    if (model.address.length>20) {
        model.address = [model.address substringToIndex:20];
    }
    self.titleLabel.text = model.address;
}
- (IBAction)editAction:(id)sender {
    AddCarveViewController *vc = [[AddCarveViewController alloc] init];
    vc.model = self.model;
    NSLog(@"%@",[Tools getCurrentVC]);
    [[Tools getCurrentVC].navigationController pushViewController:vc animated:YES];
}

@end
