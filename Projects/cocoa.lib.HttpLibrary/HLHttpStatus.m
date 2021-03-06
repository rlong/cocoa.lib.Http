// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "HLHttpStatus.h"
#import "HLHttpStatus_ErrorDomain.h"




@implementation HLHttpStatus


static HLHttpStatus_ErrorDomain* _errorDomain = nil;

+(void)initialize {
	
	_errorDomain = [[HLHttpStatus_ErrorDomain alloc] init];
	
}



+(HLHttpStatus_ErrorDomain*)errorDomain {
    
    return _errorDomain;
    
}



+(NSString*)getReason:(int)statusCode {
    
    

    switch (statusCode) {
    
        case 101:
            return @"Switching Protocols";

		case 200:
			return @"OK";
		case 204:
			return @"No Content";
		case 206:
			return @"Partial Content";

        case 304:
            return @"Not Modified";

		case 400:
			return @"Bad Request";
		case 401:
			return @"Unauthorized";
		case 402:
			return @"Payment Required";
		case 403:
			return @"Forbidden";
		case 404:
			return @"Not Found";
		case 405:
			return @"Method Not Allowed";
		case 406:
			return @"Not Acceptable";
		case 407:
			return @"Proxy Authentication Required";
		case 408:
			return @"Request Time-out";
		case 409:
			return @"Conflict";
		case 410:
			return @"Gone";
		case 411:
			return @"Length Required";
		case 412:
			return @"Precondition Failed";
		case 413:
			return @"Request Entity Too Large";
		case 414:
			return @"Request-URI Too Large";
		case 415:
			return @"Unsupported Media Type";
		case 416:
			return @"Requested range not satisfiable";
		case 417:
			return @"Expectation Failed";
			
		case 500:
			return @"Internal Server Error";
		case 501:
			return @"Not Implemented";
		case 502:
			return @"Bad Gateway";
		case 503:
			return @"Service Unavailable";
		case 504:
			return @"Gateway Time-out";
		case 505:
			return @"HTTP Version not supported";
						
		default:
            // fall through ... 
			break;
            
	}
    return @"Unknown";
    
}


@end




int const HttpStatus_SWITCHING_PROTOCOLS_101 = 101;

int const HttpStatus_OK_200 = 200;
int const HttpStatus_NO_CONTENT_204 = 204;
int const HttpStatus_PARTIAL_CONTENT_206 = 206;

int const HttpStatus_NOT_MODIFIED_304 = 304;

int const HttpStatus_BAD_REQUEST_400 = 400;
int const HttpStatus_UNAUTHORIZED_401 = 401;
int const HttpStatus_FORBIDDEN_403 = 403;
int const HttpStatus_NOT_FOUND_404 = 404;
int const HttpStatus_REQUEST_ENTITY_TOO_LARGE_413 = 413;

int const HttpStatus_INTERNAL_SERVER_ERROR_500 = 500;
int const HttpStatus_NOT_IMPLEMENTED_501 = 501;


