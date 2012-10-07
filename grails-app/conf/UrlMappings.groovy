class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

       "/"(controller: 'checkout', action: 'index')

       "/status"(controller: 'checkout', action: 'status')

       "/termsOfService"(controller: 'checkout', view: "terms")

        "/privacy"(controller: 'checkout', view: "privacyPolicy")

        "/subscription/cancel"(controller: 'subscription', action = [POST: "cancel"])

        "/subscription/cancel/confirm/$cancelLink"(controller: 'subscription', action = [GET: "processCancelConfirmationIndex"])
        "/subscription/cancel/confirm"(controller: 'subscription', action = [POST: "processCancel"])

        "/api/v1/callback"(controller: 'stripeApiCallback',action = [POST: "processStripeCallback"])

		"500"(view:'/error')
	}
}
