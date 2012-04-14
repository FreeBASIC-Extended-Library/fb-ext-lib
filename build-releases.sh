#!/bin/sh
#FreeBASIC Extended Library Release generator

#some variables:
extver=`grep -G '[0-9].[0-9].[0-9]' inc/ext/detail/common.bi | awk 'BEGIN { FS = "." ; OFS = "." } ; { print $2,$3,$4 }'`
win32bin=fbext-win32-${extver}
srczip=fbext-source-${extver}
builddir=fbext-${extver}

#make a release dir to build in
if [ ! -d ${builddir} ]; then
echo 'Creating build directory...'
mkdir ${builddir}

if [ "$1" == "local" ]; then
echo 'Using local files for build.'
cp -r inc ${builddir}
cp -r src ${builddir}
cp -r tests ${builddir}
cp -r examples ${builddir}
cp -r bin ${builddir}

mkdir -p ${builddir}/lib/win32
mkdir -p ${builddir}/lib/linux

cp Makefile ${builddir}
cp common.mki ${builddir}
cp COPYING ${builddir}
cp INSTALL ${builddir}
cp README ${builddir}
cp TODO ${builddir}

else
	echo 'Using SVN:HEAD for build.'
	cd ${builddir}
	svn checkout http://fb-extended-lib.googlecode.com/svn/trunk/ .
	cd ..
	fi
else
	if [ ! "$1" == "local" ]; then
	echo 'Error: you must delete this directory or pass local to build.'
	fi
	
fi
#ok, now a little cleanup
echo 'Ensuring sane build directory...'
cd ${builddir}
find -name '*.*~' -or -name '.svn' | xargs rm -rf

#start building
echo 'Building... (1 of 2)'
make clean VERBOSE=0 && make clean MT=1 VERBOSE=0 && make NDEBUG=1 VERBOSE=0 && make MT=1 NDEBUG=1 VERBOSE=0 && make examples VERBOSE=0
if [ "$?" -ne 0 ]; then
	echo 'Build aborted due to make error'
	exit 42
else
	make tests VERBOSE=0
	if [ "$?" -ne 0 ]; then
		echo 'Build did not pass unit tests. Aborting...'
	else
		echo 'Unit tests were passed.'
		echo 'Preparing to package source...'
		make clean-all VERBOSE=0 && make clean-all MT=1 VERBOSE=0
		cd ..
		echo 'Packaging source...'
		zip a -r ${srczip}.zip ${builddir} 
		echo 'Building Win32 binaries...'
		cd ${builddir}
		make VERBOSE=0 NDEBUG=1 && make VERBOSE=0 MT=1 NDEBUG=1 && make VERBOSE=0 examples
		if [ "$?" -ne 0 ]; then
			echo 'Error during build, aborting...'
			rm ../${srczip}.zip
			exit 42
		else
			echo 'Compressing EXEs...'
			find -name '*.exe' | xargs upx -q -9
			echo 'Packaging Win32 build...'
			find -name '*.o' | xargs rm -f
			cd ..
			zip a -r ${win32bin}.zip ${builddir}/inc && \
			zip a -r ${win32bin}.zip ${builddir}/bin && \
			zip a -r ${win32bin}.zip ${builddir}/lib && \
			zip a -r ${win32bin}.zip ${builddir}/examples && \
			zip a ${win32bin}.zip ${builddir}/docs/LICENSE.txt ${builddir}/docs/freetype/ftl.txt ${builddir}/docs/freetype/gpl.txt ${builddir}/docs/jpeg/libjpeg-license.txt ${builddir}/docs/zlib/zlib.txt && \
			zip a ${win32bin}.zip ${builddir}/COPYING ${builddir}/INSTALL ${builddir}/TODO ${builddir}/README
			if [ "$?" -ne 0 ]; then
				echo 'Unknown error during packing, build aborted.'
				rm ${srczip}.zip
				rm ${win32bin}.zip
				exit 42
			else
				echo 'Build complete!'
			fi
		fi
	fi
	exit 1
fi
	
	
