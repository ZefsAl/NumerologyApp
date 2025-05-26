//
//  LocationSearchVC.swift
//  Numerology
//
//  Created by Serj on 27.01.2024.
//

import UIKit
import MapKit

protocol LocationValueDelegate {
    func getLocationString(value: String)
}


class LocationSearchView: UIView {
    
    lazy var locationValueDelegate: LocationValueDelegate? = nil
    
    lazy var completer: MKLocalSearchCompleter = {
       let lsc = MKLocalSearchCompleter()
        lsc.delegate = self
        lsc.region = MKCoordinateRegion(.world)
        lsc.filterType = .locationsOnly
        lsc.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        return lsc
    }()
    
     var searchCompletion: [MKLocalSearchCompletion] = []
    
    // MARK: - set Search Bar
//    private func setSearchBar() {
//        let sb = UISearchBar(frame: .zero)
//        sb.searchBarStyle = UISearchBar.Style.default
//        sb.placeholder = "Search"
//        sb.sizeToFit()
//        sb.isTranslucent = false
//        sb.backgroundImage = UIImage()
//        sb.delegate = self
//        self.navigationItem.titleView = sb
//    }
    
    lazy var searchTableView: UITableView = {
        let sv = UITableView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.delegate = self
        sv.dataSource = self
        sv.backgroundColor = .clear
        return sv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //
        styleConfig()
        setConsraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleConfig() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
        self.layer.cornerRadius = DS.maxCornerRadius
        // Border
        self.layer.borderWidth = DS.borderWidth
        self.layer.borderColor = #colorLiteral(red: 0.7607843137, green: 0.4705882353, blue: 0.9529411765, alpha: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0.7450980392, green: 0.4705882353, blue: 0.9490196078, alpha: 0.5)
    }
    
    // MARK: - view Did Load
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    
    private func setConsraints() {
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.addSubview(searchTableView)
        let margin = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 0),
            searchTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            searchTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            searchTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
}



// MARK: - UI Search Bar Delegate
extension LocationSearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if textSearched != "" {
            searchFor(term: textSearched)
        } else {
            self.searchCompletion = []
            self.searchTableView.reloadData()
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
}

extension LocationSearchView: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchCompletion = completer.results
        self.searchTableView.reloadData()
    }
    
    func searchFor(term: String) {
        completer.queryFragment = term
    }
}

// MARK: - UITableView
extension LocationSearchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchCompletion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.backgroundColor = .clear
        cell?.textLabel?.text = "\(searchCompletion[indexPath.row].title), \(searchCompletion[indexPath.row].subtitle)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let val = "\(searchCompletion[indexPath.row].title), \(searchCompletion[indexPath.row].subtitle)"
        locationValueDelegate?.getLocationString(value: val)
//        self.dismiss(animated: true)
    }
    
}
