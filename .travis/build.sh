: "${CS_ID:=}"
: "${CS_TEAM:=}"

xcodebuild -resolvePackageDependencies -workspace Clipy.xcworkspace -scheme Clipy -configuration Release -clonedSourcePackagesDirPath SourcePackages

set -o pipefail && xcodebuild -workspace Clipy.xcworkspace -scheme Clipy -configuration Release -clonedSourcePackagesDirPath SourcePackages -destination 'generic/platform=macOS' -archivePath Clipy.xcarchive CODE_SIGN_IDENTITY="" DEVELOPMENT_TEAM="" clean archive | xcpretty

if [[ -n "${CS_ID}" ]]; then
  codesign -f --deep -v -s "${CS_TEAM}" --keychain signing_temp.keychain Clipy.xcarchive/Products/Applications/Clipy.app
fi

# Clean up
rm -rf Clipy.app* || true
working_dir=$(pwd)
# Copy
(cd Clipy.xcarchive/Products/Applications && zip -ry "${working_dir}/Clipy.app.zip" Clipy.app)
unzip Clipy.app.zip