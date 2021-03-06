//
//  VZMistTemplate.m
//  MIST
//
//  Created by moxin on 2016/12/6.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZMistTemplate.h"
#import "VZDataStructure.h"
#import "VZMistTemplateHelper.h"
#import "VZMistTemplateController.h"
#import "VZMist.h"
#import "VZMistError.h"
#import "VZScriptManager.h"

@implementation VZMistTemplate

- (instancetype)initWithTemplateId:(NSString *)tplId content:(NSDictionary *)content
{
    if (self = [super init]) {
        if (![content isKindOfClass:[NSDictionary class]]) {
            NSAssert(content, @"%@: a template with empty content %@", self.class, content);
            VZMistError *error = [VZMistError templateEmptyErrorWithTemplateId:tplId];
            [VZMist sharedInstance].errorCallback(error);
            return nil;
        }
        NSDictionary *layout = __vzDictionary(content[@"layout"], nil);
        if (!layout) {
            NSAssert(layout, @"%@: a template with empty content %@", self.class, content);
            VZMistError *error = [VZMistError templateEmptyErrorWithTemplateId:tplId];
            [VZMist sharedInstance].errorCallback(error);
            return nil;
        }

        _tplId = tplId;
        _tplRawContent = content;
        _tplParsedResult = [VZMistTemplateHelper parseExpressionsInTemplate:layout];
        
        NSString *str = content[@"script"];
        if (str.length) {
            [[VZScriptManager manager] runScript:str];
        }
        
        _tplControllerClass = NSClassFromString(content[@"controller"]);
        NSAssert(!_tplControllerClass || [_tplControllerClass isSubclassOfClass:[VZMistTemplateController class]], @"controller must be inherited from VZMistTemplateController");
        if (![_tplControllerClass isSubclassOfClass:[VZMistTemplateController class]]) {
            _tplControllerClass = nil;
        }
        _initialState = [VZMistTemplateHelper parseExpressionsInTemplate:content[@"state"]];
        _tplReuseIdentifier = content[@"reuse-identifier"];
        _identifier = content[@"identifier"];
        _styles = __vzDictionary([VZMistTemplateHelper parseExpressionsInTemplate:content[@"styles"]], nil);
        //_asyncDisplay = __vzBool(content[@"async-display"], NO);
    }
    return self;
}


@end
