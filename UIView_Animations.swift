/*
					Hikarus Guijarro-Fayard - iOS developer specialized in Swift
					http://ikiteruningen.net
					https://github.com/HikarusGF
*/

class HKUI＋ {
   
/*
   These functions perform animations in 1, 2, and 3 phases respectively. They are very useful to compose complex animations chaining one after the other
   Because most parameters in the header for all animation phases have default values the calls can be very short
   To get an idea of how compact a complex animation can become using these functions here's the exoskeleton that the triple animation produces:
   
   HKUI＋.animation3𝜙(𝜙1Duration＃: sectionTransitionDuration＃, 𝜙1ƒ: {
         // 1st phase code
      }, 𝜙2ƒ: {
         // 2nd phase code
      }, 𝜙3ƒ: {
         // 3rd phase code
      }, completionƒ: {
         // code after animation is completed
   })
*/

// 1-PHASE ANIMATION
   class func animation(iterations iterations＃: Int = 0, options: UIViewAnimationOptions = .CurveEaseInOut, delay＃: NSTimeInterval = 0, duration＃: NSTimeInterval, springVelocityⓖ: CGFloat? = nil, springDampingⓖ: CGFloat? = nil, mainƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      if springDampingⓖ != nil && springVelocityⓖ != nil {
         UIView.animateWithDuration(duration＃, delay: delay＃, usingSpringWithDamping: springDampingⓖ!, initialSpringVelocity: springVelocityⓖ!, options: options, animations: {
            mainƒ()
         }, completion: { _ in
            if completionƒ != nil { completionƒ!() }
            if iterations＃ > 0 { animation(iterations: iterations＃ - 1, options: options, delay＃: delay＃, duration＃: duration＃, springVelocityⓖ: springVelocityⓖ, springDampingⓖ: springDampingⓖ, mainƒ: mainƒ, completionƒ: completionƒ) }
         })
      } else {
         UIView.animateWithDuration(duration＃, delay: delay＃, options: options, animations: {
            mainƒ()
         }, completion: { _ in
            if completionƒ != nil { completionƒ!() }
            if iterations＃ > 0 { animation(iterations: iterations＃ - 1, options: options, delay＃: delay＃, duration＃: duration＃, mainƒ: mainƒ, completionƒ: completionƒ) }
         })
      }
   }

   
// 2-PHASE ANIMATION
   class func animation2𝜙(options options: UIViewAnimationOptions = .CurveEaseInOut, iterations＃: Int = 0, 𝜙1Delay＃: NSTimeInterval = 0, 𝜙1Duration＃: NSTimeInterval, 𝜙1SpringVelocityⓖ: CGFloat? = nil, 𝜙1SpringDampingⓖ: CGFloat? = nil,  𝜙1ƒ: () -> (), 𝜙2Delay＃: NSTimeInterval = 0, var 𝜙2Duration＃: NSTimeInterval? = nil, 𝜙2SpringVelocityⓖ: CGFloat? = nil, 𝜙2SpringDampingⓖ: CGFloat? = nil, 𝜙2ƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      if 𝜙2Duration＃ == nil { 𝜙2Duration＃ = 𝜙1Duration＃  }
      if 𝜙1SpringDampingⓖ != nil && 𝜙1SpringVelocityⓖ != nil {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, usingSpringWithDamping: 𝜙1SpringDampingⓖ!, initialSpringVelocity: 𝜙1SpringVelocityⓖ!, options: options, animations: {
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringDampingⓖ != nil && 𝜙2SpringVelocityⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            }
         })
      } else {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, options: options, animations: {
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringDampingⓖ != nil && 𝜙2SpringVelocityⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙1Duration＃, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            }
         })
      }
   }

// 3-PHASE ANIMATION
   class func animation3𝜙(options options: UIViewAnimationOptions = .CurveEaseInOut, iterations＃: Int = 0, 𝜙1Delay＃: NSTimeInterval = 0, 𝜙1Duration＃: NSTimeInterval, 𝜙1SpringVelocityⓖ: CGFloat? = nil, 𝜙1SpringDampingⓖ: CGFloat? = nil,  𝜙1ƒ: () -> (), 𝜙2Delay＃: NSTimeInterval = 0, var 𝜙2Duration＃: NSTimeInterval? = nil, 𝜙2SpringVelocityⓖ: CGFloat? = nil, 𝜙2SpringDampingⓖ: CGFloat? = nil, 𝜙2ƒ: () -> (), 𝜙3Delay＃: NSTimeInterval = 0, var 𝜙3Duration＃: NSTimeInterval? = nil, 𝜙3SpringVelocityⓖ: CGFloat? = nil, 𝜙3SpringDampingⓖ: CGFloat? = nil, 𝜙3ƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      if 𝜙2Duration＃ == nil { 𝜙2Duration＃ = 𝜙1Duration＃ }; if 𝜙3Duration＃ == nil { 𝜙3Duration＃ = 𝜙1Duration＃ }
      if 𝜙1SpringVelocityⓖ != nil && 𝜙1SpringDampingⓖ != nil {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, usingSpringWithDamping: 𝜙1SpringDampingⓖ!, initialSpringVelocity: 𝜙1SpringVelocityⓖ!, options: options, animations: { // 1 ? ?
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringVelocityⓖ != nil && 𝜙2SpringDampingⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: { // 1 1 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 1 1 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, options: options, animations: { // 1 1 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, options: options, animations: { // 1 0 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 1 0 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, options: options, animations: { // 1 0 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            }
         })
      } else {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, options: options, animations: { // 0 ? ?
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringVelocityⓖ != nil && 𝜙2SpringDampingⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: { // 0 1 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 0 1 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, options: options, animations: { // 0 1 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃!, delay: 𝜙2Delay＃, options: options, animations: { // 0 0 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 0 0 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃!, delay: 𝜙3Delay＃, options: options, animations: { // 0 0 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            }
         })
      }
   }
}

/* VARIABLE-TYPE SUFFIX CRITERION

I've built a custom keyboard layout to include these suffix I find very useful in my code
Some characters like { ＃ ＋ ﹙﹚ ﹖ } have resemblance to the standard pound, plus, parenthesis, question mark, but are really alternate ASCII characters that can perfectly be used in Swift code

you can of course remove them from the code :)

   Boolean              ⓑ
   String               $
   number               ＃
   Int                  ＃i
   Float                ＃f
   Double               ＃d
   CGFloat              ⓖ
   CGPoint              ⓖ²    2 dimensional CGFloats
   CGRect               ⓖ⁴    4 dimensional CGFloats
   Binary/Data          ß     For NSData, and images or videos in CoreData
   Core Image           ⓘ
   NSDate               ㊐
   Object               🅞
   Tuple                🅣
   Array                🅐
   Set                  ...     ? not sure about this one...
   Dictionary           🅓
   Enumeration          🅔
   Structure            🅢
   Library Class        ＋     (suffix)
   Additive parameter   ＋     (prefix)
   Complex Structure    ﹙﹚
   Undetermined         ﹖     for Undetermined types: Optional or AnyObject
   Implicitly unwrapped ﹗
   Protocol             Ⓟ
   Function             ƒ
   Pointer              ⓟ⃗
   PhotoAsset           ⓐ
   Collection           🅒
   URL                  🅤
   
   Example: an array of dictionaries with a string key which value is a tuple of an enum and a number
   myVariable＃🅔🅣$🅓🅐
   
*/
