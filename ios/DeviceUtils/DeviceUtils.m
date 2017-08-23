/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2017 Digital Strawberry LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import "DeviceUtils.h"
#import <sys/sysctl.h>
#import <UIKit/UIKit.h>

static BOOL DeviceUtilsLogEnabled = NO;
FREContext DeviceUtilsExtContext = nil;

@implementation DeviceUtils
@end

# pragma mark - Private API

NSString* devutils_getSysInfo(char* typeSpecifier)
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char* sysInfo = malloc(size);
    sysctlbyname(typeSpecifier, sysInfo, &size, NULL, 0);
    
    NSString* result = [NSString stringWithCString:sysInfo encoding:NSUTF8StringEncoding];
    
    free(sysInfo);
    
    return result;
}

# pragma mark - ANE Functions

DEFINE_ANE_FUNCTION(devutils_getModel)
{
    NSString* model = devutils_getSysInfo("hw.machine");
    
    FREObject result = NULL;
    FRENewObjectFromUTF8((unsigned int) [model length], (const uint8_t*) [model UTF8String], &result);
    return result;
}

DEFINE_ANE_FUNCTION(devutils_getIdfv)
{
    NSString* idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    FREObject result = NULL;
    FRENewObjectFromUTF8((unsigned int) [idfv length], (const uint8_t*) [idfv UTF8String], &result);
    return result;
}

DEFINE_ANE_FUNCTION(devutils_getSystemName)
{
    NSString* sysName = [[UIDevice currentDevice] systemName];
    
    FREObject result = NULL;
    FRENewObjectFromUTF8((unsigned int) [sysName length], (const uint8_t*) [sysName UTF8String], &result);
    return result;
}

DEFINE_ANE_FUNCTION(devutils_getSystemVersion)
{
    NSString* sysVersion = [[UIDevice currentDevice] systemVersion];
    
    FREObject result = NULL;
    FRENewObjectFromUTF8((unsigned int) [sysVersion length], (const uint8_t*) [sysVersion UTF8String], &result);
    return result;
}

/**
 *
 *
 * Context initialization
 *
 *
 **/

void DeviceUtilsContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction airDeviceUtilsExtFunctions[] = {
        MAP_FUNCTION(getIdentifierForVendor, devutils_getIdfv, NULL),
        MAP_FUNCTION(getModel, devutils_getModel, NULL),
        MAP_FUNCTION(getSystemName, devutils_getSystemName, NULL),
        MAP_FUNCTION(getSystemVersion, devutils_getSystemVersion, NULL),
    };
    
    *numFunctionsToSet = sizeof( airDeviceUtilsExtFunctions ) / sizeof( FRENamedFunction );
    
    *functionsToSet = airDeviceUtilsExtFunctions;
    
    DeviceUtilsExtContext = ctx;
}

void DeviceUtilsContextFinalizer( FREContext ctx ) { }

void DeviceUtilsInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &DeviceUtilsContextInitializer;
    *ctxFinalizerToSet = &DeviceUtilsContextFinalizer;
}

void DeviceUtilsFinalizer( void* extData ) { }







