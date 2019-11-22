//
//  PullDownImageController.m
//  DemoGather
//
//  Created by deepbaytech on 2019/11/22.
//  Copyright © 2019 SLQ. All rights reserved.
//

#import "PullDownImageController.h"

@interface PullDownImageController ()<UITableViewDelegate,UITableViewDataSource>

// 图片下面的 tableView
@property (strong, nonatomic) UITableView *tableView;
// 顶部的照片
@property (strong, nonatomic) UIImageView *topImageView;

@end

static CGFloat const imageHeight = 250;
@implementation PullDownImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"PullDownImage" ;
    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        // 这里为了留出放照片的位置
        self.tableView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 0, 0);
        
        self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -imageHeight, self.view.frame.size.width, imageHeight))];
        
        _topImageView.image = [self grayImage:[UIImage imageNamed:@"Xe56XEzC2Gc-8"]];
    //    # 关键： 照片按照自己的比例填充满
            _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    //    # 关键： 超出 imageView部分裁减掉
            _topImageView.clipsToBounds = YES;
        [self.tableView addSubview:self.topImageView];
    [self.view addSubview:self.tableView];
    
}

- (UIImage*)grayImage:(UIImage*)sourceImage {
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil, width, height,8,0, colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context ==NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0,0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下的话 为负数
    CGFloat off_y = scrollView.contentOffset.y;
    NSLog(@"------->%f",off_y);
// 下拉超过照片的高度的时候
    if (off_y < - imageHeight)
    {
        CGRect frame = self.topImageView.frame;
// 这里的思路就是改变 顶部的照片的 fram
        self.topImageView.frame = CGRectMake(0, off_y, frame.size.width, -off_y);
    }
}

@end
