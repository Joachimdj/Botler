//
//  buyer.h
//  MobilePaySwift2
//
//  Created by Joachim Dittman on 31/08/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface buyer : UIViewController
 
- (void)buy:(NSString * )orderIdFrom:(NSString * )reciptMessageFrom:(NSString *)priceFrom;
@end
