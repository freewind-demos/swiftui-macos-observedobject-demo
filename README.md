# SwiftUI macOS @ObservedObject 外部状态

## 简介

演示 SwiftUI 中 @ObservedObject 的用法，用于在视图间共享可观察对象的状态。

## 快速开始

```bash
cd swiftui-macos-observedobject-demo
xcodegen generate
open SwiftUIObservedObjectDemo.xcodeproj
# Cmd+R 运行
```

## 概念讲解

### 定义可观察对象

```swift
class CounterModel: ObservableObject {
    @Published var count = 0

    func increment() {
        count += 1
    }
}
```

### 在父视图创建

```swift
struct ParentView: View {
    @StateObject private var counter = CounterModel()  // 创建

    var body: some View {
        ChildView(counter: counter)  // 传给子组件
    }
}
```

### 在子组件接收

```swift
struct ChildView: View {
    @ObservedObject var counter: CounterModel  // 接收

    var body: some View {
        Text("\(counter.count)")
    }
}
```

## 完整示例

```swift
class UserModel: ObservableObject {
    @Published var name = ""
    @Published var isLoggedIn = false
}

struct ContentView: View {
    @StateObject private var user = UserModel()

    var body: some View {
        VStack {
            TextField("名字", text: $user.name)
            ProfileView(user: user)
        }
    }
}

struct ProfileView: View {
    @ObservedObject var user: UserModel

    var body: some View {
        VStack {
            Text(user.name)
            Text(user.isLoggedIn ? "已登录" : "未登录")
        }
    }
}
```

## 完整讲解（中文）

### @StateObject vs @ObservedObject

| 特性 | @StateObject | @ObservedObject |
|------|-------------|----------------|
| 创建对象 | 是 | 否 |
| 拥有权 | 父视图 | 父视图 |
| 销毁时机 | 父视图销毁时 | 自动 |
| 推荐场景 | 根视图 | 子组件 |

### 工作原理

1. 父视图用 `@StateObject` 创建并拥有对象
2. 通过参数传给子组件
3. 子组件用 `@ObservedObject` 接收
4. 对象属性变化时，SwiftUI 自动更新视图

### 使用场景

- 共享业务逻辑
- 多个视图需要同步状态
- 需要引用类型的共享状态
