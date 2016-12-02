//
//  ViewController.swift
//  blue2th
//
//  Created by Veeha Khanna on 11/9/16.
//  Copyright © 2016 Veeha Khanna. All rights reserved.
//
import CoreBluetooth
import UIKit
   
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate {
    
        var centralManager: CBCentralManager?
        var peripherals: Array<CBPeripheral> = Array<CBPeripheral>()
        
        @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad()
        {
            super.viewDidLoad()
            
            //Initialise CoreBluetooth Central Manager
            centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        
        //CoreBluetooth methods
        func centralManagerDidUpdateState(_ central: CBCentralManager)
        {
            if (central.state == CBManagerState.poweredOn)
            {
                self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
            }
            else
            {
                // do something like alert the user that ble is not on
            }
        }
        
        private func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber)
        {
            peripherals.append(peripheral)
            tableView.reloadData()
        }
        
        
        //UITableView methods
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            
            let peripheral = peripherals[indexPath.row]
            cell.textLabel?.text = peripheral.name
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return peripherals.count
        }
}


