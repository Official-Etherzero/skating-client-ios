//
//  EVOMd5Generate.m
//  EVOClientForiOS
//

#import "EVOMd5Generate.h"

#import "md5.h"
#import "NSDictionary+Ext.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFURLRequestSerialization.h"

@implementation EVOMd5Generate


+ (NSString *)genMd5WithDictionary:(NSDictionary *)dictionary {
    NSArray *keyArray = [dictionary yy_sortedKeys];
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *key in keyArray) {
        if (string.length > 0) {
            [string appendString:@"&"];
        }
        [string appendFormat:@"%@=%@", key, AFPercentEscapedStringFromString(dictionary[key])];
    }
    NSString *targetString = string.copy;
    return [EVOMd5Generate genMd5:targetString];
}

+ (NSString *)genMd5:(NSString *)string {
    std::string srcStr = std::string([string UTF8String]);
//    srcStr.append("bdgfTER546");
    std::string md5Hash = md5(srcStr);

    return [NSString stringWithCString:md5Hash.c_str()
                              encoding:[NSString defaultCStringEncoding]];
}

+ (NSString *)getFileMd5:(NSString *)path start:(NSInteger)start end:(NSInteger)end {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    [handle seekToFileOffset:start];
    if (handle == nil) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    NSInteger total = end - start;
    NSInteger perPartLenght = 256;
    while (!done) {
        total -= perPartLenght;
        if (total < 0) {
            perPartLenght += total;
        }
        NSData *fileData = [handle readDataOfLength:perPartLenght];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG) [fileData length]);
        if ([fileData length] == 0) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *s = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                             digest[0], digest[1],
                                             digest[2], digest[3],
                                             digest[4], digest[5],
                                             digest[6], digest[7],
                                             digest[8], digest[9],
                                             digest[10], digest[11],
                                             digest[12], digest[13],
                                             digest[14], digest[15]];

    return s;
}

+ (NSString *)getFileMd5ForPath:(NSString *)path {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ){
        // file didnt exist
        return @"ERROR GETTING FILE MD5";
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    NSInteger perPartLenght = 8 * 1024;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength:perPartLenght];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

@end
