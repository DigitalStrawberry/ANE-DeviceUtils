# ANE-DeviceUtils

A simple native extension to retrieve basic device information.

### Usage

Download the ANE from the [bin](bin/) directory or from the [releases](../../releases/) page and add it to your app's descriptor:

```xml
<extensions>
    <extensionID>com.digitalstrawberry.ane.deviceUtils</extensionID>
</extensions>
```

To retrieve an [identifier for vendor](https://developer.apple.com/reference/uikit/uidevice/1620059-identifierforvendor) (iOS) / [ANDROID_ID](https://developer.android.com/reference/android/provider/Settings.Secure.html#ANDROID_ID) (Android), call the `idfv` getter:

```as3
if(DeviceUtils.isSupported)
{
    trace(DeviceUtils.idfv);
}
```

You can also retrieve the device model, system name and version:

```as3
trace(DeviceUtils.model);
trace(DeviceUtils.systemName);
trace(DeviceUtils.systemVersion);
```

### Changelog

#### August 23, 2017 (v1.0.2)

* Changed structure of the iOS project

#### June 13, 2017 (v1.0.1)

* Initialized `FREObject` variables to `NULL` (iOS)

#### April 27, 2017 (v1.0.0)

* Public release
