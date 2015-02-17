//
//  SXMainViewController.m
//  93 - Coredata通讯录
//
//  Created by 董 尚先 on 15/2/17.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXMainViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Conpany.h"
@interface SXMainViewController ()<NSFetchedResultsControllerDelegate,UISearchBarDelegate>

@property(nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@property(nonatomic,strong) AppDelegate *appDelegate;
@end

@implementation SXMainViewController

#pragma mark - ******************** 懒加载
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController == nil) {
        
        // 1. 查询请求
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
        // 2. 排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"personName" ascending:YES];
        request.sortDescriptors = @[sort];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        // 设置代理
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

- (AppDelegate *)appDelegate
{
    if (_appDelegate == nil) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

#pragma mark - ******************** 结果器代理方法
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"改变");
    
    [self.tableView reloadData];
}

#pragma mark - ******************** SearchBar代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    [self searchWithSearchText:searchText];
    
    
}
- (void)searchWithSearchText:(NSString *)searchText
{
    // 1. 查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    // 2. 排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"personName" ascending:YES];
    request.sortDescriptors = @[sort];
    
    if (searchText.length != 0) {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@" personName CONTAINS %@ || company.companyName CONTAINS %@",searchText,searchText];
        request.predicate = pred;
    }
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // 设置代理
    _fetchedResultsController.delegate = self;

    [self.fetchedResultsController performFetch:NULL];
    
    [self.tableView reloadData];
}

#pragma mark - ******************** 首次加载
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.fetchedResultsController performFetch:NULL];
    
    [self.tableView reloadData];
}

#pragma mark - ******************** tbv数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"PersonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    Person *p = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    cell.textLabel.text = p.personName;
    cell.detailTextLabel.text = p.company.companyName;
    
    return cell;
}

@end
