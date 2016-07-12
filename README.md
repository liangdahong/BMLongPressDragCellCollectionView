<h1>1、LDChained<span style="font-size: 12px;">(链式编程思想下的链式设置控件属性)</span></h1>
<h2><span style="font-size: 12px;">1.1 、代码演示</span></h2>
<p>&nbsp;</p>
<div class="cnblogs_code">
<pre>    UILabel *label = [UILabel <span style="color: #0000ff;">new</span><span style="color: #000000;">];
    [self.view addSubview:label];
    
</span><span style="color: #0000ff;">#if</span> 0<span style="color: #000000;">
    label.text </span>= <span style="color: #800000;">@"</span><span style="color: #800000;">123</span><span style="color: #800000;">"</span><span style="color: #000000;">;
    label.textAlignment </span>= <span style="color: #800080;">1</span><span style="color: #000000;">;
    label.textColor </span>=<span style="color: #000000;"> [UIColor orangeColor];
    label.font </span>= [UIFont systemFontOfSize:<span style="color: #800080;">15</span><span style="color: #000000;">];
    label.frame </span>= CGRectMake(<span style="color: #800080;">100</span>, <span style="color: #800080;">100</span>, <span style="color: #800080;">100</span>, <span style="color: #800080;">20</span><span style="color: #000000;">);
    label.backgroundColor </span>=<span style="color: #000000;"> [UIColor grayColor];
</span><span style="color: #0000ff;">#else</span>
    <span style="color: #008000;">//</span><span style="color: #008000;"> 这样是可以的.</span>
    label.ld_text(<span style="color: #800000;">@"</span><span style="color: #800000;">123</span><span style="color: #800000;">"</span>).ld_textAlignment(<span style="color: #800080;">1</span>).ld_textColor([UIColor orangeColor]).ld_font([UIFont systemFontOfSize:<span style="color: #800080;">15</span>]).ld_frame(CGRectMake(<span style="color: #800080;">100</span>, <span style="color: #800080;">100</span>, <span style="color: #800080;">100</span>, <span style="color: #800080;">20</span><span style="color: #000000;">)).ld_backgroundColor([UIColor grayColor]);
</span><span style="color: #0000ff;">#endif</span><span style="color: #000000;">
    
    label._._._.ld_tag(</span><span style="color: #800080;">1</span><span style="color: #000000;">);
    UIButton </span>*button = [UIButton <span style="color: #0000ff;">new</span><span style="color: #000000;">];
    button.ld_title(</span><span style="color: #800000;">@"</span><span style="color: #800000;">1</span><span style="color: #800000;">"</span>,<span style="color: #800080;">1</span>).ld_titleShadowColor([UIColor redColor],<span style="color: #800080;">1</span>).ld_attributedTitle(nil,<span style="color: #800080;">1</span><span style="color: #000000;">);
    
    label.ld_x(</span><span style="color: #800080;">100</span><span style="color: #000000;">);
    label.ld_y(</span><span style="color: #800080;">100</span><span style="color: #000000;">);
    label.ld_origin(CGPointMake(</span><span style="color: #800080;">0</span>, <span style="color: #800080;">0</span><span style="color: #000000;">));
    label.ld_size(CGSizeMake(</span><span style="color: #800080;">100</span>, <span style="color: #800080;">100</span><span style="color: #000000;">));

    label.ld_x(</span><span style="color: #800080;">100</span>).ld_width(<span style="color: #800080;">100</span>).ld_height(<span style="color: #800080;">100</span><span style="color: #000000;">);
    label.ld_x(</span><span style="color: #800080;">100</span>).ld_y(<span style="color: #800080;">0</span>).ld_width(<span style="color: #800080;">100</span>).stop.ld_height(<span style="color: #800080;">100</span>);</pre>
</div>
<p>&nbsp;</p>
<p>求❤️<a href="http://www.jianshu.com/users/8cd6042f01e8/latest_articles" target="_blank">简书地址😊</a></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
