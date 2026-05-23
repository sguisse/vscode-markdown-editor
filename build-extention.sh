#!/usr/bin/env sh

# Check if ../vditor not exists stop the script and print error message
if [ ! -d "../vditor" ]; then
  echo "❌ Error: ../vditor directory not found. Please make sure you have the vditor sguisse fork repository cloned in the parent directory."
  exit 1
fi

cd ../vditor
pwd
source ./build-vditor.sh
cd ../vscode-markdown-editor
pwd

echo "================================================================================================================================="
echo ""

echo "⚙️ Building the vscode-markdown-editor extension in $(pwd)..."
echo ""

echo "Building media-src, using local vditor; Path: $(pwd)/../vditor..."
cd media-src
pwd
rm -rf ../media/dist
echo "✅ Clean old dist files successfully."
rm -rf /node_modules
echo "✅ Remove node_modules successfully."
pnpm install
echo "✅ Install dependencies successfully."
#pnpm run copy-vditor-dist --- IGNORE done automatically by postinstall script ---
pnpm run build
echo "✅ Build media-src successfully."

echo "--------------------------------------------------------------------------------------------------------------------------------"
cd ..
pwd
rm -f markdown-editor-*-sgu.vsix;
echo "✅ Clean old VSIX files successfully."
rm -rf node_modules;
echo "✅ Remove node_modules successfully."
pnpm install;
echo "✅ Install dependencies successfully."

pnpm run build
echo "✅ Build the extension successfully."
npm install -g @vscode/vsce
echo "✅ Install vsce tool successfully."
vsce package
echo ""
echo "🚀 Package the extension successfully."
echo ""
echo "--------------------------------------------------------------------------------------------------------------------------------"
