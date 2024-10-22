//
//  ContentView.swift
//  WebSocketClient
//
//  Created by digital on 22/10/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var wsClient = WebSocketClient.shared
    @State var messageToSend = ""
    
    var body: some View {
        VStack {
            ZStack {
                
                if wsClient.receivedMessages.isEmpty {
                    Text("No message received")
                } else {
                    List{
                        ForEach(wsClient.receivedMessages) { message in
                            Text(message.content)
                        }
                    }
                }

            }
            .frame(height: 300)
            
            Spacer()
                .frame(height: 40)
            
            TextField("Your message",text: $messageToSend)
                .textFieldStyle(.plain)
            
            Spacer()
                .frame(height: 20)
            
            Button("Send message") {
                let formattedMessage = messageToSend.trimmingCharacters(in: .whitespacesAndNewlines)
                if !formattedMessage.isEmpty {
                    wsClient.sendMessage(formattedMessage)
                }
                self.messageToSend = ""
            }
        }
        .padding()
        .onAppear {
            wsClient.connect(url:"127.0.0.1:8080/say")
        }
    }
}

#Preview {
    ContentView()
}
