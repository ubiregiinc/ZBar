#!/bin/bash

set -e
set -x

xcodebuild archive -project iphone/zbar.xcodeproj/ -scheme libzbar -destination="iOS" -archivePath iphoneos -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -project iphone/zbar.xcodeproj/ -scheme libzbar -destination="iOS Simulator" -archivePath iphonesimulator -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

mkdir -p Headers/zbar
cp iphone/include/ZBarSDK/*.h Headers/
cp include/zbar.h Headers/
cp include/zbar/{Decoder,Exception,Image,ImageScanner,Processor,Scanner,Symbol,Video,Window}.h Headers/zbar/

xcodebuild -create-xcframework -library iphoneos.xcarchive/Products/usr/local/lib/libzbar.a -headers Headers/ -library iphonesimulator.xcarchive/Products/usr/local/lib/libzbar.a -headers Headers -output ZBarSDK.xcframework

cp module.modulemap ZBarSDK.xcframework/ios-arm64/Headers/module.modulemap
cp module.modulemap ZBarSDK.xcframework/ios-arm64_x86_64-simulator/Headers/module.modulemap

rm -rf iphoneos.xcarchive
rm -rf iphonesimulator.xcarchive
rm -rf Headers
