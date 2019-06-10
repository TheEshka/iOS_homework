protocol Container{
    associatedtype Item
    mutating func append(_ item:Item)
    var count:Int { get }
    subscript(i: Int) -> Item! { get }
}

enum ContainerErros: Error{
    case OutOfTheBounds
}


//LinkedList
class LinkedListNode<T>{
    var value:T
    var next:LinkedListNode<T>?
    
    init(_ value:T) {
        self.value = value
    }
}

struct LinkedList<T>:Container{
   
    var head:LinkedListNode<T>?
    
    mutating func append(_ value:T){
        let newNode = LinkedListNode(value)
        var node:LinkedListNode<T>? = head
        if node == nil {self.head = newNode}
        while node?.next != nil {
            node = node!.next
        }
        node?.next = newNode
        return
    }
    
    mutating func insert(_ value:T, at index:Int) throws {
        let newNode = LinkedListNode(value)
        var node:LinkedListNode<T>? = head
        if index == 0 { newNode.next = head; head = newNode; return }
        var i = index-1
        while i>0 {
            if node?.next != nil{
                node = node!.next
                i -= 1
            } else {
                throw ContainerErros.OutOfTheBounds
            }
        }
        newNode.next = node?.next
        node?.next = newNode
        return
    }
    
    var count:Int {
        var node = self.head
        var i = 0
        while (node != nil){
            i+=1
            node = node!.next
        }
        return i
    }
    
    subscript(i: Int) -> T! {
        var node:LinkedListNode<T>? = head
        var index = i
        while node != nil {
            if index == 0 { return node!.value }
            index -= 1
            node = node!.next
        }
        return nil
    }
}




//FIFO queue
struct Queue<T>: Container{
    var items = [T]()
    
    mutating func append(_ value:T){
        items.append(value)
    }
    
    var count:Int {
        return items.count
    }
    
    subscript(i: Int) -> T! {
        return items[i]
    }
    
    mutating func push(_ value:T){
        self.append(value)
    }
    
    mutating func pop() -> T {
        return items.removeFirst()
    }
}


//test LinkedList
var qwe = LinkedList<String>()
qwe.append("123123")
qwe.append("qweqweqw")
qwe.append("asdasdas")
try qwe.insert("zxcvbn", at: 2)
print(qwe[4])


//test FIFO queue
var asd = Queue<String>()
asd.push("qwerty")
asd.push("asdfgh")
asd.push("zxcvbn")
print (asd.count)
print(asd.pop())
print (asd.count)
print(asd.pop())

