//
//  ViewController.swift
//  facts
//
//  Created by Do Xuan Thanh on 4/3/19.
//  Copyright © 2019 monstar-lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var factImage: UIImageView!
    @IBOutlet weak var factText: UITextView!
    @IBOutlet weak var moreButton: UIButton!
    var detailLink: String?
    var nextLink: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        factText.isEditable = false
        guard let card = Card(link: nil) else { return }
        updateViewForCard(card)
        
        //swipe gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    private func updateViewForCard(_ card: Card) {
        let data = try? Data(contentsOf: URL(string: card.image)!)
        factImage.image = UIImage(data: data!)
        
        factText.text = card.fact
        nextLink = URL(string: "\(Config.RootUrl)\(card.nexLink)")
        detailLink = card.detailLink
        if detailLink == nil {
            moreButton.isHidden = true
        } else {
            moreButton.isHidden = false
        }
    }
    
    @objc private func nextCard() {
        guard let card = Card(link: nextLink) else { return }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.updateViewForCard(card)
        }, completion: nil)
    }

    @IBAction func seeMore(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! DetailViewController
        des.link = detailLink
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

