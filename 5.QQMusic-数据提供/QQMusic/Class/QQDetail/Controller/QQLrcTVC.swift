//
//  QQLrcTVC.swift
//  QQMusic
//
//  Created by 单车 on 2020/4/2.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQLrcTVC: UITableViewController {

    var scrollRow = 0{
        didSet{
            
            if scrollRow == oldValue {
                return
            }
            let indexPath = NSIndexPath(row: scrollRow, section: 0)
            tableView.scrollToRow(at: indexPath as IndexPath, at: .middle, animated: true)
        }
    }
    
    var lrcMs : [QQLrcModel] = [QQLrcModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.separatorStyle = .none
        
        tableView.allowsSelection = false
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: tableView.height * 0.5, left: 0, bottom: tableView.height * 0.5, right: 0)

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcMs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "lrc"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
            cell?.backgroundColor = UIColor.clear
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = UIColor.white
//            cell?.selectionStyle = .none
        }
        let model = lrcMs[indexPath.row]
        
        cell?.textLabel?.text = model.lrcContent
        
        return cell!
        
        
    }
}
