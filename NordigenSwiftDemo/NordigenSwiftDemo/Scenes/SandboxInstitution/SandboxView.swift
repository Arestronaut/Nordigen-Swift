//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import NordigenSwift
import SwiftUI

struct SandboxView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel: SandboxViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Account Information")
                .font(.title2)

            if let account = viewModel.account {
                accountView(account)
            } else {
                Text("Not Provided")
            }

            Divider()

            Text("Balances")
                .font(.title2)

            let balances = viewModel.balances
            if !balances.isEmpty {
                ForEach(balances, id: \.self) { balance in
                    Text("Amount: ").font(.title3) + Text(balance.balanceAmount.description)
                }
            } else {
                Text("Not provided")
            }

            Divider()

            Text("Transactions")
                .font(.title2)

            HStack {
                VStack(alignment: .leading) {
                    DatePicker("From", selection: $viewModel.fromDate, displayedComponents: .date)
                        .datePickerStyle(.compact)

                    DatePicker("To", selection: $viewModel.toDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }

                Spacer()

                Button {
                    viewModel.loadTransactions()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(6.0)
                }
            }

            if let transactions = viewModel.transactions, !(transactions.booked.isEmpty && transactions.pending.isEmpty) {
                List {
                    if !transactions.pending.isEmpty {
                        Text("Pending")
                            .font(.title3)
                            .bold()
                        ForEach(transactions.pending, id: \.self) { transaction in
                            transactionView(transaction)
                        }
                    }

                    if !transactions.booked.isEmpty {
                        Text("Booked")
                            .font(.title3)
                            .bold()
                        ForEach(transactions.booked, id: \.self) { transaction in
                            transactionView(transaction)
                        }
                    }
                }
                .ignoresSafeArea(.all)
                .listStyle(.plain)
            } else {
                Text("Not provided")
            }

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .showLoading("sandbox_view.is_loading_account.alert.title", isLoading: $viewModel.isLoadingAccount)
        .showLoading("sandbox_view.is_loading_balances.alert.title", isLoading: $viewModel.isLoadingBalances)
        .showLoading("sandbox_view.is_loading_transactions.alert.title", isLoading: $viewModel.isLoadingTransactions)
        .onReceive(viewModel.dismissPublisher, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
        .task(priority: .background) {
            await viewModel.loadAccount()
            await viewModel.loadBalances()
        }
    }

    private func accountView(_ account: Account) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Account Holder: ").font(.title3) + Text(account.ownerName).font(.body)
                Text("IBAN: ").font(.title3) + Text(account.iban).font(.body)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(Color.black, lineWidth: 1.0)
        }
    }

    private func transactionView(_ transaction: NordigenSwift.Transaction) -> some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack {
                Text(transaction.debtorName ?? "Debtor unkown")
                Spacer()
                Text(transaction.bookingDate ?? Date(), format: .dateTime)
            }

            Text(transaction.transactionAmount.description)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(Color.black, lineWidth: 1.0)
        }
        .listRowSeparator(.hidden)
    }
}

