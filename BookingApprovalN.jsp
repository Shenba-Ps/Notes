<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>BookingApproval</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Plugins/Boostrap.css">
<link rel="stylesheet" href="Plugins/jquery.dataTables.css">
<link rel="stylesheet" href="Script/Common.css">
<script src="Plugins/jQuery.js"></script>
<script src="Plugins/bootstrap.js"></script>
<script src="Script/BookingApproval.js"></script>
<script src="Plugins/jquery.dataTables.js"></script>
<style type="text/css">
#item-list {
	display: none;
	margin-top: 10px;
	padding: 0;
	list-style-type: none;
}

#item-list li {
	margin-bottom: 5px;
}

.paginationButton {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
}
</style>
</head>
<body>
		<form  method="post">
	<div style="height: 97vh;">
		<div class="Title form-group">Please approve or Reject the
			booking</div>


		<div>

			<table id="myTable">
				<tbody>

				</tbody>
			</table>

		</div>
		<div style="display: inline-block;" id="paginationButtonId"></div>
		<a href="HomePage.jsp"> Back</a>
		<table id="tblList" class="display">
			<thead>
				<tr class="ListHeaderRow">
					<th class="ListHeaderCol" style="width: 50px;">Application.NO</th>
					<th class="ListHeaderCol">Name</th>
					<th class="ListHeaderCol">Address</th>
					<th class="ListHeaderCol">Nric</th>
					<th class="ListHeaderCol">Usage Trade</th>
					<th class="ListHeaderCol">Email</th>
					<th class="ListHeaderCol">Hand Phone</th>
					<th class="ListHeaderCol">Office</th>
					<th class="ListHeaderCol">Home</th>
					<th class="ListHeaderCol">Booking Date</th>
					<th class="ListHeaderCol">Booking Slots</th>
					<th class="ListHeaderCol">Reason for rejection</th>
					<th class="ListHeaderCol">Action</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="bookingList" items="${pendingStatusList}"
					varStatus="counter">

					<tr class="ListBodyRow">


						<td class="ListBodyCol" style="width: 200px"><a
							class="btn btn-error form-group"
							href="detailedView?applicationNumber=<c:out value='${bookingList.applicationNumber}' />"><c:out
									value="${bookingList.applicationNumber}" /></a>&nbsp;&nbsp;&nbsp;&nbsp;


						
						<td class="ListBodyCol"><c:out value="${bookingList.name}" /></td>
						<td class="ListBodyCol"><c:out value="${bookingList.address}" /></td>
						<td class="ListBodyCol"><c:out
								value="${bookingList.nricNumber}" /></td>
						<td class="ListBodyCol"><c:out
								value="${bookingList.usageTrade}" /></td>
						<td class="ListBodyCol"><c:out value="${bookingList.email}" /></td>
						<td class="ListBodyCol"><c:out
								value="${bookingList.homePhoneNumber}" /></td>
						<td class="ListBodyCol"><c:out
								value="${bookingList.officePhoneNumber}" /></td>
						<td class="ListBodyCol"><c:out
								value="${bookingList.handPhoneNumber}" /></td>
						<td class="ListBodyCol"><c:out
								value="${bookingList.bookingDate}" /></td>
						<td class="ListBodyCol"><c:out
								value="${bookingList.slectedSlots}" /></td>
								
								<td class="ListBodyCol" > <textarea  name="nmReason"> </textarea></td>

						<td class="ListBodyCol">
					<%-- 		<button type="button" class="btn btn-error form-group"
								 onclick="OpenComments()">Reject</button> --%>
								 <a
							class="btn btn-error form-group"
							href="approval?applicationNumber=<c:out value='${bookingList.applicationNumber}' />">Approve</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="reject?applicationNumber=<c:out value='${bookingList.applicationNumber}' />">Reject</a>




						
					</tr>





					<%--For displaying Page numbers. The when condition does not display
              a link for the current page--%>



					<%--For displaying Next link --%>


					</div>
					<!-- Modal -->
					<div class="modal fade" data-backdrop="static" id="mdlAck"
						role="dialog">
						<div class="modal-dialog" style="width: 70%;">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-body">
									<div class="row form-group">
										<div class="col-xs-3 RightAlign">
											<label>Comments</label>
										</div>
										<div class="col-xs-6">
											<input class="form-control" type="text" id="idComments"
												name="nmComments">
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<%-- 	<button type="button" class="btn btn-primary"
							onclick="onclickReject()">Reject</button> --%>
									<%-- 		<button type="submit" class="btn btn-primary" id="btnReject"
							style="display: none;"
							formaction="<%=request.getContextPath()%>/reject?applicationNumber"></button>--%>
									<%-- 		<input type="hidden" id="appInput" name="reject" value='${bookingList.applicationNumber}'>
							<input type="submit" value='Reject' class="btn btn-primary form-group"
									formaction="<%=request.getContextPath()%>/reject"> --%>
									<a
										href="reject?applicationNumber=<c:out value='${bookingList.applicationNumber}' />">Reject</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>



			</tbody>
		</table>
	</div>





	<script>
	$(function() {
		let table = new DataTable('#tblList', {
		    //config options...
		});
	});
	</script>
	<script>
		$(document)
				.ready(
						function() {
							var objValue = '${pendingStatusList}';
							alert(objValue.name);

							var currentPage = 1;
							var totalPage = objValue.length;
							function changePage(val) {
								currentPage = val;
								$('#paginationList').empty();
								for (var i = (currentPage - 1) * 5; i < currentPage * 5; i++) {

									$("#paginationList").append(
											'<li><button class="listLi">'
													+ (i + 1)
													+ '</button></li>');
								}
							}
							var lastPagination = currentPage + 3 <= totalPage ? currentPage + 3
									: totalPage;
							for (var i = currentPage <= 3 ? 1 : currentPage - 3; i <= lastPagination; i++) {

								$('#paginationButtonId')
										.append(
												'<div class="paginationButton" ><button type="button" value="'
														+ i
														+ '" onclick="changePage(this.value)">'
														+ i + '</button></div>');
							}
							$("#myTable tr").remove();
							for (var i = (currentPage - 1) * 5; i < totalPage; i++) {
								$('#myTable tr:last').after('<tr class="ListBodyRow"><td class="ListBodyCol" style="width: 200px;">objValue.applicationNumber</td><td class="ListBodyCol">'+objValue.name+'</td><td class="ListBodyCol">'+objValue.address+'</td><td class="ListBodyCol">'+objValue.nricNumber+'</td><td class="ListBodyCol">'+objValue.usageTrade+'</td><td class="ListBodyCol">'+objValue.email+'</td><td class="ListBodyCol">'+objValue.homePhoneNumber+'</td><td class="ListBodyCol">'+objValue.officePhoneNumber+'</td><td class="ListBodyCol">'+objValue.handPhoneNumber+'</td><td class="ListBodyCol">'+objValue.bookingDate+'</td><td class="ListBodyCol">'+objValue.slectedSlots+'</td>'+
+'<td class="ListBodyCol"><button type="button" class="btn btn-error form-group"'+' onclick="OpenComments()">Reject</button>	<button type="submit" class="btn btn-primary form-group"'+' formaction="'+<%=request.getContextPath()%>
		+ '/approval"	'
														+ '	href="approval?applicationNumber='
														+ objValue.applicationNumber
														+ '">Approval</button>	'
														+ '<input type="hidden" id="hdnRefNo" name="hdnRefNo"	value="'+objValue.applicationNumber+'"></input></td>						</tr>');
								$("#paginationList").append(
										'<li><button class="listLi">'
												+ objValue[i].name
												+ '</button></li>');
								if (i >= currentPage * 5) {
									break;
								}
							}
						});
	</script>

</form>
</body>
</html>
