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


class LocationSearchVC: UIViewController {
    
    lazy var locationValueDelegate: LocationValueDelegate? = nil
    
    private lazy var completer: MKLocalSearchCompleter = {
       let lsc = MKLocalSearchCompleter()
        lsc.delegate = self
        lsc.region = MKCoordinateRegion(.world)
        lsc.filterType = .locationsOnly
        lsc.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        return lsc
    }()
    
    private var searchCompletion: [MKLocalSearchCompletion] = []
    
    // MARK: - set Search Bar
    private func setSearchBar() {
        let sb = UISearchBar(frame: .zero)
        sb.searchBarStyle = UISearchBar.Style.default
        sb.placeholder = "Search"
        sb.sizeToFit()
        sb.isTranslucent = false
        sb.backgroundImage = UIImage()
        sb.delegate = self
        self.navigationItem.titleView = sb
    }
    
    private lazy var searchTableView: UITableView = {
        let sv = UITableView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.delegate = self
        sv.dataSource = self
        sv.backgroundColor = .black
        return sv
    }()
    
    // MARK: - view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setSearchBar()
        setConsraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setConsraints() {
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(searchTableView)
        let margin = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 0),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}



// MARK: - UI Search Bar Delegate
extension LocationSearchVC: UISearchBarDelegate {
    
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

extension LocationSearchVC: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchCompletion = completer.results
        self.searchTableView.reloadData()
    }
    
    func searchFor(term: String) {
        completer.queryFragment = term
    }
}

// MARK: - UITableView
extension LocationSearchVC: UITableViewDelegate, UITableViewDataSource {
    
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
        self.dismiss(animated: true)
    }
    
}
