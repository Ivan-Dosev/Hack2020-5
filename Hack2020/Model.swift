//
//  Model.swift
//  Hack2020
//
//  Created by Ivan Dosev Dimitrov on 26.03.20.
//  Copyright © 2020 Ivan Dosev Dimitrov. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

struct Lecarstvo100: Identifiable, Codable {
    
    var id: Int
    var nameLecarstvo : String
    var nameFirma     : String
    var vidove        : String
    var optional      : String

}

struct Lecarstvo: Identifiable, Codable {
    
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
    var grupa     : String    //  група на лекарството
    
    
}

class Model: ObservableObject {
    
    @Published var database    = [Lecarstvo]()
    @Published var database100 = [Lecarstvo100]()
    
    var kgPazientMod : Int        // килограми на пациента
    var goPazientMod : Int       // години на пациента
    var fromMinMod   : CGFloat       // диапазон ОТ в долната граница   ...  или килограми ..  или гогини на пациент
    var toMinMod     : CGFloat       // диапазон ДО в долната граница
    var fromMaxMod   : CGFloat       // диапазон ОТ в горната граница граница   ...  или килограми ..  или гогини на пациент
    var toMaxMod     : CGFloat       // диапазон ДО в горната граница
    var mjarkaMod    : String     // мерна единица на лекарството
    var maxDozaMod   : CGFloat         // максимална диза изчислената стоиност нетрябва да е повече от максимална
    var firstDozaMod : CGFloat         // първа доза  първи ден на прием
    var priemIMod    : Int       // начин на прием на лекарството вариант първи
    var priemIIMod   : Int       // начин на прием на лекарството вариант втори
    var opisMod      : String    // описание на приема в текст когато неможе да се калкулира
    var lekarstvoMod : String    // име на лекарството
    var grupaMod     : String    //  група на лекарството
    var isMinMod     : Bool      //  ако е истина не се използва калкулатора
    var isMaxMod     : Bool      //  ако е истина не се използва калкулатора
    
    var nameLecarstvoMod : String
    var nameFirmaMod     : String
    var vidoveMod        : String
    var optionalMod      : String
    
    init(
           kgPazientMod : Int = 0,
           goPazientMod : Int = 0,
           fromMinMod   :      CGFloat = 0,
           toMinMod     :      CGFloat = 0,
           fromMaxMod   :      CGFloat = 0,
           toMaxMod     :      CGFloat = 0,
           mjarkaMod    : String = "",
           maxDozaMod   :      CGFloat = 0,
           firstDozaMod :      CGFloat = 0,
           priemIMod    : Int = 0,
           priemIIMod   : Int = 0,
           opisMod      : String = "",
           lekarstvoMod : String = "",
           grupaMod     : String = "",
           isMinMod     : Bool   = false,
           isMaxMod     : Bool   = false,
        
        
         nameLecarstvoMod : String = "",
         nameFirmaMod     : String = "",
         vidoveMod        : String = "",
         optionalMod      : String = ""
        
        
           )  {
        
        self.kgPazientMod    =  kgPazientMod
        self.goPazientMod    =  goPazientMod
        self.fromMinMod      =  fromMinMod
        self.toMinMod        =  toMinMod
        self.fromMaxMod      =  fromMaxMod
        self.toMaxMod        =  toMaxMod
        self.mjarkaMod       =  mjarkaMod
        self.maxDozaMod      =  maxDozaMod
        self.firstDozaMod    =  firstDozaMod
        self.priemIMod       =  priemIMod
        self.priemIIMod      =  priemIIMod
        self.opisMod         =  opisMod
        self.lekarstvoMod    =  lekarstvoMod
        self.grupaMod        =  grupaMod
        self.isMinMod        =  isMinMod
        self.isMaxMod        =  isMaxMod
        
        self.nameLecarstvoMod = nameLecarstvoMod
        self.nameFirmaMod     = nameFirmaMod
        self.vidoveMod        = vidoveMod
        self.optionalMod      = optionalMod

      //  loadJSON()
        
        loadFromJSON()
    }
     func loadFromJSON(){
        
           guard let url = URL(string: "https://api.myjson.com/bins/16shgq") else {return}

         URLSession.shared.dataTask(with: url ) { (data,_,_) in
             guard let data = data else {return}
        
             let pokemon = try! JSONDecoder().decode([Lecarstvo].self, from: data)
             
             DispatchQueue.main.async {
                 self.database  = pokemon
             
             }
         }.resume()
         
     }
    
    func loadJSON(){
      
          guard let url = URL(string: "https://api.myjson.com/bins/jtagk") else {return}

        URLSession.shared.dataTask(with: url ) { (data,_,_) in
            guard let data = data else {return}
       
            let pokemon100 = try! JSONDecoder().decode([Lecarstvo100].self, from: data)
            
            DispatchQueue.main.async {
                self.database100  = pokemon100
            
            }
        }.resume()
        
    }

}

