//
//  DetailViewController.m
//  SaltSideSample
//
//  Created by Ashish Kumar on 04/12/15.
//  Copyright © 2015 SS. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@end

@implementation DetailViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.title = @"Detail";

    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.detailTableView.bounds.size.width, 170)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,10,self.detailTableView.bounds.size.width,150)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL]];
    [backgroundView addSubview:imageView];
    

    _detailTableView.tableHeaderView = backgroundView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma Tableview Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Title:";
    }
    else
        return @"Description:";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(indexPath.section == 0){
        cell.textLabel.text = _detailTitle;
    }
    else{
        cell.textLabel.text = _detailDescription;
        cell.textLabel.numberOfLines = 0;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1){
        
        return [self findHeightForText:_detailDescription havingWidth:tableView.bounds.size.width-60 andFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0]].height;
    }
    return 50;
}


- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
