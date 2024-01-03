//
//  ContentView.swift
//  iExpense
//
//  Created by Mirna Olvera on 1/2/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var businessItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(businessItems) {
                UserDefaults.standard.set(encoded, forKey: "Business")
            }
        }
    }

    var personalItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey: "Personal")
            }
        }
    }

    init() {
        if let businsesItemsData = UserDefaults.standard.data(forKey: "Business") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: businsesItemsData) {
                businessItems = decodedItems
            }
        }

        if let savedItems = UserDefaults.standard.data(forKey: "Personal") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                personalItems = decodedItems
                return
            }
        }

        businessItems = []
        personalItems = []
    }
}

struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var expenses = Expenses()

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Business Expenses")
                        .font(.title)
                    List {
                        ForEach(expenses.businessItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)

                                    Text(item.type)
                                }
                                Spacer()

                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(getForeGroundStyle(item.amount))
                            }
                        }
                        .onDelete { offests in
                            removeItems(at: offests, type: "Business")
                        }
                    }
                }

                VStack {
                    Text("Personal Expenses")
                        .font(.title)
                    List {
                        ForEach(expenses.personalItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)

                                    Text(item.type)
                                }
                                Spacer()

                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(getForeGroundStyle(item.amount))
                            }
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, type: "Personal")
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    showingAddExpense = true
                }

                EditButton()
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func getForeGroundStyle(_ amount: Double) -> Color {
        if amount <= 10 {
            return .green
        }
        else if amount < 100 {
            return .blue
        }
        else if amount >= 100 {
            return .red
        }

        return .white
    }

    func removeItems(at offsets: IndexSet, type: String) {
        offsets.forEach { i in
            print("Index : \(i)")
        }
        if type == "Business" {
            expenses.businessItems.remove(atOffsets: offsets)
        }
        else {
            expenses.personalItems.remove(atOffsets: offsets)
        }
    }
}

#Preview {
    ContentView()
}
