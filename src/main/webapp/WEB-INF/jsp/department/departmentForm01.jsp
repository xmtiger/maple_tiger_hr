
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>
        
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
         <form class="well form-horizontal" action=" " method="post"  id="dept_form">
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
                            
                            <input type="text" class="form-control" value="yyyy-mm-dd" name="begin_time" id = "dept_begin_time"/>
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>     
                </div>
                
                <!-- Button -->
                <div class="form-group">
                  <label class="col-md-4 control-label"></label>
                  <div class="col-md-4">
                    <button id="addButton" type="submit" class="btn btn-warning" >Send <span class="glyphicon glyphicon-send"></span></button>
                  </div>
                </div>               
                
                
            </fieldset>
         </form>
        <br>       
        <!-- Result Container  -->
        <div id="resultContainer" style="display: none;">
         <hr/>
         <h4 style="color: green;">JSON Response From Server</h4>
          <pre style="color: green;">
            <code></code>
           </pre>
        </div>
        
        <!-- jQuery first, then Tether, then Bootstrap JS. -->
        <!-- jQuery library -->
        <!--script src="resources/core/js/jquery.min.js"></script-->
        
        <!-- Latest compiled JavaScript -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>
                
        
        <script type="text/javascript">
            $(document).ready(function() {
                /* Submit form using Ajax. Note it does not work to use button.on("click", function(e)) 
                 * it muset be using form.on("submit", function(e) to send ajax request */
                $("#dept_form").on("submit",function(e){
                    
                    /*var v = this.data("bootstrapValidator").validate();
                    if(!v.isValid()){
                        return;
                    }*/
                    
                    e.preventDefault();          
                    
                    //$("#departmentDiv").load("index");                        
                    
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
                        url: "department/create",
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
                    autoclose: true,
                    format: 'yyyy-mm-dd'
                }).on('changeDate', function(e) {
                    // Revalidate the date field
                    //alert("datepicker.on");
                    $('#dept_form').bootstrapValidator('revalidateField', 'date');
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
