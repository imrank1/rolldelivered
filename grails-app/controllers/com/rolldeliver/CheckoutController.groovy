package com.rolldeliver


import com.stripe.model.Charge

import com.stripe.Stripe
import rolldeliver.PurchaseRecord

import grails.converters.JSON
import com.stripe.model.Subscription
import com.stripe.model.Customer;
class CheckoutController {
//
    def index() {
        String scheme = request.getScheme()
        println "scheme is $scheme"

        String proto = request.getHeader("X-Forwarded-Proto")
        println "proto is $proto"
//        if(grails.util.Environment.getCurrent().equals(grails.util.Environment.PRODUCTION)){
                if(!proto.equals("https")){
                    println "Redirecting to https"
                    redirect(url:"https://www.rolldelivered.com")
                } else{

                    render(view: "index")

                }
//        }
//        else{
//            println "Non production mode index"
//            render(view: "index")
//
//        }
//            println("getting index ( in https ) ")
    }


    def status (){
        response.status = 200
        def res = [:]
        res.success = true
        render res as JSON
    }

    def terms() {
        render(view: "terms")
    }

    def privacy() {
        render(view:"privacyPolicy")
    }
    
	def charge()  {
        Stripe.apiKey = 'sk_07vkIYtFhTJY68s2pipRKmlvDtiqk'
        def amountInCents = (100 * 100) as Integer
        def email = params.email
        def firstName = params.firstName
        def lastName = params.lastName
        def address1 = params.address1
        def address2 = params.address2
        def city = params.city
        def zip = params.zip

        if(!firstName || !lastName){
            response.status = 500
            def errorResponse = [:]
            errorResponse.error = "Missing params!"
            render errorResponse as JSON
        }else {
		log.info 'amountInCents = ${amountInCents}'
        String desc = "email:${email} signed up for delivery at ${address1} ${address2} ${city} ${zip}"
        def chargeParams = [
            'amount': amountInCents, 
            'currency': 'usd', 
            'card': params.stripeToken,
            'description': desc
        ]

        def status
        try {
            Map<String, Object> customerParams = new HashMap<String, Object>();
            customerParams.put("description", desc);
            customerParams.put("card", params.stripeToken);
            customerParams.put("plan","starter")
            customerParams.put("email",email)// obtained with Stripe.js
            Customer customer = Customer.create(customerParams);


            status = 'Your purchase was successful.'
            PurchaseRecord purchaseRecord = 
            new PurchaseRecord
            (firstName:firstName,lastName:lastName,address1:address1,address2:address2,city:city,zip:zip, stripeId:customer.getId(),email:email,description: desc,purchaseDate: new Date())
            if(!purchaseRecord.save()){
                log.info "Error saving purchase record"
                purchaseRecord.errors.each { print it }
            }

        } catch(Exception ex) {
	        log.info ('somthing with wrong', ex  )
            status = 'There was an error processing your credit card. Please contact support at support@rolldelivered.com'
            response.status = 500
        }

		log.info 'status is ${status}'
        try{
        sendMail  {
            to "${email}"
            subject "Subscription Confirmation with RollDelivered"
            body "Thanks for signing up with RollDelivered! You're on you way to simplifying your life! If you have any questions/concertins/want to cancel simply email us at support@rolldelivered.com."
        }}catch(Exception ex){
            log.info "Failed to send confirmation email to ${email}"
            Errors error = new Errors(message:"Failed to send confirmation email to ${email}",date:new Date())
            error.save()
        }
        
        status = "Thanks for signing up!"
        def res = [:]
        res.success = true
        render res as JSON
    }
        //render(view:'../',model:[signupSuccess:true])
        //render(uri:'/',model: [msg:status,signupSuccess:true])
//        redirect(action: "index", params: [msg: status])
    }

    def message() {
        def name = params.name
        def email = params.email
        def message = params.message

         try{
        sendMail  {
            to "${email}"
            subject "Support Question from ${name}"
            body "${message}"
        }}catch(Exception ex){
            log.info "Failed to send support email from ${email}"
            Errors error = new Errors(message:"Failed to send support email from ${email}",date:new Date())
            error.save()
             def errorMap = [:]
             errorMap.error = true
            response.status = 500
            render errorMap as JSON
        }

        def res = [:]
        res.success = true
        render res as JSON
    }

    def confirmation(String msg) {
        render(view:"/",msg: msg)
    }
}
