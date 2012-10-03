package rolldeliver

import org.bson.types.ObjectId

class ChargeLog {

    static mapWith = "mongo"
    ObjectId id
    String email
    String stripeId
    String failureMessage
    Date created
    String purchaseRecordId

    static constraints = {
        failureMessage(nullable: true)
    }
}
