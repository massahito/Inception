#!/bin/bash
set -eux
function test()
{
	fljajfa
}
for i in `seq 0 9`
do
	test
	echo $?
	sleep 1
done

