package rolldeliver

import org.bson.types.ObjectId

class PurchaseRecord {

    static mapWith = "mongo"
    ObjectId id
    String stripeId
    String firstName
    String lastName
    String email
    String description
    Date purchaseDate
    String address1
    String address2
    String city
    String zip
    static constraints = {
        description (nullable: true)
        address2(nullable:true)
        address2(blank:true)
    }
}
