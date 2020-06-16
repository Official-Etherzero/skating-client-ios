#import "UIColor+Ext.h"
@implementation UIColor (Ext)
+ (UIColor *)yy_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
    return [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1.0];
}

+ (UIColor *)yy_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a {
    return [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:a];
}

+ (UIColor *)yy_colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
        alpha = 1.0f;
        red   = [self colorComponentFrom:colorString start:0 length:1];
        green = [self colorComponentFrom:colorString start:1 length:1];
        blue  = [self colorComponentFrom:colorString start:2 length:1];
        break;
        case 4: // #ARGB
        alpha = [self colorComponentFrom:colorString start:0 length:1];
        red   = [self colorComponentFrom:colorString start:1 length:1];
        green = [self colorComponentFrom:colorString start:2 length:1];
        blue  = [self colorComponentFrom:colorString start:3 length:1];
        break;
        case 6: // #RRGGBB
        alpha = 1.0f;
        red   = [self colorComponentFrom:colorString start:0 length:2];
        green = [self colorComponentFrom:colorString start:2 length:2];
        blue  = [self colorComponentFrom:colorString start:4 length:2];
        break;
        case 8: // #AARRGGBB
        alpha = [self colorComponentFrom:colorString start:0 length:2];
        red   = [self colorComponentFrom:colorString start:2 length:2];
        green = [self colorComponentFrom:colorString start:4 length:2];
        blue  = [self colorComponentFrom:colorString start:6 length:2];
        break;
        default:
        [NSException raise:@"Invalid color value" format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
        break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)yy_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
        red   = [self colorComponentFrom:colorString start:0 length:1];
        green = [self colorComponentFrom:colorString start:1 length:1];
        blue  = [self colorComponentFrom:colorString start:2 length:1];
        break;
        case 4: // #ARGB
        red   = [self colorComponentFrom:colorString start:1 length:1];
        green = [self colorComponentFrom:colorString start:2 length:1];
        blue  = [self colorComponentFrom:colorString start:3 length:1];
        break;
        case 6: // #RRGGBB
        red   = [self colorComponentFrom:colorString start:0 length:2];
        green = [self colorComponentFrom:colorString start:2 length:2];
        blue  = [self colorComponentFrom:colorString start:4 length:2];
        break;
        case 8: // #AARRGGBB
        red   = [self colorComponentFrom:colorString start:2 length:2];
        green = [self colorComponentFrom:colorString start:4 length:2];
        blue  = [self colorComponentFrom:colorString start:6 length:2];
        break;
        default:
        [NSException raise:@"Invalid color value" format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
        break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

+ (instancetype)yy_colorGradientChangeWithSize:(CGSize)size
                                          type:(YYGradientDirectionType)type
                                    startColor:(UIColor*)startcolor
                                      endColor:(UIColor*)endColor {
    if (CGSizeEqualToSize(size,CGSizeZero)
        || !startcolor
        || !endColor) {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0,0, size.width, size.height);
    CGPoint startPoint = CGPointZero;
    if (type == YYGradientDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0,1.0);
    }
    gradientLayer.startPoint = startPoint;
    CGPoint endPoint = CGPointZero;
    switch (type) {
        case YYGradientDirectionLevel:{
            endPoint =CGPointMake(1.0,0.0);
        }
        break;
        case YYGradientDirectionVertical:{
            endPoint =CGPointMake(0.0,1.0);
        }
        break;
        case YYGradientDirectionUpwardDiagonalLine:{
            endPoint =CGPointMake(1.0,1.0);
        }
        break;
        case YYGradientDirectionDownDiagonalLine:{
            endPoint =CGPointMake(1.0,0.0);
        }
        break;
        
        default:
        break;
    }
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}


@end
