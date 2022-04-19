//
//  GameScene.swift
//  project11.1
//
//  Created by Ainura Kerimkulova on 16/3/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false{
        didSet{
            if editingMode{
                editLabel.text = "Done"
            } else{
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.position = CGPoint(x: 80, y: 700)
        editLabel.text = "Edit"
        addChild(editLabel)
       
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        let slotPosition = size.width / 8
        makeSlot(at: CGPoint(x: slotPosition, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: slotPosition * 3, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: slotPosition * 5, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: slotPosition * 7, y: 0), isGood: false)
        
        let bouncerPosition = size.width / 4
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: bouncerPosition, y: 0))
        makeBouncer(at: CGPoint(x: bouncerPosition * 2 , y: 0))
        makeBouncer(at: CGPoint(x: bouncerPosition * 3, y: 0))
        makeBouncer(at: CGPoint(x: size.width, y: 0))

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let location = touch.location(in: self)
        
        let objects = nodes(at: location)
        
        if objects.contains(editLabel){
            editingMode.toggle()
        }else{
            if editingMode{
                let size = CGSize(width: CGFloat.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                box.physicsBody = SKPhysicsBody(rectangleOf: size)
                box.physicsBody?.isDynamic = false
                addChild(box)
                
            }else{
        
                let ball = SKSpriteNode(imageNamed: "ballRed")
                ball.position = CGPoint(x: location.x, y: self.size.height)
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                ball.physicsBody?.restitution = 0.4
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.name = "ball"
                addChild(ball)
            }
        }
    }
    
    func makeBouncer(at position: CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.position = position
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
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        slotBase.position = position
        
        slotGlow.position = position
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode){
        if object.name == "good"{
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad"{
            destroy(ball: ball)
            score -= 1
        }
    }
    
    func destroy(ball: SKNode){
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyA = contact.bodyA.node else {return}
        guard let bodyB = contact.bodyB.node else {return}
        
        if bodyA.name == "ball"{
            collisionBetween(ball: bodyA, object: bodyB)
        } else if bodyB.name == "ball"{
            collisionBetween(ball: bodyB, object: bodyA)
        }
    }
        

}
