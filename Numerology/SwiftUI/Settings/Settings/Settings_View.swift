import SwiftUI
import RevenueCat

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    //
    @ObservedObject private var settingsViewModel = SettingsViewModel()
    //
    @State var isDestinationActive = false
    @State private var selectedModel: Setting?
    // Safari
    @State var presentURL: URL?
    // Alert
    @State var isShowingAlert: Bool = false
    @State var alertTitle = ""
    @State var alertMessage: String? = nil
    // Custom Alert
    @State var isCustomShowAlert: Bool = false
    //
    @State private var isAnimating = false
    
    var body: some View {
        List {
            ForEach(settingsViewModel.settings, id: \.self) { setting in
                SettingCellView(
                    actionHandler: {
                        action(model: setting)
                    },
                    customView: ChevronCellView(),
                    model: setting
                )
            }
        }
        
        .navigationBarTitle("Settings", displayMode: .automatic)
        
        .background(
            NavigationLink(
                destination: destinationView(for: selectedModel),
                isActive: $isDestinationActive
            ) {
                EmptyView()
            }.hidden()
        )
        .accentColor(.white)
        .sheet(item: $presentURL) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
        .customAlert(
            isPresented: $isCustomShowAlert,
            title: "Do you like this app?"
        ) {
            AppReview.requestReview()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isCustomShowAlert = false
            }
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage ?? ""),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
    
    func restorePurchases() {
        Purchases.shared.restorePurchases { (customerInfo, error) in
            if customerInfo?.entitlements.all["Access"]?.isActive == true {
                alertTitle = "Purchases restored"
                alertMessage = nil
            } else {
                alertTitle = "Purchases not restored"
                alertMessage = "We couldn't find your purchases"
            }
            // Показать алерт после получения результата
            self.isShowingAlert = true
        }
    }
    
    
    private func action(model: Setting) -> Void {
        
        switch model.settingType {
        case .lifetime:
            allowDestination()
        case .profile:
            allowDestination()
        case .music:
            allowDestination()
        case .rate:
            isDestinationActive = false
            self.withoutTransaction {
                isCustomShowAlert = true
            }
        case .terms:
            setUrl(AppSupportedLinks.terms.rawValue)
        case .privacy:
            setUrl(AppSupportedLinks.privacy.rawValue)
        case .support:
            setUrl(AppSupportedLinks.site.rawValue)
        case .restore:
            isDestinationActive = false
            self.restorePurchases()
            return
        case .none: return
        }
        
        func allowDestination() {
            self.isDestinationActive = true
            self.selectedModel = model
        }
        
        func setUrl(_ string: String) {
            if let url = URL(string: string) {
                presentURL = url
            }
        }
    }
    
    @ViewBuilder private func destinationView(for model: Setting?) -> some View {
        if let model = model {
            switch model.settingType {
            case .lifetime:
                SpecialOfferPaywall_SUI()
                    .ignoresSafeArea()
            case .profile:
                ProfileSetting()
            case .music:
                MusicSetting()
            default:
                Text("Unknown setting")
            }
        } else {
            EmptyView()
        }
    }
}


#Preview {
    SettingsView()
}

//
struct PlugView: View {
    let xome: String
    var body: some View {
        Text("Detail View for \(xome)")
            .navigationTitle(xome).navigationBarTitleDisplayMode(.inline)
    }
}

