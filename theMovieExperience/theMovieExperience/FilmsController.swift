//
//  TableViewController.swift
//  coursIos2
//
//  Created by GwenaelMarchetti on 23/03/2021.
//

import UIKit




struct Artist{
    let name: String
    let urlPage: String
}

extension Artist{ // voir comment structurer les donné de l'artiste via un json recu pour un artiste; new Artist; .name = json["name"] par ex ?)

    init?(json: [String: AnyObject]) {
        guard let name = json["name"] as? String,
            let urlPage = json["coordinates"] as? String
        else {
            return nil
        }

        self.name = name
        self.urlPage = urlPage
    }

}


class FilmsController: UITableViewController {

    /*
     var browser :[String] = [
    "http://www.google.com",
    "http://www.amazon.com",
    "http://www.facebook.com",
    "http://www.apple.com",
    "http://www.microsoft.com",
    ]*/
    var browser :[Artist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //self.getDataApiFoot();
        self.getDataApiDeezer();

    }

    
    func getDataApiDeezer(){
        self.browser.removeAll()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
       
        let url = URL(string: "http://api.deezer.com/search?q=halliday")!
        //?q= mettreUneStringPourChercher //exemple jean pour trouver tous ceux avec le nom jean

        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        
                        if let items = data["data"] as? [[String: AnyObject]] {
                            for item in items {
                                print(item["link"]!)
                                if let artist = Artist(json:item){
                                    self.browser.append(artist)
                                }
                            }
                        }
                    }
                }
            }
            
            /**
                used to launch after getting data from API asynchronously
             */
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        task.resume()
    }
    
    /**
        only to get data from a specific API, here francefootball
    */
    func getDataApiFoot(){
        self.browser.removeAll()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
       
        let url = URL(string: "http://app.francefootball.fr/json/les_plus/plus.json")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [[String: AnyObject]] {
                        
                        if let items = data[1]["items"] as? [[String: AnyObject]] {
                            for item in items {
                                print(item["titre"]!)
                                //self.browser.append(item["fullUrl"]! as! String)
                            }
                        }
                    }
                }
            }
            
            /**
                used to launch after getting data from API asynchronously
             */
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        task.resume()
                
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
            return self.browser.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        /*cell.textLabel?.text = self.browser[indexPath.row] + " section : \(indexPath.section) +row : \(indexPath.row)"*/
        cell.textLabel?.text = self.browser[indexPath.row].name

        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.purple
        }
        else{
            cell.backgroundColor = UIColor.yellow
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController( identifier:"webView") as? WebViewController{
            //vc.linkBrowser = self.browser[indexPath.row]
            vc.linkBrowser = self.browser[indexPath.row].urlPage
            self.present(vc, animated:true , completion:nil)
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
