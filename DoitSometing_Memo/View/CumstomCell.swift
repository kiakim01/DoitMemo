//
//  CumstomCell.swift
//  DoitSometing_Memo
//
//  Created by kiakim on 2023/09/18.
//

import UIKit

class CustomCell : UITableViewCell{
    
    var isDoneHandler:((Bool)->Void)?
    
    private var row = 0
    
    //MARK: property
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
//                label.backgroundColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 20)
        label.widthAnchor.constraint(equalToConstant: 65).isActive = true
        //        label.frame = CGRect(x: 0, y: 0, width: 65, height: 25)
        //        label.layer.addBorder([.right], color: UIColor.gray, width: 0.5)
        return label
    }()
    
    let userInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
//        textField.backgroundColor = UIColor.lightGray
        textField.font = UIFont.systemFont(ofSize: 20)
        
        let placeholderPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = placeholderPadding
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let isDoneButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(changeIsDoneValue), for: .touchUpInside)
        return button
    }()
    
    
    let checkIcon : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "checkmark.circle")
        return view
    }()
    
    
    //customCell을 만들때 작성하는 형식으로, 초기화 과정을 다루고 있음
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        //셀의 스타일과, 재사용 식별자를 매개변수로 받고 있음.
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setLayout()
    }
    
    
    
    
    required init?(coder: NSCoder) {
        //1번: 스토리보드에서 셀을 초기화 하지 않도록 강제(스토리보드를 사용하지 않았음으로 1번 코드 채택)
        fatalError("init(coder:) has not been implemented")
        //2번 :super.init을 호출해서 셀을 초기화 할수있도록 함.
        //        super.init(coder: coder)
    }
    
    
    
}


extension CustomCell{
    func saveIndexRow (_ row: Int){
        self.row = row
    }
    
    @objc func changeIsDoneValue(){
        print(" 체크아이콘 눌렀어요 ! ")
        
        var todo =  contentsList[self.row]
        var switchisDoneValue = todo.isDone.toggle()
        print(todo)
        print(switchisDoneValue)
        
    }
    
    @objc func changeIsDoneValue2(){
        //0.배열로 저장한 userDefaults 값의 일부를 직접 변경할 수 있는지 확인
        //contentsList 업데이트 후 userDefaults 동기화
         var todo =  contentsList[self.row]
        contentsList[self.row] = TodoData(contents: todo.contents, isDone: !todo.isDone)
        
        var isDone = contentsList[self.row].isDone
//      
       var switchIsDone = isDone.toggle()
        print("->",switchIsDone)
        
        checkIcon.image = isDone ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
        
        
        let todoView = TodoView()
        let doneView = DoneView()
        
        
        TodoDataManager.shared.saveUserDefaluts()
        TodoDataManager.shared.loadUserDefaluts()
//        todoView.toDoTableView.reloadData()
//        doneView.doneTableView.reloadData()
       
    
        
//        print(contentsList)
    }
    //이건 왜 있는거지 ?
    func checkIconUI(with contentsList : TodoData){
        let isDone = contentsList.isDone
        checkIcon.image = isDone ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
        print("IwonderValue", isDone)

    }
    
    
    
    
    func configureUI(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(userInput)
        contentView.addSubview(isDoneButton)
        isDoneButton.addSubview(checkIcon)
        
    }
    func setLayout(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        userInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInput.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            userInput.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userInput.rightAnchor.constraint(equalTo: checkIcon.leftAnchor,constant: -10)
        ])
        
        isDoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([     isDoneButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
                                          isDoneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                                    ])
        
        checkIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkIcon.centerXAnchor.constraint(equalTo: isDoneButton.centerXAnchor),
            checkIcon.centerYAnchor.constraint(equalTo: isDoneButton.centerYAnchor)
        ])
        
    }
}
