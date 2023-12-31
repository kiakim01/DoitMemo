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
    
    var isDoneButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(changeIsDoneValue), for: .touchUpInside)
        return button
    }()
    
    
    var checkIcon : UIImageView = {
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
    
    
    @objc func changeIsDoneValue(){
       isDoneButton.isSelected.toggle()
        let isDone = isDoneButton.isSelected
        
        checkIcon.image = isDone ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
        //[1]index에 맞는 isDone Value를 바꾸는 동작 성공
        print(userInput.text, isDone)
        
        //[2]userDefaults에 저장이 문제
        TodoDataManager.shared.saveUserDefaluts()
        TodoDataManager.shared.loadUserDefaluts()
        
        print(contentsList)
    }
    
    
    //Use to DoneView
    func checkIconUI(with contentsList : TodoData){
//        let isDone = contentsList.isDone
//        checkIcon.image = isDone ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
//        print("IwonderValue", isDone)
        
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
