//
//  ContentView.swift
//  Hack2020
//
//  Created by Ivan Dosev Dimitrov on 26.03.20.
//  Copyright © 2020 Ivan Dosev Dimitrov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
@ObservedObject var getData = Model()
@State          var isShow : Bool = true
@State          var txt = ""
        
    var body: some View {
        ZStack {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack {
                    Text("CATALOG")
                        .multilineTextAlignment(.center)
                        .font(.custom("Brushwell", size: 40))
                       
                    SearchView(txt: self.$txt , data: self.getData.database, isShow: self.$isShow)
                    
                    
                }.frame(minWidth: geometry.size.width)
            }


        }

        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Bayer: View {
    
    var id: Int
    var kgPazient : Int       // килограми на пациента
    var goPazient : Int       // години на пациента
    var fromMin   : CGFloat        // диапазон ОТ в долната граница   ...  или килограми ..  или гогини на пациент
    var toMin     : CGFloat        // диапазон ДО в долната граница
    var fromMax   : CGFloat        // диапазон ОТ в горната граница граница   ...  или килограми ..  или гогини на пациент
    var toMax     : CGFloat        // диапазон ДО в горната граница
    var isMin     : Bool      //  ако е истина не се използва калкулатора
    var isMax     : Bool      //  ако е истина не се използва калкулатора
    var mjarka    : String    // мерна единица на лекарството
    var maxDoza   : CGFloat         // максимална диза изчислената стоиност нетрябва да е повече от максимална
    var firstDoza : CGFloat         // първа доза  първи ден на прием
    var priemI    : Int       // начин на прием на лекарството вариант първи
    var priemII   : Int       // начин на прием на лекарството вариант втори
    var opis      : String    // описание на приема в текст когато неможе да се калкулира
    var lekarstvo : String    // име на лекарството
    var grupa     : String
    
 
@State var FromTxt : String = ""
@State var ToTxt   : String = ""
@State var xoro    : Int = 0
@State var forMat = ""
@State var priem  = ""
    @State var isMenCat : Bool = false
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.alo()
        }
    }
    
@State var stoKilo = 150
    
    
    var body: some View {
        VStack {
            VStack {
                   Text(grupa)
                    .font(.system( size: 30))
                    .foregroundColor(Color.blue)
                    .opacity(0.5)
                  
                   Text(lekarstvo)
                    .font(.system( size: 35))
                      .foregroundColor(Color.blue)
                      .opacity(1)
                  
            }
             Text(opis)
                 .font(.system( size: 20))
            
            HStack {
                Text("The dosage for ")
                Text(" \(stoKilo) ")
                 .font(.system( size: 30))
                Text(" kg. patient is:")
                    
                  
            }.padding(20)
             .foregroundColor(Color.red)
                
            // .font(.custom("Sherlyn", size: 40))

    /*
            Text(isXoro ? " взема се от " +  String(format: "%.4f", fromMin * CGFloat(stoKilo)) + "\(mjarka)" : " взема се от " +  String(format: "%.4f", fromMax * CGFloat(stoKilo)) + "\(mjarka)")
           Text(isXoro ? "           до " +  String(format: "%.4f", toMin * CGFloat(stoKilo)) + "\(mjarka)" :  "           до " +  String(format: "%.4f", toMax * CGFloat(stoKilo)) + "\(mjarka)")
           Text(" \(priemI)  дневно.")
     */
 
           
            VStack {
                HStack {
                    Text( "from: " )
                               
                    Text(  FromTxt )
                            .font(.system( size: 30))
                    Text(  mjarka  )
                               
                }.padding(20)
                
                HStack {
                    Text( "    to: " )
                    Text(  ToTxt     )
                              .font(.system( size: 30))
                    Text(  mjarka    )
                        
                }.padding(20)
                
                 Text( "   every \(priem)")
                               .font(.system( size: 30))
            }.foregroundColor(Color.red)
            
            
              Spacer()

        
            .padding(.horizontal)
               // Text("kilogram \(stoKilo) person")
              
             Picker(selection: self.$stoKilo, label:Text("").labelsHidden()) {
                    ForEach(0..<self.stoKilo) { arda in
                     Text("\(arda)")
                        
                    }
                    
                }.padding(.horizontal)
                 .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white))
                 .shadow(radius: 20, y: 50)
                 .padding()
            
                .sheet(isPresented: $isMenCat, content: { MenCat(lek: self.lekarstvo) })
        }
       // .sheet(isPresented: $isMenCat, content: { MenCat() })
        .onAppear(){
            self.timer
        }
    }
    func alo(){
        
        switch priemI {
             case 1: self.priem = "24h"
             case 2: self.priem = "12h"
             case 3: self.priem = " 8h"
             case 4: self.priem = " 6h"
            
        default:
                     self.priem = "_"
        }
        

        if fromMin < 1  {
                forMat = "%.4f"  // четири числа след запетаята
        }else {
                forMat = "%.0f"  // нула  числа след запетаята като цели
        }

        
        if self.kgPazient != 0 {
            self.xoro = self.kgPazient
        }
        if self.goPazient != 0 {
            self.xoro = self.goPazient
        }
        
        if self.stoKilo > self.xoro {
            if self.isMax {
                self.FromTxt = String(format: forMat, self.fromMax * CGFloat(self.stoKilo))
                self.ToTxt   = String(format: forMat, self.toMax   * CGFloat(self.stoKilo))
            } else {
              self.FromTxt = String(format: forMat, self.fromMax )
              self.ToTxt   = String(format: forMat, self.toMax   )
            }
            
        }else {
            if self.isMin {
                    self.FromTxt = String(format: forMat, self.fromMin * CGFloat(stoKilo))
                    self.ToTxt   = String(format: forMat, self.toMin   * CGFloat(stoKilo))
            } else {
                     self.FromTxt = String(format: forMat, self.fromMin )
                     self.ToTxt   = String(format: forMat, self.toMin   )
            }
        }  // if stoKilo > xoro {
   
      
   
        
    }
}
// ------------------------------------------------

