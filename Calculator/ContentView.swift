//
//  ContentView.swift
//  Calculator
//
//  Created by 신아인 on 2023/03/07.
//


import SwiftUI

enum ButtonType: String {
    case first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, zero
    case dot, equal, plus, minus, multiple, devide
    case percent, opposite, clear
    
    var ButtonDisplayName: String {
        switch self {
        case .first :
            return "1"
        case .second :
            return "2"
        case .third :
            return "3"
        case .fourth :
            return "4"
        case .fifth :
            return "5"
        case .sixth :
            return "6"
        case .seventh :
            return "7"
        case .eighth :
            return "8"
        case .ninth :
            return "9"
        case .zero :
            return "0"
        case .dot :
            return "."
        case .equal :
            return "="
        case .plus :
            return "+"
        case .minus :
            return "-"
        case .multiple :
            return "x"
        case .devide :
            return "÷"
        case .percent :
            return "%"
        case .opposite :
            return "+/-"
        case .clear :
            return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .first, .second, .third, .fourth, .fifth, .sixth, .seventh, .eighth, .ninth, .zero, .dot: return Color("NumberButton")
        case .equal, .plus, .minus, .multiple, .devide: return Color.orange
        case .percent, .opposite, .clear: return Color.gray
        }
    }
    
    var forgroundColor: Color {
        switch self {
        case .first, .second, .third, .fourth, .fifth, .sixth, .seventh, .eighth, .ninth, .zero, .dot, .equal, .plus, .minus, .multiple, .devide: return Color.white
        case .percent, .opposite, .clear: return Color.black
        }
    }
}

struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    @State var isNotEnding:Bool = true
    
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .devide],
        [.seventh, .eighth, .ninth, .multiple],
        [.fourth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text(totalNumber).padding().font(.system(size: 73)).foregroundColor(.white)
                }
                ForEach(buttonData, id: \.self) { line in
                    HStack{
                        ForEach(line, id: \.self) {item in
                            Button{
                                if isNotEnding {
                                    if item == .clear {
                                        totalNumber = "0"
                                        isNotEnding = true
                                    }else if item == .plus ||
                                                item == .minus ||
                                                item == .multiple ||
                                                item == .devide {
                                        totalNumber = "Error"
                                    }else {
                                        totalNumber = item.ButtonDisplayName
                                        isNotEnding = false // 이미 입력 받고있음
                                    }
                                } else {
                                    if item == .clear {
                                        totalNumber = "0"
                                        isNotEnding = true // 새로 입력 받을 옞
                                    }else if item == .plus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .plus
                                        isNotEnding = true
                                        
                                    }else if item == .multiple {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .multiple
                                        isNotEnding = true
                                        
                                    }else if item == .minus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .minus
                                        isNotEnding = true
                                        
                                    }
                                    else if item == .devide {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .devide
                                        isNotEnding = true
                                        
                                    }else if item == .equal {
                                        
                                        if operatorType == .plus {
                                            totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                                        }else if operatorType == .multiple {
                                            totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                                        }else if operatorType == .minus {
                                            totalNumber = String(tempNumber - (Int(totalNumber) ?? 0))
                                        }else if operatorType == .devide {
                                            totalNumber = String(tempNumber / (Int(totalNumber) ?? 0))
                                        }
                                    }
                                    else {
                                        totalNumber += item.ButtonDisplayName
                                    }
                                }
                            }label: {
                                Text(item.ButtonDisplayName).frame(width: calculatorButtonWidth(button: item), height: calculatorButtonHeight(button: item)).background(item.backgroundColor).cornerRadius(40).foregroundColor(item.forgroundColor).font(.system(size: 33))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func calculatorButtonWidth(button buttonType: ButtonType) -> CGFloat {
        switch buttonType {
        case .zero:
            return ((UIScreen.main.bounds.width - 5*10) / 4) * 2
        default:
            return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    
    private func calculatorButtonHeight(button: ButtonType) -> CGFloat{
        return (UIScreen.main.bounds.width - 5*10) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

