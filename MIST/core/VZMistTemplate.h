//
//  VZMistTemplate.h
//  MIST
//
//  Created by moxin on 2016/12/6.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VZMistTemplate : NSObject


/**
 模板Id
 */
@property (nonatomic, strong, readonly) NSString *tplId;
/**
 模板的内部标识，一般用于native代码识别模板的标识，从而能够跟模板Id隔离。
 */
@property (nonatomic, strong, readonly) NSString *identifier;
/**
 模板原始内容
 */
@property (nonatomic, strong, readonly) NSDictionary *tplRawContent;
/**
 模板解析后的结果
 */
@property (nonatomic, strong, readonly) NSDictionary *tplParsedResult;
/**
 initial state
 理解state参考Reacthttps://facebook.github.io/react-native/docs/state.html
 */
@property (nonatomic, strong, readonly) NSDictionary *initialState;
/**
 模板对应的controller类
 */
@property (nonatomic, strong, readonly) Class tplControllerClass;
/**
 模板复用的表示
 */
@property (nonatomic, strong, readonly) NSString *tplReuseIdentifier;
/**
 样式表
 */
@property (nonatomic, strong, readonly) NSDictionary *styles;
/**
 模板显示是否需要光栅化
 @discussion：todo
 */
//@property (nonatomic, assign, readonly) BOOL asyncDisplay;


/**
 创建Template实体

 @param tplId 模板Id
 @param content 模板原始数据
 @return 模板对象
 */
- (instancetype)initWithTemplateId:(NSString *)tplId content:(NSDictionary *)content;

@end
