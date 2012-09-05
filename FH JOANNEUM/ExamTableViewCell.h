//
//  ExamTableViewCell.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 20/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
