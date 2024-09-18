import SwiftUI

struct TextFieldForEmailView: View {
    //MARK: - PROPERTIES
    @Binding var text: String
    private struct DrawingConstants {
        static let verticalPaddingSize: CGFloat = 50
    }
    //MARK: - BODY
    var body: some View {
        HStack {
            Text("Resources.Text.email")
                .foregroundStyle(.white)
                .padding(.vertical, DrawingConstants.verticalPaddingSize)
            Spacer()
        }
        TextField("Resources.Text.yourEmail", text: $text, prompt: Text("Resources.Text.yourEmail").foregroundColor(.gray))
            .font(.title3)
            .foregroundStyle(.white)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.pink, lineWidth: 2).shadow(color: .pink, radius: 3)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .keyboardType(.emailAddress)
            .tint(.pink)
    }
}

//MARK: - PREVIEW
struct TextFieldForEmailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var text = "EEE"
        TextFieldForEmailView(text: $text)
    }
}
