//
//  QQLrcTVC.swift
//  QQMusic
//
//  Created by 单车 on 2020/4/2.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQLrcTVC: UITableViewController {

    ///提供给外界赋值的进度
    var progress:CGFloat = 0{
        didSet{
            //拿到当前正在播放的Cell
            let indexPath = NSIndexPath(row: scrollRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as? QQLrcCell
            
            cell?.progress = progress
            

            
        }
    }
    
    ///提供给外界的数值，代表需要滚动的行数
    var scrollRow = -1{
        didSet{
            
            if scrollRow == oldValue {
                return
            }
            
            //先刷新tableView 可见的 cell
            let indexPaths = tableView.indexPathsForVisibleRows
            tableView.reloadRows(at: indexPaths!, with: .fade)
            
            //再滚动
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
        
        let cell = QQLrcCell.cellWithTableView(tableView: tableView)
        
        //取出歌词模型
        let model = lrcMs[indexPath.row]

        if indexPath.row == scrollRow {
            cell.progress = progress
        }else{
            cell.progress = 0
        }
        
        //给 cell 展示
        cell.lrcContent = model.lrcContent
        
        return cell
        
        
    }
}
