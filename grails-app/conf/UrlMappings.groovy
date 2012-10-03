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
	//	"/"(view:"/index")
		

        "/api/v1/callback"(controller: 'stripeApiCallback',action = [POST: "processStripeCallback"])


		"500"(view:'/error')
	}
}
