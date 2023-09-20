//
//  TodoView.swift
//  DoitSometing_Memo
//
//  Created by kiakim on 2023/09/18.
//

import UIKit
import SnapKit

class TodoView : UIView, UITableViewDelegate, UITableViewDataSource {
    
    // UIViewController에 대한 참조
    weak var viewController: UIViewController?
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.addTarget(self, action: #selector(addCell), for: .touchUpInside)
        return button
    }()
    
    let toDoTableView: UITableView = {
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
extension TodoView {
    //행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsList.count
    }
    
    //View에 표현할 내용을 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.saveIndexRow(indexPath.row)
        
        let contentsList = contentsList[indexPath.row]
        cell.checkIconUI(with: contentsList)
        cell.userInput.text = contentsList.contents
        
        
        
        return cell
    }
    
    
}
//MARK: Method
extension TodoView {
    
    
    @objc func addCell (){
        //알럿채우기
        let alert = UIAlertController(title: "할일 추가하기", message: "", preferredStyle: .alert)
        // placeholder 외의 다른 기능이 있나 ?
        alert.addTextField{(UITextField:UITextField)in UITextField.placeholder = "추가하기"}
        
        let addAction = UIAlertAction(title: "완료", style: .default){[weak self] _ in
            if let textField = alert.textFields?.first,
               let contentsTextField = textField.text,
               !contentsTextField.isEmpty {
                
                //1. TodoData type에 따라, addTodoData 인스턴스 생성
                let addTodoData = TodoData(contents: contentsTextField, isDone: false)
                
                //2. contentsList 배열에 추가
                contentsList.append(addTodoData)
                self?.toDoTableView.reloadData()
                            
                //3. userDefaults에 추가하기
                TodoDataManager.shared.saveUserDefaluts()
                TodoDataManager.shared.loadUserDefaluts()
                
                
                // 4.userDefaults 저장됬는지 확인
                if let savedData = UserDefaults.standard.data(forKey: addTodoData.contents),
                   let decodedData = try? JSONDecoder().decode([TodoData].self, from: savedData) {
                    print("UserDefaults에 저장된 내용: \(decodedData)")
                } else {
                    print("UserDefaults에 저장된 내용이 없거나 읽을 수 없습니다.")
                }
            }
            
            
        }
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel){ (cancle) in
            
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        self.viewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}






extension TodoView {
    func setupUI(){
        //        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.addSubview(addButton)
        self.addSubview(toDoTableView)
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        addButton.layer.borderWidth = 1
        addButton.layer.cornerRadius = 10
        addButton.setTitleColor(UIColor.systemBlue, for: .normal)
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        toDoTableView.backgroundColor = UIColor.systemBlue
        toDoTableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(10)
        }
        
        
    }
    
}

