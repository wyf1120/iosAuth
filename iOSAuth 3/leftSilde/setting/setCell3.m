//
//  setCell3.m
//  anQuanTong
//
//  Created by 吴宇飞 on 17/6/17.
//  Copyright © 2017年 gyd. All rights reserved.
//

#import "setCell3.h"

@implementation setCell3

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
    lab.text = @"清理缓存";
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = [UIColor blackColor];
    [self.contentView addSubview:lab];
    
    UILabel *cacheLab = [[UILabel alloc] init];
    _cacheLab = cacheLab;
    cacheLab.text =@"0.2M";
    cacheLab.textAlignment = NSTextAlignmentRight;
    cacheLab.textColor = [UIColor grayColor];
    cacheLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:cacheLab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(200*WIDTH, 20*HEIGHT));
    }];
    
    [cacheLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab.mas_centerY);
        make.right.mas_equalTo(-15*WIDTH);
        make.size.mas_equalTo(CGSizeMake(100*WIDTH, 20));
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
