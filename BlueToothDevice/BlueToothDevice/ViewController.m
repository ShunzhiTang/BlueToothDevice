//
//  ViewController.m
//  BlueToothDevice
//
//  Created by Tsz on 15/11/13.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>

@interface ViewController ()<UIImagePickerControllerDelegate , UINavigationControllerDelegate , GKPeerPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)connectDevice:(UIButton *)sender;

- (IBAction)choicePciture:(UIButton *)sender;

- (IBAction)sendPicture:(UIButton *)sender;


//全局实例
@property (nonatomic ,strong)GKSession *session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/**
 * 连接设备
 *
 * @param sender: 按钮的参数
 */
- (IBAction)connectDevice:(UIButton *)sender {
    
    //1、创建控制器
    GKPeerPickerController *picker = [GKPeerPickerController new];
    
    //代理
    picker.delegate = self;
    
    //3、显示
    [picker show];
}

/**
 当连接到蓝牙设备
 节点
 会话(发送和接受)
 */
#pragma  mark: 实现peer的 代理
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    
    //1、保留会话
    self.session = session;
    
    //2、设置句柄
    [self.session setDataReceiveHandler:self withContext:nil];
    
    //3、picker 消失
    [picker dismiss];
}




- (IBAction)choicePciture:(UIButton *)sender {
    
    //1、判断是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    //2、创建 图片控制期
    UIImagePickerController *pickVc = [UIImagePickerController new];
    
    //3、设置 图片的源
    pickVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //4、设置代理
    pickVc.delegate = self;
    
    //5、显示 控制器
    [self presentViewController:pickVc animated:YES completion:nil];
}

//执行协议显示图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sendPicture:(UIButton *)sender {
}
@end
