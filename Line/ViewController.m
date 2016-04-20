//
//  ViewController.m
//  Line
//
//  Created by liqunfei on 16/4/20.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LineView *line = [[LineView alloc] initWithFrame:CGRectMake(20, 60, self.view.bounds.size.width - 40, 200)];

    line.dataArray = @[[self valueX:0 Y:0],[self valueX:2 Y:2],[self valueX:3 Y:6],[self valueX:4 Y:3],[self valueX:5 Y:2],[self valueX:6 Y:0]];
    line.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:line];

    // Do any additional setup after loading the view, typically from a nib.
}

- (NSValue *)valueX:(CGFloat)x Y:(CGFloat)y {
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
