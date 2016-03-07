#!/bin/bash

##
## Author......: Jens Steube <jens.steube@gmail.com>
## License.....: MIT
##

export IN=$HOME/oclHashcat-master
export OUT=$HOME/xy/oclHashcat-master

rm -rf $OUT
rm -rf $OUT.7z

mkdir -p $OUT
mkdir -p $OUT/include

cp    $IN/oclHashcat-master/oclHashcat??.exe                      $OUT/oclHashcat-master
cp    $IN/oclHashcat-master/oclHashcat??.bin                      $OUT/oclHashcat-master
cp    $IN/oclHashcat-master/hashcat.hcstat                        $OUT/oclHashcat-master
cp    $IN/oclHashcat-master/hashcat_tuning.hctab                  $OUT/oclHashcat-master

cp -r $IN/oclHashcat-master/docs                                  $OUT/oclHashcat-master
cp -r $IN/oclHashcat-master/charsets                              $OUT/oclHashcat-master
cp -r $IN/oclHashcat-master/masks                                 $OUT/oclHashcat-master
cp -r $IN/oclHashcat-master/rules                                 $OUT/oclHashcat-master
cp -r $IN/oclHashcat-master/extra                                 $OUT/oclHashcat-master
cp    $IN/oclHashcat-master/example.dict                          $OUT/oclHashcat-master
cp    $IN/oclHashcat-master/example[0123456789]*.hash             $OUT/oclHashcat-master
cp    $IN/oclHashcat-master/example[0123456789]*.cmd              $OUT/oclHashcat-master

cp -r $IN/oclHashcat-master/include/constants.h                   $OUT/oclHashcat-master/include
cp -r $IN/oclHashcat-master/include/kernel_functions.c            $OUT/oclHashcat-master/include
cp -r $IN/oclHashcat-master/include/kernel_vendor.h               $OUT/oclHashcat-master/include
cp -r $IN/oclHashcat-master/include/rp_kernel.h                   $OUT/oclHashcat-master/include
cp -r $IN/oclHashcat-master/OpenCL                                $OUT/oclHashcat-master

# since for the binary distribution we still use .bin, we need to rewrite the commands
# within the example*.sh files

for example in example[0123456789]*.sh; do

  sed 's!./oclHashcat !./oclHashcat64.bin !' $IN/${example} > $OUT/${example}

done

dos2unix $OUT/oclHashcat-master/rules/*.rule
dos2unix $OUT/oclHashcat-master/rules/hybrid/*.rule
dos2unix $OUT/oclHashcat-master/docs/*
dos2unix $OUT/oclHashcat-master/example*

unix2dos $OUT/oclHashcat-master/masks/*.hcmask
unix2dos $OUT/oclHashcat-master/rules/*.rule
unix2dos $OUT/oclHashcat-master/rules/hybrid/*.rule
unix2dos $OUT/oclHashcat-master/docs/*
unix2dos $OUT/oclHashcat-master/example*.cmd

chmod 700 $OUT/oclHashcat-master
chmod 700 $OUT/oclHashcat-master/rules
chmod 600 $OUT/oclHashcat-master/rules/*
chmod 700 $OUT/oclHashcat-master/docs
chmod 600 $OUT/oclHashcat-master/docs/*
chmod 700 $OUT/oclHashcat-master/charsets
chmod 700 $OUT/oclHashcat-master/charsets/*
chmod 700 $OUT/oclHashcat-master/masks
chmod 600 $OUT/oclHashcat-master/masks/*
chmod 600 $OUT/oclHashcat-master/example*
chmod 700 $OUT/oclHashcat-master/example*.sh
chmod 700 $OUT/oclHashcat-master/extra
chmod 700 $OUT/oclHashcat-master/extra/tab_completion/*.sh
chmod 700 $OUT/oclHashcat-master/extra/tab_completion/install
chmod 700 $OUT/oclHashcat-master/include
chmod 600 $OUT/oclHashcat-master/include/*
chmod 700 $OUT/oclHashcat-master/OpenCL
chmod 600 $OUT/oclHashcat-master/OpenCL/*
chmod 600 $OUT/oclHashcat-master/*.exe
chmod 700 $OUT/oclHashcat-master/*.bin
chmod 600 $OUT/oclHashcat-master/hashcat.hcstat
chmod 600 $OUT/oclHashcat-master/hashcat_tuning.hctab

time 7z a -t7z -m0=lzma2:d31 -mx=9 -mmt=8 -ms=on $OUT.7z $OUT
