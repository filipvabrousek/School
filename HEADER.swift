//
//  ViewController.swift
//  Sticky-tv
//
//  Created by Filip Vabroušek on 09/01/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var hheight: NSLayoutConstraint?
    
    
    let imv: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "jumpl.png") // jumpf
        i.contentMode = .scaleAspectFill // sclaAspectFill
        i.clipsToBounds = false
        return i
    }()
    
    
    let lbl: UILabel = {
        var l = UILabel()
        l.text = "Breca Wanaka 19"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.black)
        l.textColor = .white
        return l
    }()
    
    lazy var tableView: UITableView = {
        var t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.allowsSelection = false
        t.register(UITableViewCell.self, forCellReuseIdentifier: "UCell")
        t.backgroundColor = .clear
        t.alpha = 1.0
        return t
    }()
    
    
    var hw: UIView = {
       let v = UIView()
       v.backgroundColor = .orange
       return v
    }()
    
    
    
    var perc: UILabel = {
       let l = UILabel()
        l.text = "scrolled"
        l.textColor = .orange
        return l
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        view.addSubview(hw)
        hw.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hw.topAnchor.constraint(equalTo: view.topAnchor),
            hw.leftAnchor.constraint(equalTo: view.leftAnchor),
            hw.rightAnchor.constraint(equalTo: view.rightAnchor),
            ])
        
        hheight = hw.heightAnchor.constraint(equalToConstant: 600)
        hheight?.isActive = true
        
        hw.addSubview(imv)
        hw.addSubview(lbl)
        
        view.addSubview(tableView)
        view.addSubview(perc)
      
        
        imv.fillsuperview(top: 0, left: 0, right: 0, bottom: 0)
    
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
       
        lbl.pin(a: .top, b: .left, ac: 53, bc: 0, w: view.frame.width, h: 30, to: nil)
        //lbl.stretch(within: hw, insets: [0,0,0,0])
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    let users = ["FIRST", "Petr", "Eva", "Marek","Filip", "Petr", "Eva", "Marek","Filip", "Petr", "Eva", "Marek","Filip", "Petr", "Eva", "Marek","Filip", "Petr", "Eva", "Marek", "Filip", "Petr", "Eva", "Marek","Filip", "Petr", "Eva", "Marek","Filip", "Petr", "Eva", "Marek","Filip", "Petr", "Eva", "LAST",]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UCell")
        cell?.textLabel?.text = users[indexPath.row]
        return cell!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
}




extension ViewController:UIScrollViewDelegate {
    
    func animateHeader() {
        self.hheight?.constant = 600
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if Double((self.hheight?.constant)!) > 600.0 {
            animateHeader()
        }
    }
    
  
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
          
            if Int((self.hheight?.constant)!) < 670 { // < 670
            self.hheight!.constant += abs(scrollView.contentOffset.y) / 7
            }
            
        
        }
        else if scrollView.contentOffset.y > 0 && self.hheight!.constant >= 600 {
            self.hheight!.constant -= scrollView.contentOffset.y / 7 // 6
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}







/*
 func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
 if Double((self.hheight?.constant)!) > 600.0 {
 animateHeader()
 }
 } */
