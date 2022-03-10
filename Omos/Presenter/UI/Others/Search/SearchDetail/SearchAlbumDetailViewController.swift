//
//  SearchAlbumDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import UIKit

class SearchAlbumDetailViewController:BaseViewController {
    
    let selfView = SearchAlbumDetailView()
    let viewModel:SearchAlbumDetailViewModel
    let albumInfo:AlbumRespone
    let searchType:SearchType
    
    init(viewModel:SearchAlbumDetailViewModel,albumInfo:AlbumRespone,searchType:SearchType) {
        self.viewModel = viewModel
        self.albumInfo = albumInfo
        self.searchType = searchType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        viewModel.albumDetailFetch(albumId: albumInfo.albumID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
    }
    
    func bind() {
        viewModel.albumDetails
            .subscribe(onNext: { [weak self] data in
                self?.selfView.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}


extension SearchAlbumDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentAlbumDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchAlbumDetailCell.identifier, for: indexPath) as! SearchAlbumDetailCell
        self.searchType == .me ? (cell.createdButton.isHidden = false) : (cell.createdButton.isHidden = true)
        let cellData = viewModel.currentAlbumDetails[indexPath.row]
        cell.configureModel(albumDetail: cellData,count:indexPath.row+1)
        if searchType == .me {
            cell.createdButton.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    print("click")
                    let vc = CategoryViewController(defaultModel: .init(musicId:cellData.musicID, imageURL:self?.albumInfo.albumImageURL ?? "" , musicTitle: cellData.musicTitle, subTitle: cellData.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"}))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }).disposed(by: cell.disposeBag)
        }
      
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.mainHeight * 0.06
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchAlbumDetailHeader.identifier) as! SearchAlbumDetailHeader
        headerView.titleLabel.text = albumInfo.albumTitle
        headerView.subTitleLabel.text = albumInfo.artists.map { $0.artistName }.reduce("") { $0 + " \($1)"}
        headerView.createdLabel.text = albumInfo.releaseDate
        headerView.albumImageView.setImage(with: albumInfo.albumImageURL)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.mainBackGround
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.365
    }
    
}
