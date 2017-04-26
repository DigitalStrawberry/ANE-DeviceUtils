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
#import "Functions/GetIdentifierForVendorFunction.h"
#import "Functions/GetSystemNameFunction.h"
#import "Functions/GetSystemVersionFunction.h"
#import "Functions/GetModelFunction.h"

static BOOL DeviceUtilsLogEnabled = NO;
FREContext DeviceUtilsExtContext = nil;

@implementation DeviceUtils
@end

/**
 *
 *
 * Context initialization
 *
 *
 **/

FRENamedFunction airDeviceUtilsExtFunctions[] = {
    { (const uint8_t*) "getIdentifierForVendor", 0, devutils_getIdfv },
    { (const uint8_t*) "getModel",               0, devutils_getModel },
    { (const uint8_t*) "getSystemName",          0, devutils_getSystemName },
    { (const uint8_t*) "getSystemVersion",       0, devutils_getSystemVersion }
};

void DeviceUtilsContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet ) {
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







