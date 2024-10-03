#!/bin/sh

rm -f *.o *.so

source /opt/miniconda3/etc/profile.d/conda.sh
conda activate p27hedges

ARCH_FLAGS="-arch x86_64"
CPP_STANDARD="-std=c++11"

clang++ -fPIC -fpermissive -w $ARCH_FLAGS $CPP_STANDARD -c NRpyDNAcode.cpp -o NRpyDNAcode.o \
    -I$(python -c "import sysconfig; print(sysconfig.get_path('include'))") \
    -I$(python -c "import numpy; print(numpy.get_include())")

clang++ -dynamiclib -o NRpyDNAcode.so NRpyDNAcode.o \
    -L$(python -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))") -lpython2.7

clang++ -fPIC -fpermissive -w $ARCH_FLAGS $CPP_STANDARD -c NRpyRS.cpp -o NRpyRS.o \
    -I$(python -c "import sysconfig; print(sysconfig.get_path('include'))") \
    -I$(python -c "import numpy; print(numpy.get_include())")

clang++ -dynamiclib -o NRpyRS.so NRpyRS.o \
    -L$(python -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))") -lpython2.7

echo "done"

