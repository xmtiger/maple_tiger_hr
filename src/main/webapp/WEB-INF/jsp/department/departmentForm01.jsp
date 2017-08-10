<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <c:set var="context" value="${pageContext.request.contextPath}"/>
        <!-- Latest compiled and minified CSS -->    
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
        
        <!--link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" /-->
        
        <link rel="stylesheet" href="${context}/resources/bootstrapDatePicker/css/bootstrap-datepicker.min.css"/>
        <link rel="stylesheet" href="${context}/resources/bootstrapDatePicker/css/bootstrap-datepicker3.min.css"/>
        
        <link rel="stylesheet" href="${context}/resources/bootstrapValidator/css/bootstrapValidator.min.css" />
        
        <title>Department Form Page</title>
        
        <style type="text/css">
            #eventForm.form-control-feedback {
                top: 0;
                right: -15px;
            }
            
            span.error{
                color: red;
                margin-left: 5px;
            }
        </style>    
        
    </head>

    <body>
        <!-- disable action and method properties of the following form action=" " method="post"
        Only activate click event and start submit from click function-->
         <form class="well form-horizontal"   id="dept_form">
            <fieldset>

                <!-- Form Name -->
                <legend>DEPARTMENT FORM</legend>

                <!-- Text input-->

                <div class="form-group">
                  <label class="col-md-4 control-label">Name</label>  
                  <div class="col-md-4 inputGroupContainer">
                  <div class="input-group">
                  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                  <input  name="name" placeholder="Name" class="form-control"  type="text" id="dept_name"/>
                    </div>
                  </div>
                </div>

                <!-- Text input-->

                <div class="form-group">
                  <label class="col-md-4 control-label" >Address</label> 
                    <div class="col-md-4 inputGroupContainer">
                    <div class="input-group" >
                  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                  <input name="address" placeholder="Address" class="form-control"  type="text" id="dept_address"/>
                    </div>
                  </div>
                </div>
                
                <!-- time input -->
                <div class="form-group">
                  <label class="col-md-4 control-label" >Begin Date</label> 
                    <!--div class="col-xs-5 date"-->
                    <div class="col-md-4 date">
                        <div class="input-group input-append date" id="datePicker">
                            
                            <input type="text" class="form-control"  name="begin_time" id="dept_begin_time"/>
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>     
                </div>
                
                <!-- Button -->
                <div class="form-group">
                  <label class="col-md-4 control-label"></label>
                  <div class="col-md-4">
                    <button id="addButton" class="btn btn-warning" >Send <span class="glyphicon glyphicon-send"></span></button>
                  </div>
                </div>               
                
                
            </fieldset>
         </form>
        <br>       
        <!-- Result Container  -->
        <br>
        <div id="resultContainer_click" style="display: none;">
         <hr/>
         <h4 style="color: green;">Submit function Response and JSON Response From Server</h4>
          <pre style="color: green;">
            <code></code>
           </pre>
        </div>
        <br>
        <div id="resultContainer" style="display: none;">
         <hr/>
         <h4 style="color: green;">Click function result</h4>
          <pre style="color: green;">
            <code></code>
           </pre>
        </div>
        
        
        <!-- jQuery first, then Tether, then Bootstrap JS. -->
        <!-- jQuery library -->
        <script src="${context}/resources/core/js/jquery.min.js"></script>
        
        <!-- Latest compiled JavaScript -->      
        
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
        <!--script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script-->
        <script src="${context}/resources/bootstrapDatePicker/js/bootstrap-datepicker.min.js"></script>
        
        <!--script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script-->        
        <script src= "${context}/resources/bootstrapValidator/js/bootstrapValidator.min.js"> </script>        
        
        <script type="text/javascript">
            $(document).ready(function() {
                
                var ctx ="${pageContext.request.contextPath}"; 
                
                
                $("#addButton").on("click",function(e){
                    e.preventDefault();
                    
                    $('#resultContainer_click').text(ctx);
                    $('#resultContainer_click').show();
                    
                    var bootstrapValidator = $("#dept_form").data('bootstrapValidator');
                    bootstrapValidator.validate();
                    if(bootstrapValidator.isValid()){
                        $('#resultContainer_click').text("validation is passed in click function");
                        $('#resultContainer_click').show();
                        
                        $("#dept_form").submit();
                    } else{
                        $('#resultContainer_click').text("validation is not passed in click function");
                        $('#resultContainer_click').show();
                        
                        return;
                    } 
                        
                });
                
                /* Submit form using Ajax. Note it does not work to use button.on("click", function(e)) 
                 * it muset be using form.on("submit", function(e) to send ajax request */
                $("#dept_form").on("submit",function(e){
                    
                    e.preventDefault();          
                                       
                    var bootstrapValidator = $("#dept_form").data('bootstrapValidator');
                    bootstrapValidator.validate();
                    if(bootstrapValidator.isValid()){
                        $('#resultContainer').text("validation is passed in sumbit function");
                        $('#resultContainer').show();                        
                       
                    } else{
                        $('#resultContainer').text("validation is not passed in submit function");
                        $('#resultContainer').show();
                        
                        return;
                    }
                    //$("#departmentDiv").load("index");                        
                    var url_address = ctx + "/department/create";
                    
                    var form = $('#dept_form');
                    
                    /*The following conversion is necessary to send server the correct json data*/
                    var jsonData = {};
                    $.each($(form).serializeArray(), function() {
                        jsonData[this.name] = this.value;
                    });
                    var form_data = JSON.stringify(jsonData);
                                               
                    // Use Ajax to submit form data
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: url_address,
                        data: form_data,
                        dataType: "json",                                                                         
                        
                        success: function(res){
                            //alert("success");
                            if(res.validated){
                                
                                $('#resultContainer').text(JSON.stringify(res.department));
                                $('#resultContainer').show();
                            }else{
                                //Set error messages
                                $.each(res.errorMessages,function(key,value){
                                    $('input[name='+key+']').after('<span class="error">'+value+'</span>');
                                });
                            }
                        }
                    });
                });
                
                $("#datePicker").datepicker({
                    autoclose: false,
                    format: 'yyyy-mm-dd'
                    
                }).on('changeDate', function(e) {
                    // Revalidate the date field
                    //alert("datepicker.on");
                    $('#dept_form').bootstrapValidator('revalidateField', 'begin_time');
                });
                    
                $('#dept_form').bootstrapValidator({
                    // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
                    framework: "bootstrap",
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        name: {
                            row: '.col-xs-4',
                            validators: {
                                    stringLength: {
                                    min: 2,
                                    message: 'The minimum length is 2'
                                },
                                    notEmpty: {
                                    message: 'Please input a name'
                                }
                            }
                        },
                        address: {
                            validators: {
                                 stringLength: {
                                    min: 2,
                                    message: 'The minimum length is 2'
                                },
                                notEmpty: {
                                    message: 'Please input an address'
                                }
                            }
                        },
                        begin_time: {
                            validators: {
                                date: {
                                    format: 'YYYY-MM-DD',
                                    message: 'The value is not a valid date'
                                },
                                notEmpty: {
                                    message: 'Please input or pick a date'
                                }
                            }
                        }
                    }
                });                
                /*.on('submit', function(e) {
                    
                    //alert("success");
                    //Prevent default submission of form
                    e.preventDefault();          
                    
                    //$("#departmentDiv").load("index");                        
                    
                    var form = $('#dept_form');
                    //var arrayData = $(form).serializeArray();
                    //var form_data2 = JSON.stringify(arrayData);
                    
                    var jsonData = {};
                    $.each($(form).serializeArray(), function() {
                        jsonData[this.name] = this.value;
                    });
                    var form_data = JSON.stringify(jsonData);
                                               
                    // Use Ajax to submit form data
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "department/create",
                        data: form_data,
                        dataType: "json",                                                                         
                        
                        success: function(res){
                            
                            if(res.validated){
                                $('#resultContainer').text(JSON.stringify(res.department));
                                $('#resultContainer').show();
                            }else{
                                //Set error messages
                                $.each(res.errorMessages,function(key,value){
                                        $('input[name='+key+']').after('<span class="error">'+value+'</span>');
                                });
                            }
                        }
                    });
                    
                }); */       
                
            });
    
        </script>
        
    </body>
  
</html>
