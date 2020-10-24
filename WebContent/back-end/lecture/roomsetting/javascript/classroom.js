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

//印出教室 layout，訂位用
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
			} else if (statusStr[seatIndex] === "*") {
				spaceBlock.addClass("chosen");
				spaceBlock.attr("status", "chosen");
			}  
			else if (statusStr[seatIndex] === "2") {
				spaceBlock.addClass("booked");
				spaceBlock.attr("status", "booked");
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

// 註冊 Block 的點擊事件(also update fixed seats)
function addClickToBothSeats() {
	$(".spaceblock").click(function() {
		let index = $(this).attr("countNum") - 1;
		if ($(this).hasClass("seat")) {
			$(this).removeClass("seat");
			$(this).addClass("aisle");
			$(this).attr("status", "aisle");
			statusStr = replaceCharAtStringIndex(statusStr, index, "0");
			setBothSeatsValue(statusStr);
		} else if ($(this).hasClass("aisle")) {
			$(this).removeClass("aisle");
			$(this).addClass("seat");
			$(this).attr("status", "seat");
			statusStr = replaceCharAtStringIndex(statusStr, index, "1");
			setBothSeatsValue(statusStr);
		}
	});
}

// 註冊 Block 的點擊事件：訂位用，限購四個走道不能點擊
function addClickForBooking() {
		$(".spaceblock").click(function() {
			let index = $(this).attr("countNum") - 1;
			statusStr = $("#defaultseat").val();
			let chosenCount = chosenSeatCount(statusStr);
			console.log("**chosenCount = "+ chosenCount);
			console.log("**hasClass seat? = "+ $(this).hasClass("seat"));
			if (chosenCount < 4 && $(this).hasClass("seat")) {
					$(this).removeClass("seat");
					$(this).addClass("chosen");
					$(this).attr("status", "chosen");
					statusStr = replaceCharAtStringIndex(statusStr, index, "*");
					setCurrseatValue(statusStr);
			} else if ($(this).hasClass("chosen")) {
				$(this).removeClass("chosen");
				$(this).addClass("seat");
				$(this).attr("status", "seat");
				statusStr = replaceCharAtStringIndex(statusStr, index, "1");
				setCurrseatValue(statusStr);
			} else {
				alert("每人限購4個座位，請重新選擇");
				$(".spaceblock").removeClass("chosen");
				$(".spaceblock").addClass("seat");
				$(".spaceblock").attr("status", "seat");
				setCurrseatValue(defseat);
			}
		});
	}
// 註冊 Block 的點擊事件：取消座位
function addClickForCancel() {
	$(".spaceblock").click(function() {
		let index = $(this).attr("countNum") - 1;
		if ($(this).hasClass("booked")) {
			$(this).removeClass("booked");
			$(this).addClass("cancelled");
			$(this).attr("status", "cancelled");
			statusStr = replaceCharAtStringIndex(statusStr, index, "*");
			setLodrseatCurrseatValue(statusStr);
		} else if ($(this).hasClass("cancelled")) {
			$(this).removeClass("cancelled");
			$(this).addClass("booked");
			$(this).attr("status", "booked");
			statusStr = replaceCharAtStringIndex(statusStr, index, "2");
			setLodrseatCurrseatValue(statusStr);
		}
	});
}

function replaceCharAtStringIndex(str, index, newChar) {
	let beforeStr = str.substring(0, index);
	let afterStr = str.substring(index + 1);
	let newStr = beforeStr + newChar + afterStr;
	return newStr;
};

//訂位用，toggle座位號碼
function replaceSeatName(str, index, newChar) {
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

// 訂位用，將 input 內寫入剩餘座位字串值
function setCurrseatValue(statusStr) {
	$("#defaultseat").val(statusStr);
	$("#seatCount").text(seatCount(statusStr));
	$("#blockCount").text(totalSeatCount(statusStr));
	let chosenCount = chosenSeatCount(statusStr);
	console.log("chosenCount=" + chosenCount);
	$("#count").val(chosenCount);
	let lecprice = $("#lecprice").val();
	console.log(lecprice);
	let currAmount = chosenCount * lecprice;
	$("#lecamt").val(currAmount);
}

// 修改座位用，將 input 內寫入剩餘座位字串值
function setLodrseatCurrseatValue(statusStr) {
	$("#defaultseat").val(statusStr);
	$("#seatCount").text(seatCount(statusStr));
	$("#blockCount").text(totalSeatCount(statusStr));
	let bookedCount = bookedSeatCount(statusStr);
	$("#count").val(bookedCount);
	let lecprice = $("#lecprice").val();
	let currAmount = bookedCount * lecprice;
	$("#lecamt").val(currAmount);
}

// 將 input 內寫入預設座位字串值(also update fixed seats)
function setBothSeatsValue(statusStr) {
	$("#fixedseat").val(statusStr);
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

// 訂位用，計算剩餘座位
function totalSeatCount(statusStr) {
	let ttlseatCount = 0;
	for (let i = 0; i < statusStr.length; i++) {
		ttlseatCount++;
	}
	return (ttlseatCount);
}

// 訂位用，計算目前選擇座位數量
function chosenSeatCount(statusStr) {
	let chosenCount = 0;
	for (let i = 0; i < statusStr.length; i++) {
		if (statusStr.charAt(i) === "*") {
			chosenCount++;
		}
	}
	return (chosenCount);
}

//修改座位用，計算目前剩餘訂購座位數量
function bookedSeatCount(statusStr) {
	let bookedCount = 0;
	for (let i = 0; i < statusStr.length; i++) {
		if (statusStr.charAt(i) === "2") {
			bookedCount++;
		}
	}
	return (bookedCount);
}
