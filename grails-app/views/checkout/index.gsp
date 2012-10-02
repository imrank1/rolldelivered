<!DOCTYPE html >
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Roll Delivered: Simple Hassle Free Toilet Paper Subscription</title>
   <link rel="shortcut icon" href="https://s3.amazonaws.com/rolldelivered-static/images/favicon.ico.png" type="image/x-icon" />
    <link rel="stylesheet" href="https://s3.amazonaws.com/rolldelivered-static/css/styles.css" type="text/css" />
  <link href="https://s3.amazonaws.com/rolldelivered-static/css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="https://s3.amazonaws.com/rolldelivered-static/css/eco.css" type="text/css" />
  <link href='https://fonts.googleapis.com/css?family=Droid+Sans:regular,bold' rel='stylesheet' type='text/css' />
  <!-- star rating css -->
  <script type="text/javascript" src="https://s3.amazonaws.com/rolldelivered-static/js/jquery-1.4.3.min.js"></script>
  <script src="https://s3.amazonaws.com/rolldelivered-static/js/jquery.validate.min.js"></script>

  <script src="https://s3.amazonaws.com/rolldelivered-static/js/spin.min.js"></script>


  

  <script type="text/javascript" src="https://js.stripe.com/v1/"></script>

  <script type="text/javascript">
  $(document).ready(function() {

    $('#payment-form').validate(
    {
      rules: {
        firstName: {
          minlength: 2,
          required: true
        },
        lastName: {                                            PO
          minlength: 2,
          required:true
        },
        email: {
          required: 2,
          email: true
        },
        address1: {
         required: true,
         minlength:2
       },
       city: {
         required: true,
         minlength: 2
       },
       zip: {
         required: true,
         minlength: 5
       }

     },
     highlight: function(label) {
      $(label).closest('.control-group').addClass('error');

    },
    success: function(label) {
      label
      .text('OK!').addClass('valid')
      .closest('.control-group').addClass('success');

    }
  });
  });

  </script>

  <script type="text/javascript">
  Stripe.setPublishableKey('pk_07vkuRVmBagGqY4VbFQ7y345CbbNN');

  $(document).ready(function() {
      window.spinnertarget = document.getElementById('spinnerContainer');
      window.spinner = new Spinner();
    $("#payment-form").submit(function(event) {
      $('.submit-button').attr("disabled", "disabled");
      if($("#payment-form").valid()){
      window.spinner.spin();
      window.spinnertarget.appendChild(spinner.el);

      $("#paymentErrorMessage").hide("slow");
      $("#errorMessage").hide("slow");
      $("#successMessage").hide("slow");
        // disable the submit button to prevent repeated clicks
        Stripe.createToken({
          number: $('.card-number').val(),
          cvc: $('.card-cvc').val(),
          exp_month: $('.card-expiry-month').val(),
          exp_year: $('.card-expiry-year').val()
        }, stripeResponseHandler);
        // prevent the form from submitting with the default action
        return false;
    }
      });
  });
  </script>






  <script type="text/javascript">

  function stripeResponseHandler(status, response) {
    if (response.error) {
        window.spinner.stop();

        // show the errors on the form
        $("#paymentErrorMessage").show("slow");
        $(".submit-button").removeAttr("disabled");
      } else {
        var form$ = $("#payment-form");
        var token = response['id'];

        var fName = $('#firstName').val();
        var lName = $('#lastName').val();
        var address1 = $('#address1').val();
        var address2 = $('#address2').val();
        var city = $('#city').val();
        var zip = $('#zip').val();


        var e = $('#email').val();
        $.ajax({
          url: 'checkout/charge',
          type: 'post',
          data: { firstName: fName,lastName:lName,email:e,stripeToken:token,address1:address1,address2:address2,city:city,zip:zip },
          cache: false,
          success: function(){
            window.spinner.stop();
            $("#successMessage").show("slow");
            $(".submit-button").removeAttr("disabled");
            $("#payment-form").find('input:text, input:password, input:file, select, textarea').val('');
            $("#payment-form").find('input:radio, input:checkbox').removeAttr('checked').removeAttr('selected');          },
          error: function(){
            $("#errorMessage").show("slow");
          }
        });
        $(".submit-button").removeAttr("disabled");
        return false;
      }
    }
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
        <div id="menu">
          <ul id="navigation">
            <li><a href="#home_page" class="slide_link">Home</a></li>
            <li><a href="#buy_now" class="slide_link">Buy Now</a></li>
            <li><a href="#support" class="slide_link">Support</a></li>
            <li><a href="#about" class="slide_link">About</a></li>
          </ul>
        </div>
      </div>
    </div>
    <!--end header-->
    <div id="home_page"></div>
    <div id="bg_top">
      <div id="wrapper">
        <div class="main_box_wrapper" id="home_pag" style="padding-top:0;">
          <div class="main_box_background"> <!-- start box background -->

            <div class="main_box" id="section1">

      <div class="home_box">
        <div class="text">
          <h1>Welcome to Roll Delivered</h1>
          <h2 style="font-weight:bold">We deliver premium toilet paper to you monthly for $8.99. Simple.</h2>
          <h3>One Step to Signup. One Step to Cancel.<br> No Hassles.</h3>
          <ul class="numbered_list">
            <li><span>1</span>No more runs to the store.</li>
            <li><span>2</span>Never carry bulky packs of toilet paper in public again.</li>
            <li><span>3</span>Automatic monthly delivery. Defer a month with One Click.</li>
          </ul>
          <ul class="buttons_float" style="margin-top: -15px;">
            <li>
              <a href="#support" class="slide_link"><div class="ml-btn-13">F.A.Q.</div></a>
            </li>
            <li>
              <a href="#buy_now" class="slide_link"><div class="ml-btn-13">Buy Now</div></a>
            </li>
          </ul>
        </div>
        <!--end left-->
        <div class="home_right">
          <div class="star">new</div>
          <img src="https://s3.amazonaws.com/rolldelivered-static/images/home_image.png" width="400" height="430" alt="product" /></div>
          <!--end home right-->
        </div>
      </div>
      <!--end home box-->
    </div>
    <!-- end main box background -->
  </div>


  <!--buy now box-->
  <div class="main_box_wrapper" id="buy_now">
    <div class="main_box_background"> <!-- start box background -->
      <div class="main_box">
        <div class="content">
          <div class="two_column_wrapper">
            <div class="side_left">

              <!--side box-->
              <div class="side_box">
                <div class="top"></div>
                <div class="content_middle" align="middle">
                  <img src="https://s3.amazonaws.com/rolldelivered-static/images/eco/price_box.png" alt="$8.99 shipping and tax included" />
                  <p>Thats $0.004 per sheet.</p>
                  <div class="clear"></div>
                </div>
                <div class="bottom"></div>
              </div>
              <!--end side box-->
              <!--side box-->
              <div class="side_box">
                <div class="top"></div>
                <div class="content_middle" align="middle">
                  <img src="https://s3.amazonaws.com/rolldelivered-static/images/premium_quality2.png" alt="Satisfaction Guaranteed"/>
                  <p>Satisfaction Guaranteed</p>
                  <div class="clear"></div>
                </div>
                <div class="bottom"></div>
              </div>
              <!--end side box-->
	      <!--side box-->
              <div class="side_box">
                <div class="top"></div>
                <div class="content_middle" align="center">
                  <a href="https://www.stripe.com"><img src="https://s3.amazonaws.com/rolldelivered-static/images/card-info.png" alt="Secure Payments"></a>
                  <div class="clear"></div>
                </div>
                <div class="bottom"></div>
              </div>
              <!--end side box-->

            </div>	
            <div class="content_right">
              <div class="box_title"> Get Roll Delivered. Simplify Your Life. </div>
              <p><img src="https://s3.amazonaws.com/rolldelivered-static/images/formheader.png" style="margin-top:0px;"/></p>
              <p>Enter your details to order and Simplify Your Life.</p>
              <div class="span6 columns">
                <fieldset>

                  <g:form url="checkout/charge" id="payment-form" useToken="true" class="form-horizontal">
                  <div class="clearfix control-group">
                    <label class="control-label" style="text-align:left" for="firstName">First Name</label>
                    <div class="input">
                      <input class="field" id="firstName" name="firstName" size="30" type="text" />
                    </div>
                  </div>

                  <div class="clearfix control-group">
                   <label class="control-label" style="text-align:left" for="lastName">Last Name</label>
                   <div class="input">
                     <input class="field" id="lastName" name="lastName" size="30" type="text" />
                   </div>
                 </div>




                 <div class="clearfix control-group">
                  <label class="control-label" style="text-align:left" for="email">Email</label>
                  <div class="input">
                    <input class="field" id="email" name="email" size="30" type="text" />
                  </div>
                </div>

                <div class="clearfix">
                </div>

                <div class="clearfix">


                  <input id="stripeToken" name="stripeToken" type="hidden" />
                </div>


                <noscript>
                  <p>This form requires Javascript to use</p>
                </noscript>

                <div id="credit-card" style="display:block">
                  <div id="credit-card-errors" style="display:none">
                    <div id="stripe-error-message" class="alert-message block-message error">
                    </div>
                  </div>

                  <div class="clearfix control-group">
                    <label class="control-label" style="text-align:left" for="creditCardNumber">Credit Card Number</label>
                      <div class="input">
                        <input class="field card-number"  type="text" />
                      </div>
                    </div>

                    <div class="clearfix control-group">
                      <label class="control-label" style="text-align:left" for="cvv">Security code (CVV)</label>
                      <div class="input">
                        <input class="input-small card-cvc"  id="cvv" type="text" />
                      </div>
                    </div>

                    <div class="clearfix control-group">
                      <label class="control-label" style="text-align:left" for="card-expiry-month">Expiry Date</label>
                      <div class="input">
                        <select class="input-small card-expiry-month">
                          <option value="1">1</option>
                          <option value="2">2</option>
                          <option value="3">3</option>
                          <option value="4">4</option>
                          <option value="5">5</option>
                          <option value="6">6</option>
                          <option value="7">7</option>
                          <option value="8">8</option>
                          <option selected="selected" value="9">9</option>
                          <option value="10">10</option>
                          <option value="11">11</option>
                          <option value="12">12</option>
                        </select>
                        <select class="input-small card-expiry-year">
                          <option selected="selected" value="2012">2012</option>
                          <option value="2013">2013</option>
                          <option value="2014">2014</option>
                          <option value="2015">2015</option>
                          <option value="2016">2016</option>
                          <option value="2017">2017</option>
                          <option value="2018">2018</option>
                          <option value="2019">2019</option>
                          <option value="2020">2020</option>
                          <option value="2021">2021</option>
                          <option value="2022">2022</option>
                          <option value="2023">2023</option>
                          <option value="2024">2024</option>
                          <option value="2025">2025</option>
                          <option value="2026">2026</option>
                          <option value="2027">2027</option>
                          <option value="2028">2028</option>
                          <option value="2029">2029</option>
                          <option value="2030">2030</option>
                          <option value="2031">2031</option>
                          <option value="2032">2032</option>
                          <option value="2033">2033</option>
                          <option value="2034">2034</option>
                          <option value="2035">2035</option>
                          <option value="2036">2036</option>
                          <option value="2037">2037</option>
                        </select>
			</div>
			</div>
                        <div class="control-group">
                          <label class="control-label" style="text-align:left" for="address1">Address</label>
                          <div class="input">
                            <input class="field " id="address1" name="address1" type="text" />
                          </div>
                        </div>

                        <div class="control-group">
                          <label class="control-label" style="text-align:left" for="address2">Address (Optional)</label>
                          <div class="input">
                            <input class="field " id="address2"  type="text" />
                          </div>
                        </div>

                        <div class="control-group">
                          <label class="control-label" style="text-align:left" for="city">City </label>
                          <div class="input">
                            <input class="field " id="city" name="city" type="text" />
                          </div>
                        </div>


                        <div class="control-group">
                          <label class="control-label" style="text-align:left" for="zip">Zip Code </label>
                          <div class="input">
                            <input class="field " id="zip" name="zip" type="text" />
                          </div>
                      </div>
                      <!-- empty -->

                  </div>
                  <input type="checkbox" id="termsOfServiceCheck" disabled="disabled" name="termsOfServiceCheck" checked> I Agree to the <a href="/termsOfService">Terms of Service</a>
                  <p>


                  %{--<a href="/privacy">Check out our Privacy Policy</a>--}%

                  <div class="actions" style="clear:none;">
                      %{--<div style="float:left;width:50%;">--}%

                      <span><button type="submit" class="btn btn-primary submit-button " ">Sign up Now!</button>
		      <span class="help-inline">This is a Secure Transaction.</span>

                      %{--</div>--}%
                      <div id="spinnerContainer" style="float:right; width:65%; margin-top:16px"></div>
                      <span>
                  </div>
                  %{--<span class="payment_errors"></span>--}%
                </g:form>



                <div class="alert alert-success" style="display:none;" id="successMessage"> Awesome! You're all signed up! Look for an email shortly!
                </div>
                <div class="alert alert-error" id="errorMessage" class="alert alert-error" style="display:none;">Hmm something went wrong on our end processing your registration! Please try again or contact support at support@rolldelivered.com.</p> </div>
                <div class="alert alert-error" id="paymentErrorMessage" class="alert alert-error" style="display:none;">Hmm something went wrong processing your credit card! Check the fields above or contact support at support@rolldelivered.com.</p>

                </div>
            </fieldset>
          </div>


        </div>
        <div class="clear"></div>
      </div>
      <!--end two_column_wrapper-->
    </div>
  </div>
  <!-- end main box background --> </div>
