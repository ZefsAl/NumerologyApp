//
//  Profile_View.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

// MARK: - Profile Setting View
struct ProfileSetting: View {
    @Environment(\.presentationMode) var presentationMode
    //
    @ObservedObject var settingsVM = SettingsViewModel()
    //
    @State private var showSaveAlert: Bool = false
    @State private var saveAlertText: String = ""
    //
    @State private var showDeleteAlert: Bool = false
    //
    let deleteButtonModel = Setting(
        settingType: nil,
        title: "Delete user data",
        color: Color(UIColor.systemRed),
        imageName: "trash.fill"
    )
    
    var body: some View {
        VStack {
            if DeviceMenager.isSmallDevice {
                self.setupList()
            } else {
                NavigationView() {
                    self.setupList()
                        .environment(\.defaultMinListHeaderHeight, 0)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Profile", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    backAndSave()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 17, weight: .semibold))
                        Text("Settings")
                    }
                    .foregroundStyle(.white)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x: -8)
            }
        }
        .alert(isPresented: $showSaveAlert) {
            Alert(
                title: Text(self.saveAlertText),
                dismissButton: .cancel() {}
            )
        }
        
    }// view end
    
    
    @ViewBuilder func setupList() -> some View {
        List {
            Section(header: Text("Name").textCase(nil)) {
                PlainTextField_SUI(
                    enteredText: self.$settingsVM.name,
                    setPlaceholder: "Enter name"
                )
            }
            Section(header: Text("Surname").textCase(nil)) {
                PlainTextField_SUI(
                    enteredText: self.$settingsVM.surname,
                    setPlaceholder: "Enter surname"
                )
            }
            Section(header: Text("Date of birth").textCase(nil)) {
                DatePickerTF_SUI(
                    date: self.$settingsVM.dateOfBirth,
                    setPlaceholder: "Select date"
                )
            }
            Section(header: Text("").textCase(nil)) {
                SettingCellView<EmptyView>(
                    actionHandler: {
                        // MARK: - Delete
                        self.showDeleteAlert = true
                    },
                    customView: EmptyView(),
                    model: deleteButtonModel
                )
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text("Your data will be deleted and the app will start over."),
                        primaryButton: .destructive(Text("Delete")) {
                            deleteAct()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
    private func deleteAct() {
        // костыль какой то ?
        UserDataKvoManager.shared.set(type: .name, value: nil)
        UserDataKvoManager.shared.set(type: .surname, value: nil)
        UserDataKvoManager.shared.set(type: .dateOfBirth, value: nil)
        self.settingsVM.name = nil
        self.settingsVM.surname = nil
        self.settingsVM.dateOfBirth = nil
        //
        AppFlowRoute.shared.setAppFlow(.onboarding, animated: true)
    }
    
    private func backAndSave() {
        guard
            let name = self.settingsVM.name,
            let surname = self.settingsVM.surname,
            let dateOfBirthVal = self.settingsVM.dateOfBirth,
            name != "",
            surname != "",
            self.settingsVM.dateOfBirth != nil
        else {
            self.saveAlertText = "Fields must be filled!"
            self.showSaveAlert = true
            return
        }
        // MARK: - Save
        UserDataKvoManager.shared.set(type: .name, value: name)
        UserDataKvoManager.shared.set(type: .surname, value: surname)
        UserDataKvoManager.shared.set(type: .dateOfBirth, value: dateOfBirthVal)
        presentationMode.wrappedValue.dismiss()
    }
    
}

#Preview {
    ProfileSetting()
}



class AlertModel: Identifiable, ObservableObject {
    let id = UUID()
    
    let alertTitle: String = ""
    let message: String = ""
    
    let primaryButtonText: String? = nil
    let secondaryButtonText: String? = nil
}
