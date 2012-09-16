package com.rolldeliver


import com.stripe.model.Charge
import com.stripe.exception.CardException
import com.stripe.Stripe
import rolldeliver.PurchaseRecord
import grails.converters.JSON;
class CheckoutController {

	def charge()  {
        Stripe.apiKey = 'sk_07vkIYtFhTJY68s2pipRKmlvDtiqk'
        def amountInCents = (100 * 100) as Integer
        def email = params.email
        def firstName = params.firstName
        def lastName = params.lastName

        if(!firstName || !lastName){
            response.status = 500
            def errorResponse = [:]
            errorResponse.error = "Missing params!"
            render errorResponse as JSON
        }else {
		log.info 'amountInCents = ${amountInCents}'
        def chargeParams = [
            'amount': amountInCents, 
            'currency': 'usd', 
            'card': params.stripeToken,
            'description': 'customer@sample.org'
        ]

        def status
        try {
            Charge charge = Charge.create(chargeParams)
            status = 'Your purchase was successful.'
            PurchaseRecord purchaseRecord = new PurchaseRecord(firstName:firstName,lastName:lastName, stipeId:charge.getId(),email:email,description: "Test description",purchaseDate: new Date())
            if(!purchaseRecord.save()){
                log.info "Error saving purchase record"
                purchaseRecord.errors.each { print it }
            }

        } catch(Exception ex) {
	        log.info ('somthing with wrong', ex  )
            status = 'There was an error processing your credit card. Please contact support at support@rolldelivered.com'
            response.status = 500
            //redirect(uri:'/',params: [msg:status,error:true])//        chain  action:'index',model: [message:status]
        }

		log.info 'status is ${status}'

        sendMail  {
            to "${email}"
            subject "Subscription Confirmation with RollDelivered"
            body "Thanks for signing up with RollDelivered! "
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

    def confirmation(String msg) {
        render(view:"/",msg: msg)
    }
}
