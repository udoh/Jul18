//
//  View.m
//  Jul18
//
//  Created by Udo Hoppenworth on 7/18/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "View.h"

@implementation View


- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
    
	if (self) {
        [self setup];
	}
	return self;
}

- (void)awakeFromNib
{
    [self setup];
}


- (void)setup
{
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    
    // initialize buttons and switch
    self.buttonOne = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.mySwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
    
    // setup gepmetry
    CGSize s = CGSizeMake(120, 44);
    CGRect b = self.bounds;
    
    CGRect buttonOneFrame = CGRectMake(
                                       b.origin.x + (b.size.width - s.width) / 2,
                                       b.origin.y + (b.size.height - s.height) / 2 - b.size.height / 5,
                                       s.width,
                                       s.height
                                       );
    
    CGRect buttonTwoFrame = CGRectMake(
                                       b.origin.x + (b.size.width - s.width) / 2,
                                       b.origin.y + (b.size.height - s.height) / 2,
                                       s.width,
                                       s.height
                                       );
    
    CGPoint switchCenter = CGPointMake(b.origin.x + b.size.width / 2, b.origin.y + b.size.height / 2 + b.size.height / 5);
    
    
    self.buttonOne.frame = buttonOneFrame;
    [self.buttonOne setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
    [self.buttonOne setTitle: @"Play Video" forState: UIControlStateNormal];
    
    self.buttonTwo.frame = buttonTwoFrame;
    [self.buttonTwo setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
    [self.buttonTwo setTitle: @"Play Sound" forState: UIControlStateNormal];
    
    self.mySwitch.center = switchCenter;
    self.mySwitch.on = NO;
    
    
    // setup target-action
    [self.buttonOne addTarget: [UIApplication sharedApplication].delegate
                       action: @selector(playMovie:)
             forControlEvents: UIControlEventTouchUpInside];
    
    [self.buttonTwo addTarget: [UIApplication sharedApplication].delegate
                       action: @selector(playSound:)
             forControlEvents: UIControlEventTouchUpInside
     ];
    
    [self.mySwitch addTarget: [UIApplication sharedApplication].delegate
                      action: @selector(valueChanged:)
            forControlEvents: UIControlEventValueChanged
     ];
    
    
    // add buttons and switch to view
    [self addSubview: self.buttonOne];
    [self addSubview: self.buttonTwo];
    [self addSubview: self.mySwitch];
}


@end
