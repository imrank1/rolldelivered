
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>RD-Sandbox</title>
  <link rel="stylesheet" href="css/styles.css" type="text/css" />
  <link rel="stylesheet" href="css/eco.css" type="text/css" />
  <link href="css/bootstrap.css" media="screen" rel="stylesheet" type="text/css" />
  <!--[if IE 9]> <link rel="stylesheet" href="css/styles_ie9.css" type="text/css" /> <![endif]-->
  <!--[if IE 8]> <link rel="stylesheet" href="css/styles_ie8.css" type="text/css" /> <![endif]-->
  <!--[if IE 7]> <link rel="stylesheet" href="css/styles_ie7.css" type="text/css" /> <![endif]-->
  <link href='http://fonts.googleapis.com/css?family=Droid+Sans:regular,bold' rel='stylesheet' type='text/css' />
  <link rel="stylesheet" href="css/jquery.lightbox-0.5.css" type="text/css" />
  <link rel="stylesheet" href="php/widget-rating.php?css" type="text/css" />
  <!-- star rating css -->
  <script type="text/javascript" src="js/jquery-1.4.3.min.js"></script>
  <script type="text/javascript" src="js/jquery.lightbox-0.5.pack.js"></script>
  <script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
  <script type="text/javascript" src="js/dtbaker_slider_links.js"></script>
  <script type="text/javascript" src="js/dtbaker_slider.js"></script>
  <script type="text/javascript" src="js/dtbaker_animation.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>

  <script type="text/javascript" src="https://js.stripe.com/v1/"></script>
  <script type="text/javascript">
  Stripe.setPublishableKey('pk_07vkx4yqszys5bnTNnHPSAAimkCie');

  $(document).ready(function() {
    $("#payment-form").submit(function(event) {
      $("#errorMessage").hide("slow");
      $("#successMessage").hide("slow");
        // disable the submit button to prevent repeated clicks
        $('.submit-button').attr("disabled", "disabled");

        Stripe.createToken({
          number: $('.card-number').val(),
          cvc: $('.card-cvc').val(),
          exp_month: $('.card-expiry-month').val(),
          exp_year: $('.card-expiry-year').val()
        }, stripeResponseHandler);

        // prevent the form from submitting with the default action
        return false;
      });
  });
  </script>
  <script type="text/javascript">

  function stripeResponseHandler(status, response) {
    if (response.error) {

        // show the errors on the form
        $(".payment_errors").text(response.error.message);
        $(".submit-button").removeAttr("disabled");
      } else {

        var form$ = $("#payment-form");
        // token contains id, last4, and card type
        var token = response['id'];
        // insert the token into the form so it gets submitted to the server
        //form$.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
        // and submit
        //form$.get(0).submit();
       var fName = $('#firstName').val();
       var lName = $('#lastName').val();
       var e = $('#email').val();
        $.ajax({
                url: 'checkout/charge',
                type: 'post',
                data: { firstName: fName,lastName:lName,email:e,stripeToken:token },
                cache: false,
                success: function(){ 
                    $("#successMessage").show("slow");
                   $(".submit-button").removeAttr("disabled");
                },
                error: function(){
                    $("#errorMessage").show("slow");
                }
            });
        $(".submit-button").removeAttr("disabled");

      }
    }
    </script>
    <script type="text/javascript"> //google analytics

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-34220335-1']);
    _gaq.push(['_setDomainName', 'doughly.com']);
    _gaq.push(['_setAllowLinker', true]);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

    </script>




    <script type="text/javascript">
    <!-- js friendly fallback for animations -->
    document.write(unescape('%3Cstyle type="text/css"%3E.spacer_animation .spacer_animation_parts div{ margin-top:400px; }%3C/style%3E'));
    document.write(unescape('%3Cstyle type="text/css"%3E.main_box_background .main_box_bg_left{ margin-left:0px; }%3C/style%3E'));
    document.write(unescape('%3Cstyle type="text/css"%3E.main_box_background .main_box_bg_right{ margin-left:475px;margin-top:-438px; }%3C/style%3E'));
    $(function() {
      $('.spacer_animation').each(function(){
       var foo = new anim_scroller();
       foo.init_popup(this);
       anim_scrollers.push(foo);
     });
		// popout leaf code.
		//$('.main_box_background').each(function(){
		//	var foo = new anim_scroller();
		//	foo.init_popout(this,[
		//		{class:'.main_box_bg_left',image:'images/eco/leaves_left.png',animation_from:{marginLeft:0},animation_to:{marginLeft: -121},time:600},
		//		{class:'.main_box_bg_right',image:'images/eco/leaves_right.png',animation_from:{marginLeft:475, marginTop:-438},animation_to:{marginLeft: 595,marginTop: -331},time:600}
		//		]
		//	);
		//	anim_scrollers.push(foo);
		//});
		//window.onscroll=dtbaker_anim_scroll_go;
		//dtbaker_anim_scroll_go();

    $('.lightbox').lightBox();
    $('.dtbaker_gallery a').lightBox();
        // this starts the "portfolio" sideways scroller.
        // create a new one of these for each sideways scroller you would like to have.
        new dtbaker_scroller('portfolio_slider');
        new dtbaker_simpleCart({
			'id': 'buy_now', // unique id for this product. don't change this.
			'paypal': 'dtbaker@gmail.com', // change to false to disable paypal
			'google': '251134918603076', // change to false to disable google
			'email': true, // allow the email method
			'flat_rate': false, // change to false to charge shipping per item
			'shipping_rate': 0, // shipping rate is controlled by the drop down on order form.
			'product_name': 'TP Box from Roll Delivered',
			'product_price': 9.99,
			'currency': USD,
			'thank_you_url': 'thank_you.html'
		});
      });
