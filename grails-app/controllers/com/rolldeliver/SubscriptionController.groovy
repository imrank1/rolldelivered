package com.rolldeliver

import grails.converters.JSON
import rolldeliver.PurchaseRecord
import rolldeliver.CancelRequest

class SubscriptionController {

    def cancel =  {

        String email = params.email
        if(!email){
            response.status = 400
            def errorMessage = [errors:"No email provided"]
            render errorMessage as JSON
        }else{
            List<PurchaseRecord> purchaseRecords = PurchaseRecord.findAllByEmail(email)
            purchaseRecords.each{purchaseRecord ->
            if (purchaseRecord){
                String objectidAsString = purchaseRecord.id.toString()
                String cancelLink = objectidAsString.substring(1,10)
                CancelRequest cancelRequest = new CancelRequest(purchaseRecordId: objectidAsString,cancelString: cancelLink,processed: new Boolean(false))
                cancelRequest.save()
                try{
                    def emailMessage = """
                    We received a request to cancel account with email address ${email}.

                    We're sorry that you would like to cancel your account. Please do contact us at support@rolldelivered.com
                    if you think there is somthing we could change/improve that would make you happy and stay on as a customer.

                    If you would still like to cancel your account please click here : https://www.rolldelivered.com/cancelRequest/confirm/${cancelLink}


                   The Roll Delivered Team"""
                        sendMail  {
                            to "${email}"
                            subject "Action Required:Cancel Account with RollDelivered Confirmation"
                            body emailMessage
                        }}catch(Exception ex){
                            log.info "Failed to send cancellation confirmation request email to ${email}"
                            Errors error = new Errors(message:"Failed to send cancellation confirmation request email to ${email}",date:new Date())
                            error.save(failOnError:true)
                        }
            }
            }
            def res = [:]
            response.status = 200
            res.success = true
            render res as JSON
        }
        
        
        

    }
    
    def processCancelConfirmationIndex = {
        //make sure the request exists

        //render a view
    }
    
    def processCancel = {
        //lookup the cancel request by the link 
        //cancel stripe recurring
        //mark cancel request as processed
        //mark purchaserecord as canceled and set a cancel date
        
    }
}
