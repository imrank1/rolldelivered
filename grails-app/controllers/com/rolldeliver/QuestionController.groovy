package com.rolldeliver

class QuestionController {

    def index() { }

    def sendQuestionToTeam () {
        def name = params.name
        def email = params.email
        def message = params.email

        try {
            sendMail  {
            to "imrank1@gmail.com"
             subject "Question on rolldelivered"
             body "From:${email},Name:${name},Message:${message} "
                    }
        }
        catch(Exception e){
            log.info("There was an error sending email for email:${email} and message ${message}")

        }
    }
}