</div>
<!--end buy now box-->

<!--start under animation-->
<div class="spacer_animation" id="spacer_animation_wind">
  <div class="spacer_animation_bg"></div>
  <div class="spacer_animation_parts">
    <div class="spacer_animation_part1"></div>
    <div class="spacer_animation_part2"></div>
    <div class="spacer_animation_part3"></div>
    <div class="spacer_animation_part4"></div>
  </div>
</div>
<!--end under animation-->


<!--end screenshot box-->
<div class="spacer_graphic4"></div>

<!--contact box-->
<div class="main_box_wrapper" id="support">
  <div class="main_box_background"> <!-- start box background -->
    <div class="main_box">
      <div class="content">
        <div class="content_left">
          <h1>Support</h1>
          <p class="title18">Frequently Asked Questions</p>
          <ul class="dots">
            <li><a href="#support">What is this Roll Delivered thing?</a></li>
            <li><a href="#support">How much do I get?</a></li>
            <li><a href="#support">Do you guys send prison roll?</a></li>
            <li><a href="#support">How much is shipping?</a></li>
            <li><a href="#support">Will I be automatically billed every month?</a></li>
            <li><a href="#support">How many people is one Roll Delivered order for?</a></li>
          </ul>
          <p><strong class="title14">What is this Roll Delivered thing?</strong><br />
            Thanks for asking! Roll Delivered is a service to deliver you toilet paper every month. All you have to do is sign up with us and you will never have to think about toilet paper again. We ship it over automatically so you never run out. Nationwide shipping is included in the price so there is nothing extra you have to worry about.</p>
            <p><strong class="title14">How much do I get?</strong><br />
              In every monthly shipment we will send you 2000 sheets in 4 special premium quality rolls. This should be enough for even our most power users.</p>
              <p><strong class="title14">Do you guys send prison (poor quality) roll?</strong><br />
                Absolutely Not! We only ship premium quality product from the nations leading brands! No single ply poor quality products here. Only Super Awesome Premium Stuff.</p>
                <p><strong class="title14">How much is shipping?</strong><br />
                  FREE! Our prices include shipping to any address in the Continental US.</p>
                  <p><strong class="title14">Will I be automatically billed every month?</strong><br />
                    We know how much of a pain it can be to be automatically hooked into anything and we give all our customers the choice to defer shipment or cancel every month. We want to make this simple and hassle-free. We like our customers. We want you to be happy!</p>
                    <p><strong class="title14">How many people is one Roll Delivered order for?</strong><br />
                      Our sophisiticated mathematical models are based on useage statistics for one to two people :). If you have more than two people in the household, we recommend you purchase multiple packs.</p>
                    </div>
                    <!--end content left-->
                    <div class="side_right">
                      <!--side menu-->
                      <div class="side_menu">
                        <h3>&nbsp;</h3>
                      </div>
                      <!--end side menu-->
                      <!--side box-->
                      <div class="side_box_thin">
                        <!--search-->

                        <!--end search-->
                      </div>
                      <!--end side box thin-->
                      <!--form-->
                      <div class="side_form">
                        <h3 class="blue">Have we not answered all your questions?</h3>
                        <a href="mailto:support@rolldelivered.com">Email us!</a>
                      </div>
                      <!--end form-->
                    </div>
                    <div class="clear"></div>
                  </div>
                </div>
              </div>
              <!-- end main box background -->
            </div>
            


            <!--end contact box-->
            %{--<div class="spacer_graphic6"></div>--}%
            <!--contact box-->
            <div class="main_box_wrapper" id="about">
              <div class="main_box_background"> <!-- start box background -->
                <div class="main_box">
                  <div class="content">
                    <h1>About Us</h1>
                    <p>We built Roll Delivered to bring you peace of mind. We are taking the hassle out of buying, transporting and storing bulky bathroom rolls to give you simplicity you can rely on. We are committed to our customers and welcome your comments or concerns!<br></br></P>
                    <div class="half_column_left">
                      <h3>The Founders:</h3>
                      <div class="founders"><img src="https://s3.amazonaws.com/rolldelivered-static/images/imran.jpg" alt="Imran Khawaja" width="140" height="140" border="1.5"/><div class="text">Imran Khawaja<br>
                      Programmer,UMBC & JHU Computer Science</br></div></div>

                      <div class="founders"><img src="https://s3.amazonaws.com/rolldelivered-static/images/fhmalik.jpg" alt="FH Malik" width="140" height="140" border="1.5"/><div class="text">FH Malik<br>
                      <p>Former consultant, financier and current Toilet Paper enthusiast</p>
                      <a href="http://www.twitter.com/fhnama/">@fhnama</a></br></div></div>
                      </div>
                      <!--end left half-->
                      <div class="half_column_right">
                        <h3>Connect with us:</h3>
                        <ul class="contacts" style="margin-left:9px;">
                          <li>Box 33, Washington, DC 20002</li>
                          <li>Email us: support - [at] - rolldelivered.com</li>
                          <li>Call us: 202-683-0000




                            <li>                              <a href="https://twitter.com/RollDelivered" class="twitter-follow-button" data-show-count="false" data-dnt="true">Follow @RollDelivered</a>
                                                          <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script></a> </li>
                          </ul>
                          <p></p>
                          <h3>Our Policies:</h3>
                          <p></p>
                          <li><a href="/termsOfService">Terms of service</a></li>
                          <li><a href="/privacy">Privacy</a></li>
			  <p></p>
			  <br></br>
			   &copy;2012 Roll Delivered Inc. All Rights Reserved.
                        </div>
                        <div class="clear"></div>
                      </div>
                    </div>
                  </div>            
          </div>

                </div>


              </body>
              </html>
