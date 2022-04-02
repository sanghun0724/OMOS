//
//  Search + Table.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import UIKit

extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == selfView.bestTableView {
            return 10
        } else {
            return 10
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if tableView == selfView.bestTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: BestSearchTableCell.identifier, for: indexPath) as! BestSearchTableCell
            switch indexPath.row {
            case 0:
                cell.rankLabel.text = "1"
                cell.bestLabel.text = "아이유"
            case 1:
                cell.rankLabel.text = "2"
                cell.bestLabel.text = "장범준"
            case 3:
                cell.rankLabel.text = "3"
                cell.bestLabel.text = "BTS"
            case 4:
                cell.rankLabel.text = "4"
                cell.bestLabel.text = "에일리"
            case 5:
                cell.rankLabel.text = "5"
                cell.bestLabel.text = "크러쉬"
            case 6:
                cell.rankLabel.text = "6"
                cell.bestLabel.text = "박재범"
            case 7:
                cell.rankLabel.text = "7"
                cell.bestLabel.text = "태연"
            case 8:
                cell.rankLabel.text = "8"
                cell.bestLabel.text = "김범수"
            case 9:
                cell.rankLabel.text = "9"
                cell.bestLabel.text = "검정치마"
            default:
                cell.bestLabel.text = "에스파"
            }
            return cell
        } else {
            
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
              cell.textLabel?.text = "겔겔겔"
              return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BestHeaderView.identtifier) as! BestHeaderView
        if tableView == selfView.bestTableView {
            return header
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == selfView.bestTableView {
            return 60
        } else {
            return 0
        }
    }
    
    
}
