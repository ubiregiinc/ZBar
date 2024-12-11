#!/bin/bash

set -e
set -x

mkdir -p Sources/ZBarSDK/include

cd Sources/ZBarSDK/include/
ln -s ../../../include/zbar.h .
ln -s ../../../zbar/*.h .
rm debug.h
ln -s ../../../zbar/decoder/*.h .
ln -s ../../../zbar/qrcode/*.h .
ln -s ../../../iphone/include/*.h .
ln -s ../../../iphone/include/ZBarSDK/*.h .
rm {ZBarHelpController,ZBarReaderController,ZBarReaderViewController,ZBarCameraSimulator}.h
cd ..

ln -s ../../include/zbar.h .
ln -s ../../zbar/*.h .
rm debug.h
ln -s ../../iphone/include/*.h .
ln -s ../../iphone/include/ZBarSDK/*.h .
rm {ZBarHelpController,ZBarReaderController,ZBarReaderViewController,ZBarCameraSimulator}.h
ln -s ../../zbar/decoder/*.h .
ln -s ../../zbar/qrcode/*.h .

ln -s ../../zbar/{config,decoder,error,image,img_scanner,refcnt,scanner,symbol}.c .
ln -s ../../zbar/decoder/{codabar,code39,code93,code128,databar,ean,i25,qr_finder}.c .
ln -s ../../zbar/qrcode/*.c .

ln -s ../../iphone/ZBarCVImage.m .
cd ../..

echo -e "#ifndef DEBUG_H\n#define DEBUG_H\n" > Sources/ZBarSDK/debug.h
cat zbar/debug.h iphone/debug.h >> Sources/ZBarSDK/debug.h
echo -e "\n#endif" >> Sources/ZBarSDK/debug.h
cd Sources/ZBarSDK/include
ln -s ../debug.h .
cd ../../..

rm Sources/ZBarSDK/decoder.h Sources/ZBarSDK/include/decoder.h
sed 's/decoder\///g' zbar/decoder.h > Sources/ZBarSDK/decoder.h
cd Sources/ZBarSDK/include
ln -s ../decoder.h .
cd ../../..

sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarCVImage.h > Sources/ZBarSDK/ZBarCVImage.h
# cd Sources/ZBarSDK/include
# ln -s ../ZBarCVImage.h .
# cd ../../..

# include <ZBarSDK/....h>をinclude "....h"に置換　
sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarCaptureReader.m > Sources/ZBarSDK/ZBarCaptureReader.m
sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarReaderView.m > Sources/ZBarSDK/ZBarImage.m
sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarReaderView.m > Sources/ZBarSDK/ZBarImageScanner.m
sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarReaderView.m > Sources/ZBarSDK/ZBarReaderView.m
sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarReaderViewImpl_Capture.m > Sources/ZBarSDK/ZBarReaderViewImpl_Capture.m
sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarReaderViewImpl_Simulator.m > Sources/ZBarSDK/ZBarReaderViewImpl_Simulator.m
sed -E 's/<ZBarSDK\/([A-Za-z]+.h)>/"\1"/g' iphone/ZBarSymbol.m > Sources/ZBarSDK/ZBarSymbol.m
