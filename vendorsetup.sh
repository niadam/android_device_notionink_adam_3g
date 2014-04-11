#
# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file is executed by build/envsetup.sh, and can use anything
# defined in envsetup.sh.
#
# In particular, you can add lunch options with the add_lunch_combo
# function: add_lunch_combo generic-eng
export USE_CCACHE=1
add_lunch_combo cm_adam_3g-userdebug
echo ""
echo "Patching Workspace..."
echo ""

rootDir=$(pwd)

for p in $(find device/notionink/adam_3g/patches/ -name "*.diff")
        do
                patchname=$(basename $p | awk -F"." '{print $1}')
                if [ -f $patchname".p" ]; then
                        echo "Patch "$patchname" already applied"
                else
                        echo -n "Applying patch: "$patchname
                        echo ""

                        dir=$(echo ${patchname%'-'*} | tr _ /)
                        echo "To dir: "$dir
                        if [ -d $dir ]; then
                                echo "Patch dir exists do patching"
                                cd $dir
                                patch -p1 < $rootDir"/"$p > /dev/null 2>&1
                                cd $rootDir
                                if [ $? == 0 ]; then
                                        echo "     [DONE]"
                                        touch $patchname".p"
                                else
                                        echo "     [FAIL]"
                                fi

                        else
                                echo "ERROR: Dir where patch should be applied doesn't exists. Please check patch name format. It should be dir_dir_dir-patchname.diff"
                        fi

                fi
                echo ""
        done

echo "Cleaning .orig and .rej files if any..."
find . \( -name \*cpp.orig -o -name \*xml.orig -o -name \*.h.orig -o -name \*.java.orig -o -name \*.rej \) -delete
echo ""

