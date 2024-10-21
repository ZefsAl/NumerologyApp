import SwiftUI
import RevenueCat

struct ChevronCellView: View {
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(uiColor: .systemGray3))
            }
        }
    }
}

extension URL: Identifiable {
    public var id: String {
        self.absoluteString
    }
}

struct SettingsView: View {
    @ObservedObject private var settingsViewModel = SettingsViewModel()
    //
    @State var isDestinationActive = false
    @State private var selectedModel: Setting?
    // Safari
    @State var presentURL: URL?
    // Alert
    @State var isShowingAlert = false {
        didSet {
            print("isShowingAlert", isShowingAlert)
        }
    }
    
    
    
    var body: some View {
        NavigationView {
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
                .background(
                    NavigationLink(
                        destination: destinationView(for: selectedModel),
                        isActive: $isDestinationActive
                    ) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
            .navigationTitle("Settings")
        }
        .accentColor(.white)
        .sheet(item: $presentURL) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage ?? ""),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
    
    
    
    @State var alertTitle = ""
    @State var alertMessage: String? = nil
    
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
            AppReview.requestReview()
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

