//
//  SettingRowModel.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/16.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SettingRowType) {
    SettingRowTypeNone,
    SettingRowTypeArrow,
    SettingRowTypeDesc,
    SettingRowTypeDescArrow,
    SettingRowTypeCustome,
    SettingRowTypeCheckbox,
};

@interface SettingRowModel : NSObject

@property(nonatomic,   copy) NSString          *title;
@property(nonatomic,   copy) NSString          *imageName;
@property(nonatomic, assign) SettingRowType  rowType;
@property(nonatomic,   copy) NSString          *desc;
@property(nonatomic, assign) BOOL              selected;
@property(nonatomic, assign) BOOL              isNeedUpgrade;
@property(nonatomic, assign, getter=isEnable)  BOOL enable;
@property(nonatomic, assign, getter=isVisible) BOOL visible;

@property(nonatomic, strong) NSNumber *value;


+ (instancetype)modelWithRowType:(SettingRowType)rowType;

+ (instancetype)modelWithTitle:(NSString *)title
                       rowType:(SettingRowType)rowType;

+ (instancetype)modelWithImageName:(NSString *)imageName
                             title:(NSString *)title
                           rowType:(SettingRowType)rowType;

+ (instancetype)modelWithImageName:(NSString *)imageName
                             title:(NSString *)title
                              desc:(NSString *)desc
                           rowType:(SettingRowType)rowType;

+ (instancetype)modelWithTitle:(NSString *)title
                       rowType:(SettingRowType)rowType
                       visible:(BOOL)visible;

+ (instancetype)modelWithTitle:(NSString *)title
                          desc:(NSString *)desc
                       rowType:(SettingRowType)rowType;

+ (instancetype)modelWithTitle:(NSString *)title
                         value:(NSNumber *)value
                       rowType:(SettingRowType)rowType;

@end

NS_ASSUME_NONNULL_END
