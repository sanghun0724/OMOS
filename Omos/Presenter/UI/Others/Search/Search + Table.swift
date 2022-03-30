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
            return cell
        } else {
            
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//              cell.textLabel?.text = item.name
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
