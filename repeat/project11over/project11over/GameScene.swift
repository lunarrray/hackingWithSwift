//
//  GameScene.swift
//  project11over
//
//  Created by Ainura Kerimkulova on 31/3/22.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var ballsLabel: SKLabelNode!
    
    var balls = [String]()
    
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var ballCount = 5{
        didSet{
            let text: String
            if ballCount < 0{
                ballCount = 0
            }
            switch ballCount{
            case 0:
                text = "You haven't any ball"
            case 1:
                text = "You have 1 ball"
            default:
                text = "You have \(ballCount) balls"
            }
            ballsLabel.text = text
        }
    }
    var editingMode: Bool = false{
        didSet{
            if editingMode{
                editLabel.text = "Done"
            }else{
                editLabel.text = "Edit"
            }
        }
    }
    var slotGlows = [SKSpriteNode]()
    
    
    override func didMove(to view: SKView) {
        
        balls += ["ballRed", "ballYellow", "ballBlue", "ballGreen", "ballCyan", "ballGrey", "ballPurple"]

        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        let slotPosition = self.size.width / 8
        makeSlot(at: CGPoint(x: slotPosition, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: slotPosition * 3, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: slotPosition * 5, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: slotPosition * 7, y: 0), isGood: false)
        
        let bouncerPosition = self.size.width / 4
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: bouncerPosition, y: 0))
        makeBouncer(at: CGPoint(x: bouncerPosition * 2, y: 0))
        makeBouncer(at: CGPoint(x: bouncerPosition * 3, y: 0))
        makeBouncer(at: CGPoint(x: bouncerPosition * 4, y: 0))
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: self.size.width - 100, y: self.size.height - 100)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.horizontalAlignmentMode = .left
        editLabel.position = CGPoint(x: self.size.width * 0.1, y: self.size.height - 100)
        addChild(editLabel)
        
        ballsLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsLabel.text = "You have 5 balls"
        ballsLabel.position = CGPoint(x: scoreLabel.position.x + 50, y: scoreLabel.position.y - 40)
        ballsLabel.horizontalAlignmentMode = .right
        addChild(ballsLabel)
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            let objects = nodes(at: location)
            if objects.contains(editLabel){
                editingMode.toggle()
                for slotGlow in slotGlows {
                    if editingMode{
                        if slotGlow.action(forKey: "spinForever") != nil {
                            slotGlow.removeAction(forKey: "spinForever")
                        }
                    }else{
                        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
                        let spinForever = SKAction.repeatForever(spin)
                        slotGlow.run(spinForever, withKey: "spinForever")
                    }
                }
           
            }else{
                if editingMode{
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.name = "box"
                    addChild(box)
                    
                }else{
                    ballCount -= 1
                    if ballCount <= 0{
                        let noBallLabel = SKLabelNode(fontNamed: "Chalkduster")
                        noBallLabel.text = "You've used all your balls"
                        noBallLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                        addChild(noBallLabel)
                    } else{
                        let imageName = balls[Int.random(in: 0..<balls.count)]
                        let ball = SKSpriteNode(imageNamed: imageName)
                        ball.position = CGPoint(x: location.x, y: self.size.height)
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                        ball.physicsBody?.restitution = 0.4
                        ball.name = "ball"
                        addChild(ball)
                    }
                    
                }
            }
        }
    }
    
    func makeBouncer(at position: CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool){
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood{
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        }else{
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        slotGlow.position = position
        addChild(slotBase)
        addChild(slotGlow)
        
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever, withKey: "spinForever")
        slotGlows.append(slotGlow)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyA = contact.bodyA.node else{ return }
        guard let bodyB = contact.bodyB.node else{ return }
        if bodyA.name == "ball"{
            collisionBetween(ball: bodyA, object: bodyB)
            
        }else if bodyB.name == "ball"{
            collisionBetween(ball: bodyB, object: bodyA)
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode){
        if object.name == "good"{
            destroy(ball: ball)
            score += 1
            ballCount += 1
        }else if object.name == "bad"{
            destroy(ball: ball)
            score -= 1
        }else if object.name == "box"{
            object.removeFromParent()
        }
    }
    
    func destroy(ball: SKNode){
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles"){
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }
        
       
}
