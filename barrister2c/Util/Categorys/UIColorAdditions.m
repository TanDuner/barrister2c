//
//  UIColorAdditions.m
//  Weibo
//
//  Created by junmin liu on 10-9-30.
//  Copyright 2010 Openlab. All rights reserved.
//
#define DEFAULT_VOID_COLOR ([UIColor blackColor])
#import "UIColorAdditions.h"



///////////////////////////////////////////////////////////////////////////////////////////////////
// Color algorithms from http://www.cs.rit.edu/~ncs/color/t_convert.html

#define MAX3(a,b,c) (a > b ? (a > c ? a : c) : (b > c ? b : c))
#define MIN3(a,b,c) (a < b ? (a < c ? a : c) : (b < c ? b : c))


///////////////////////////////////////////////////////////////////////////////////////////////////
static void RGBtoHSV(float r, float g, float b, float* h, float* s, float* v) {
	float min, max, delta;
	min = MIN3(r, g, b);
	max = MAX3(r, g, b);
	*v = max;        // v
	delta = max - min;
	if( max != 0 )
		*s = delta / max;    // s
	else {
		// r = g = b = 0    // s = 0, v is undefined
		*s = 0;
		*h = -1;
		return;
	}
	if( r == max )
		*h = ( g - b ) / delta;    // between yellow & magenta
	else if( g == max )
		*h = 2 + ( b - r ) / delta;  // between cyan & yellow
	else
		*h = 4 + ( r - g ) / delta;  // between magenta & cyan
	*h *= 60;        // degrees
	if( *h < 0 )
		*h += 360;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
static void HSVtoRGB( float *r, float *g, float *b, float h, float s, float v ) {
	int i;
	float f, p, q, t;
	if( s == 0 ) {
		// achromatic (grey)
		*r = *g = *b = v;
		return;
	}
	h /= 60;      // sector 0 to 5
	i = floor( h );
	f = h - i;      // factorial part of h
	p = v * ( 1 - s );
	q = v * ( 1 - s * f );
	t = v * ( 1 - s * ( 1 - f ) );
	switch( i ) {
		case 0:
			*r = v;
			*g = t;
			*b = p;
			break;
		case 1:
			*r = q;
			*g = v;
			*b = p;
			break;
		case 2:
			*r = p;
			*g = v;
			*b = t;
			break;
		case 3:
			*r = p;
			*g = q;
			*b = v;
			break;
		case 4:
			*r = t;
			*g = p;
			*b = v;
			break;
		default:    // case 5:
			*r = v;
			*g = p;
			*b = q;
			break;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Additions.
 */
@implementation UIColor (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor*)colorWithHue:(CGFloat)h saturation:(CGFloat)s value:(CGFloat)v alpha:(CGFloat)a {
	CGFloat r, g, b;
	HSVtoRGB(&r, &g, &b, h, s, v);
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)multiplyHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	CGFloat a = rgba[3];
	
	CGFloat h, s, v;
	RGBtoHSV(r, g, b, &h, &s, &v);
	
	h *= hd;
	v *= vd;
	s *= sd;
	
	HSVtoRGB(&r, &g, &b, h, s, v);
	
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)copyWithAlpha:(CGFloat)newAlpha {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	
	return [UIColor colorWithRed:r green:g blue:b alpha:newAlpha];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)addHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	CGFloat a = rgba[3];
	
	CGFloat h, s, v;
	RGBtoHSV(r, g, b, &h, &s, &v);
	
	h += hd;
	v += vd;
	s += sd;
	
	HSVtoRGB(&r, &g, &b, h, s, v);
	
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)highlight {
	return [self multiplyHue:1 saturation:0.4 value:1.2];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)shadow {
	return [self multiplyHue:1 saturation:0.6 value:0.6];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hue {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat h, s, v;
	RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
	return h;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)saturation {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat h, s, v;
	RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
	return s;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)value {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat h, s, v;
	RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
	return v;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return DEFAULT_VOID_COLOR;
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
	if ([cString length] != 6) return DEFAULT_VOID_COLOR;
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}

+ (UIColor *)colorWithString:(NSString *)colorValue colorAlpha:(float)alpha{
    
    UIColor *color = [UIColor clearColor];
    
    if ([[colorValue substringToIndex:1] isEqualToString:@"#"]) {
        
        if ([colorValue length]==7) {
            NSRange range = NSMakeRange(1,2);
            NSString *strRed = [colorValue substringWithRange:range];
            
            range.location = 3;
            NSString *strGreen = [colorValue substringWithRange:range];
            
            range.location = 5;
            NSString *strBlue = [colorValue substringWithRange:range];
            
            
            float r = [XuUtlity getIntegerFromString:strRed];
            float g = [XuUtlity getIntegerFromString:strGreen];
            float b = [XuUtlity getIntegerFromString:strBlue];
            
            color = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:alpha];
        }
    }
    return color;
}
@end

