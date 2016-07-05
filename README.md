<h1>1、LDChained<span style="font-size: 12px;">(链式编程思想下的链式设置控件属性)</span></h1>
<h2><span style="font-size: 12px;">1.1 、代码演示</span></h2>
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
</span><span style="color: #0000ff;">#endif</span></pre>
</div>
<p>&nbsp;</p>
