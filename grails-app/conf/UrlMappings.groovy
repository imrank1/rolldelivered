class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

     //  "/"(controller: 'checkout', action: 'index')

       "/status"(controller: 'checkout', action: 'status')


		"/"(view:"/index")
		
		
		"500"(view:'/error')
	}
}
