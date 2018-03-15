//
//  ViewController.m
//  pickerView
//
//  Created by PatrickY on 2018/3/15.
//  Copyright © 2018年 PatrickY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSDictionary              *pickerData;
@property (nonatomic, strong) NSArray                   *pickerProvincesData;
@property (nonatomic, strong) NSArray                   *pickerCitiesData;

@end

@implementation ViewController {
    UILabel                                             *_label;
    UIButton                                            *_button;
    UIPickerView                                        *_picerkView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat topView = 50;
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 21;
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 30;
    CGFloat pickerViewWidth = 300;
    CGFloat pickerViewHeight = 162;
    
    _picerkView = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 20, pickerViewWidth, pickerViewHeight)];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width - labelWidth) / 2, topView + pickerViewHeight + 20, labelWidth, labelHeight)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"Label";
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, topView + pickerViewHeight + labelHeight + 20, buttonWidth, buttonHeight);
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_picerkView];
    [self.view addSubview:_label];
    [self.view addSubview:_button];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"provinces_cities" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.pickerData = dict;
    self.pickerProvincesData = [self.pickerData allKeys];
    
    NSString *selectedProvince = [self.pickerProvincesData objectAtIndex:0];
    self.pickerCitiesData = [self.pickerData objectForKey:selectedProvince];
    
    //设置代理和数据源
    _picerkView.delegate = self;
    _picerkView.dataSource = self;
    
    
}


- (void)buttonClick:(id)sender {
    
    NSInteger row1 = [_picerkView selectedRowInComponent:0];
    NSInteger row2 = [_picerkView selectedRowInComponent:1];
    NSString *selected1 = [self.pickerProvincesData objectAtIndex:row1];
    NSString *selected2 = [self.pickerCitiesData objectAtIndex:row2];
    
    NSString *title = [[NSString alloc] initWithFormat:@"%@,%@市", selected1, selected2];
    
    _label.text = title;
    
}


#pragma UIPickerViewDelegate, UIPickerViewDataSource
//pickView列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.pickerProvincesData count];
    }else {
        return [self.pickerCitiesData count];
    }
    
}

//pickerView显示
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.pickerProvincesData objectAtIndex:row];
    }else {
        return [self.pickerCitiesData objectAtIndex:row];
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        NSString *selectedProvince = [self.pickerProvincesData objectAtIndex:row];
        NSArray *array = [self.pickerData objectForKey:selectedProvince];
        self.pickerCitiesData = array;
        [_picerkView reloadComponent:1];
        
    }
    
}



@end
