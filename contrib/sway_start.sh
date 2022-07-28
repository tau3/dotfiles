#!/bin/bash

# fix to display mouse
export WLR_NO_HARDWARE_CURSORS=1

# fix to use vulkan
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json

sudo chgrp video /dev/dri/renderD128

# start sway 
dbus-run-session sway &> log

