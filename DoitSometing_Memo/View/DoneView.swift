//
//  TodoView.swift
//  DoitSometing_Memo
//
//  Created by kiakim on 2023/09/18.
//

import UIKit
import SnapKit

class DoneView : UIView, UITableViewDelegate, UITableViewDataSource {
       
    
    let deleteButton : UIButton = {
       let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        return  button
    }()
    
    let doneTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: tableView
extension DoneView {
    
 //[bug] 이 테이블뷰에서는 isDone값이 true인것만 보여주고 싶은데, false인 cell이 포함되서 나타나고 있어 어떻게 수정하면 좋을지 알려줘


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsList.filter { $0.isDone == true}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        //필터링된 내용만 보여줄수있도록 ... !
        let doneContents = contentsList.filter { $0.isDone == true }
        let contentsList = doneContents[indexPath.row]
        cell.checkIconUI(with: contentsList)

        cell.userInput.text = contentsList.contents
     return cell
    }
    
    
}

extension DoneView {
    func setupUI(){
//        self.backgroundColor = UIColor.systemBlue
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.addSubview(deleteButton)
        self.addSubview(doneTableView)
        doneTableView.delegate = self
        doneTableView.dataSource = self
        
        deleteButton.layer.borderColor = UIColor.systemBlue.cgColor
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.cornerRadius = 10
        deleteButton.setTitleColor(UIColor.systemBlue, for: .normal)
        deleteButton.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
    }
        
        doneTableView.backgroundColor = UIColor.systemBlue
        doneTableView.snp.makeConstraints { make in
            make.top.equalTo(deleteButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(10)
        }
        
 

    }
    
}


