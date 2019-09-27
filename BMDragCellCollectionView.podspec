Pod::Spec.new do |s|
s.name         = 'BMDragCellCollectionView'
s.version      = '3.0.0'
s.summary      = '🎉 iOS UICollectionView UICollectionViewCell long press to drag the reorder framework.'
s.homepage     = 'https://github.com/liangdahong/BMDragCellCollectionView'
s.license      = 'MIT'
s.authors      = {'liangdahong' => 'ios@liangdahong.com'}
s.platform     = :ios, '9.0'
s.source       = {:git => 'https://github.com/liangdahong/BMDragCellCollectionView.git', :tag => s.version}
s.source_files = 'BMDragCellCollectionView/Sources/BMDragCellCollectionView/**/*.{h,m}'
s.requires_arc = true
end
