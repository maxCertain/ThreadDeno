//
//  ViewController.m
//  ThreadDeno
//
//  Created by liicon on 2017/6/16.
//  Copyright © 2017年 max. All rights reserved.
////线程间通信，线程间数据共享

#import "ViewController.h"
#import "ImageCell.h"
#import "UIImageView+maxWebCache.h"
#import "UIImageView+WebCache.h"
#import "PthreadTools.h"
#import "AutoSizeCell.h"

#define kScreen_width  [UIScreen mainScreen].bounds.size.width;
#define kScreen_height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSString *sStr;
@property(nonatomic, copy) NSString *cStr;
@property(nonatomic, retain) NSString *rStr;

@property(nonatomic, strong) NSArray *sArray;
@property(nonatomic, copy) NSArray *cArray;
@property(nonatomic, strong) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, copy) NSMutableArray *heightOfindexs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    
    PthreadTools *tool = [[PthreadTools alloc] init];
    [self maintUI];
    
    NSArray *array = @[@"fasdfafa- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{",@"dafafda",@"//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{",@"numberOfRowsInSection:(NSInteger)",@"最后再说说iOS7下UILabel的一个坑，如果要使你的UILabel能够正常的多行显示，除了一开始说到的设置numberOfLines为0，还需要设置preferredMaxLayoutWidth，这个属性指的当换行的最大宽度。iOS8＋能够通过AutoLayout计算出UILabel的宽度，把这个宽度作为preferredMaxLayoutWidth，但是iOS7下面不行，应该是一个bug。解决的方案是继承UILabel，重写layoutSubviews。"];
    NSMutableArray *mut = [array mutableCopy];
    [mut addObjectsFromArray:array];
    [mut addObjectsFromArray:array];
    [mut addObjectsFromArray:array];
    self.datas = mut;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.datas.count;
    }else{
      return self.dataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }else{
        return 200;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AutoSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
        cell.taskdescribe.text = [self.datas objectAtIndex:indexPath.row];
        [cell.contentView setAutoresizesSubviews:YES];
        return cell;
    }else{
        ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        NSString *urlStr = [_dataSource objectAtIndex:indexPath.row];
    //    NSURL *url = [NSURL URLWithString:urlStr];
    //    [cell.customImageView sd_setImageWithURL:url];

        [cell.customImageView max_imageWithUrl:urlStr];
        
        return cell;
    }
}


- (void)maintUI{
    UINib *nib = [UINib nibWithNibName:@"ImageCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    UINib *nib2 = [UINib nibWithNibName:@"AutoSizeCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"cell2"];
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.title = @"图片";
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848541&di=03e0d7999f0244898353daaba956daa9&imgtype=0&src=http%3A%2F%2Fstaticfile.tujia.com%2Fupload%2Finfo%2Fday_130820%2F201308201234512187.jpg",
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848859&di=0dee93906245ecd2f8746e7fbb93414e&imgtype=0&src=http%3A%2F%2Fwww.cits01.cn%2Fscenery%2FUploadFiles_1440%2F201104%2F2011041102283730.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848859&di=0b68393787a811c458c26999ecef6f5c&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2F100f050000000eyyn49D9.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848859&di=9feac15c37aac519c1a3e223802682f3&imgtype=0&src=http%3A%2F%2Fm.tuniucdn.com%2Ffb2%2Ft1%2FG1%2FM00%2FBB%2F9C%2FCii9EVabtLaIby1JAAQXPiDuaksAABgfgJouMUABBdW634_w500_h280_c1_t0.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848858&di=2f5a740903a5f29d44aaaec8bd6ee0c8&imgtype=0&src=http%3A%2F%2Fpw.dreams-travel.com%2Fbbs%2Ftravel-pic%2Ffpimages%2F2012-10%2F2012102615748.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848858&di=bcf8bc680c51cc43f446a28be39598ea&imgtype=0&src=http%3A%2F%2Fwww.visithaidian.com%2Fuploadfile%2F2014%2F0317%2F20140317033851561.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848858&di=4ac843ad3605c7469b861e2c7ffff2df&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2F1003050000000kudm9058.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497607848857&di=9995b3762babe6196e5f51e5575f86e6&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F533%2F553%2F224%2F65e4ae46b4f54ccb9f548410d7bd035f.jpg"];
        NSMutableArray *mut = [array mutableCopy];
        [mut addObjectsFromArray:array];
        [mut addObjectsFromArray:array];
        [mut addObjectsFromArray:array];
        _dataSource = mut;
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
