var tempStorage = {};

$(function() {
	InitPage();

	$('#postalCode').keyup(function() {
		var inpValue = $(this).val();
		var pattern = /^[0-9 a-z A-Z]*$/i
		if (!pattern.test(inpValue)) {
			$(this).val("");
		}
	});
	$('#postalCode').focusout(function() {
		var inpValue = $(this).val();
		var pattern = /^[0-9 a-z A-Z]*$/i
		if (!pattern.test(inpValue)) {
			$(this).val("");
		}
	});
});

function InitPage() {
	tempStorage.PageDetail = {
		SelectedFacadeItem : "",
		FacadeID : "",
		"UserRole" : $('#txtuserRole').val()
	};
	tempStorage.Facade = {
		ItemList : [],
		ItemDefectList : []
	};
	var FacadeID = $('#txtFacadeID').val();
	if (FacadeID != null && FacadeID != "undefined") {
		tempStorage.PageDetail.FacadeID = FacadeID;
	}
	GetFaceDetails();
}

function GetFaceDetails() {
	if (tempStorage.PageDetail.FacadeID == "") {
		return;
	}
	var param = {};
	param.FacadeID = tempStorage.PageDetail.FacadeID;
	param.Action = "Facade";
	$.ajax({
		url : '/InspectionForBuildingFacadeWeb/NewFacadeReportServlet',
		type : "POST",
		data : 'BodyData=' + JSON.stringify(param),
		success : function(response) {
			var objResponse = response;
			console.log(objResponse);
			BindFacadeDetails(objResponse);
		},
		error : function(errorMessage) {
			alert("Ajax error");
		}
	});
}

function BindFacadeDetails(objResponse) {
	tempStorage.Facade = {
		ItemList : [],
		ItemDefectList : []
	};
	// Bind facade detail
	$('#propertyType').val(objResponse["FacadeDetails"]["propertyType"])
	$('#postalCode').val(objResponse["FacadeDetails"]["postalCode"])
	$('#inspectionDate').val(objResponse["FacadeDetails"]["inspectionDate"])
	// Item list
	for (i = 0; i < objResponse.FacadeItemList.length; i++) {
		var objItemDetail = {};
		objItemDetail["Item_Name"] = objResponse.FacadeItemList[i]["facadeName"];
		objItemDetail["Status"] = "U";
		tempStorage.Facade.ItemList.push(objItemDetail);
	}
	// Defect list
	for (i = 0; i < objResponse.FacadeItemDefectList.length; i++) {
		var objDefectDetail = {};
		objDefectDetail["Item_Name"] = objResponse.FacadeItemDefectList[i]["facadeName"];
		objDefectDetail["Defect_Name"] = objResponse.FacadeItemDefectList[i]["defectName"];
		objDefectDetail["Element_Name"] = objResponse.FacadeItemDefectList[i]["element"];
		objDefectDetail["Location"] = objResponse.FacadeItemDefectList[i]["location"];
		objDefectDetail["Risk"] = objResponse.FacadeItemDefectList[i]["risk"];
		objDefectDetail["Status"] = "U";
		tempStorage.Facade.ItemDefectList.push(objDefectDetail);
	}

	BindFacadeItemList();
}

function onclickFacadeItemAdd() {
	var strFacadeItem = $('#facadeName').val();
	var blnItemExist = false;
	for (i = 0; i < tempStorage.Facade.ItemList.length; i++) {
		if (strFacadeItem == tempStorage.Facade.ItemList[i]["Item_Name"]
				&& tempStorage.Facade.ItemList[i]["Status"] != "D") {
			blnItemExist = true;
			break;
		}
	}
	if (blnItemExist == false) {
		var objItemDetail = {};
		objItemDetail.Item_Name = strFacadeItem;
		objItemDetail["Status"] = "N";
		tempStorage.Facade.ItemList.push(objItemDetail);
		BindFacadeItemList();
	}
}

function BindFacadeItemList() {
	var HTML = "No facade item selected";
	if (tempStorage.Facade.ItemList.length > 0) {
		HTML = "<table style='width:500px;'>";
		for (i = 0; i < tempStorage.Facade.ItemList.length; i++) {
			if (tempStorage.Facade.ItemList[i]["Status"] == "D") {
				continue;
			}
			HTML += "<tr style='border:2px solid black'>";
			HTML += "<td style='border:2px solid black'>";
			HTML += tempStorage.Facade.ItemList[i]["Item_Name"];
			HTML += "</td>";
			HTML += "<td style='border:2px solid black;text-align:center;padding:5px;'>";
			HTML += "<button type='button' onclick='onclickEditItem(1," + i
					+ ")'>Defect</button>";
			HTML += "<button type='button' onclick='onclickEditItem(2," + i
					+ ")'>Delete</button>";
			HTML += "</td>";
			HTML += "</tr>";
		}
		HTML += "</table>";
	}
	$('#divFacadeItem').html(HTML);
}

