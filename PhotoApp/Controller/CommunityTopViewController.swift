//
//  CommunityTopViewController.swift
//  PhotoApp
//
//  Created by Yo Higashida on 2022/06/29.
//

import UIKit
import FirebaseFirestore

class CommunityTopViewController: UIViewController {
    
    var members: [Member] = []
    
    @IBOutlet var memberCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "PhotoApp"
        
        watchFirestore()
        
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        memberCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
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
        cell.imageWidth = Double(self.view.bounds.width/3 - 17)
        cell.setCellFromMember(member: members[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "CommunityMemberVC") as! CommunityMemberViewController
        nextVC.member = members[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // ????????????????????????????????????UICollectionViewDelegateFlowLayout ????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // ??????????????????????????????
        let cellSize:CGFloat = self.view.bounds.width/3 - 17
        // ???????????????????????????width,height??????????????????
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // ??????????????????????????????????????????????????????????????????UICollectionViewDelegateFlowLayout ????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    // ??????????????????????????????????????????????????????UICollectionViewDelegateFlowLayout ????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension CommunityTopViewController {
    func watchFirestore() {
        let db = Firestore.firestore()
        db.collection("member")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.members = []
                documents.forEach{
                    let member = Member(document: $0)
                    self.members.append(member)
                    self.memberCollectionView.reloadData()
                }
            }
    }
}
