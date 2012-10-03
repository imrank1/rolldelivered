package com.rolldeliver

import rolldeliver.PurchaseRecord
import rolldeliver.ChargeLog

class StripeApiCallbackController {

    private static final String eventType = "charge.succeeded"
    def processStripeCallback={
        def json = request.JSON
        log.info("callback json is $json")

        def type = json.type
        if (type == eventType){
            def data = json.data
            def object = data.object
            def amount = object.amount
            def failureMessage = object.failure_message
            def disputed = object.disputed
            def stripeCustomerId = object.customer

            PurchaseRecord purchaseRecord = PurchaseRecord.findByStripeId(stripeCustomerId)

            ChargeLog chargeLog = new ChargeLog(stripeId: stripeCustomerId,email: purchaseRecord.email,created: new Date(),failureMessage: failureMessage,purchaseRecordId: purchaseRecord.id.toString())

            if(!chargeLog.save(failOnError:true)){
                log.info "Error saving charge log record"
                purchaseRecord.errors.each { log.info it }
                Errors error = new Errors(message:"Failed to save purchase charge log for stripe customer id  ${stripeCustomerId} desc :received a charge.succeeded but could not save it",date:new Date())
                error.save()
            }

            try{
                def emailMessage = """
                We got a successfull charge on for customer ${purchaseRecord.firstName} ${purchaseRecord.lastName}, email ${purchaseRecord.email}
                Send a package to ${purchaseRecord.address1} ${purchaseRecord.address2} ${purchaseRecord.city} ${purchaseRecord.zip}"""

                sendMail  {
                    to "imrank1@gmail.com"
                    subject "Subscription Confirmation with RollDelivered"
                    body emailMessage
                   }}catch(Exception ex){
                       log.info "Failed to send send package email "
                       Errors error = new Errors(message:"Failed to send send package email ",date:new Date())
                       error.save(failOnError:true)
                }

        }




    }
}
