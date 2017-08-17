
WORK_HOME=`pwd -P`
PROJECT_HOME=$WORK_HOME

# OLD_PORT=833
# NEW_PORT=733

REPLACE_KEYWORD=true
CLONE_FROM_GIT=true

OLD_NAME=BIT
OLD_COIN_UNIT_D="BTC"
OLD_COIN_UNIT_U=satoshis

NEW_NAME=XYZ
NEW_COIN_UNIT_D="TVG"
NEW_COIN_UNIT_U=tradevans



BIT_VER=13
if [ ! "undefined" == "undefined${1}" ] ; then
BIT_VER=${1}
GIT_TAG=0.${BIT_VER}
else
GIT_TAG=0.${BIT_VER}.1
fi



CLONE_FROM=$(echo "$CLONE_FROM" | tr '[:upper:]' '[:lower:]')
OLD_COIN_L=$(echo "${OLD_NAME}coin" | tr '[:upper:]' '[:lower:]')
OLD_COIN_U=$(echo "${OLD_NAME}coin" | tr '[:lower:]' '[:upper:]')
OLD_COIN_H=$(echo "${OLD_COIN_U}" | cut -c1)$(echo "${OLD_COIN_L}" | cut -c2-)
OLD_PROJ=${PROJECT_HOME}/${OLD_COIN_L}

NEW_COIN_L=$(echo "${NEW_NAME}coin" | tr '[:upper:]' '[:lower:]')
NEW_COIN_U=$(echo "${NEW_NAME}coin" | tr '[:lower:]' '[:upper:]')
NEW_COIN_H=$(echo "${NEW_COIN_U}" | cut -c1)$(echo "${NEW_COIN_L}" | cut -c2-)
NEW_PROJ=${PROJECT_HOME}/${NEW_COIN_L}


echo OLD_COIN = ${OLD_COIN_L}, ${OLD_COIN_U}, ${OLD_COIN_H}, OLD_COIN_UNIT=${OLD_COIN_UNIT_U}/${OLD_COIN_UNIT_D}
echo OLD_PROJ=${OLD_PROJ}


echo NEW_COIN = ${NEW_COIN_L}, ${NEW_COIN_U}, ${NEW_COIN_H}, NEW_COIN_UNIT=${NEW_COIN_UNIT_U}/${NEW_COIN_UNIT_D}
echo NEW_PROJ=${NEW_PROJ}

echo clone from ${GIT_TAG}

echo \n\nPress Enter to continue : ${NEW_PROJ}
read

# prepare PROJECT
cd $PROJECT_HOME
if [ ! -d $NEW_PROJ ] ; then mkdir -p $NEW_PROJ; fi

echo OK, let\'s GO...
echo remove $NEW_PROJ in $(pwd -P)
rm -rf $NEW_PROJ

# using git ...
if [ "istrue" == "is${CLONE_FROM_GIT}" ] ; then
echo clone code from GIT HUB : https://github.com/bitcoin/bitcoin.git
git clone https://github.com/bitcoin/bitcoin.git $NEW_PROJ
if [ "${GIT_TAG}undefined" != "undefined" ]; then
echo check out special TAG ${GIT_TAG}
cd $NEW_PROJ
git checkout ${GIT_TAG}
fi
fi


if [ "istrue" != "is${CLONE_FROM_GIT}" ] ; then
echo copy file from $(pwd -P) into $NEW_PROJ
cd $PROJECT_HOME
cp -rv $OLD_PROJ/ $NEW_PROJ/

cd $NEW_PROJ

find . -name "*.o" -print0 | xargs -0 rm 
find . -name "*.a" -print0 | xargs -0 rm 
find . -name "*.so" -print0 | xargs -0 rm 
find . -name ".libs" -print0 | xargs -0 rm -rf
find . -name "bitcoind" -print0 | xargs -0 rm 
find . -name "bitcoin-tx" -print0 | xargs -0 rm 
find . -name "bitcoin-cli" -print0 | xargs -0 rm 
find . -name "bitcoin-qt" -print0 | xargs -0 rm 

fi

echo copy done ...


if [ "is${REPLACE_KEYWORD}" == "istrue" ] ; then
cd ${NEW_PROJ}
echo chnage keyword in $(pwd -P)
# pwd -P

echo replace keyword ${OLD_COIN_L} to ${NEW_COIN_L}
find . -type f -exec sed -i "s/${OLD_COIN_L}/${NEW_COIN_L}/g" {} +
echo replace keyword ${OLD_COIN_U} to ${NEW_COIN_U}
find . -type f -exec sed -i "s/${OLD_COIN_U}/${NEW_COIN_U}/g" {} +
echo replace keyword ${OLD_COIN_H} to ${NEW_COIN_H}
find . -type f -exec sed -i "s/${OLD_COIN_H}/${NEW_COIN_H}/g" {} +