struct MenCat: View {
    
     @ObservedObject var getData100 = Model()
     var lek : String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white , Color.gray]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            Form {
                Text("\(self.lek)")
                    .padding(.leading, 10)
                    .multilineTextAlignment(.center)
                       .font(.system(size: 20))
                   
        List(getData100.database100.filter  { $0.nameLecarstvo.lowercased().contains(self.lek.lowercased())} , id: \.nameFirma ) { firma in
                VStack {
                Text("\(firma.nameFirma)")
                    .background(Color.red.opacity(0.1))
                    .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0))
                    .font(.system(size: 16))
                Text("\(firma.vidove)")
                     .font(.system(size: 12))
                Text("\(firma.optional)")
                     .font(.system(size: 12))
                      }
                }
               .multilineTextAlignment(.center)
            }
        }
        
    }
}
/*
 var id: Int
 var nameLecarstvo : String
 var nameFirma     : String
 var vidove        : String
 var optional      : String
 */

// -------------------------------------------------
struct Dossi: View {
    
    var id: Int
    var kgPazient : Int       // килограми на пациента
    var goPazient : Int       // години на пациента
    var fromMin   : CGFloat        // диапазон ОТ в долната граница   ...  или килограми ..  или гогини на пациент
    var toMin     : CGFloat        // диапазон ДО в долната граница
    var fromMax   : CGFloat        // диапазон ОТ в горната граница граница   ...  или килограми ..  или гогини на пациент
    var toMax     : CGFloat        // диапазон ДО в горната граница
    var isMin     : Bool      //  ако е истина не се използва калкулатора
    var isMax     : Bool      //  ако е истина не се използва калкулатора
    var mjarka    : String    // мерна единица на лекарството
    var maxDoza   : CGFloat         // максимална диза изчислената стоиност нетрябва да е повече от максимална
    var firstDoza : CGFloat         // първа доза  първи ден на прием
    var priemI    : Int       // начин на прием на лекарството вариант първи
    var priemII   : Int       // начин на прием на лекарството вариант втори
    var opis      : String    // описание на приема в текст когато неможе да се калкулира
    var lekarstvo : String    // име на лекарството
    var grupa     : String
    
    
    var body: some View {
    
        NavigationLink(destination: Bayer(id: id,
                                          kgPazient: kgPazient,
                                          goPazient: goPazient,
                                          fromMin: fromMin,
                                          toMin: toMin,
                                          fromMax: fromMax,
                                          toMax: toMax,
                                          isMin: isMin,
                                          isMax: isMax,
                                          mjarka: mjarka,
                                          maxDoza: maxDoza,
                                          firstDoza: firstDoza,
                                          priemI: priemI,
                                          priemII: priemII,
                                          opis: opis,
                                          lekarstvo: lekarstvo,
                                          grupa: grupa)) {
            
                       Text(lekarstvo)
        }
   
      

    }
}




struct SearchView: View {
    
    @Binding var txt : String
    var data : [Lecarstvo]
    @Binding var isShow : Bool
    
    var body: some View {
        
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        TextField("search ... " ,text: $txt)
                            .padding(.trailing, 75)
                        
                    }.padding()
                     .background(Color.white)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.txt = ""
                           
                        }) {
                            Text("cancel")
                        }.foregroundColor(.black)
                    }.padding()
                }
NavigationView {
    
   // List(data.filter { $0.lekarstvo .lowercased().contains(self.txt.lowercased()) } , id: \.lekarstvo) { i in
        
    List( data.filter {self.txt.isEmpty ? true : $0.lekarstvo .lowercased().contains(self.txt.lowercased()) }, id: \.lekarstvo) { i in

        Dossi(id: i.id,
              kgPazient: i.kgPazient,
              goPazient: i.goPazient,
              fromMin: i.fromMin,
              toMin: i.toMin,
              fromMax: i.fromMax,
              toMax: i.toMax,
              isMin: i.isMin,
              isMax: i.isMax,
              mjarka: i.mjarka,
              maxDoza: i.maxDoza,
              firstDoza: i.firstDoza,
              priemI: i.priemI,
              priemII: i.priemII,
              opis: i.opis,
              lekarstvo: i.lekarstvo,
              grupa: i.grupa)
                                     
                            }
 
        

                }
            }
        }
    }
}

/*
         List(data.filter { $0.lekarstvo .lowercased().contains(self.txt.lowercased()) } , id: \.lekarstvo) { i in


 Dossi(id: i.id,
       kgPazient: i.kgPazient,
       goPazient: i.goPazient,
       fromMin: i.fromMin,
       toMin: i.toMin,
       fromMax: i.fromMax,
       toMax: i.toMax,
       isMin: i.isMin,
       isMax: i.isMax,
       mjarka: i.mjarka,
       maxDoza: i.maxDoza,
       firstDoza: i.firstDoza,
       priemI: i.priemI,
       priemII: i.priemII,
       opis: i.opis,
       lekarstvo: i.lekarstvo,
       grupa: i.grupa)
                              
                     }

 */
