//
//  ViewController.h
//  test
//
//  Created by ligang on 2018/2/7.
//  Copyright © 2018年 LG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (NSDictionary *)FindFirstCommonParentNode:(NSDictionary *)root
								   addFirst:(NSDictionary *)first
								  andSecond:(NSDictionary *)second;

@end

