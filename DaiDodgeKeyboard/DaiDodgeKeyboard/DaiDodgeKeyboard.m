//
//  DaiDodgeKeyboard.m
//  DaiDodgeKeyboard
//
//  Created by 啟倫 陳 on 2014/4/25.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "DaiDodgeKeyboard.h"

#import "UIView+FirstResponderNotify.h"
#import "DaiDodgeKeyboard+AccessObject.h"
#import "DaiDodgeKeyboard+Animation.h"

@interface DaiDodgeKeyboard ()

+ (void)keyboardWillShow:(NSNotification *)notification;
+ (void)keyboardWillHide:(NSNotification *)notification;
+ (void)addObservers;
+ (void)removeObservers;

@end

@implementation DaiDodgeKeyboard

#pragma mark - private

+ (void)keyboardWillShow:(NSNotification *)notification
{
    [self objects].isKeyboardShow = YES;
	NSDictionary *userInfo = [notification userInfo];
    [self objects].keyboardAnimationDutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self objects].keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	[self dodgeKeyboardAnimation];
}

+ (void)keyboardWillHide:(NSNotification *)notification
{
    [self objects].isKeyboardShow = NO;
	[self dodgeKeyboardAnimation];
}

+ (void)addObservers
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

+ (void)removeObservers
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - class method

+ (void)addRegisterTheViewNeedDodgeKeyboard:(UIView *)view
{
    [self objects].observerView = view;
    [self objects].originalViewFrame = view.frame;
    [self objects].isKeyboardShow = NO;
	[self addObservers];
}

+ (void)removeRegisterTheViewNeedDodgeKeyboard
{
	objc_removeAssociatedObjects(self);    
	[self removeObservers];
}

@end
