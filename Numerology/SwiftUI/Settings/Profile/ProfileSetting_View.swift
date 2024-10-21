//
//  Profile_View.swift
//  MapApp
//
//  Created by Serj_M1Pro on 04.10.2024.
//

import SwiftUI

// MARK: - Profile Setting View
struct ProfileSetting: View {
    @ObservedObject var settingsVM = SettingsViewModel()
    
    let deleteButtonModel = Setting(
        settingType: nil,
        title: "Delete user data",
        color: Color(UIColor.systemRed),
        imageName: "trash.fill"
    )
    
    
    
    

//    @State var name: String = UserDataKvoManager.shared.name ?? ""
//    @State var surname: String = UserDataKvoManager.shared.surname ?? ""
    
    
    
    
    var body: some View {
        List {
//            ForEach(settingsViewModel.profileSettingData, id: \.self) { data in
//                Section(header: Text(data.sectionTitle).textCase(nil)) {
//                    SettingTextFieldCell(inputText: data.cellText)
//                }
//            }
            
            Section(header: Text("Name").textCase(nil)) {
//                SettingTextFieldCell(inputText: "Enter your name")
                SettingTextFieldCell(inputText: self.$settingsVM.name)
            }
            Section(header: Text("Surname").textCase(nil)) {
                SettingTextFieldCell(inputText: self.$settingsVM.surname)
            }
            Section(header: Text("Date of birth").textCase(nil)) {
                CustomTF_SUI(date: self.$settingsVM.dateOfBirth, setPlaceholder: "\(setDateFormat(date: self.settingsVM.dateOfBirth ?? Date()))")
                
            }
            

            SettingCellView<EmptyView>(model: deleteButtonModel)
        }
        .navigationTitle("Profile").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                
                print(self.settingsVM.name)
                print(self.settingsVM.surname)
                print(self.settingsVM.dateOfBirth)
                
                
                
                guard
                    let dateOfBirthVal = self.settingsVM.dateOfBirth
                else { return }
                
                UserDataKvoManager.shared.set(type: .dateOfBirth, value: dateOfBirthVal)
                UserDataKvoManager.shared.set(type: .name, value: self.settingsVM.name)
                UserDataKvoManager.shared.set(type: .surname, value: self.settingsVM.surname)
                
                
//                guard
//                    let nameVal = self.name,
//                    let surnameVal = self.surname,
//                    let dateOfBirthVal = self.settingsVM.dateOfBirth
//                    let newDateOfBirth = self.newDateOfBirth ?? UserDefaults.standard.object(forKey: UserDefaultsKeys.dateOfBirth) as? Date
//                else {
//                    print("⚠️ Error getting data for save")
//                    return
//                }
                
//                if nameVal != "" && surnameVal != "" && dateOfBirthVal != nil {
//                    UserDataKvoManager.shared.set(type: .dateOfBirth, value: dateOfBirthVal)
//                    UserDataKvoManager.shared.set(type: .name, value: nameVal)
//                    UserDataKvoManager.shared.set(type: .surname, value: surnameVal)
//                    print("saved")
////                    self.navigationController?.popViewController(animated: true)
//                } else {
//                    print("NOT saved")
//                }
                
            } label: {
                Text("Save")
            }

        }
    }
}

#Preview {
    ProfileSetting()
}
