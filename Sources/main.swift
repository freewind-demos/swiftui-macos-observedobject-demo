import Cocoa

@main
struct ObservedObjectApp: App {
    var body: some Scene {
        Window("@ObservedObject 外部状态", id: "main") {
            ContentView()
        }
        .defaultSize(width: 500, height: 500)
    }
}
