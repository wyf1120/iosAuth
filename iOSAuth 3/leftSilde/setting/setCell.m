//
//  setCell.m
//  anQuanTong
//
//  Created by 吴宇飞 on 17/6/16.
//  Copyright © 2017年 gyd. All rights reserved.
//

#import "setCell.h"

@implementation setCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    UILabel *lab = [[UILabel alloc] init];
    _textLab = lab;
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = [UIColor blackColor];
    [self.contentView addSubview:lab];
    
    UIImageView *detailImg = [[UIImageView alloc] init];
    detailImg.image = [UIImage imageNamed:@"Personal-Center_gd"];
    [self.contentView addSubview:detailImg];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 20*HEIGHT));
    }];
    
    [detailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab.mas_centerY);
        make.right.mas_equalTo(-10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(18*WIDTH, 18*WIDTH));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
