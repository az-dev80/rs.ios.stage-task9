//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "SecondaryViewController.h"
#import "RSSchool_T9-Swift.h"
#import "ColorViewController.h"

static CGFloat xw;

@interface SecondaryViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *titleCellsArray;
}

@property(strong,nonatomic)UITableView *myTableView;
@property(strong,nonatomic) NSArray<NSLayoutConstraint *> *wideConstraints;
@property(strong,nonatomic) NSArray<NSLayoutConstraint *> *narrowConstraints;
@property(strong,nonatomic) NSArray<NSLayoutConstraint *> *commonConstraints;
@end

@implementation SecondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1].CGColor;
    titleCellsArray = @[@"Draw stories", @"Stroke  color"];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.layer.cornerRadius = 16;
    self.myTableView.layer.backgroundColor = [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1].CGColor;
    self.myTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell0"];
    [self.view addSubview: self.myTableView];
    [self setupconstraint];
}

- (void)viewWillAppear:(BOOL)animated{
    //[self.myTableView reloadData];
}
-(void)setupconstraint{
    
    NSLayoutConstraint *cnX = [self.myTableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0.0];
   // NSLayoutConstraint *cnY = [self.myTableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0.0];
    NSLayoutConstraint *top = [self.myTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:123.0];
    top.priority = UILayoutPriorityDefaultLow;
    NSLayoutConstraint *hgt = [self.myTableView.heightAnchor constraintEqualToConstant: 100.0];
    hgt.priority = UILayoutPriorityDefaultLow;
    NSLayoutConstraint *wdt = [self.myTableView.widthAnchor constraintEqualToConstant: (self.view.frame.size.width - 40)];
    wdt.priority = UILayoutPriorityDefaultLow;
    
    self.commonConstraints = @[cnX, top, hgt];
    
    self.narrowConstraints = @[wdt];
    
    self.wideConstraints = @[[self.myTableView.widthAnchor constraintEqualToConstant: (self.view.frame.size.width - 100)]];
    
    [NSLayoutConstraint activateConstraints: self.commonConstraints];
    if (self.view.frame.size.width > self.view.frame.size.height) {
        [NSLayoutConstraint activateConstraints: self.wideConstraints];
    } else {
        [NSLayoutConstraint activateConstraints: self.narrowConstraints];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
    [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell0"];
    
    cell.textLabel.text = titleCellsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        UISwitch *btn = [[UISwitch alloc]initWithFrame:CGRectZero];
        [btn setOn:true animated:true];
        cell.accessoryView = btn;
        [btn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        ColorViewController *colorInst = [ColorViewController new];
        [colorInst colorForDrawing];
        cell.detailTextLabel.text = colorInst.colorName;
        cell.detailTextLabel.textColor = [UIColor colorNamed:colorInst.colorName];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1){
        ColorViewController *colorVC = [ColorViewController new];
        [[self navigationController] pushViewController:colorVC animated:NO];
     }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleCellsArray.count;
}

-(void)switchAction:(id)sender {
    UISwitch *switchBtn = sender;
    if (switchBtn.on == YES) {
        xw = 0.0;
    }
    else {
        xw = 1.0;
    }
}

-(void)valueForPass{
    self.timerValueObj = xw;
}

@end
