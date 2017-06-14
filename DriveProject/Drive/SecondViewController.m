//
//  SecondViewController.m
//  Drive
//
//  Created by BlackApple on 2017/6/13.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
#import "Screen.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SecondViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* _tableView;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen.width, 264) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"SecondTableViewCell";
    SecondTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        //设置圆角
        cell.myLabel.layer.masksToBounds = YES;
        cell.myLabel.layer.cornerRadius = 8;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.myImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", 331+(int)indexPath.row]];
    cell.myLabel.text = [NSString stringWithFormat:@"视频%d", (int)indexPath.row];
    return cell;
}
//单元格点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* path = [[NSBundle mainBundle]pathForResource:@"a" ofType:@"mp4"];
    NSURL* url = [NSURL fileURLWithPath:path];
    /*
    MPMoviePlayerViewController* mpc = [[MPMoviePlayerController alloc]initWithContentURL:url];
    //mpc.moviePlayer.shouldAutoplay = YES;
    [self.navigationController pushViewController:mpc animated:YES];
    */
    //视频播放
    AVPlayerViewController *player = [[AVPlayerViewController alloc]init];
    player.player = [[AVPlayer alloc]initWithURL:url];
    [self presentViewController:player animated:YES completion:nil];
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
