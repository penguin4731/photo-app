//
//  CommunityTopViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/29.
//

import UIKit

class CommunityTopViewController: UIViewController {
    
    var members: [Member] = []
    
    @IBOutlet var memberCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Sample Community"
        
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        memberCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        // TODO: delete mock
        let memberIntroductionImage = MemberIntroductionImage(imageUrl: "https://guide.line.me/ja/dogday_01.jpg", title: "犬", discription: "実家では5匹犬を飼ってました")
        let memberSNS = MemberSNS(twitter: "", facebook: "", web: "")
        members.append(contentsOf: [
            Member(name: "田中太郎", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage, memberIntroductionImage, memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "山田花子", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "浅岡千代彦", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "風岡暢", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "山中裕一", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
            Member(name: "杉山眞太郎", mainImageUrl: "https://thebluegrasssituation.com/wp-content/uploads/2020/08/Square-Headshot-970x970-1.jpg", images: [memberIntroductionImage], sns: memberSNS, id: ""),
        ])
    }
    
    @IBAction func tappedAddButton() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "EditMemberVC") as! EditMemberViewController
        nextVC.isCreate = true
        let navigationController = UINavigationController(rootViewController: nextVC)
        present(navigationController, animated: true)
    }
}

extension CommunityTopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memberCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.setCellFromMember(member: members[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "CommunityMemberVC") as! CommunityMemberViewController
        nextVC.member = members[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // アイテムの大きさを設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のスペース調整
        let cellSize:CGFloat = self.view.bounds.width/3 - 17
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // アイテム表示領域全体の上下左右の余白を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    // アイテムの上下の余白の最小値を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
