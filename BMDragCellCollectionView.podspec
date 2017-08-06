Pod::Spec.new do |s|
s.name         = 'BMDragCellCollectionView'
s.version      = '1.0.7'
s.summary      = '一款可以简单实现长按拖拽重排的 UICellCollectionView Cell框架，简单实现支付宝等拖拽重排功能,完美支持iOS6+'
s.homepage     = 'https://github.com/asiosldh/BMDragCellCollectionView'
s.license      = 'MIT'
s.authors      = {'idhong' => 'asiosldh@163.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/asiosldh/BMDragCellCollectionView.git', :tag => s.version}
s.source_files = 'BMDragCellCollectionView/**/*.{h,m}'
s.requires_arc = true
end
