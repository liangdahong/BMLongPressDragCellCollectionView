Pod::Spec.new do |s|
s.name         = 'BMDragCellCollectionView'
s.version      = '1.1.5'
s.summary      = 'iOS UICollectionView UICollectionViewCell long press to drag the rearrangement framework, iOS7+'
s.homepage     = 'https://github.com/liangdahong/BMDragCellCollectionView'
s.license      = 'MIT'
s.authors      = {'liangdahong' => 'asiosldh@163.com'}
s.platform     = :ios, '7.0'
s.source       = {:git => 'https://github.com/liangdahong/BMDragCellCollectionView.git', :tag => s.version}
s.source_files = 'BMDragCellCollectionView/**/*.{h,m}'
s.requires_arc = true
end
