protocol Container{
    associatedtype Item
    mutating func append(_ item:Item)
    var count:Int { get }
    subscript(i: Int) -> Item! { get }
}

indirect enum LinkedListNode<T>{
    case null
    case general(value:T, next:LinkedListNode<T>)
    
    func getNext() -> LinkedListNode<T>{
        switch self {
        case .general(_, let next):
            return next
        default:
            return self
        }
    }
}

struct LinkedList<T>:Container{
    var head = LinkedListNode<T>.null
    var count:Int = 0
    
    mutating func append(_ newValue:T){
        self.head = createWithAdding(newValue)
        count += 1
    }
    
    private mutating func createWithAdding(_ newValue: T) -> LinkedListNode<T>{
        switch self.head {
        case .general(let value, let next):
            self.head = next
            let newNode = LinkedListNode<T>.general(value: value, next: createWithAdding(newValue))
            return newNode
        default:
            return LinkedListNode<T>.general(value: newValue, next: LinkedListNode<T>.null)
        }
    }
    
    
    mutating func insert(_ value:T, at index: Int){
        var node = LinkedListNode<T>.null
        switch index{
        case 0:
            return
        default:
            
            return
        }
    }
    

    subscript(i: Int) -> T! {
        var node = head
        var result:T?
        
        var index = 0
        switchLoop:while (index <= i) {
            switch node {
            case .null:
                return nil
            case .general(let value, let next):
                index += 1
                result = value
                node = next
            }
        }
        return result
    }
}




var qwe = LinkedList<String>()
qwe.append("123123")
print(qwe.count)
qwe.append("qweqweqw")
qwe.append("ячсмит")
print(qwe.count)
print(qwe[0]!)
print(qwe[1]!)
print(qwe[2]!)
