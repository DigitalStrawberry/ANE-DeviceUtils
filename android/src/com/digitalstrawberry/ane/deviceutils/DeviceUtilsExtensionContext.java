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

package com.digitalstrawberry.ane.deviceutils;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.digitalstrawberry.ane.deviceutils.functions.GetIdentifierForVendorFunction;
import com.digitalstrawberry.ane.deviceutils.functions.GetModelFunction;
import com.digitalstrawberry.ane.deviceutils.functions.GetSystemNameFunction;
import com.digitalstrawberry.ane.deviceutils.functions.GetSystemVersionFunction;
import com.digitalstrawberry.ane.deviceutils.utils.AIR;

import java.util.HashMap;
import java.util.Map;

public class DeviceUtilsExtensionContext extends FREContext {

    @Override
    public Map<String, FREFunction> getFunctions()
    {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();

        functions.put("getIdentifierForVendor", new GetIdentifierForVendorFunction());
        functions.put("getModel", new GetModelFunction());
        functions.put("getSystemName", new GetSystemNameFunction());
        functions.put("getSystemVersion", new GetSystemVersionFunction());

        return functions;
    }

    @Override
    public void dispose()
    {
        AIR.setContext(null);
    }
}
