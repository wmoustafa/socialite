#!/usr/bin/env bash

oldpwd=`pwd`
root="`dirname "$0"`/../"
root=`cd "$root"; pwd`
bin="$root/bin"

export JAVA_HEAP_MAX=-Xmx2048m
export JAVA_HEAP_MIN=-Xmx256m
. "$bin/socialite-config.sh"

testit() {
    testSource=$1
    test=${testSource//src/}
    test=${test//.java/}
    test=${test/\//}

    test=${test//\//.}

    echo "=================================================="
    echo " Running... " $test
    echo "=================================================="

    "$JAVA" -server -ea $JAVA_HEAP_MAX $JAVA_HEAP_MIN $SOCIALITE_OPTS  -classpath "$CLASSPATH" $test
}

cd $root
echo "Building SociaLite"
ant -q

echo
echo " Testing SociaLite compiler"
echo " Some tests may take a few minutes"
echo

for testSrc in $(find src/ -name "*Test.java"); do
   testit $testSrc
done
    
   # -exec bash -c 'testit "$0"' {} \;
