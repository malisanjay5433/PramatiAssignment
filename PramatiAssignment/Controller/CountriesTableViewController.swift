//
//  CountriesTableViewController.swift
//  PramatiAssignment
//
//  Created by Sanjay Mali on 06/12/17.
//  Copyright © 2017 Sanjay Mali. All rights reserved.
//

import UIKit
class CountriesTableViewController:UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var searchbar: UISearchBar!
    var world_Countries = [String:String]()
    var world_List = NSMutableArray()
    var table_Data = [CountryModel]()
    var filtered_Data = [CountryModel]()
    var searchActive : Bool = false
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchbar.delegate = self
        self.tableView.rowHeight = 80
        tableView.backgroundView = UIImageView(image: UIImage(named: "2"))
        searchbar.placeholder = "Search here..."
        segmentedControl.selectedSegmentIndex = 0
        readFileContents()
    }
    
    // MARK: - Method for read text from file and parse it using model
    func readFileContents(){
        let filepath = Bundle.main.path(forResource: "File", ofType: "txt")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filepath!){
            do{
                let contents = try String(contentsOfFile: filepath!,encoding:String.Encoding.utf8)
                let countries = contents.components(separatedBy: "\n") as [String]
                for i in (0..<countries.count - 1){
                    let data = countries[i].components(separatedBy:",")
                    let list = CountryModel(name:"\(data[1])",population:"\(data[4])")
                    table_Data.append(list)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch let error as NSError{
                print(error)
            }
        }
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchActive == true {
            return filtered_Data.count
        }else{
            return table_Data.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CountryCell
        let kdata = table_Data[indexPath.row]
        let font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        if searchActive ==  true{
            if filtered_Data.count == 0{
                return cell
            }
            let fdata = filtered_Data[indexPath.row]
            cell.name_Lbl.text = fdata.name
            cell.population_Lbl.text = fdata.population
            cell.name_Lbl.font = font
        }else{
            cell.name_Lbl.text = kdata.name
            if kdata.population == ""{
                cell.population_Lbl.text = "0"
            }else{
                cell.population_Lbl.text = kdata.population
            }
            
        }
        cell.name_Lbl.font = font
        cell.population_Lbl.font = font
        cell.name_Lbl.textColor = UIColor.white
        cell.population_Lbl.textColor = UIColor.white
        return cell
    }
}
extension  CountriesTableViewController{
    // MARK: - Searchbar Delegate methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered_Data = table_Data.filter({ (model:CountryModel) -> Bool in
            return model.name?.lowercased().range(of:searchText.lowercased()) != nil
        })
        if searchText != ""{
            searchActive = true
            self.tableView.reloadData()
            
        }else{
            searchActive = false
            self.tableView.reloadData()
        }
    }
    @IBAction func indexChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            print("First Segment Selected")
            self.asc_sortList()
        case 1:
            print ("Second Segment Selected")
            self.des_sortList()
        default:
            break
        }
    }
    func des_sortList() { // should probably be called sort and not filter
        let data = self.table_Data.sorted(by:{ $0.population! > $1.population!})
        self.table_Data = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func asc_sortList() { // should probably be called sort and not filter
        let data = self.table_Data.sorted(by:{ $0.population! < $1.population!})
        self.table_Data = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
