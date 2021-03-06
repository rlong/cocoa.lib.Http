//
//  HLFileSorters.m
//  remote_gateway
//
//  Created by Richard Long on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "CABaseException.h"
#import "CALog.h"
#import "CANumericUtilities.h"

#import "HLFileSorters.h"




// vvv scraped from XPFileUtilities
// vvv scraped from XPFileUtilities
// vvv scraped from XPFileUtilities

@interface HLFileUtilities : NSObject

// is case-sensitive: 'A' and 'a' are different
+(NSInteger)compare:(NSString*)filename1 with:(NSString*)filename2;

@end

@implementation HLFileUtilities



static NSCharacterSet* _dotCharacterSet = nil;

+(void)initialize {
	
    _dotCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"."];
	
}



+(NSRange)getLastNumerics:(NSString*)filename {
    
    NSRange answer;
    
    answer.length = 0;
    answer.location = NSNotFound;
    
    NSRange lastDot = [filename rangeOfCharacterFromSet:_dotCharacterSet options:NSBackwardsSearch];
    
    // no file extension ?
    if( NSNotFound == lastDot.location ) {
        lastDot.location = [filename length]-1;
        lastDot.length = 1;
    }
    
    NSInteger lastDigit = -1;
    
    for( NSInteger i = lastDot.location; i >= 0; i-- ) {
        unichar currentCharacter = [filename characterAtIndex:i];
        if( currentCharacter <= '9' && currentCharacter >= '0' ) {
            lastDigit = i;
            break;
        }
    }
    
    if( -1 == lastDigit ) {
        return answer;
    }
    NSInteger firstDigit = lastDigit;
    
    for( NSInteger i = lastDigit; i >= 0; i-- ) {
        
        unichar currentCharacter = [filename characterAtIndex:i];
        if( currentCharacter > '9' || currentCharacter < '0' ) {
            break;
        }
        firstDigit = i;
    }
    
    answer.location = firstDigit;
    answer.length = ( lastDigit - firstDigit ) + 1;
    
    return answer;
    
}


// on returning nil or throwing an exception, use the standard compare function
+(NSNumber*)tryCompare:(NSString*)filename1 with:(NSString*)filename2 {
    
    
    NSRange lastNumerics1 = [self getLastNumerics:filename1];
    if( NSNotFound == lastNumerics1.location ) {
        return nil;
    }
    
    NSRange lastNumerics2 = [self getLastNumerics:filename2];
    if( NSNotFound == lastNumerics2.location ) {
        return nil;
    }
    
    
    
    NSString* filename1Prefix = [filename1 substringToIndex:lastNumerics1.location];
    //    Log_debugString( filename1Prefix );
    
    NSString* filename2Prefix = [filename2 substringToIndex:lastNumerics2.location];
    //    Log_debugString( filename2Prefix );
    
    // different prefixes ?
    NSInteger prefixComparison = [filename1Prefix compare:filename2Prefix];
    if( 0 != prefixComparison ) {
        return [NSNumber numberWithInteger:prefixComparison];
    }
    
    NSString* filename1NumericSuffix = [filename1 substringWithRange:lastNumerics1];
    //    Log_debugString( filename1NumericSuffix );
    long filename1Numeric = [CANumericUtilities parseLong:filename1NumericSuffix];
    
    NSString* filename2NumericSuffix = [filename2 substringWithRange:lastNumerics2];
    //    Log_debugString( filename2NumericSuffix );
    long filename2Numeric = [CANumericUtilities parseLong:filename2NumericSuffix];
    
    
    return [NSNumber numberWithLong:filename1Numeric - filename2Numeric];
    
}


// is case-sensitive: 'A' and 'a' are different
+(NSInteger)compare:(NSString*)filename1 with:(NSString*)filename2 {
    
    
    @try { // CANumericUtilities might throw an exception
        
        NSNumber* comparison = [self tryCompare:filename1 with:filename2];
        if( nil != comparison ) {
            return [comparison integerValue];
        }
    }
    @catch (CABaseException *exception) {
        Log_warnException(exception);
    }
    
    return [filename1 compare:filename2];
    
}


@end



// ^^^ scraped from XPFileUtilities
// ^^^ scraped from XPFileUtilities
// ^^^ scraped from XPFileUtilities



NSInteger HLFileSorters_sortByAgeAscending( CAFile* f1, CAFile* f2, void *context) {
    
    NSDate* date1 = [f1 getModificationDate];
    NSDate* date2 = [f2 getModificationDate];
    
    return [date1 compare:date2];
    
}

NSInteger HLFileSorters_sortByAgeDescending( CAFile* f1, CAFile* f2, void *context) {
    
    NSDate* date1 = [f1 getModificationDate];
    NSDate* date2 = [f2 getModificationDate];
    
    return [date2 compare:date1];
    
}


NSInteger HLFileSorters_sortByNameAscending( CAFile* f1, CAFile* f2, void *context){
    
    
    NSString* name1 = [f1 getName];
    NSString* name2 = [f2 getName];
    
    return [HLFileUtilities compare:name1 with:name2];
}


NSInteger HLFileSorters_sortByNameDescending( CAFile* f1, CAFile* f2, void *context){
    
    
    NSString* name1 = [f1 getName];
    NSString* name2 = [f2 getName];
    
    return [HLFileUtilities compare:name2 with:name1];
    
}


NSInteger HLFileSorters_sortBySizeAscending( CAFile* f1, CAFile* f2, void *context){
    
//    NSNumber* size1 = [f1 getSize];
//    NSNumber* size2 = [f2 getSize];
//
//    return [size1 compare:size2];

    long long length1 = [f1 length];
    long long length2 = [f2 length];
    
    if( length1 < length2 ) {
        return -1;
    } else if( length1 > length2 ) {
     
        return 1;
    }
    
    return 0;
    
    
}

NSInteger HLFileSorters_sortBySizeDescending( CAFile* f1, CAFile* f2, void *context){
    
//    NSNumber* size1 = [f1 getSize];
//    NSNumber* size2 = [f2 getSize];
//    
//    return [size2 compare:size1];

    long long length1 = [f1 length];
    long long length2 = [f2 length];
    
    if( length1 > length2 ) {
        
        return -1;
        
    } else if( length1 < length2 ) {
        
        return 1;
        
    }
    
    return 0;

}
