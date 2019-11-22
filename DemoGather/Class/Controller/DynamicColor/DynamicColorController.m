//
//  DynamicColorController.m
//  DemoGather
//
//  Created by deepbaytech on 2019/11/22.
//  Copyright © 2019 SLQ. All rights reserved.
//

#import "DynamicColorController.h"

@interface DynamicColorController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DynamicColorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"DynamicColor" ;
    
    
    self.label.backgroundColor = [UIColor colorNamed:@"button"];
    
    
    UIColor *aaaa = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.label.text = @"白天";
            return [UIColor colorNamed:@"title"];
        } else {
            self.label.text = @"黑夜";
            return [UIColor colorNamed:@"title"];
        }
    }];
    self.label.textColor = aaaa;
    
}


@end
