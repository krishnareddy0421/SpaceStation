//
//  PassesTableViewController.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import UIKit
import EZLoadingActivity

class PassesTableViewController: UITableViewController {

    var userLocation: Location?
    var responseReceived: WebResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let usrLocation = userLocation {
            EZLoadingActivity.show("Loading...", disableUI: true)
            APIManager.fetchISSPasses(latitude: usrLocation.latitude, longitude: usrLocation.longitude, onComplete: { (response) in
                DispatchQueue.main.async {
                    EZLoadingActivity.hide(true, animated: true)
                    if let rcvdResponse = response {
                        self.responseReceived = rcvdResponse
                        self.tableView.reloadData()
                    } else {
                        self.showAlert(message: "Failed to fetch ISS details. Go back and try again")
                    }
                }
            })
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let resp = responseReceived {
            return resp.response.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ISSPass", for: indexPath)

        if let resp = responseReceived {
            let item = resp.response[indexPath.row]
            cell.textLabel?.text = "Date : " + Utility.getTimeStamp(for: item.risetime)
            cell.detailTextLabel?.text = "Duration : " + Utility.secondsToHoursMinutesSeconds(seconds: item.duration)
        }

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
