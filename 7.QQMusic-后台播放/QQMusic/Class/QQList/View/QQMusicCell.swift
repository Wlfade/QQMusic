//
//  QQMusicCell.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit


class QQMusicCell: UITableViewCell {
    
    var musicModel : QQMusicModel?{
        didSet{
            signerIconImageView.image = UIImage(named: (musicModel?.singerIcon)!)
            songNameLabel.text = musicModel?.name
            singerNameLabel.text = musicModel?.singer
        }
    }
    
    @IBOutlet weak var signerIconImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var singerNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        signerIconImageView.layer.cornerRadius = signerIconImageView.width / 2
        signerIconImageView.layer.masksToBounds = true
    }
    
    class func cellWithTableView(tableView:UITableView)->QQMusicCell{
        let cellID = "music"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? QQMusicCell
        if cell == nil {
            print("test")
            cell = Bundle.main.loadNibNamed("QQMusicCell", owner: nil, options: nil)?.first as? QQMusicCell
        }
        
        return cell!
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
