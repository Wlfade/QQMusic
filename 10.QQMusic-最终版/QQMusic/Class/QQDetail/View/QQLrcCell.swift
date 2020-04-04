//
//  QQLrcCell.swift
//  QQMusic
//
//  Created by 单车 on 2020/4/2.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQLrcCell: UITableViewCell {

    @IBOutlet weak var lrcLabel: QQLrcLabel!
    
    var progress : CGFloat = 0 {
        didSet{
            lrcLabel.radio = progress
        }
    }
    
    
    var lrcContent : String = ""{
        didSet{
            lrcLabel.text = lrcContent
        }
    }
    
    
    class func cellWithTableView(tableView : UITableView) -> QQLrcCell {
        let cellID = "lrc"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? QQLrcCell
        if cell == nil {
            
            cell = Bundle.main.loadNibNamed("QQLrcCell", owner: nil, options: nil)?.first as? QQLrcCell

            cell?.backgroundColor = UIColor.clear
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = UIColor.white
    //            cell?.selectionStyle = .none
        }
        return cell!
        
    }
}
