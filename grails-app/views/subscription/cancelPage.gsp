<!DOCTYPE html >
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Roll Delivered: Simple Hassle Free Toilet Paper Subscription</title>
   <link rel="shortcut icon" href="https://s3.amazonaws.com/rolldelivered-static/images/favicon.ico.png" type="image/x-icon" />
  <link href="https://s3.amazonaws.com/rolldelivered-static/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://s3.amazonaws.com/rolldelivered-static/css/styles.css" type="text/css" />
  <link rel="stylesheet" href="https://s3.amazonaws.com/rolldelivered-static/css/eco.css" type="text/css" />
  <link href='https://fonts.googleapis.com/css?family=Droid+Sans:regular,bold' rel='stylesheet' type='text/css' />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="https://s3.amazonaws.com/rolldelivered-static/js/bootstrap.min.js"></script>


  <script src="https://s3.amazonaws.com/rolldelivered-static/js/spin.min.js"></script>

  <script type="text/javascript">

  $(document).ready(function() {

      $("#cancel-form").submit(function(event) {
          $('#cancel-confirm-button').attr("disabled", "disabled");
         window.spinnertarget = document.getElementById('spinnerContainer');
          window.spinner = new Spinner();
          $("#successMessage").hide("slow");
          $("#errorMessage").hide("slow");


          $.ajax({
                    url: '/subscription/cancel/confirm',
                    type: 'post',
                    data: { cancelLink:'${cancelLink}' },
                    cache: false,
                    success: function(){
                      window.spinner.stop();
                        $("#successMessage").show("slow")
                      $("#cancel-confirm-button").removeAttr("disabled");
                                         },
                    error: function(){
                        $("#errorMessage").show("slow");
                    }
           });

//          $("cancel-confirm-button").removeAttr("disabled");
          return false;

            });

  });
  </script>


<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34220335-1']);
  _gaq.push(['_setDomainName', 'rolldelivered.com']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>


  </head>
  <body>
    <div id="fixed_header">
      <div id="header">
        <div id="logo"><a href="#home_page" class="slide_link">Roll Delivered - Hassle-Free Toilet Paper Delivery</a>
        </div>

      </div>
    </div>
    <!--end header-->
    <div id="home_page"></div>
    <div id="bg_top">
      <div id="wrapper">



  <!--buy now box-->
  <div class="main_box_wrapper" id="buy_now">
    <div class="main_box_background"> <!-- start box background -->
      <div class="main_box" style="min-height: 276px;">
        <div class="content">
          %{--<div class="two_column_wrapper">--}%

              <g:if test="${error}">
                  Hmm sorry we couldn't find the account referenced. If you think this is an error please email us at <a href="mailto:support@rolldelivered.com">support@rolldelivered.com</a>
              </g:if>
            <g:else>
                <h2 style="font-weight:bold">Confirm cancellation of account :${email}</h2>

              <div class="span10 columns">
                <fieldset>

                  <g:form url="/subscription/cancel/confirm" id="cancel-form" class="form-horizontal">
                  <div class="clearfix control-group">
                   <span style="float:left"> By cancelling you'll no longer be enrolled and will not be charged.</span>

                  <div class="actions" style="clear:none;margin-top: 30px;">
                      <span><button type="submit" id=cancel-confirm-button" class="btn-warning submit_button" ">I understand I'm complicating my life. Unroll me!</button>
                      <div id="spinnerContainer" style="float:right; width:65%; margin-top:16px"></div>
                      <span>
                  </div>
                  </g:form>


                <br>
                <div class="alert alert-success" style="display:none; width:250px;" id="successMessage">We've deactivated your account and emailed you a confirmation. </div>
                <div class="alert alert-error" id="errorMessage" class="alert alert-error" style="display:none;">Hmm something went wrong on our end. Please try again or contact support at support@rolldelivered.com.</p> </div>

                </div>
            </fieldset>
          </div>


            </g:else>


        <div class="clear"></div>

    </div>
  </div>
  <!-- end main box background --> </div>
</div>

              </body>
              </html>
