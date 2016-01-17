//
//  LoginController.m
//  WildTo
//
//  Created by 千锋 on 16/1/16.
//  Copyright (c) 2016年 LSP. All rights reserved.
//
#import "Define.h"
#import "UMSocial.h"
#import "RegisterViewController.h"
#import "FogetPassWordViewController.h"
#import "SPTabBarController.h"
#import "LoginController.h"

@interface LoginController ()<UITextFieldDelegate>

@property(strong ,nonatomic) UIImageView *imageView;
//账号
@property(strong ,nonatomic) UITextField *accountNum;
//密码
@property(strong ,nonatomic) UITextField *password;

@property(strong ,nonatomic) UIButton *loginBtn;

@property(strong ,nonatomic) SPTabBarController *tabBar;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"登录";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(clickRegist)];
    self.navigationItem.rightBarButtonItem.tintColor =[UIColor blackColor];
    self.view.backgroundColor =[UIColor colorWithRed:215/255.0f green:215/255.0f blue:215/255.0f alpha:0.4];
    
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenW*0.4, ScreenH*0.1, 75, 53)];
    _imageView.center =CGPointMake(ScreenW*0.5, ScreenH*0.2);
    _imageView.image =[UIImage imageNamed:@"login_logo"];
    [self.view addSubview:_imageView];
    
    _tabBar =[[SPTabBarController alloc]init];
    
    //账号
    [self creatAccount];
    //密码
    [self creatPassword];
    //登录
    [self creatLoginBtn];
    //忘记密码
    [self fogetPassword];
    [self creatBottomView];
}

-(void)creatLoginBtn
{
    _loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame =CGRectMake(10, CGRectGetMaxY(_password.frame)+20, ScreenW-20, 40);
    _loginBtn.backgroundColor =[UIColor colorWithRed:76/255.0f green:162/255.0f blue:43/255.0f alpha:1];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateHighlighted];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.layer.cornerRadius= 10;
    [self.view addSubview:_loginBtn];

}

-(void)fogetPassword
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame =CGRectMake(ScreenW -100, CGRectGetMaxY(_loginBtn.frame)+30, 70, 20);
    [button setImage: [UIImage imageNamed:@"login_normal.9"] forState:UIControlStateSelected];
    [button setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickFogetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

//点击了忘记密码
-(void)clickFogetPassWord
{
    FogetPassWordViewController *foget =[[FogetPassWordViewController alloc]init];
    [self.navigationController pushViewController:foget animated:YES];

}

//点击了登录
-(void)clickLogin
{
    if(_accountNum.text.length!=11){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"手机号码必须是11位" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }else{
        if ([_password.text isEqualToString:@"654321"]) {
            
        [self presentViewController:_tabBar animated:NO completion:nil];
        }else{
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
        }
    
    }
    
    
    
    
    
}

-(void)creatAccount
{
    _accountNum =[[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageView.frame)+30, ScreenW-20, 40)];
    _accountNum.delegate =self;
    _accountNum.tag =101;
    _accountNum.placeholder =@" 手机号码";
    _accountNum.background =[UIImage imageNamed:@"txt_bac_login.9"];
    [self.view addSubview:_accountNum];
    

}

-(void)creatPassword
{
    _password =[[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_accountNum.frame)+20, ScreenW-20, 40)];
    _password.delegate =self;
    _password.placeholder =@" 密码";
    _password.secureTextEntry =YES;
    _password.background =[UIImage imageNamed:@"txt_bac_login.9"];
    [self.view addSubview:_password];
    
}

-(void)clickRegist
{
    RegisterViewController *regist =[[RegisterViewController alloc]init];

    [self.navigationController pushViewController:regist animated:YES];
//    [self presentViewController:nav animated:YES completion:nil];

}

-(void)creatBottomView
{
    UILabel *otherLogin =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 15)];
    otherLogin.center =CGPointMake(ScreenW*0.5, ScreenH*0.8);
    otherLogin.text =@"其他方式登录";
    otherLogin.textColor =[UIColor grayColor];
    otherLogin.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:otherLogin];
    
    UIButton *qqIcon =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    qqIcon.center =CGPointMake(ScreenW*0.5, CGRectGetMaxY(otherLogin.frame)+45);
    [qqIcon setImage:[UIImage imageNamed:@"login_tencent_unpress"] forState:UIControlStateNormal];
    [qqIcon addTarget:self action:@selector(clickQQLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqIcon];
    
    UILabel *qqLabel =[[UILabel alloc]initWithFrame:CGRectMake(qqIcon.frame.origin.x, CGRectGetMaxY(qqIcon.frame)+5, qqIcon.frame.size.width, 15)];
    qqLabel.font =[UIFont systemFontOfSize:12];
    qqLabel.text =@"QQ登录";
    [self.view addSubview:qqLabel];
    
    UIButton *weixinIcon =[UIButton buttonWithType:UIButtonTypeCustom];
    weixinIcon.frame =CGRectMake(0, 0, 50, 50);
    weixinIcon.center =CGPointMake(ScreenW*0.2, qqIcon.center.y);
    [weixinIcon setImage:[UIImage imageNamed:@"login_wechat_unpress"] forState:UIControlStateNormal];
    [weixinIcon addTarget:self action:@selector(clickWeiXinLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixinIcon];
    
    UILabel *weixinLabel =[[UILabel alloc]initWithFrame:CGRectMake(weixinIcon.frame.origin.x, CGRectGetMaxY(weixinIcon.frame)+5, weixinIcon.frame.size.width, 15)];
    weixinLabel.font =[UIFont systemFontOfSize:12];
    weixinLabel.text =@"微信登录";
    [self.view addSubview:weixinLabel];
    
    UIButton *weiboIcon =[UIButton buttonWithType:UIButtonTypeCustom];
    weiboIcon.frame =CGRectMake(0, 0, 50, 50);
    weiboIcon.center =CGPointMake(ScreenW*0.8, qqIcon.centerY);
    [weiboIcon setImage:[UIImage imageNamed:@"login_weibo_unpress"] forState:UIControlStateNormal];
    [weiboIcon addTarget:self action:@selector(clickWeiBoLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiboIcon];
    
    UILabel *weiboLabel =[[UILabel alloc]initWithFrame:CGRectMake(weiboIcon.frame.origin.x, CGRectGetMaxY(weiboIcon.frame)+5, weiboIcon.frame.size.width, 15)];
    weiboLabel.font =[UIFont systemFontOfSize:12];
    weiboLabel.text =@"微博登录";
    [self.view addSubview:weiboLabel];
    

}

//点击了微博登录
-(void)clickWeiBoLogin
{
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"569a2f9e67e58e2d22001770"shareText:@"微博分享"shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil] delegate:nil];
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            [self presentViewController:_tabBar animated:NO completion:nil];

            
        }});
    //在授权完成后调用获取用户信息
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
        
        
    }];

}

//点击了qq登录
-(void)clickQQLogin
{
    
}
//点击了微信登录
-(void)clickWeiXinLogin
{
    

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_accountNum resignFirstResponder];
    [_password resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag ==101) {
        return [self validateNumber:string];
    }else{
        return YES;
    }
    
}

-(BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
