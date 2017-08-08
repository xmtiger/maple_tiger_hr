
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />
        
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
         <form class="well form-horizontal" action=" " method="post"  id="contact_form">
            <fieldset>

                <!-- Form Name -->
                <legend>DEPARTMENT FORM</legend>

                <!-- Text input-->

                <div class="form-group">
                  <label class="col-md-4 control-label">Name</label>  
                  <div class="col-md-4 inputGroupContainer">
                  <div class="input-group">
                  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                  <input  name="name" placeholder="Name" class="form-control"  type="text">
                    </div>
                  </div>
                </div>

                <!-- Text input-->

                <div class="form-group">
                  <label class="col-md-4 control-label" >Address</label> 
                    <div class="col-md-4 inputGroupContainer">
                    <div class="input-group" >
                  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                  <input name="address" placeholder="Address" class="form-control"  type="text">
                    </div>
                  </div>
                </div>
                
                <!-- time input -->
                <div class="form-group">
                  <label class="col-md-4 control-label" >Begin Date</label> 
                    <div class="col-xs-5 date">
                        <div class="input-group input-append date" id="datePicker">
                            
                            <input type="text" class="form-control" value="yyyy-mm-dd" name="date" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>     
                </div>
                
                <!-- Button -->
                <div class="form-group">
                  <label class="col-md-4 control-label"></label>
                  <div class="col-md-4">
                    <button type="submit" class="btn btn-warning" >Send <span class="glyphicon glyphicon-send"></span></button>
                  </div>
                </div>               
                
                
            </fieldset>
         </form>
        <br>

        <!--div class="container">
            <h2>Department Form</h2>
            <form id="eventForm" action="saveDepartment" method="post" name="departmentForm">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" class="form-control" id="name" placeholder="Enter name" name="name">
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" class="form-control" id="address" placeholder="Enter address" name="address">
                </div>
                
                
                <div class="form-group">
                    <label class="col-md-4 control-label" >Begin Date</label>
                    <div class="col-xs-5 date">
                        <div class="input-group input-append date" id="datePicker2">
                            
                            <input type="text" class="form-control" value="yyyy-mm-dd" name="date" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>
                </div>
                <br>
                <br>
              <button type="submit" class="btn btn-default" id="addButton">Submit</button>
            </form>
            
        </div-->
        
        <!-- jQuery first, then Tether, then Bootstrap JS. -->
        <!-- jQuery library -->
        
        <script type="text/javascript" src="resources/core/js/jquery-3.2.1.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>
                
        <!--script src="/resources/core/js/jquery.js"></script>
        <script src="https://cdn.jsdelivr.net/jquery.validation/1.17.0/jquery.validate.js"></script-->
        <script type="text/javascript">
            $(document).ready(function() {
                /* Submit form using Ajax  */
                $("#addButton").click(function(){
                    
                });
                
                $("#datePicker").datepicker({
                    autoclose: true,
                    format: 'yyyy-mm-dd'
                }).on('changeDate', function(e) {
                    // Revalidate the date field
                    //alert("datepicker.on");
                    //$('#eventForm').formValidation('revalidateField', 'date');
                });
                    
                $('#contact_form').bootstrapValidator({
                    // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        name: {
                            validators: {
                                    stringLength: {
                                    min: 2,
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
                                },
                                notEmpty: {
                                    message: 'Please input an address'
                                }
                            }
                        }
                    }
                })                
                .on('success.form.bv', function(e) {
                    //$('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
                    alert("success function");
                    $('#contact_form').data('bootstrapValidator').resetForm();

                    // Prevent form submission
                    e.preventDefault();

                    // Get the form instance
                    var $form = $(e.target);

                    // Get the BootstrapValidator instance
                    var bv = $form.data('bootstrapValidator');

                    // Use Ajax to submit form data
                    $.post($form.attr('action'), $form.serialize(), function(result) {
                        console.log(result);
                    }, 'json');
                });               
                
            });
    
        </script>
        
    </body>
  
</html>
