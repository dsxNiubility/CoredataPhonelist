//
//  SXPersonViewController.m
//  93 - Coredata通讯录
//
//  Created by 董 尚先 on 15/2/17.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXPersonViewController.h"

@interface SXPersonViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextField *companyText;


@property (nonatomic, strong) UIPickerView *pickerView;


@end

@implementation SXPersonViewController

#pragma mark - ******************** 懒加载
- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
#pragma mark - ******************** 添加公司按钮
- (IBAction)btnAddCompany:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加公司" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}
#pragma mark - ******************** 弹窗之后点击保存
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - ******************** 保存信息
- (IBAction)save {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
