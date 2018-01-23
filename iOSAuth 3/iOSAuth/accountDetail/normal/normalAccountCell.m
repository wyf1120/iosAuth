//
//  normalAccountCell.m
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/23.
//  Copyright © 2018年 Aran. All rights reserved.
//

#import "normalAccountCell.h"

@implementation normalAccountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 4;
    backgroundView.layer.shadowOpacity = 0.6;
    backgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    backgroundView.layer.shadowOffset = CGSizeMake(1,1);
    backgroundView.layer.shadowRadius = 4;
    [self.contentView addSubview:backgroundView];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"时间：2018年1月23日";
    _timeLab = timeLab;
    timeLab.font = [UIFont systemFontOfSize:17];
    timeLab.textColor = [UIColor blackColor];
    [backgroundView addSubview:timeLab];
    
    UILabel *addLab = [UILabel new];
    addLab.text = @"地点：中国湖北武汉";
    _addLab = addLab;
    addLab.font = [UIFont systemFontOfSize:17];
    addLab.textColor = [UIColor blackColor];
    [backgroundView addSubview:addLab];
    
    UILabel *ipLab = [UILabel new];
    ipLab.text = @"IP：222.158.45.52";
    _ipLab = ipLab;
    ipLab.font = [UIFont systemFontOfSize:17];
    ipLab.textColor = [UIColor blackColor];
    [backgroundView addSubview:ipLab];
    
    UILabel *wayLab = [UILabel new];
    _wayLab = wayLab;
    wayLab.text = @"登录方式：手机短信";
    wayLab.font = [UIFont systemFontOfSize:17];
    wayLab.textColor = [UIColor blackColor];
    [backgroundView addSubview:wayLab];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.backgroundColor = [UIColor orangeColor];
    [backgroundView addSubview:img];
    
    UILabel *blockHeight = [[UILabel alloc] init];
    blockHeight.font = [UIFont systemFontOfSize:17];
    blockHeight.textColor = [UIColor blackColor];
    blockHeight.text = @"存储区块高度：9991";
    blockHeight.textAlignment = NSTextAlignmentRight;
    [backgroundView addSubview:blockHeight];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.topMargin.leftMargin.rightMargin.bottomMargin.mas_equalTo(5*WIDTH);
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-10);
    }];
    
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
    }];
    
    [addLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLab.mas_bottom).offset(10*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
    }];
    
    [ipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addLab.mas_bottom).offset(10*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
    }];
    
    [wayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ipLab.mas_bottom).offset(10*HEIGHT);
        make.left.mas_equalTo(10*WIDTH);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
    }];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLab.mas_top);
        make.right.mas_equalTo(-20*WIDTH);
        make.size.mas_equalTo(CGSizeMake(80*WIDTH, 50*HEIGHT));
    }];
    
    [blockHeight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(wayLab.mas_bottom);
        make.right.mas_equalTo(img.mas_right);
        make.size.mas_equalTo(CGSizeMake(150*WIDTH, 20*HEIGHT));
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
