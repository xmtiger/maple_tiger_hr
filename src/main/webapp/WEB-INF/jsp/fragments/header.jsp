<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<title>mapletiger_HR_System</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">








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