//
//  SXPersonViewController.m
//  93 - Coredata通讯录
//
//  Created by 董 尚先 on 15/2/17.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXPersonViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Conpany.h"

@interface SXPersonViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextField *companyText;


@property(nonatomic,strong) AppDelegate *appDelegate;

@property (nonatomic, strong) UIPickerView *pickerView;

/**
 *  查询结果"控制器" Controller
 *
 *  在CoreData中负责统一处理数据查询工作
 */
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

// 用户选中的公司对象
@property (nonatomic, weak) Conpany *selectedCompany;

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
- (AppDelegate *)appDelegate
{
    if (_appDelegate == nil) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}


/** 查询结果控制器 */
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Conpany"];
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"companyName" ascending:YES];
        
        request.sortDescriptors = @[sort];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

#pragma mark - ******************** 首次加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.companyText.inputView = self.pickerView;
    
    [self.fetchedResultsController performFetch:NULL]; // $$$$$  千万不能忘了
}
#pragma mark - ******************** 查询结果控制器代理方法
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"改变");
    
    [self.pickerView reloadAllComponents];
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
    UITextField *textFiled = [alertView textFieldAtIndex:0];
    if (textFiled.text.length == 0) {
        return;
    }
    if (buttonIndex == 0) {
        NSLog(@"点击了取消");
        return;
    }
    
    Conpany *conpany = [NSEntityDescription insertNewObjectForEntityForName:@"Conpany" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    conpany.companyName = textFiled.text;
    
    [self.appDelegate saveContext];
}

#pragma mark - ******************** 保存信息
- (IBAction)save {
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.appDelegate.managedObjectContext];
    person.age = @([self.ageText.text intValue]);
    person.personName = self.nameText.text;
    person.personNo = self.phoneText.text;
    person.company = self.selectedCompany;
    
    [self.appDelegate saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark - ******************** UIPickerView的数据源&代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // 使用FetchedResultsController负责数据查询，直接返回查询结果的数量
    NSInteger count = self.fetchedResultsController.fetchedObjects.count;
    
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    Conpany *company = self.fetchedResultsController.fetchedObjects[row];
    
    return company.companyName;
}

// 选中公司，设置对应的公司名称
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    Conpany *company = self.fetchedResultsController.fetchedObjects[row];
    
    self.companyText.text = company.companyName;
    
    self.selectedCompany = company;
}





@end
