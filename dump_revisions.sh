#!/bin/bash

PROJ=$(pwd)
TARGET=${PROJ}/modules_versions

echo "# revision for each git submodule" > ${TARGET}

for i in $(ls -1)
do
	if [ -d ${i} ]
	then
		pushd ${i}
			revision=$(git rev-parse HEAD)
			url=$(grep url .git/config | awk '{print $3}')
		popd
		echo "export ${i}_revision=${revision}" >> ${TARGET}
		echo "export ${i}_url=${url}" >> ${TARGET}
	fi
done
