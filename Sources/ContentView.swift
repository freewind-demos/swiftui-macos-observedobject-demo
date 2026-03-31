import SwiftUI

// 可观察的计数器模型
class CounterModel: ObservableObject {
    @Published var count = 0
    @Published var lastAction = "无"

    func increment() {
        count += 1
        lastAction = "加 1"
    }

    func decrement() {
        count -= 1
        lastAction = "减 1"
    }

    func reset() {
        count = 0
        lastAction = "重置"
    }
}

// 主视图
struct ContentView: View {
    @StateObject private var counter = CounterModel()

    var body: some View {
        VStack(spacing: 30) {
            Text("@ObservedObject 示例")
                .font(.headline)

            // 显示计数器
            VStack(spacing: 10) {
                Text("\(counter.count)")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.blue)

                Text("最后操作: \(counter.lastAction)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // 操作按钮
            HStack(spacing: 20) {
                Button("减一") {
                    counter.decrement()
                }

                Button("重置") {
                    counter.reset()
                }
                .buttonStyle(.borderless)

                Button("加一") {
                    counter.increment()
                }
            }

            Divider()

            // 子组件也接收同一个对象
            CounterDisplayView(counter: counter)

            Divider()

            // 另一个子组件
            CounterControlsView(counter: counter)
        }
        .padding()
    }
}

// 显示组件
struct CounterDisplayView: View {
    @ObservedObject var counter: CounterModel

    var body: some View {
        VStack(spacing: 5) {
            Text("显示组件")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                Text("计数:")
                Text("\(counter.count)")
                    .font(.title2)
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)
    }
}

// 控制组件
struct CounterControlsView: View {
    @ObservedObject var counter: CounterModel

    var body: some View {
        VStack(spacing: 10) {
            Text("控制组件")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 10) {
                ForEach(1..<6) { n in
                    Button("+\(n)") {
                        counter.count += n
                        counter.lastAction = "加 \(n)"
                    }
                }
            }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)
    }
}
