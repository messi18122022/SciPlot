import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SciPlot")
            
            Button(action: {
                print("Button wurde gedrückt!")
            }) {
                Text("Drücke mich")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
