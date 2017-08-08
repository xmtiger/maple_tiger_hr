<%@ page session="false" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    
    <script src="/resources/core/js/jquery.min.js"></script>
    <!--jsp:include page="../fragments/header.jsp"/-->
    <body>
    <div class="container">
        
        <c:choose>
            <c:when test="${department['new']}">
                <h1>Add Department</h1>
            </c:when>
                
            <c:otherwise>
                <h1>Update Department</h1>                    
            </c:otherwise>
            
        </c:choose>
        
        <br />
        <spring:url value="/department" var="departmentActionUrl" />

        <form:form class="form-horizontal" method="post" modelAttribute="department" action="${departmentActionUrl}">
            
            <form:hidden path="id" />
            
            <spring:bind path="name">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Name</label>
                    <div class="col-sm-10">
                        <form:input path="name" type="text" class="form-control" id="name" placeholder="Name" />
                        <form:errors path="name" class="control-label" />
                    </div>                
                </div>
            </spring:bind>
            
            <spring:bind path="begin_time">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Begin time</label>
                    <div class="col-sm-10">
                        <form:input path="begin_time" class="form-control" id="begin_time" placeholder="begin_time" />
                        <form:errors path="begin_time" class="control-label" />
                    </div>                
                </div>
            </spring:bind>     
                    
            <spring:bind path="end_time">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">End time</label>
                    <div class="col-sm-10">
                        <form:password path="end_time" class="form-control" id="end_time" placeholder="end_time" />
                        <form:errors path="end_time" class="control-label" />
                    </div>                
                </div>
            </spring:bind>             
            
                    
            <spring:bind path="address">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label class="col-sm-2 control-label">Address</label>
                    <div class="col-sm-10">
                        <form:textarea path="address" class="form-control" id="address" placeholder="address" />
                        <form:errors path="address" class="control-label" />
                    </div>                
                </div>
            </spring:bind>  
            
                        
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <c:choose>
                        <c:when test="${department['new']}">
                            <button id = "new" class="btn-lg btn-primary pull-right">Create</button>
                        </c:when>
                        <c:otherwise>
                            <button id ="update" class="btn-lg btn-primary pull-right">Update</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
                        
        </form:form>
                    
        
    </div>
        
    <!--jsp:include page="../fragments/footer.jsp"/-->         
    <script>
        $(document).ready(function(){
                           
            $("#addButton").click(function(){
                   
                $.ajax({
                    type: "post",
                    url: "department/new", //this is my servlet
                    data: "input=" +$('#ip').val()+"&output="+$('#op').val(),
                    success: function(msg){      
                            $('#output').append(msg);
                    }
                });
                
                $("#departmentDiv").load("department/new");
                   
            });
               
        });    
    </script>
        
    </body>
</html>