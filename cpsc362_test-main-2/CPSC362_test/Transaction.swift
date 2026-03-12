//
//  Transaction.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Transaction: Codable, Identifiable {
    @DocumentID var id:String?
    var item:String
    var cost:Float
    var type:String
    var datetime:Date
    var uid:String
}
