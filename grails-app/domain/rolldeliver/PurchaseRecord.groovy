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
    String cancelRequestId
    Date cancelDate
    static constraints = {
        description (nullable: true)
        address2(nullable:true)
        address2(blank:true)
        address2(nullable:true)
        cancelRequestId(nullable: true)
        cancelDate(nullable: true)
    }
}
