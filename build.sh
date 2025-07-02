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

if cp "$(pwd)/arch/arm64/boot/Image" "$(pwd)/build_product" ; then
    echo "Copy Image to build_product directory successful"
else
    echo "Copy Image to build_product directory failed"
    exit 1
fi

if cp "$(pwd)/arch/arm64/boot/dts/broadcom/wt2837.dtb" "$(pwd)/build_product" ; then
    echo "Copy Device Tree Blob to build_product directory successful"
else
    echo "Copy Device Tree Blob to build_product directory failed"
    exit 1
fi

RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

printf "Image loclation: ${RED}$(pwd)/build_product/Image${NC}\n"
printf "Device Tree Blob loclation: ${RED}$(pwd)/build_product/wt2837.dtb${NC}\n"
printf "\n\n"
printf "${YELLOW}Copy the Image and Device Tree Blob to tftp server directory${NC}\n"
