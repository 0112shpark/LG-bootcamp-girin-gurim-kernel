#! /bin/bash

# if [ ! -e "$(pwd)/arch/arm64/boot/Image" ]; then
# fi

make clean
if [ $? -ne 0 ]; then
    echo "Make clean failed"
    exit 1
fi

make wt2837_defconfig
if [ $? -ne 0 ]; then
    echo "Make wt2837_defconfig failed"
    exit 1
fi

make -j$(nproc)
if [ $? -ne 0 ]; then
    echo "Make failed"
    exit 1
fi

echo "Image loclation: $(pwd)/arch/arm64/boot/Image"
echo "Device Tree Blob loclation: $(pwd)/arch/arm64/boot/dts/broadcom/wt2837.dtb"
echo ""
echo "Copy the Image and Device Tree Blob to tftp servere directory"