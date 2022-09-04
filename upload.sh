#!/bin/bash

export BASEPATH=/home/vraccoon/repos/custom-package
export HARBORURL=harbor.app.vraccoon.lab
export HARBORPROJECT=packages

#remove image.yml
rm $BASEPATH/vraccoon-nginx/.imgpkg/images.yml
rm $BASEPATH/vraccoon-pkg-repo/.imgpkg/images.yml

# Resolv pkg images
kbld -f $BASEPATH/vraccoon-nginx/config --imgpkg-lock-output $BASEPATH/vraccoon-nginx/.imgpkg/images.yml

# push package
imgpkg push -b $HARBORURL/$HARBORPROJECT/vraccoon-nginx:1.0.0 -f $BASEPATH/vraccoon-nginx --registry-ca-cert-path ~/demos/ssl-certs/apps/harbor/harbor.app.vraccoon.lab.crt

# resolv pkg-repos images
kbld -f $BASEPATH/vraccoon-pkg-repo/packages/ --imgpkg-lock-output $BASEPATH/vraccoon-pkg-repo/.imgpkg/images.yml --registry-ca-cert-path ~/demos/ssl-certs/apps/harbor/harbor.app.vraccoon.lab.crt

# push repos
imgpkg push -b $HARBORURL/$HARBORPROJECT/vraccoon-pkg-repo:1.0.0 -f $BASEPATH/vraccoon-pkg-repo --registry-ca-cert-path ~/demos/ssl-certs/apps/harbor/harbor.app.vraccoon.lab.crt