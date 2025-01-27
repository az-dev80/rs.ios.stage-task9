//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 3.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "ColorViewController.h"
#import "SecondaryViewController.h"
#import "RSSchool_T9-Swift.h"
static NSUInteger indexPth = 6;
static NSString *coloring = @"#f3af22";
@interface ColorViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSArray *colorCellsArray;
}
@property(strong,nonatomic)UITableView *colorTableView;
@property(strong,nonatomic) NSArray<NSLayoutConstraint *> *wideConstraints;
@property(strong,nonatomic) NSArray<NSLayoutConstraint *> *narrowConstraints;
@property(strong,nonatomic) NSArray<NSLayoutConstraint *> *commonConstraints;
@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1].CGColor;
    colorCellsArray = @[@"#be2813", @"#3802da", @"#467c24", @"#808080", @"#8e5af7", @"#f07f5a", @"#f3af22", @"#3dacf7", @"#e87aa4", @"#0f2e3f", @"#213711", @"#511307", @"#92003b"];
    
    self.colorTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.colorTableView.layer.cornerRadius = 16;
    self.colorTableView.layer.backgroundColor = [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1].CGColor;
    self.colorTableView.dataSource = self;
    self.colorTableView.delegate = self;
    self.colorTableView.translatesAutoresizingMaskIntoConstraints = NO;
    //self.colorTableView.pagingEnabled = YES;
    [self.colorTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview: self.colorTableView];
    [self setupconstraint];
    
}

-(void)setupconstraint{
    
    NSLayoutConstraint *cnX = [self.colorTableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0.0];
    NSLayoutConstraint *top = [self.colorTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:123.0];
    NSLayoutConstraint *lead = [self.colorTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0];
    NSLayoutConstraint *hgt = [self.colorTableView.heightAnchor constraintEqualToConstant: 572.0];
    NSLayoutConstraint *wdtW = [self.colorTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50];
    NSLayoutConstraint *bottom = [self.colorTableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:5];
    NSLayoutConstraint *topWide1 = [self.colorTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:5];
    
    self.commonConstraints = @[cnX, lead, top, hgt];
    self.wideConstraints = @[cnX, wdtW, topWide1, bottom];
    
    if (self.view.frame.size.width > self.view.frame.size.height) {
        [NSLayoutConstraint activateConstraints: self.wideConstraints];
    } else {
        [NSLayoutConstraint activateConstraints: self.commonConstraints];
    }
}
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    if(newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular){
        [NSLayoutConstraint deactivateConstraints: self.commonConstraints];
        [NSLayoutConstraint activateConstraints: self.wideConstraints];
    }
    else{
        [NSLayoutConstraint deactivateConstraints: self.wideConstraints];
        [NSLayoutConstraint activateConstraints: self.commonConstraints];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.textLabel.text = colorCellsArray[indexPath.row];
    NSString *string = colorCellsArray[indexPath.row];
    cell.textLabel.textColor = [UIColor colorNamed: string];
    if (indexPath.row == indexPth) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.tintColor = UIColor.redColor;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return colorCellsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadData];
    indexPth = indexPath.row;
    coloring = colorCellsArray[indexPth];
}
-(void)colorForDrawing{
    self.colorName = coloring;
}

@end
