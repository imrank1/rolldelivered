package com.rolldeliver

import grails.converters.JSON
import rolldeliver.PurchaseRecord
import rolldeliver.CancelRequest
import com.stripe.model.Customer
import com.stripe.Stripe

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

                    If you would still like to cancel your account please click here : https://www.rolldelivered.com/subscription/cancel/confirm/${cancelLink}


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
        CancelRequest cancelRequest = CancelRequest.findByCancelString(params.cancelLink)
        def model = [:]
        if (cancelRequest){
           model.cancelLink = cancelRequest.cancelString
           PurchaseRecord purchaseRecord = PurchaseRecord.findById(cancelRequest.purchaseRecordId)
           model.email = purchaseRecord.email
           model.error = false
        }else{
            model.error = true
        }
        render(view:"cancelPage",model: model)
    }
    
    def processCancel = {
        //Live
        //Stripe.apiKey ='sk_07vkTfsJXClB16FwyAXCGqFFNJnls'
        //TEst
        Stripe.apiKey = 'sk_07vkIYtFhTJY68s2pipRKmlvDtiqk'
        CancelRequest cancelRequest = CancelRequest.findByCancelString(params.cancelLink)
        PurchaseRecord purchaseRecord
        if (cancelRequest && cancelRequest.processed != null && cancelRequest.processed != true){
            purchaseRecord = PurchaseRecord.findById(cancelRequest.purchaseRecordId)

        Customer existingCustomer = Customer.retrieve(purchaseRecord.stripeId)
        existingCustomer.cancelSubscription()

        
        cancelRequest.processed = new Boolean(true)
        cancelRequest.save()
        purchaseRecord.cancelRequestId = cancelRequest.id.toString()
        purchaseRecord.cancelDate = new Date()
        purchaseRecord.save()
        try{
            def emailMessage = """
            We deactivated your account with email address ${purchaseRecord.email}.

            We're sorry that you canceled your account.

            Thank you for your business.

            The Roll Delivered Team"""
                sendMail  {
                    to "${purchaseRecord.email}"
                    subject "Account with Rolldelivered Deactivated"
                    body emailMessage
            }
        }catch(Exception ex){
                    log.info "Failed to send cancellation confirmation  email to ${purchaseRecord.email}"
                    Errors error = new Errors(message:"Failed to send cancellation confirmation request email to ${purchaseRecord.email}",date:new Date())
                    error.save(failOnError:true)
        }
        }





        
        response.status = 200
        def res = [:]
        res.success = true
        render res as JSON
        
    }
}
