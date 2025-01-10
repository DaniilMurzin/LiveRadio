//
//  Zipper.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.12.2024.
//

struct Zipper<Element> {
    private(set) var elements: [Element]
    private var currentIndex: Int
    var current: Element? { elements[safe: currentIndex] }
    
    init(_ array: [Element]) {
        self.elements = array
        self.currentIndex = array.startIndex
    }
    
    init?(_ array: [Element], selected: (Element) -> Bool) {
        guard let selectedIndex = array.firstIndex(where: selected) else {
            return nil
        }
        self.elements = array
        self.currentIndex = selectedIndex
    }
    
    mutating func forward() {
        guard currentIndex < elements.endIndex else {
            return
        }
        currentIndex = elements.index(after: currentIndex)
    }
    
    mutating func backward() {
        guard currentIndex > elements.startIndex else {
            return
        }
        currentIndex = elements.index(before: currentIndex)
    }
    
    mutating func move(to selected: (Element) -> Bool) {
        guard let newSelected = elements.firstIndex(where: selected) else {
            return
        }
        currentIndex = newSelected
    }
}
