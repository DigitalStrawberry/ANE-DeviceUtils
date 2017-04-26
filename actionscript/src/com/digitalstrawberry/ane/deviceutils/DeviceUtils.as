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

package com.digitalstrawberry.ane.deviceutils
{

	import flash.system.Capabilities;

	CONFIG::ane {
		import flash.external.ExtensionContext;
	}

	public class DeviceUtils
	{
		private static const EXTENSION_ID:String = "com.digitalstrawberry.ane.deviceUtils";
		private static const iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") > -1;
		private static const ANDROID:Boolean = Capabilities.manufacturer.indexOf("Android") > -1;

		CONFIG::ane {
			private static var mContext:ExtensionContext;
		}

		/**
		 * @private
		 * Do not use. DeviceUtils is a static class.
		 */
		public function DeviceUtils()
		{
			throw Error("DeviceUtils is static class.");
		}


		/**
		 *
		 *
		 * Public API
		 *
		 *
		 */


		/**
		 * Disposes native extension context.
		 */
		public static function dispose():void
		{
			if(!isSupported)
			{
				return;
			}

			CONFIG::ane {
				if(mContext != null)
				{
					mContext.dispose();
					mContext = null;
				}
			}
		}


		public static function get model():String
		{
			if(!isSupported || !initExtensionContext())
			{
				return Capabilities.manufacturer;
			}

			CONFIG::ane {
				return mContext.call("getModel") as String;
			}
			return Capabilities.manufacturer;
		}


		public static function get systemName():String
		{
			if(!isSupported || !initExtensionContext())
			{
				return Capabilities.os;
			}

			CONFIG::ane {
				return mContext.call("getSystemName") as String;
			}
			return Capabilities.os;
		}


		public static function get systemVersion():String
		{
			if(!isSupported || !initExtensionContext())
			{
				return "";
			}

			CONFIG::ane {
				return mContext.call("getSystemVersion") as String;
			}
			return "";
		}


		public static function get idfv():String
		{
			if(!isSupported || !initExtensionContext())
			{
				return "";
			}

			CONFIG::ane {
				return mContext.call("getIdentifierForVendor") as String;
			}
			return "";
		}


		/**
		 * Extension version.
		 */
		public static function get version():String
		{
			return "1.0.0";
		}


		/**
		 * Supported on iOS and Android.
		 */
		public static function get isSupported():Boolean
		{
			return iOS || ANDROID;
		}


		/**
		 *
		 *
		 * Private API
		 *
		 *
		 */

		/**
		 * Initializes extension context.
		 * @return <code>true</code> if initialized successfully, <code>false</code> otherwise.
		 */
		private static function initExtensionContext():Boolean
		{
			CONFIG::ane {
				if(mContext === null)
				{
					mContext = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				}
				return mContext !== null;
			}
			return false;
		}

	}
}
