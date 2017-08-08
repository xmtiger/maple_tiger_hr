<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
<title>mapletiger_HR_System</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="/resources/core/js/jquery.min.js"></script>

<spring:url value="/resources/core/js/bootstrap.min.js" var="bootstrapJs"></spring:url>


<link href="${bootstrapCss}" rel="stylesheet" />

</head>

<spring:url value="/" var="urlHome" />
<spring:url value="/departments/add" var="urlAddDepartment" />

<nav class="navbar navbar-inverse ">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="${urlHome}">Home Page</a>
		</div>
		<div id="navbar">
			<ul class="nav navbar-nav navbar-right">
				<li class="active"><a href="${urlAddDepartment}">Add Department</a></li>
			</ul>
		</div>
	</div>
</nav>