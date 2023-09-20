//
//  ViewController.swift
//  DoitSometing_Memo
//
//  Created by kiakim on 2023/09/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
        //[segment step 2] 버튼 선택시 보여줄 화면을 설정
    var shouldHideTodoView: Bool?{
        didSet{
            guard let shouldHideTodoView = self.shouldHideTodoView
                else{return}
            self.todoView.isHidden = shouldHideTodoView
            self.doneView.isHidden = !self.doneView.isHidden
        }
    }
    
        //[segment step 1] 선언
    let segmentedControl : UISegmentedControl = {
        let controler = UISegmentedControl(items: ["Todo","Done"])
        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        let attributes = [NSAttributedString.Key.font:font]
        controler.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        return controler
    }()

    
    let todoView : TodoView = {
        let view = TodoView()
        return view
    }()
    
    
    let doneView : DoneView = {
       let view = DoneView()
            return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }


}

extension ViewController {
    @objc func screenChange(segment: UISegmentedControl){
        //[segment step 1] shouldHideTodoView가 true이면,SegmentIndex == 1을 보여줍니다
        self.shouldHideTodoView = segment.selectedSegmentIndex == 1
        
    }
}

extension ViewController {
    func setupUI () {
        view.addSubview(segmentedControl)
        view.addSubview(todoView)
        todoView.viewController = self
        //userDefaluts에 저장된 array가 호출될수 있도록 셋팅 필요
        TodoDataManager.shared.loadUserDefaluts()
        view.addSubview(doneView)
        //[segment step 3] 클릭시 함수 호출
        shouldHideTodoView = false
        segmentedControl.addTarget(self, action: #selector(screenChange(segment:)), for: .valueChanged)
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
//            make.right.equalTo(view.snp.right).offset(20)
            make.height.equalTo(50)
        }
        
        todoView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        doneView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}
