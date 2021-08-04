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
    NSLayoutConstraint *cnY = [self.colorTableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0.0];
    NSLayoutConstraint *top = [self.colorTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:123.0];
    NSLayoutConstraint *hgt = [self.colorTableView.heightAnchor constraintEqualToConstant: 572.0];
    NSLayoutConstraint *wdt = [self.colorTableView.widthAnchor constraintEqualToConstant: (self.view.frame.size.width - 40)];
    NSLayoutConstraint *wdtW = [self.colorTableView.widthAnchor constraintEqualToConstant: (self.view.frame.size.width - 100)];
    NSLayoutConstraint *topWide1 = [self.colorTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20];
    
    self.commonConstraints = @[cnX, cnY, hgt];
    
    self.narrowConstraints = @[top, wdt];
    
    self.wideConstraints = @[topWide1, wdtW];
    
    [NSLayoutConstraint activateConstraints: self.commonConstraints];
    [NSLayoutConstraint activateConstraints: self.narrowConstraints];
    //[NSLayoutConstraint activateConstraints: self.narrowConstraints];
//    if (self.view.frame.size.width > self.view.frame.size.height) {
//        [NSLayoutConstraint activateConstraints: self.wideConstraints];
//    } else {
//        [NSLayoutConstraint activateConstraints: self.narrowConstraints];
//    }
    
}

//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//
//    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context)
//     {
//
//        NSLayoutConstraint *heightWide = [self.colorTableView.heightAnchor constraintEqualToConstant: self.view.frame.size.height];
//        heightWide.priority = UILayoutPriorityRequired;
//        //NSLayoutConstraint *bottomWide = [self.colorTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0];
//        //bottomWide.priority = UILayoutPriorityDefaultLow;
////        NSLayoutConstraint *topWide = [self.colorTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:30];
////        topWide.priority = UILayoutPriorityRequired;
////        NSLayoutConstraint *topNarr = [self.colorTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:123];
////        NSLayoutConstraint *widthNarr = [self.colorTableView.widthAnchor constraintEqualToConstant: (self.view.frame.size.width - 40)];
////        NSLayoutConstraint *hgtNarr = [self.colorTableView.heightAnchor constraintEqualToConstant: 572.0];
//
//       // hgtNarr.priority = UILayoutPriorityRequired;
//        //topNarr.priority = UILayoutPriorityRequired;
//        //bottomNarr.priority = UILayoutPriorityRequired;
//
//        if (self.view.frame.size.width > self.view.frame.size.height) {
//            //[NSLayoutConstraint deactivateConstraints: @[topNarr, widthNarr, hgtNarr]];
//            [NSLayoutConstraint activateConstraints: @[heightWide]];
//            //[NSLayoutConstraint activateConstraints: @[bottomWide]];
//            //[NSLayoutConstraint activateConstraints: @[topWide]];
//            //[self.colorTableView setNeedsUpdateConstraints];
//        } else if (self.view.frame.size.width < self.view.frame.size.height){
//
//            [NSLayoutConstraint deactivateConstraints: @[heightWide]];
//            //[NSLayoutConstraint deactivateConstraints: @[bottomWide]];
//            //[NSLayoutConstraint deactivateConstraints: @[topWide]];
//
//            [NSLayoutConstraint activateConstraints: @[[self.colorTableView.heightAnchor constraintEqualToConstant: 572.0]]];
//            [self.colorTableView setNeedsUpdateConstraints];
//        }
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context){}];
//
//
//}
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

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
//        cell.transform = transform;
//}

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
