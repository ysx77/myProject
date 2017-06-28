window.onload = function() {
	$('#navigation-bar').singlePageNav({
		offset: 100, //目标元素偏移顶部的距离
		duration: 1000, //滚动到目标元素上持续的时间
		started: function() {}, // 开始滚动时回调的函数
		finished: function() {} //结束滚动时回调的函数
	});
	$('.nav').singlePageNav({offset:60});
	
	new WOW().init();
}



