//
//  HistoryViewController.swift
//  testTutti
//
//  Created by hugo roman on 7/8/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class HistoryViewController: UITableViewController {
    
    //for url only
    var ret : ConnectionResult = .NoCredentials
    var tableData : [RecordCard] = []
    let historyCellIdentifier = "historyCell"
    
    @IBOutlet var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.setNavigationBarHidden(true, animated: false)
        self.configureTableView()
    }

    override func viewDidAppear(animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: false)
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
        print(myUtils.currentTimeMillis())
        
        uGoClient.sharedInstance().uGOHistoryRecord() {(result, error) -> Void in
            if let _ = result as ConnectionResult! {
                uGoClient.sharedInstance().isConnected = true
                if (result == ConnectionResult.Success){
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableData = uGoClient.sharedInstance().myHistoryRecords
                        self.tableView.reloadData()
                        activityView.stopAnimating()
                        print(myUtils.currentTimeMillis())
                    })
                }
                if (result == ConnectionResult.ServerError){
                    CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "Error en servidor uGo", myActionTitle: "Error", myActionStyle: .Default)
                }
                if (result == ConnectionResult.NoCredentials){
                    CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "Error en credenciales uGo", myActionTitle: "Error", myActionStyle: .Default)
                }
                if (result == ConnectionResult.TimeOut){
                    CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "uGo con time out", myActionTitle: "Error", myActionStyle: .Default)
                }
                if (result == ConnectionResult.NoConnection){
                    CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "uGo sin comunicación", myActionTitle: "Error", myActionStyle: .Default)
                }
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        //
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return historyCellAtIndexPath(indexPath)
    }
    
    func historyCellAtIndexPath(indexPath:NSIndexPath) -> HistoryCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(historyCellIdentifier) as! HistoryCell
        let record = tableData[indexPath.row] as RecordCard
        cell.titleLabel.text = record.rcTipoEvento ?? "[No event]"
        cell.subtitleLabel.text = record.rcFecServidor ?? record.rcDispositivo
        if record.rcTipoEvento == "Entrada"{
            cell.eventImage.image = UIImage(named: "entrada.png")
        }
        if record.rcTipoEvento == "Salida"{
            cell.eventImage.image = UIImage(named: "salida.png")
        }
        if record.rcDispositivo == "A"{
            cell.deviceImage.image = UIImage(named: "android.png")
        }
        if record.rcDispositivo == "I"{
            cell.deviceImage.image = UIImage(named: "apple.png")
        }
        if record.rcDispositivo == "E"{
            cell.deviceImage.image = UIImage(named: "intranet.png")
        }
        if record.rcDispositivo == "P"{
            cell.deviceImage.image = UIImage(named: "tablet.png")
        }
        if record.rcValLatitud == "" || record.rcValLongitud == ""{
            cell.gpsImage.hidden = true
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let indexPath = self.tableView.indexPathForSelectedRow!
        let record = tableData[indexPath.row] as RecordCard
        if record.rcValLatitud == "" || record.rcValLongitud == "" {
            return
        }
        let mapViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailRecordHistoryViewController") as? DetailRecordHistoryViewController
        mapViewController!.myRecord = record
        self.navigationController?.pushViewController(mapViewController!, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    func configureTableView()->Void {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 220.0
    }

}


