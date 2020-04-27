#!/bin/sh
echo "准备 pod trunk push"
echo "请确保已打 Tag"
#echo "start..."
#echo "验证文件"
#pod lib lint
echo "start pod trunk push"
#pod trunk push BMLongPressDragCellCollectionView.podspec --allow-warnings --verbose
pod trunk push BMLongPressDragCellCollectionView.podspec --allow-warnings
echo "end"

