<!DOCTYPE HTML><%@page
	import="com.inspectionForBuildingFacade.model.StaffRegistration"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>NewFacadeReport</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Plugin/Boostrap.css">
<script src="Plugin/jQuery.js"></script>
<script src="Plugin/bootstrap.js"></script>
<script src="Script/EditFacadeReport.js"></script>
</head>
<body>
	<div align="center">
		<input type="hidden" id="txtuserRole" value="${userRole}" /> <input
			type="hidden" id="txtFacadeID" value="${FacadeID}" />
		<button type="button" onclick="GetFaceDetails()">GetFaceDetails</button>
		<h1>New Facade Report</h1>
		<form id="form" action="<%=request.getContextPath()%>/" method="post">
			<table style="with: 80%">

				<tr>
					<td>Property Type</td>
					<td><select name="propertyType" id="propertyType">
							<option value="01">Residential</option>
							<option value="02">Commercial</option>
							<option value="03">Market</option>
							<option value="04">Pavilion</option>
							<option value="05">ESS</option>
					</select></td>

				</tr>
				<tr>
					<td>Postal Code</td>
					<td><input type="number" id="postalCode" name="postalCode"
						maxlength="6" /></td>
				</tr>
				<tr>
					<td>Inspection Date</td>
					<td><input type="date" id="inspectionDate"
						name="inspectionDate" /></td>
				</tr>
				<tr>
					<td>Facade Item</td>
					<td><select name="facadeName" id="facadeName">
							<c:forEach items="${facadeNameList}" var="facadename">
								<option value="${facadename}"><c:out
										value="${facadename}" /></option>
							</c:forEach>
					</select></td>
					<td><button type="button" onclick="onclickFacadeItemAdd()">Add</button></td>
				</tr>
			</table>
			<div id="divFacadeItem" style="padding-top: 50px;">No facade
				item selected</div>
			<button type="button" style="margin-top: 50px;"
				onclick="onclickSubmit()">Submit</button>
			<!-- Modal -->
			<div id="mdlDefect" class="modal fade" role="dialog">
				 
				<div class="modal-dialog">
					   
					<!-- Modal content-->
					   
					<div class="modal-content">
						     
						<div class="modal-header">
							       
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							       
							<h4 class="modal-title">Add facade item defect</h4>
							     
						</div>
						     
						<div class="modal-body">
							 
							<table>
								<tr>
									<td>Defect Item</td>
									<td><select name="defectName" id="defectName">
											<c:forEach items="${defectNameList}" var="defectname">
												<option value="${defectname}"><c:out
														value="${defectname}" /></option>
											</c:forEach>
									</select></td>

								</tr>

								<tr>
									<td>Element</td>
									<td><select name="element" id="element">
											<c:forEach items="${elementList}" var="elementName">
												<option value="${elementName}"><c:out
														value="${elementName}" /></option>
											</c:forEach>
									</select></td>

								</tr>

								<tr>
									<td>Location</td>
									<td><select name="location" id="location">
											<c:forEach items="${locationList}" var="locationName">
												<option value="${locationName}"><c:out
														value="${locationName}" /></option>
											</c:forEach>
									</select></td>

								</tr>

								<tr>
									<td>Risk</td>
									<td><select name="risk" id="risk">
											<option value="U">Urgent</option>
											<option value="R">Risk</option>
											<option value="L">Low</option>
											<option value="N">None</option>

									</select></td>

								</tr>
								<tr>
									<td><button type="button"
											onclick="onclickFacadeItemDefectAdd()">Add</button></td>
								</tr>
							</table>
							<div id="divFacadeItemDefect" style="padding-top: 50px;">No
								facade item defect selected</div>
						</div>
						     
						<div class="modal-footer">
							   
							<button type="button" data-dismiss="modal">Close</button>
							     
						</div>
						   
					</div>
					 
				</div>
			</div>
		</form>
	</div>
</body>
</html>
