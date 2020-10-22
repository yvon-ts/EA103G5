/**
 * 
 */
function status(){
		
		 swal('老師資格審核中', '請耐心等候1~3個工作天，一但審核完畢，即會立刻通知', 'info');
	}
	
	var inform2 = document.getElementById('inform2').value;
	if(inform2 ==='200'){
		swal('完了', '沒辦法開始您的線上之旅了!', 'error');
	}
	
	var inform3 = document.getElementById('inform3').value;

if(inform3 ==='200'){
	swal('恭喜啦', '您已經成為我們的會員囉<br>趕快來登入並且開始瀏覽課程吧', 'success');
}

 var inform4 = document.getElementById('inform4').value;
 	if(inform4 ==='200'){
 		swal('已成功更新', '您的個人檔案!', 'success');
 	}