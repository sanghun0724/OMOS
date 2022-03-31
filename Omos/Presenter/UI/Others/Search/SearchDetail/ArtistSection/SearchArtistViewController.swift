//
//  SearchArtistViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/28.
//

import UIKit

class SearchArtistViewController:BaseViewController {
    
    let topView = SearchArtistHeaderView()
    let viewModel:SearchArtistDetailViewModel
    let artistData:ArtistRespone
    let bottomViewController:SearchArtistTopTabViewController
    
    init(viewModel:SearchArtistDetailViewModel,artistData:ArtistRespone) {
        self.viewModel = viewModel
        self.artistData = artistData
        self.bottomViewController = SearchArtistTopTabViewController(viewModel: viewModel, artistId: artistData.artistID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.artistDetailTrackFetch(artistId: self.artistData.artistID)
        viewModel.artistDetailAlbumFetch(artistId: self.artistData.artistID, request: .init(artistId: artistData.artistName, limit: 20, offset: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func configureUI() {
        super.configureUI()
        setTopViewData()
        self.view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.166)
        }
        
        addContentsView()
        
    }
    
    
    private func addContentsView() {
        addChild(bottomViewController)
        self.view.addSubview(bottomViewController.view)
        
        bottomViewController.view.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        bottomViewController.didMove(toParent: self)
    }
    
    
    private func setTopViewData() {
        topView.artistImageView.setImage(with: artistData.artistImageURL ?? "")
        topView.titleLabel.text = artistData.artistName
        topView.subTitleLabel.text = artistData.genres.reduce("") { $0 + " \($1)" }
    }
}


