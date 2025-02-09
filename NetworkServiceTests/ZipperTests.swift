//
//  ZipperTests.swift
//  NetworkServiceTests
//
//  Created by Daniil Murzin on 05.01.2025.
//
#warning("Ревью")
import Testing
import Foundation

@testable import LiveRadioApp

struct ZipperTests {
    let elements = [1,2,4,5,9]
    
    @Test
    func play_success() {
        // given
        var sut = Zipper(elements)
        
        //when
        sut.forward()
        
        //then
        #expect(sut.current == elements[1])
    }
    
    @Test
    func backward_atStart_doesNotCrash() {
        // given
        var sut = Zipper(elements)
        
        // when
        sut.backward()
        
        // then
        #expect(sut.current == elements[0])
    }
    
    @Test
    func move() {
        // given
        var sut = Zipper(elements)
        
        // when
        sut.move() {$0 == 4}
        
        // then
        #expect(sut.current == elements[2])
    }
    
    @Test
      func move_toNonExistingElement_doesNothing() {
          // given
          var sut = Zipper(elements)
          
          // when
          sut.move(to: { $0 == 10 })
          
          // then
          #expect(sut.current == elements[0])
      }
      
      @Test
      func initWithEmptyArray_returnsNil() {
          // given
          let elements: [Int] = []
          
          // when
          let sut = Zipper(elements)
          
          // then
          #expect(sut.current == nil)
      }
      
      @Test
      func initWithSelectedElement_success() {
          // given
          let elements = [1, 2, 4, 5, 9]
          
          // when
          let sut = Zipper(elements, selected: { $0 == 4 })
          
          // then
          #expect(sut?.current == 4)
      }
      
      @Test
      func initWithNonExistingSelectedElement_returnsNil() {
          // given
          let elements = [1, 2, 4, 5, 9]
          
          // when
          let sut = Zipper(elements, selected: { $0 == 10 })
          
          // then
          #expect(sut == nil)
      }
}
