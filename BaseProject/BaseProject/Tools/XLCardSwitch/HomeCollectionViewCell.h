//
//  HomeCollectionViewCell.h
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/2/28.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  HomeListModel;
NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell
-(void)setCellInfoWithModel:(HomeListModel *)model;
@end

NS_ASSUME_NONNULL_END
