// 當教室深度、寬度改變時的 Function
function seatChange() {
	statusStr = "";
	// 取得現在設定的 rows & columns
	let roomRow = $("#roomrow").val();
	let roomColumn = $("#roomcolumn").val();
	for (let i = 0; i < roomRow * roomColumn; i++) {
		statusStr += 1;
	}
	setDefaultseatValue(statusStr);

	showSeatMapping();
	addBlockClickEvent();
};

// 印出教室 layout
function showSeatMapping() {
	// 取得 defaultseat 的字串值
	statusStr = $("#defaultseat").val();
	// 取得現在設定的 rows & columns
	let roomRow = $("#roomrow").val();
	let roomColumn = $("#roomcolumn").val();
	// 依照座位大小改變教室寬度
	let classroomWidth = (roomColumn * (35 + 10)) + 100 + "px";
	$("#classroom").css("width", classroomWidth);
	// 清空原本設定的空間配置
	$("#seatmapping").empty();
	// 印出教室狀態
	for (let i = 1; i <= roomRow; i++) {
		let rowNameCharCode = 64 + i;
		for (let j = 1; j <= roomColumn; j++) {
			// 計算座位 index，由左上開始
			let seatIndex = ((i - 1) * roomColumn + j) - 1;
			// 座位編號名稱
			let seatName = String.fromCharCode(rowNameCharCode) + j;
			let spaceBlock = $("<div></div>");
			spaceBlock.addClass("spaceblock");
			if (statusStr[seatIndex] === "0") {
				spaceBlock.addClass("aisle");
				spaceBlock.attr("status", "aisle");
			} else if (statusStr[seatIndex] === "1") {
				spaceBlock.addClass("seat");
				spaceBlock.attr("status", "seat");
			}
			spaceBlock.attr("countNum", (i - 1) * roomColumn + j);
			spaceBlock.attr("seatName", seatName);
			spaceBlock.text(seatName);
			$("#seatmapping").append(spaceBlock);
		}
		$("#seatmapping").append("<br>")
	}
};

// 註冊 Block 的點擊事件
function addBlockClickEvent() {
	$(".spaceblock").click(function() {
		let index = $(this).attr("countNum") - 1;
		if ($(this).hasClass("seat")) {
			$(this).removeClass("seat");
			$(this).addClass("aisle");
			$(this).attr("status", "aisle");
			statusStr = replaceCharAtStringIndex(statusStr, index, "0");
			setDefaultseatValue(statusStr);
		} else if ($(this).hasClass("aisle")) {
			$(this).removeClass("aisle");
			$(this).addClass("seat");
			$(this).attr("status", "seat");
			statusStr = replaceCharAtStringIndex(statusStr, index, "1");
			setDefaultseatValue(statusStr);
		}
	});
}

function replaceCharAtStringIndex(str, index, newChar) {
	let beforeStr = str.substring(0, index);
	let afterStr = str.substring(index + 1);
	let newStr = beforeStr + newChar + afterStr;
	return newStr;
};

// 將 input 內寫入預設座位字串值
function setDefaultseatValue(statusStr) {
	$("#defaultseat").val(statusStr);
	$("#seatCount").text(seatCount(statusStr));
	$("#blockCount").text(blockCount(statusStr));
}

// 計算 defaultseat 內有幾個座位
function seatCount(statusStr) {
	let seatCount = 0;
	for (let i = 0; i < statusStr.length; i++) {
		if (statusStr[i] === "1") {
			seatCount++;
		}
	}
	return (seatCount);
}

// 計算教室內有幾個 Block
function blockCount(statusStr) {
	return statusStr.length;
}