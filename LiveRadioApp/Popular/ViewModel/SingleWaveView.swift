import SwiftUI

///Синусоида строится с помощью функции:

/// A – амплитуда: высота волны (максимальное отклонение вверх или вниз).
/// f – частота: количество волн на определённой ширине.
/// x – позиция по горизонтали.
/// ϕ – фаза: сдвиг волны по горизонтали (для анимации).
/// C – сдвиг по вертикали: положение центра волны.
///
/// 2. Как это выглядит на практике
/// x – будет увеличиваться от 0 до ширины экрана.
/// x мы вычислим y по формуле выше.
///
///
/// Амплитуда (A) = 50 (высота волны).
/// Частота (f) = 2𝜋 / ширина (одна волна на всю ширину).
/// Фаза (𝜙) = 0 (без сдвига).
/// Центр (𝐶) = половина высоты экрана.

struct SingleWaveView: View {
    

    
    var body: some View {
        ZStack {
            Color.mainBg
            HStack {
                
                Circle()
                    .stroke(Color.eclipse8, lineWidth: 1) // Обводка белым цветом
                    .background(Circle().fill(Color.eclipse8))
                    .frame(width: 8, height: 9)
                    .position(x: 25 , y: 18)
                    
                WaveShape(amplitudes: [2, -2, 9, -5, 5, -10, 5, -5, 0])
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 87, height: 34)
                Circle()
                    .stroke(Color.eclipse8, lineWidth: 1) // Обводка белым цветом
                    .background(Circle().fill(Color.eclipse8))
                    .frame(width: 8, height: 9)
                    .position(x: -25 , y: 18)
                    
                    
            }
        }
                .frame(width: 87, height: 34)
    }
}


struct PointOneView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addArc(center: CGPoint(x: 0.00308*width, y: 0.33542*height), radius: 5, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        return path
    }
}

struct WaveShape: Shape {
    let amplitudes: [CGFloat] // Разные амплитуды для сегментов
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let midY = rect.height / 2  // Центр по вертикали
        let segmentWidth = width / CGFloat(amplitudes.count - 1) // Ширина одного сегмента
        
        // Начинаем с первой точки
        path.move(to: CGPoint(x: 0, y: midY + amplitudes[0]))
        
        // Проходим по всем сегментам с кубическими кривыми
        for index in 1..<amplitudes.count {
            let startX = CGFloat(index - 1) * segmentWidth
            let endX = CGFloat(index) * segmentWidth
            
            let controlX1 = startX + segmentWidth / 3
            let controlY1 = midY + amplitudes[index - 1]
            
            let controlX2 = startX + 2 * segmentWidth / 3
            let controlY2 = midY + amplitudes[index]
            
            let endY = midY + amplitudes[index]
            
            path.addCurve(to: CGPoint(x: endX, y: endY),
                          control1: CGPoint(x: controlX1, y: controlY1),
                          control2: CGPoint(x: controlX2, y: controlY2))
        }
        
        return path
    }
}

#Preview {
    SingleWaveView()
        .frame(width: 87, height: 34)
}
