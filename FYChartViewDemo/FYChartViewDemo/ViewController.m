//
//  ViewController.m
//  FYChartViewDemo
//
//  sina weibo:http://weibo.com/zbflying
//
//  Created by zbflying on 13-12-1.
//  Copyright (c) 2013年 zbflying. All rights reserved.
//

#import "ViewController.h"

#import "FYChartView.h"

@interface ViewController ()<FYChartViewDataSource>

@property (nonatomic, retain) FYChartView *chartView;
@property (nonatomic, retain) NSArray *values;

@end

@implementation ViewController

#define ARC4RANDOM_MAX  0x100000000

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 50; i++)
    {
        double val = floorf(((double)arc4random() / ARC4RANDOM_MAX) * 100.0f);
        [array addObject:[NSNumber numberWithDouble:val]];
    }
    self.values = array;
    
    self.chartView = [[[FYChartView alloc] initWithFrame:CGRectMake(.0f, 100.0f, 320.0f, 200.0f)] autorelease];
    self.chartView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.chartView.rectangleLineColor = [UIColor grayColor];
    self.chartView.lineColor = [UIColor blueColor];
    self.chartView.dataSource = self;
    [self.view addSubview:self.chartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_chartView release];
    [_values release];
    [super dealloc];
}

#pragma mark - FYChartViewDataSource

//number of value count
- (NSInteger)numberOfValueItemCountInChartView:(FYChartView *)chartView;
{
    return self.values ? self.values.count : 0;
}

//value at index
- (float)chartView:(FYChartView *)chartView valueAtIndex:(NSInteger)index
{
    return [((NSNumber *)self.values[index]) floatValue];
}

//horizontal title at index
- (NSString *)chartView:(FYChartView *)chartView horizontalTitleAtIndex:(NSInteger)index
{
    if (index == 0 || index == self.values.count - 1)
    {
        return [NSString stringWithFormat:@"%.2f", [((NSNumber *)self.values[index]) floatValue]];
    }
    
    return nil;
}

//horizontal title alignment at index
- (HorizontalTitleAlignment)chartView:(FYChartView *)chartView horizontalTitleAlignmentAtIndex:(NSInteger)index
{
    HorizontalTitleAlignment alignment = HorizontalTitleAlignmentCenter;
    if (index == 0)
    {
        alignment = HorizontalTitleAlignmentCenter;
    }
    else if (index == self.values.count - 1)
    {
        alignment = HorizontalTitleAlignmentRight;
    }
    
    return alignment;
}

//description view at index
- (UIView *)chartView:(FYChartView *)chartView descriptionViewAtIndex:(NSInteger)index
{
    NSString *description = [NSString stringWithFormat:@"index=%d\nvalue=%.2f", index,
                             [((NSNumber *)self.values[index]) floatValue]];
    
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chart_ description_bg"]] autorelease];
    CGRect frame = imageView.frame;
    frame.size = CGSizeMake(80.0f, 40.0f);
    imageView.frame = frame;
    UILabel *label = [[[UILabel alloc]
                       initWithFrame:CGRectMake(.0f, .0f, imageView.frame.size.width, imageView.frame.size.height)] autorelease];
    label.text = description;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:10.0f];
    [imageView addSubview:label];
    
    return imageView;
}

@end
