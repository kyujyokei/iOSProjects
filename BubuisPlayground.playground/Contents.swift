enum Direction {
    case East
    case West
    case North
    case South
}

let mydirection = Direction.East

if mydirection == .East{
    print("Dong")
}

var yourDirection:Direction
yourDirection = .West

switch yourDirection{
    case .East:
        print("Yeas")

}