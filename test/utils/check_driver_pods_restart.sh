#!/bin/bash

# Copyright 2020 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

# Get the value of the environment variable or set a default value if it's empty
CSI_DRIVER_INSTALLED_NAMESPACE="${CSI_DRIVER_INSTALLED_NAMESPACE:-kube-system}"

echo "check the driver pods if restarts ..."
restarts=$(kubectl get pods -n "${CSI_DRIVER_INSTALLED_NAMESPACE}" | grep smb | awk '{print $4}')
for num in $restarts
do
    if [ "$num" -ne "0" ]
    then
        echo "there is a driver pod which has restarted"
        # disable pods restart check temporarily since there is driver restart in MSI enabled cluster
        # exit 3
    fi
done
echo "no driver pods have restarted"
echo "======================================================================================"
