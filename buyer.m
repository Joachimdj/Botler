//
//  buyer.m
//  MobilePaySwift2
//
//  Created by Joachim Dittman on 31/08/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//
#import "MobilePayManager.h"
#import "buyer.h"

@interface buyer ()
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) UIAlertView *errorInOrderAlertView;

@end

@implementation buyer

 


- (void)buy:(NSString * )orderIdFrom:(NSString * )reciptMessageFrom:(NSString *)priceFrom{
 NSLog(@"Buy");
    double price = [priceFrom doubleValue];
    NSString * orderId = orderIdFrom;
    NSString * reciptMessage = reciptMessageFrom;
    
    if ((reciptMessage.length > 0) && (orderId.length > 0)) {
        [[MobilePayManager sharedInstance] beginMobilePaymentWithOrderId:orderId productPrice:price receiptMessage:reciptMessage error:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                            message:[NSString stringWithFormat:@"reason: %@, suggestion: %@",error.localizedFailureReason, error.localizedRecoverySuggestion]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Install MobilePay",nil];
            [alert show];
        }];
    }else{
        self.errorInOrderAlertView = [[UIAlertView alloc] initWithTitle:@"Error in your order"
                                                                message:@"One or more parameters in your order is invalid"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok",nil];
         
    }
    

}

-(void)alertView:(UIAlertView *)alertView
{
     NSLog(@"BuyVindue");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[MobilePayManager sharedInstance].mobilePayAppStoreLinkDK]];
    
}
@end



