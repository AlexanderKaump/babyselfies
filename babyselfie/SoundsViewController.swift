//
//  SoundsViewController.swift
//  babyselfie
//
//  Created by Alexander Kaump on 8/6/16.
//  Copyright © 2016 Alexander Kaump. All rights reserved.
//

import UIKit

class SoundsViewController: UIViewController, UITableViewDelegate {
    
    var textArray = SoundAssist.dictReturn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        let object = textArray[indexPath.row]
        //get selected array
        let selectedArray = SoundAssist.returnSelect()
        
        //if array contains object["name"], set accessoryType to .Checkmark
        if selectedArray.contains(object["name"]!) {
            cell.accessoryType = .Checkmark
        }
        
        //else set accessoryType to .None
        else {
            cell.accessoryType = .None
        }
        
        cell.textLabel?.text =  object["name"]!        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select: \(indexPath)")
        let object = textArray[indexPath.row]
        
        let selectedArray = SoundAssist.returnSelect()

        
        if selectedArray.contains(object["name"]!) {
            SoundAssist.removeSelect(object["name"]!)
        }
        
        else {
            SoundAssist.addSelect(object["name"]!)
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
        
    }
    
}
