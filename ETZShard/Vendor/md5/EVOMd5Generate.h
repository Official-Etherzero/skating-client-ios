//
//  EVOMd5Generate.h
//  EVOClientForiOS
//

#import <Foundation/Foundation.h>

@interface EVOMd5Generate : NSObject

+ (NSString *)genMd5WithDictionary:(NSDictionary *)dictionary;

+ (NSString *)genMd5:(NSString *)string;

+ (NSString *)getFileMd5:(NSString *)path start:(NSInteger)start end:(NSInteger)end;

+ (NSString *)getFileMd5ForPath:(NSString *)path;
@end
