import SwiftUI
import AppKit

struct ContentView: View {
    @State private var isFileManagerOpen: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isFileManagerOpen = true
                }) {
                    HStack {
                        Image(systemName: "folder.fill")
                        Text("Dateimanager öffnen")
                    }
                    .padding(8)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding([.top, .leading])
                Spacer()
            }
            Spacer()
        }
        .frame(width: 400, height: 300)
        .sheet(isPresented: $isFileManagerOpen) {
            FileManagerView(isPresented: $isFileManagerOpen)
        }
    }
}

struct FileManagerView: View {
    @Binding var isPresented: Bool
    @State private var fileNames: [String] = []
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Text("Schließen")
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding()
            
            Button(action: {
                openFilePanel()
            }) {
                Text("Datei laden")
            }
            .padding()
            
            List {
                ForEach(fileNames, id: \..self) { fileName in
                    HStack {
                        Text(fileName)
                        Spacer()
                        Button(action: {
                            deleteFile(named: fileName)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .frame(height: 200)
        }
        .frame(width: 400, height: 300)
    }
    
    private func openFilePanel() {
        let dialog = NSOpenPanel()
        dialog.title = "Wähle eine Datei"
        dialog.allowedFileTypes = ["csv", "txt", "xls", "xlsx"]
        dialog.allowsMultipleSelection = true
        
        if dialog.runModal() == .OK {
            let urls = dialog.urls
            fileNames.append(contentsOf: urls.map { $0.lastPathComponent })
        }
    }
    
    private func deleteFile(named fileName: String) {
        fileNames.removeAll { $0 == fileName }
    }
}
