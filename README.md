<div class="cnblogs_code">
<pre><span style="color: #008080;"> 1</span>     <span style="color: #008000;">//</span><span style="color: #008000;"> 1.</span>
<span style="color: #008080;"> 2</span>     UILabel *label = [UILabel <span style="color: #0000ff;">new</span><span style="color: #000000;">];
</span><span style="color: #008080;"> 3</span>     [label ld_makeCollocationLabel:^(LDCollocationLabelMaker *<span style="color: #000000;">make) {
</span><span style="color: #008080;"> 4</span> <span style="color: #000000;">        make
</span><span style="color: #008080;"> 5</span>         .textBlock(<span style="color: #800000;">@"</span><span style="color: #800000;">123</span><span style="color: #800000;">"</span><span style="color: #000000;">)
</span><span style="color: #008080;"> 6</span> <span style="color: #000000;">        .textColorBlock([UIColor redColor])
</span><span style="color: #008080;"> 7</span> <span style="color: #000000;">        .textAlignmentBlock(NSTextAlignmentCenter)
</span><span style="color: #008080;"> 8</span> <span style="color: #000000;">        .shadowColorBlock([UIColor blueColor])
</span><span style="color: #008080;"> 9</span> <span style="color: #000000;">        .backgroundColorBlock([UIColor orangeColor]);
</span><span style="color: #008080;">10</span>     }];</pre>
</div>
<p>&nbsp;</p>
