# custom-package

## Folder structure package

vraccoon-cert-manager (<-- best-practice: package name)
- .imgpkg
-- images.yml (generated by kbld)
- config
-- packages.yaml
-- values.yaml



### packages.yaml
--> Acutal ytt Template

### values.ymal
--> default data values

## Folder structure package-repo
- .impkg
- packages
-- package-1
--- metadata.yml (apivserion: data.packaging.carvel.dev/v1alpha1; kind: PackageMetadata; ....)
--- v.1.0.0.yml

### metadata.yml
apivserion: data.packaging.carvel.dev/v1alpha1
kind: PackageMetadata
...
Contains only description/maintainer/icon of the particular package

### v1.0.0.yml
apiVersion: data.packaging.carvel.dev/v1alpha1
kind: Package
...
contains all variables to be set (from values.yml)
also contains information about package location, config files within the package, and kbld file within the package


## HowTo
1. Create Templates
2. resolve images to digest
--> kbld -f vraccoon-cert-manager/config --imgpkg-lock-output vraccoon-cert-manager/.imgpkg/images.yml
--> "yml" not "yaml" !
3. Push this to Registry
--> imgpkg push -b harbor.app.vraccoon.lab/packages/vraccoon-cert-manager:1.0.0 -f vraccoon-cert-manager --registry-ca-cert-path ~/demos/ssl-certs/apps/harbor/harbor.app.vraccoon.lab.crt
4. Create Package Repository Files
5. resolve images to digest (here package "image")
--> kbld -f vraccoon-pkg-repo/packages/ --imgpkg-lock-output vraccoon-pkg-repo/.imgpkg/images.yml --registry-ca-cert-path ~/demos/ssl-certs/apps/harbor/harbor.app.vraccoon.lab.crt
6. push repo to registry
--> imgpkg push -b harbor.app.vraccoon.lab/packages/vraccoon-pkg-repo:1.0.0 -f vraccoon-cert-manager --registry-ca-cert-path ~/demos/ssl-certs/apps/harbor/harbor.app.vraccoon.lab.crt
