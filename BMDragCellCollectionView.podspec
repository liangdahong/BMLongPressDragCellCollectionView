Pod::Spec.new do |s|
s.name         = 'BMDragCellCollectionView'
s.version      = '1.1.4'
s.summary      = 'iOS UICollectionView UICollectionViewCell long press to drag the rearrangement framework, iOS6+'
s.homepage     = 'https://github.com/asiosldh/BMDragCellCollectionView'
s.license      = 'MIT'
s.authors      = {'idhong' => 'asiosldh@163.com'}
s.platform     = :ios, '7.0'
s.source       = {:git => 'https://github.com/asiosldh/BMDragCellCollectionView.git', :tag => s.version}
s.source_files = 'BMDragCellCollectionView/**/*.{h,m}'
s.requires_arc = true
end
