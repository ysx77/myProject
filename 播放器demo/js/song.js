//歌曲清单
var songList = [
	'Taylor Swift - Shake It Off .mp3',
	'林宥嘉 (Yoga Lin) - 成全 (Live).mp3',
	'回音哥 - 陪我看日出.mp3',
	'徐佳莹,林俊杰 - 不为谁而作的歌.mp3',
	'薛之谦 - 方圆几里.mp3',
	'薛之谦 - 你还要我怎样.mp3',
	'薛之谦 - 绅士.mp3',
	'薛之谦 - 一半.mp3'
];

var state = 'pause'; //当前是播放状态还是暂停状态，（play表示播放）

var audio = $('audio')[0];

var currentIndex = 0;

setSongName();

//设置歌曲列表
for(var i = 0; i < songList.length; i++) {
	var oLi = document.createElement('li');
	oLi.index = i;
	var oA = document.createElement('a');
	oA.innerHTML = songList[i].substring(0,songList[i].indexOf('.'));
	oLi.appendChild(oA);
	//点击事件
	oLi.onclick = function() {
		currentIndex = this.index;
		cutSong();
	}
	$('.dropdown-menu')[0].appendChild(oLi);
}

//播放（暂停）
$('#play').click(function() {
	if(state == 'pause') {
		//暂停
		audio.play();
		state = 'play';
		$('#play>span')[0].className = 'glyphicon glyphicon-pause';
	} else {
		audio.pause();
		state = 'pause';
		$('#play>span')[0].className = 'glyphicon glyphicon-play';
	}
});

//停止按钮
$('#stop').click(function() {
	audio.load();
	state = 'pause';
	$('#play>span')[0].className = 'glyphicon glyphicon-play';
});

//进度条
setInterval(function() {
	$('.progress-bar')[0].style.width = parseFloat(audio.currentTime / audio.duration * 100).toFixed(2) + '%';
	//时间
	$('.progress-time>span')[0].innerHTML = formatTime(audio.currentTime);

	if(formatTime(audio.duration) == 'NaN:NaN') {
		$('.progress-time>span')[2].innerHTML = '00:00';
	} else {
		$('.progress-time>span')[2].innerHTML = formatTime(audio.duration);
	}

	//自动播放下一首
	if(audio.currentTime >= audio.duration) {
		currentIndex = ++currentIndex % songList.length;
		cutSong();
		setSongName();
	}
}, 1);

//设置歌名
function setSongName() {
	$('.song-name>marquee')[0].innerHTML = songList[currentIndex].substring(0,songList[currentIndex].indexOf('.'));
}

//下一首
$('#forward').click(function() {
	currentIndex = ++currentIndex % songList.length;
	setSongName(currentIndex);
	cutSong();
});

//上一首
$('#backward').click(function() {
	if(--currentIndex < 0) {
		currentIndex = songList.length - 1;
	}
	setSongName();
	cutSong();
});

//切换歌曲
function cutSong() {
	//停止当前播放的音乐，切换到上（下）一首
	audio.load();
	$('#play>span')[0].className = 'glyphicon glyphicon-play';
	setSongName();
	setTimeout(function() { //为了让其有从暂停，切换到下一首，然后播放的效果
		$('audio').attr('src', 'audio/' + songList[currentIndex]);
		audio.play();
		$('#play>span')[0].className = 'glyphicon glyphicon-pause';
	}, 500);
}

////////////////////////////////
//格式化时间
function formatTime(time) {
	//time = Math.floor(time);
	var m = Math.floor(time % 3600 / 60);
	var s = Math.floor(time % 60);
	return toZero(m) + ':' + toZero(s);
}

function toZero(num) {
	if(num < 10) {
		return '0' + num;
	} else {
		return num;
	}
}