//
//  TransactionItemView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//

import SwiftUI

struct TransactionItemView: View {
    var transaction:Transaction
    var dateFormat:DateFormatter=DateFormatter()
    
    init(transaction:Transaction){
        self.transaction=transaction
        dateFormat.dateFormat="MM/dd/yyyy"
    }
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading, spacing: 5){
                Text(transaction.item)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 5){
                Text(String(format:"$%.2f",transaction.cost))
                Text(transaction.type)
                Text(dateFormat.string(from: transaction.datetime))
            }
        }
        .padding(.horizontal)
    }
}

struct TransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemView(
            transaction:Transaction(
                item:"Burger",
                cost:9.99,
                type:"food",
                datetime: Date(),
                uid: ""
            )
        )
    }
}
