//
//  AddView.swfit.swift
//  iExpense
//
//  Created by Mirna Olvera on 1/2/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = "Expense name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Binding var path: NavigationPath
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        Form {
//            TextField("Name", text: $name)
                
            Picker("Type", selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }
                
            TextField("Amount", value: $amount, format: .currency(code: "USD"))
                .keyboardType(.decimalPad)
        }
            
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(id: "options") {
            ToolbarItem(id: "save", placement: .confirmationAction) {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if type == "Personal" {
                        expenses.personalItems.append(item)
                    } else {
                        expenses.businessItems.append(item)
                    }
                    
                    path = NavigationPath()
                }
            }
            ToolbarItem(id: "cancel", placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    path = NavigationPath()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    @State var path = NavigationPath()
    
    return AddView(path: $path, expenses: Expenses())
}
