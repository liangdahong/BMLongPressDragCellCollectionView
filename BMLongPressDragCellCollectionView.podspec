Pod::Spec.new do |s|
s.name         = 'BMLongPressDragCellCollectionView'
s.version      = '3.0.8'
s.summary      = '🎉 iOS UICollectionView UICollectionViewCell long press to drag the reorder framework.'
s.homepage     = 'https://github.com/liangdahong/BMLongPressDragCellCollectionView'
s.license      = 'MIT'
s.authors      = {'liangdahong' => 'ios@liangdahong.com'}
s.platform     = :ios, '7.0'
s.source       = {:git => 'https://github.com/liangdahong/BMLongPressDragCellCollectionView.git', :tag => s.version}
s.source_files = 'BMLongPressDragCellCollectionView/Sources/BMLongPressDragCellCollectionView/**/*.{h,m}'
s.requires_arc = true
end