# if [ "undefined${OLD_COIN_UNIT_D}" != "undefined" ] && [ "undefined${NEW_COIN_UNIT_D}" != "undefined" ] ; then
# echo replace keyword ${OLD_COIN_UNIT_D} to ${NEW_COIN_UNIT_D}
# find . -type f -exec sed -i "s/${OLD_COIN_UNIT_D}/${NEW_COIN_UNIT_D}/g" {} +
# fi

# if [ "undefined${OLD_COIN_UNIT_U}" != "undefined" ] && [ "undefined${NEW_COIN_UNIT_U}" != "undefined" ] ; then
# echo replace keyword ${OLD_COIN_UNIT_U} to ${NEW_COIN_UNIT_U}
# find . -type f -exec sed -i "s/${OLD_COIN_UNIT_U}/${NEW_COIN_UNIT_U}/g" {} +
# fi

# if [ "undefined" != "${OLD_PORT}undefined" ] && [ "undefined" != "${NEW_PORT}undefined" ] ; then 
# echo replace keyword PORT ${OLD_PORT} to ${NEW_PORT}
# find . -type f -exec sed -i "s/${OLD_PORT}/${NEW_PORT}/g" {} +
# fi

if [ "undefined" != "${OLD_VERSION}undefined" ] && [ "undefined" != "${OLD_VERSION}undefined" ] ; then 
echo replace keyword ${OLD_VERSION} to ${NEW_VERSION}
find . -type f -exec sed -i "s/${OLD_VERSION}/${NEW_VERSION}/g" {} +
fi


cd ${NEW_PROJ}
echo Rename file in $(pwd -P)
find . -name "*${OLD_COIN_U}*" | sed -e "p;s/${OLD_COIN_U}/${NEW_COIN_U}/g" | xargs -n2 mv
find . -name "*${OLD_COIN_H}*" | sed -e "p;s/${OLD_COIN_H}/${NEW_COIN_H}/g" | xargs -n2 mv
find . -name "*${OLD_COIN_L}*" | sed -e "p;s/${OLD_COIN_L}/${NEW_COIN_L}/g" | xargs -n2 mv

fi

# reconfig project
cd ${PROJECT_HOME}
echo reconfig project make file 

if [ -d ${PROJECT_HOME}/db-4.8.30.NC/build_unix/build ]; then
BDB_PREFIX=${PROJECT_HOME}/db-4.8.30.NC/build_unix/build
elif [ -d $HOME/workspace/db-4.8.30.NC/build_unix/build ]; then
BDB_PREFIX=$HOME/workspace/db-4.8.30.NC/build_unix/build
else
cd $PROJECT_HOME
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
# compare File Hash 
echo '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef db-4.8.30.NC.tar.gz' | sha256sum -c
tar -xvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix
BDB_PREFIX=$(pwd -P)/build
mkdir -p ${BDB_PREFIX}
../dist/configure -disable-shared -enable-cxx -with-pic -prefix=$BDB_PREFIX
make install
cd ../..
fi
echo BDB HOME: ${BDB_PREFIX}


# if [ "undefined" != "${OLD_PORT}undefined" ] && [ "undefined" != "${NEW_PORT}undefined" ] ; then 
# cd ${PROJECT_HOME}
# if [ ! -d ${PROJECT_HOME}/leveldb ]; then
# git clone https://github.com/google/leveldb.git
# fi
# if [ -f ${PROJECT_HOME}/leveldb/util/crc32c.cc ] ; then
# echo cp ${PROJECT_HOME}/leveldb/util/crc32c.cc $NEW_PROJ/src//leveldb/util/crc32c.cc
# cp ${PROJECT_HOME}/leveldb/util/crc32c.cc $NEW_PROJ/src//leveldb/util/crc32c.cc
# fi
# fi


cd $NEW_PROJ
./autogen.sh

# echo CPPFLAGS="-I${BDB_PREFIX}/include/" CXXFLAGS="-O3" LDFLAGS="-L${BDB_PREFIX}/lib/" -with-gui

./configure CPPFLAGS="-I${BDB_PREFIX}/include/" CXXFLAGS="-O3" LDFLAGS="-L${BDB_PREFIX}/lib/" \
--with-gui --disable-tests --disable-gui-tests  --with-libs=no 

# --enable-jni --enable-experimental --enable-endomorphism --enable-module-ecdh --enable-jni

# --enable-experimental --enable-endomorphism --enable-module-ecdh --enable-jni

if [ -f Makefile ]; then
make clean
STIME=`date`
make 
ETIME=`date`

echo make done $STIME, $ETIME

fi



