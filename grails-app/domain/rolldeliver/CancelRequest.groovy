package rolldeliver

import org.bson.types.ObjectId

class CancelRequest {
    static mapWith = "mongo"
    ObjectId id
    String purchaseRecordId
    String cancelString
    Boolean processed
    static constraints = {
    }
}