</script>
</head>
<body>
  <div id="fixed_header">
    <div id="header">
      <div id="logo"><a href="#home_page" class="slide_link">Roll Delivered - Hassle-Free Toilet Paper Delivery</a></div>
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
          <div class="main_box_bg_left"></div>

          <!--home box-->
          <div class="main_box" id="section1">
              <!-- <div class="home_price_tag"> WAS <del>$400</del>
        <div class="band"> NOW <span class="size48">$350</span></div>
      </div>-->
      <div class="home_box">
        <div class="text">
          <h1>Welcome to Roll Delivered</h1>
          <h2>We're simple. We deliver premium toilet paper to you monthly for $8.99.</h2>
          <h3>One Step to Signup. One Step to Cancel. No Hassles.</h3>
          <ul class="numbered_list">
            <li><span>1</span>No more runs to the store.</li>
            <li><span>2</span>Never carry bulky packs of toilet paper in public again.</li>
            <li><span>3</span>Automatic monthly delivery. Defer a month with One Click.</li>
          </ul>
          <ul class="buttons_float">
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
          <img src="images/eco/home_image.png" width="400" height="430" alt="product" /></div>
          <!--end home right-->
        </div>
      </div>
      <!--end home box-->
      <div class="main_box_bg_right"></div>
    </div>
    <!-- end main box background -->
  </div>

  <!--start under animation-->
  <div class="spacer_animation" id="spacer_animation_rocks">
    <div class="spacer_animation_bg"></div>
    <div class="spacer_animation_parts">
      <div class="spacer_animation_part1"></div>
      <div class="spacer_animation_part2"></div>
      <div class="spacer_animation_part3"></div>
    </div>
  </div>
  <!--end under animation-->

  <!--buy now box-->
  <div class="main_box_wrapper" id="buy_now">
    <div class="main_box_background"> <!-- start box background -->
      <div class="main_box_bg_left"></div>
      <div class="main_box">
        <div class="content">
    <!--        <div class="left_460">
                  <h1>Buy Now</h1>
                  <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sagittis nisi varius lorem posuere tristique condimentum eros ornare. Nunc fermentum, urna condimentum imperdiet congue, magna odio cursus mauris, a hendrerit lacus arcu id dolor. In hac habitasse platea dictumst. Nunc massa metus, rhoncus et luctus sit amet, vehicula in lorem. Cras facilisis, ipsum non dictum egestas, dolor lorem fermentum lorem, sed aliquam arcu sem vitae nisl. Etiam est mauris, lobortis sit amet accumsan ut, auctor vitae ipsum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. </p>
                  <ul class="ticklist">
                <li>Vestibulum ante ipsum primis</li>
                <li>In faucibus orci luctus et ultrices posuere cubilia</li>
                <li>Ida dapibus. Duis volutpat lectus</li>
              </ul>
                  <div class="sale_border">
                <div class="sale">
                      <div class="left">
                    <p class="title18">Buy the product online &amp; save! </p>
                    <p class="title30"> Online sale price: </p>
                    <p class="title14">*Price includes tax and free shipping </p>
                  </div>
                      <div class="balls"><span class="price1">$9.99</span> <span class="price2">SAVE<br />
                        <span class="size24">$50</span></span></div>
                      <div class="clear"></div>
                    </div>
              </div>
                </div>
              -->

              <!--end left-->
            <!--
            <div class="right_400"><img src="images/eco/buy_book.jpg" width="400" height="430" alt="book" /></div>
            <div class="clear"></div>
          -->
          <div class="two_column_wrapper">
            <div class="side_left">

              <!--side box-->
              <div class="side_box">
                <div class="top"></div>
                <div class="content_middle" align="middle">
                  <img src="images/eco/price_box.png" alt="$8.99 shipping and tax included" />
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
                  <img src="images/premium_quality2.png" alt="Satisfaction Guaranteed"/>
                  <p>Satisfaction Guaranteed</p>
                  <div class="clear"></div>
                </div>
                <div class="bottom"></div>
              </div>
              <!--end side box-->
              <!--side box-->
              <div class="side_box">
                <div class="top"></div>
                <div class="content_middle">
                  <p class="title">Pay Securely through:</p>
                  <ul class="payment">
                    <li><img src="images/icon_mastercard.png" width="47" height="29" alt="mc" /></li>
                    <li><img src="images/icon_visa.png" width="47" height="29" alt="visa" /></li>
                    <li><img src="images/icon_paypal.png" width="47" height="29" alt="paypal" /></li>
                    <li><img src="images/icon_bank.png" width="47" height="29" alt="bank" /></li>
                  </ul>
                  <div class="clear"></div>
                </div>
                <div class="bottom"></div>
              </div>
              <!--end side box-->
            </div>
            <div class="content_right">
              <div class="box_title"> Get Roll Delivered. Simplify Your Life. </div>
              <p>Enter your details to order and Simplify Your Life.</p>
              <div class="span6 columns">
                <fieldset>
                 <form action="checkout/charge" method="POST" id="payment-form">
                    <div class="clearfix">
                      <label for="user_name">First Name</label>
                      <div class="input">
                        <input class="field" id="firstName" name="firstName" size="30" type="text" />
                      </div>
                    </div>


                     <div class="clearfix">
                      <label for="user_name">Last Name</label>
                      <div class="input">
                        <input class="field" id="lastName" name="lastName" size="30" type="text" />
                      </div>
                    </div>

                    <div class="clearfix">
                      <label for="user_email">Email</label>
                      <div class="input">
                        <input class="field" id="email" name="email" size="30" type="text" />
                      </div>
                    </div>

                    <div class="clearfix">
                      <label for="user_email">Email Confirmation</label>
                      <div class="input">
                        <input class="field" id="emailConfirmation" name="emailConfirmation" size="30" type="text" />
                      </div>
                    </div>
                    <div class="clearfix">
                      <label for="user_password">Password</label>
                      <div class="input">
                        <input class="field" id="user_password" name="user[password]" size="30" type="password" />
                      </div>
                    </div>

                    <div class="clearfix">
                      <label for="user_password_confirmation">Password confirmation</label>
                      <div class="input">
                        <input class="field" id="user_password_confirmation" name="user[password_confirmation]" size="30" type="password" />
                      </div>

                      <input id="user_stripe_token" name="user[stripe_token]" type="hidden" />
                      <input id="user_last_4_digits" name="user[last_4_digits]" type="hidden" />
                    </div>


                    <noscript>
                      <p>This form requires Javascript to use</p>
                    </noscript>

                    <div id="credit-card" style="display:block">
                      <div id="credit-card-errors" style="display:none">
                        <div id="stripe-error-message" class="alert-message block-message error">
                        </div>
                      </div>

                      <!-- these fields are disabled before submission and are never transmitted back to rails -->
                      <div class="clearfix">
                        <label for="credit_card_number">Credit card number</label>
                        <div class="input">
                          <input class="field card-number" id="credit_card_number" type="text" />
                        </div>
                      </div>

                      <div class="clearfix">
                        <label for="cvv">Security code (CVV)</label>
                        <div class="input">
                          <input class="input-small card-cvc"  id="cvv"  type="text" />
                        </div>
                      </div>

                      <div class="clearfix">
                        <label for="expiry_date">Expiry date</label>
                        <div class="input">

                          <select class="input-small card-expiry-month" id="expiry-month" >
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
                          <select class="input-small card-expiry-year" id="expiry-year" >
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
                        <!-- empty -->
                      </div>
                      <span class="note">
                        Your credit card details will be securely sent directly to our payment processor
                      </span>
                    </div>

                    <div class="actions">
                      <button type="submit" class="btn-primary submit-button">Register!</button>
                    </div>
                  </form>

                  <p id="successMessage" style="display: none">Hey Thanks for signing up!</p>
                   <p id="errorMessage" style="display: none">Hmm somthing went wrong!</p>
                      </fieldset>
                </div>
              </div>
              <div class="clear"></div>
            </div>
            <!--end two_column_wrapper-->
          </div>
        </div>
        <div class="main_box_bg_right"></div>
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

      <!--portfolio box-->
      <div class="main_box_wrapper" id="features">
        <div class="main_box_background"> <!-- start box background -->
          <div class="main_box_bg_left"></div>
          <div class="main_box">
            <div class="content">
              <div id="portfolio_slider" class="slider_container">
                <div class="slider_header">
                  <h1>Features</h1>
                  <ul class="slider_buttons">
                    <li><a href="#" class="portfolio_prev slider_prev">&laquo; prev</a></li>
                    <li><a href="#" class="portfolio_next slider_next">next &raquo;</a></li>
                  </ul>
                </div>
                <div class="slider_wrapper">
                  <div class="slider_mover">
                    <!-- start -->
                    <div>
                      <ul class="threecols">
                        <li class="margin_right_30">
                          <div class="feature">
                            <div class="image"> <a href="images/feature1.jpg" class="lightbox"><img src="images/eco/icon_1.jpg" alt="Photo" width="286" height="190" border="0" /></a></div>
                            <div class="text">
                              <h3 style="font-weight:bold">Feature 1</h3>
                              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sodales metus id mi suscipit ut ullamcorper lectus congue. Ut a massa volutpat ipsum tempor auctor faucibus eget arcu.</p>
                              <p><a href="#" target="_blank" class="link_button">more</a></p>
                            </div>
                          </div>
                        </li>
                        <li class="margin_right_30">
                          <div class="feature">
                            <div class="image"> <a href="images/feature2.jpg" class="lightbox"><img src="images/eco/icon_2.jpg" alt="photo" width="286" height="190" border="0" /></a></div>
                            <div class="text">
                              <h3 style="font-weight:bold">Feature 2</h3>
                              <ul class="dots">
                                <li>Lorem ipsum dolor sit amet</li>
                                <li>Consectetur adipiscing elit. </li>
                                <li>Fusce sodales metus</li>
                                <li>Id mi suscipit ut</li>
                                <li>ullamcorper lectus congue.</li>
                              </ul>
                              <p><a href="#" target="_blank" class="link_button">more</a></p>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="feature">
                            <div class="image"> <a href="images/feature3.jpg" class="lightbox"><img src="images/eco/icon_3.jpg" alt="Photo" width="286" height="190" border="0" /></a></div>
                            <div class="text">
                              <h3 style="font-weight:bold">Feature 3</h3>
                              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sodales metus id mi suscipit ut ullamcorper lectus congue. Ut a massa volutpat ipsum tempor auctor faucibus eget arcu.</p>
                              <p><a href="#" target="_blank" class="link_button">more</a></p>
                            </div>
                          </div>
                        </li>
                      </ul>
                    </div>
                    <!-- end -->
                    <!-- start 2 -->
                    <div>
                      <ul class="threecols">
                        <li class="margin_right_30">
                          <div class="feature">
                            <div class="image"> <a href="images/feature1.jpg" class="lightbox"><img src="images/eco/icon_4.jpg" alt="Photo" width="286" height="190" border="0" /></a></div>
                            <div class="text">
                              <h3 style="font-weight:bold">Feature 4</h3>
                              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sodales metus id mi suscipit ut ullamcorper lectus congue. Ut a massa volutpat ipsum tempor auctor faucibus eget arcu.</p>
                              <p><a href="#" target="_blank" class="link_button">more</a></p>
                            </div>
                          </div>
                        </li>
                        <li class="margin_right_30">
                          <div class="feature">
                            <div class="image"> <a href="images/feature2.jpg" class="lightbox"><img src="images/eco/icon_5.jpg" alt="photo" width="286" height="190" border="0" /></a></div>
                            <div class="text">
                              <h3 style="font-weight:bold">Feature 5</h3>
                              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sodales metus id mi suscipit ut ullamcorper lectus congue. Ut a massa volutpat ipsum tempor auctor faucibus eget arcu.</p>
                              <p><a href="#" target="_blank" class="link_button">more</a></p>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="feature">
                            <div class="image"> <a href="images/feature3.jpg" class="lightbox"><img src="images/eco/icon_6.jpg" alt="Photo" width="286" height="190" border="0" /></a></div>
                            <div class="text">
                              <h3 style="font-weight:bold">Feature 6</h3>
                              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sodales metus id mi suscipit ut ullamcorper lectus congue. Ut a massa volutpat ipsum tempor auctor faucibus eget arcu.</p>
                              <p><a href="#" target="_blank" class="link_button">more</a></p>
                            </div>
                          </div>
                        </li>
                      </ul>
                    </div>
                    <!-- end 2-->
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="main_box_bg_right"></div>
        </div>
        <!-- end main box background -->
        <!--start under animation-->
        <div class="spacer_animation" id="spacer_animation_city">
          <div class="spacer_animation_bg"></div>
          <div class="spacer_animation_parts">
            <div class="spacer_animation_part1"></div>
            <div class="spacer_animation_part2"></div>
            <div class="spacer_animation_part3"></div>
          </div>
        </div>
        <!--end under animation-->
      </div>
      <!--end features box-->
      <!--end screenshot box-->
      <div class="spacer_graphic4"></div>

      <!--contact box-->
      <div class="main_box_wrapper" id="support">
        <div class="main_box_background"> <!-- start box background -->
          <div class="main_box_bg_left"></div>
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
                            Our sophisiticated mathematical models are based on useage statistics for one to two people. If you have more than two people in the household, we recommend you purchase multiple packs.</p>
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
                              <div class="search_box_container">
                                <form action="search.php" method="get" name="search">
                                  <input name="search" type="text" class="field" id="search_box2" />
                                  <input name="Search" type="submit" class="sbutton" value="search" />
                                </form>
                              </div>
                              <!--end search-->
                            </div>
                            <!--end side box thin-->
                            <!--form-->
                            <div class="side_form">
                              <h3 class="blue">Send us a question:</h3>
                              <form action="formsubmit.php" method="post">
                                <fieldset id="small_form">
                                  <label for="support_name">Name:</label>
                                  <input name="name" type="text" class="forms_small" id="support_name" size="26" />
                                  <label for="support_email">Email:</label>
                                  <input name="email" type="text" class="forms_small" id="support_email" size="26" />
                                  <label for="support_message">Message:</label>
                                  <textarea name="message" cols="18" rows="4" class="forms_small textarea" id="support_message"></textarea>
                                  <br class="clear"/>
                                  <input name="submit" type="submit" id="submit" class="submit_button" value="submit" />
                                </fieldset>
                              </form>
                            </div>
                            <!--end form-->
                          </div>
                          <div class="clear"></div>
                        </div>
                      </div>
                      <div class="main_box_bg_right"></div>
                    </div>
                    <!-- end main box background -->
                  </div>

                  <!--end contact box-->
                  <div class="spacer_graphic6"></div>
                  <!--contact box-->
                  <div class="main_box_wrapper" id="about">
                    <div class="main_box_background"> <!-- start box background -->
                      <div class="main_box_bg_left"></div>
                      <div class="main_box">
                        <div class="content">
                          <h1>About Us</h1>
                          <h3>We built Roll Delivered to bring you peace of mind. We are taking the hassle out of buying, transporting and storing bulky bathroom rolls to give you simplicity you can rely on. We are committed to our customers and welcome your comments or concerns!<br></br></h3>
                          <div class="half_column_left">
                            <h3>The Founders:</h3>
                            <div class="founders"><img src="images/imran.jpg" alt="Imran Khawaja" width="140" height="140" border="1.5"/><div class="text">Imran Khawaja</div></div>
                            <div class="founders"><img src="images/fhmalik.jpg" alt="FH Malik" width="140" height="140" border="1.5"/><div class="text">FH Malik<br>
                              <a href="http://www.twitter.com/fhnama/">@fhnama</a></br></div></div>
                            </div>
                            <!--end left half-->
                            <div class="half_column_right">
                              <h3>Connect with us:</h3>
                              <ul class="contacts">
                                <li>Box 33, Washington, DC 20002</li>
                                <li>Email us: support - [at] - rolldelivered.com</li>
                                <li>Call us: 202-683-0000
                                  <li><a href="http://www.twitter.com/rolldelivered"><img src="images/icon_twitter.gif" alt="Twitter" width="32" height="32" border="0" /></a> </li>
                                </ul>
                                <p></p>
                                <h3>Our Policies:</h3>
                                <p></p>
                                <li><a href="#">Terms of service</a></li>
                                <li><a href="#">Privacy</a></li>
                              </div>
                              <div class="clear"></div>
                            </div>
                            <!--end right half-->
                          </div>
                          <div class="main_box_bg_right"></div>
                        </div>
                        <!-- end main box background -->
                        <!--start under animation-->
                        <div class="spacer_animation" id="spacer_animation_rain">
                          <div class="spacer_animation_bg"></div>
                          <div class="spacer_animation_parts">
                            <div class="spacer_animation_part1"></div>
                            <div class="spacer_animation_part2"></div>
                            <div class="spacer_animation_part3"></div>
                          </div>
                        </div>
                        <!--end under animation-->
                      </div>
                      <!--end contact box-->
                      <!--bg top-->
                      <!-- star rating javascript -->
                    </body>
                    </html>
