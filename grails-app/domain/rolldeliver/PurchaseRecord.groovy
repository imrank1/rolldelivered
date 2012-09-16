package rolldeliver

import org.bson.types.ObjectId

class PurchaseRecord {

    static mapWith = "mongo"
    ObjectId id
    String stipeId
    String firstName
    String lastName
    String email
    String description
    Date purchaseDate
    static constraints = {
        description (nullable: true)

    }
}