function onclickEditItem(Action, Index) {
	if (Action == 2) {
		if (tempStorage.Facade.ItemList[Index]["Status"] == "N") {
			tempStorage.Facade.ItemList.splice(Index, 1);
		} else {
			tempStorage.Facade.ItemList[Index]["Status"] = "D";
		}
		BindFacadeItemList();
		for (i = 0; i < tempStorage.Facade.ItemDefectList.length; i++) {
			if (tempStorage.Facade.ItemList[Index]["Item_Name"] == tempStorage.Facade.ItemDefectList[i]["Item_Name"]) {
				if (tempStorage.Facade.ItemDefectList[i]["Status"] == "N") {
					tempStorage.Facade.ItemDefectList.splice(i, 1);
				} else {
					tempStorage.Facade.ItemDefectList[i]["Status"] = "D";
				}
			}
		}
	} else {
		tempStorage.PageDetail.SelectedFacadeItem = tempStorage.Facade.ItemList[Index]["Item_Name"];
		BindFacadeItemDefectList();
		$('#mdlDefect').modal('show');
	}
}

function onclickDelectDefect(Index) {
	if (tempStorage.Facade.ItemDefectList[Index]["Status"] == "N") {
		tempStorage.Facade.ItemDefectList.splice(Index, 1);
	} else {
		tempStorage.Facade.ItemDefectList[Index]["Status"] = "D";
	}
	BindFacadeItemDefectList();
}

function onclickFacadeItemDefectAdd() {
	var strFacadeItem = tempStorage.PageDetail.SelectedFacadeItem;
	var strDefect = $('#defectName').val();
	var strElement = $('#element').val();
	var strLocation = $('#location').val();
	var strRisk = $('#risk').val();
	var blnItemDefectExist = false;
	for (i = 0; i < tempStorage.Facade.ItemDefectList.length; i++) {
		if (strFacadeItem == tempStorage.Facade.ItemDefectList[i]["Item_Name"]
				&& strDefect == tempStorage.Facade.ItemDefectList[i]["Defect_Name"]
				&& tempStorage.Facade.ItemDefectList[i]["Status"] != "D") {
			blnItemDefectExist = true;
			break;
		}
	}
	if (blnItemDefectExist == false) {
		var objItemDefectDetail = {};
		objItemDefectDetail.Item_Name = strFacadeItem;
		objItemDefectDetail.Defect_Name = strDefect;
		objItemDefectDetail.Element_Name = strElement;
		objItemDefectDetail.Location = strLocation;
		objItemDefectDetail.Risk = strRisk;
		objItemDefectDetail.Status = "N";
		tempStorage.Facade.ItemDefectList.push(objItemDefectDetail);
		BindFacadeItemDefectList();
	}
}

function BindFacadeItemDefectList() {
	var HTML = "No facade item selected";
	if (tempStorage.Facade.ItemDefectList.length > 0) {
		HTML = "<table style='width:500px;'>";
		for (i = 0; i < tempStorage.Facade.ItemDefectList.length; i++) {
			var ItemDefectList = tempStorage.Facade.ItemDefectList[i];
			if (ItemDefectList["Item_Name"] != tempStorage.PageDetail.SelectedFacadeItem
					|| ItemDefectList["Status"] == "D") {
				continue;
			}
			var Risk = ItemDefectList["Risk"];
			HTML += "<tr style='border:2px solid black'>";
			HTML += "<td style='border:2px solid black'>";
			HTML += ItemDefectList["Item_Name"];
			HTML += "</td>";
			HTML += "<td style='border:2px solid black'>";
			HTML += ItemDefectList["Defect_Name"];
			HTML += "</td>";
			HTML += "<td style='border:2px solid black'>";
			HTML += ItemDefectList["Element_Name"];
			HTML += "</td>";
			HTML += "<td style='border:2px solid black'>";
			HTML += ItemDefectList["Location"];
			HTML += "</td>";
			HTML += "<td style='border:2px solid black'>";
			if (Risk == "N") {
				HTML += "None";
			} else if (Risk == "U") {
				HTML += "Urgent";
			} else if (Risk == "L") {
				HTML += "Low";
			} else if (Risk == "R") {
				HTML += "Risk";
			}
			HTML += "</td>";
			HTML += "<td style='border:2px solid black;text-align:center;padding:5px;'>";
			HTML += "<button type='button' onclick='onclickDelectDefect(" + i
					+ ")'>Delete</button>";
			HTML += "</td>";
			HTML += "</tr>";
		}
		HTML += "</table>";
	}
	$('#divFacadeItemDefect').html(HTML);
}

function onclickSubmit() {
	alert("click triggered");
	var UserRole = tempStorage.PageDetail.UserRole;
	if (UserRole != "CO" && UserRole != "AO") {
		alert("Sorry, you do not have rights to edit this record");
		return;
	}
	if ($('#inspectionDate').val() == "") {
		alert("Inspection date required");
		return;
	}
	var param = {};
	param = tempStorage.Facade;
	param.propertyType = $('#propertyType').val();
	param.postalCode = $('#postalCode').val();
	param.InspectionDate = $('#inspectionDate').val();
	param.FacadeID = tempStorage.PageDetail.FacadeID;
	param.Action = "Submit";
	$.ajax({
		url : '/InspectionForBuildingFacadeWeb/NewFacadeReportServlet',
		type : "POST",
		data : 'BodyData=' + JSON.stringify(param),
		success : function(response) {
			alert("Facade successfully submitted");
			console.log(response);
			InitPage();
		},
		error : function(errorMessage) {
			alert("Ajax error");
		}
	});
}
