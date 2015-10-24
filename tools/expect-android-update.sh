#!/bin/bash

OPTIONS="--no-ui --all --filter"

expect -c "
set timeout -1
spawn /opt/android-sdk/copy-tools/android update sdk $OPTIONS $@

expect {
\"Do you accept the license\" {
send \"y\n\"
exp_continue
}
Downloading {
exp_continue
}
Installing {
exp_continue
}
}
"
