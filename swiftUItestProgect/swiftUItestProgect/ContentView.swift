//
//  ContentView.swift
//  swiftUItestProgect
//
//  Created by fedir on 08.09.2020.
//  Copyright © 2020 fedir. All rights reserved.
//
 
import SwiftUI
//MARK: - структура описание круговой диаграммы

struct CircleShape : Shape {
    //progress... аргумент для заполнения
    let progress: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .radians( 1.5 * .pi),
                    endAngle: .init(radians: 2 * Double.pi * progress + 1.5 * Double.pi),
                    clockwise: false)
        return path
        
    }
}

struct ContentView: View {
    
@State var pickerItem = 0
     //MARK: - массив значений для круговой диаграмы
    @State var circleValues:  [[Double]] = [[0.30,1.6,0.2],
                                        [1.05,0.15,1.8],
                                        [0.175,0.94,0.5]]
     
 //MARK: - массив значений для диаграмы
@State var diagramValues:  [[CGFloat]] = [[30,160,90],
                                        [45,156,87],
                                        [175,34,89]]
    
var body: some View {
    ZStack{
            //заливка
            Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).edgesIgnoringSafeArea(.all)
            //MARK: - VStack вертикальное расположение элементов
    VStack {
         Spacer()
    Text("Analitics").font(.system(size:32)).fontWeight(.heavy)
    Picker(selection: $pickerItem, label: Text("")) {
        
        Text("September").tag(0)
        Text("October").tag(1)
        Text("Novembermber").tag(2)
        
    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal,16)
                HStack {
                    //MARK: - вызов функции описания круга
                    CircleeView(value:circleValues[pickerItem][0])
                    CircleeView(value:circleValues[pickerItem][1])
                    CircleeView(value:circleValues[pickerItem][2])
                }.padding(.top,16).animation(.spring())
                HStack {
                    DiagramView(value: diagramValues[pickerItem][0])
                    DiagramView(value: diagramValues[pickerItem][1])
                    DiagramView(value:  diagramValues[pickerItem][2])
                }.padding(.top,16).animation(.default)
        Spacer()
               
        }
           
    }
  }
}

struct CircleeView: View {
    //значение для функции
    var value: Double
    
    //MARK: - определение цвета  круговой диаграммы
    private var colorCircle: Color {
        if value < 0.5 {
            return .red
        }else if value > 0.5 && value < 1.3 {
            return .yellow
        } else { return .green }
    }
    
    
    var body: some View {
        
        ZStack(alignment: .center) {
CircleShape(progress: 1).stroke(Color.white,
                    style: StrokeStyle(lineWidth: 10,
                                                 lineCap: .butt,
                                                 lineJoin: .round,
                                                 miterLimit: 0,
                                                 dash: [],
                                                 dashPhase: 0))
CircleShape(progress: value).stroke(colorCircle,
                    style: StrokeStyle(lineWidth: 10,
                                                lineCap: .round,
                                                lineJoin: .round,
                                                miterLimit: 0,
                                                dash: [],
                                                dashPhase: 0))
                                                Text(String(value*100))
    }.padding()
    
    }
}

//MARK: - DiagramViewModel
struct DiagramView: View  {
    
var value: CGFloat
//MARK: - определение цвета диаграммы
    private var color: Color {
        if value < 80 {return .blue}
        else if value > 80 && value < 130 { return .green }
        else {return .red}
    }
    
var body: some View {
VStack {
    ZStack(alignment: .bottom) {
        Rectangle().frame(width: 30,height:200).foregroundColor(Color.white)
        Rectangle().frame(width: 30, height: value).foregroundColor(color)
        }.padding(.top,16)
        Text("03").padding(.top,4)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 //ZStack {
//
//            //квадрат
//            Rectangle().frame(width: 200, height: 200)
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .fill(Color.red)
//                .frame(width: 200, height: 200)

// геометрические формы
//            Capsule().fill(Color.green).frame(width: 50, height: 200)
//            Ellipse().fill(Color.white).frame(width: 45, height: 100)
//            Circle().fill(Color.yellow).frame(width: 45, height: 45)
//            }
